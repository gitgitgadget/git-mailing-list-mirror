From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [RFC] Second attempt at making git-clean a builtin
Date: Sun,  4 Nov 2007 13:02:19 -0600
Message-ID: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 20:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iokk0-0002N9-Kz
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbXKDTCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbXKDTCH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:02:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:5619 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbXKDTCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:02:04 -0500
Received: by wr-out-0506.google.com with SMTP id 36so608028wra
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=tMMtHb4cr6eQkrhCE3tSEsN2u2ofZbKmmNAn/0uFS4o=;
        b=MsYYYLR5ZxRXPrKCK2JzsK/t4en6fCUwoQKEw4xNJ6yziSMCgzHkzthfRhWgtSBukjYpk1rkNiacb96lLbIad8CBU/8BoG4uMojQ4YVqit/Je1n8aJ4hRTZ9TeLCkRt+xucNk3bBq785pI/WyTUJXzOpNeaftSQH7p8Tr0hxc7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=hBPDXSWsJH53akuQAr/85qTmiFJxWQfp7v1zpZEXdpcjVd5wPjyuaejI0Z3K+UWjStZecXYy7B/d3P2KhzkgozWeHf0L3A7I8sWGNnGfAH/k0VMXvz5v5aVRuOAz7/sDndwuv+BQTR5BltQoqp8ciapyyypBhDvhczTvMW7SrtY=
Received: by 10.90.90.16 with SMTP id n16mr2777699agb.1194202922756;
        Sun, 04 Nov 2007 11:02:02 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id 6sm3834172wrh.2007.11.04.11.02.00
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Nov 2007 11:02:01 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Sun,  4 Nov 2007 13:02:21 -0600
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63430>


I've taken all of the comments I received from my previous attempt see:

http://marc.info/?l=git&m=119181975419521&w=2

With these new changes in place my new git-clean passes all of the
original tests as well as the new tests I've added.  While looking at
how git-ls-files walks the tree there were some things that didn't quite
understand, or thought might be unnecessary so there may be some things I
missed.  For example I'm still not quite sure what verify_pathspec()
does.

I did however notice what I would call a bug in the behavior of
git-ls-files and therefore the current git-clean.sh.  With the current
git-clean if you have two directories that contain only untracked files,
for example docs/ and examples/ running:

git clean docs/ examples/

will not remove either directory.  Instead you must use the -d
parameter.  To me this makes sense, however if you run:

git clean docs/

it will remove the docs directory without using the -d parameter.  My
patch is at least consistent in that it requires the -d in both cases.
