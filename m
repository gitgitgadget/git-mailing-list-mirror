From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 0/8] make gitk work better in non-top-level directory
Date: Mon,  4 Apr 2011 22:14:11 -0400
Message-ID: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:16:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpB-0002A2-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab1DECQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:16:52 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36444 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1DECQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:39 -0400
Received: by qwk3 with SMTP id 3so3719730qwk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=cztF+SEgWndARYjVlIj7aPUnKFZWUyWo2nZ9n7H5wLE=;
        b=EK7R6QoQJ2V11lEC6h5wFuE6FtcFVq0TnpgakZMMdmkwGrjQvkurXdzAwmkF+RdaIv
         Gp6zNYPGvEhgxe2OajBIGGfsJ9R6rQeJDnx0Y0lKLgVEmryAVLZm8CODALJh9Eyrxg4r
         SV3pgqqIHeVBCPWUSHzAYomy31aYNauHwmW24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IQkXidq8U+lcw3gRjVNlzJ705V1xl+3m7Cu4Dg7kvo/eZVzTHPOgPvC2EYE23Wj2Ow
         mNb6Wrxag1Aepxv8qfQgTtIwiYCRd3DHIIyb3y4mzN614ra9PJ1PwqV+CgcW9D21IcEj
         ZTw3o9OKMH2afOu0bCWQJty57Qlh+iVuqhoSA=
Received: by 10.224.183.131 with SMTP id cg3mr6422127qab.247.1301969798771;
        Mon, 04 Apr 2011 19:16:38 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170853>

This series fixes a few different bugs in gitk related to its working
directory.

I started working on patch 1, which fixes "Highlight this only/too"
when gitk is started in a subdirectory. This problem has bothered me
for a long time, but I had heard that the Tcl code in gitk was hard to
maintain, so I didn't have a look at it until now. I have to say that
it was a lot easier to follow the code than I had feared.

While testing that the fix in patch 1 worked, I found that gitk does
not work very well when the work tree is not at ".git/..", so most of
the other patches try to improve that situation.

I think I have tested most combinations of setups (top-level dir,
subdir, separate work tree, bare repo, .git) and operations (highlight
file, blame, external diff, show origin of line).


Martin von Zweigbergk (8):
  gitk: fix file highlight when run in subdirectory
  gitk: fix "show origin of this line" with separate work tree
  gitk: fix "blame parent commit" with separate work tree
  gitk: fix "External diff" with separate work tree
  gitk: put temporary directory inside .git
  gitk: run 'git rev-parse --git-dir' only once
  gitk: simplify calculation of gitdir
  gitk: show modified files with separate work tree

 gitk-git/gitk |   59 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 33 insertions(+), 26 deletions(-)

-- 
1.7.4.79.gcbe20
