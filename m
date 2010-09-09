From: davi.reis@gmail.com
Subject: Do not let lstree output recursively when a directory whose name is a prefix of the others is given in the path list.
Date: Wed,  8 Sep 2010 22:40:25 -0700
Message-ID: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 07:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtZsj-0000TQ-3H
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 07:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0IIFlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 01:41:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45499 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0IIFlC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 01:41:02 -0400
Received: by vws3 with SMTP id 3so946225vws.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=rQyAxQ3fCshy6O8MAbb6f8h/oIX8/3C/1ULPNPwWmOo=;
        b=mjH+XbhfTjKa8n0C+n29gEFZwt4zjJk1BZoIRAMJTIcuNl1dHrE4Dnu6CBcdLuS10O
         zbmj0yj25h7xmFZVeEvttra29u96pIv3kFC0zY/eA6b0laXoOyOmr7mYn0P9VkeT/XUS
         lDe6CCGt2hOQixSCNssHYck7MgaYigJLpTIcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=N5gLATcLBlfnKIX7oOa7YtQUuBj8KtWxoOyRlOXfu7YXwOZhRNPEgGinOg1o/qII5g
         ZgMTKymVN6WKd16NGCMHSjGFvTEyzr6Op6eMMis0NZrxaYIaMwhtLOG0JowooaabYoM/
         R6DVSPSD41HZax1LXiDsAN/ye5rWaIvY+ZOhU=
Received: by 10.220.121.134 with SMTP id h6mr918891vcr.251.1284010861828;
        Wed, 08 Sep 2010 22:41:01 -0700 (PDT)
Received: from localhost.localdomain ([12.108.175.130])
        by mx.google.com with ESMTPS id j34sm528321vcs.28.2010.09.08.22.40.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 22:41:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155841>

Here is how to reproduce the bug:

git init
mkdir prefix && touch prefix/a && git add prefix/a
mkdir prefixdir && touch prefixdir/b && git add prefixdir/b
git commit -a -m "If -r is not given, ls-tree should not show files in subdirs."
git ls-tree --name-only HEAD prefix  # works as expected
git ls-tree --name-only HEAD prefixdir  # works as expected
git ls-tree --name-only HEAD prefix prefixdir  # shows file, not dir

The output of the last command is 

prefix/a
prefixdir

But it should be

prefix
prefixdir

The patch fixes the problem.
