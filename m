From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [BUG] "git diff FILE BRANCH:FILE" erroneously report FILE does not
 exist in BRANCH
Date: Sat, 21 Jan 2012 20:36:27 +0100
Message-ID: <4F1B13BB.8070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RogkB-0003Zj-EJ
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 20:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab2AUTgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 14:36:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64669 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab2AUTgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 14:36:31 -0500
Received: by eaac11 with SMTP id c11so772853eaa.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=PtVND9sczWtKCy4zhcCxZ35MFRyrPtU/XJkFfz5wr54=;
        b=sg/MMSz4XT7LlpsGZpuuNFdDeTPxD4cU/P0nq1oCwhwzJlJFzrisD5SZ0DvNd2NXSJ
         XvJJev0PdV95s8ar4qA2PfDSJSE98m/Oy/aMMNLqcLtjApQrdcYKNCOxzJJxbMeZ1tTp
         px23/NMe+Z+CZvZSY5NYr82hIEDKdgmr1PYJQ=
Received: by 10.213.28.5 with SMTP id k5mr571350ebc.35.1327174590316;
        Sat, 21 Jan 2012 11:36:30 -0800 (PST)
Received: from [87.2.92.22] (host22-92-dynamic.2-87-r.retail.telecomitalia.it. [87.2.92.22])
        by mx.google.com with ESMTPS id 28sm29695115eed.0.2012.01.21.11.36.28
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 11:36:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188928>

Here is a complete reproducer for the bug:

mkdir foo \
  && cd foo \
  && git init . \
  && >README \
  && git add README \
  && git commit -m "for all" \
  && git checkout -b devel \
  && echo dev > README \
  && git add README \
  && git commit -m "for developers" \
  && git diff devel:README master:README \
  && git diff README master:README

I'd expect the last "git diff" to report the same diffs as the previous one;
instead, it errors out with this bogus message:

  fatal: Path 'README' exists on disk, but not in 'master'.

Behaviour verified with git version 1.7.7.3 (installed from official Debian
packages) and the latest git development version (1.7.9.rc0.69.gbddcef, from
master).

Regards, and thanks for your amazing software,
  Stefano
