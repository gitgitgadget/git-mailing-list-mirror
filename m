From: Jason Holden <jason.k.holden@gmail.com>
Subject: [PATCH] subtree merge strategy fails if branch.master.rebase=true
Date: Sun, 26 Jul 2009 17:47:45 -0400
Message-ID: <1248644865-1998-1-git-send-email-jason.k.holden@gmail.com>
Cc: Jason Holden <jason.k.holden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 26 23:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVBZm-0002gU-6t
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 23:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbZGZVsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 17:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZGZVsF
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 17:48:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:17016 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbZGZVsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 17:48:03 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1446892qwh.37
        for <git@vger.kernel.org>; Sun, 26 Jul 2009 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bwoOZ2n8opoTzFEer0iIra9pgoxw3pa1Hm7OUdc0kNs=;
        b=M0vHuSqTdfA9ZkgZKUON7eJSmNrA4dpSuVjlBVrOMv0V1E+HZsXeVFZoEEmxJvoIiJ
         g5q5nNeUq0BcPqtGxACycCCkNbk6NWPcgJqUS9x6NQBasqLs1bJfA9t80uy1QJeARG3v
         T+0RSjgnZV4U6zvmPzO51/678G/0TWT4LKzmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l0dmPU4iy3qOsZq8bLM/tPbn4wgwKn9TeKtR5uPEMukqM3Qai84RTEXh5hpDxcroDi
         AVM6XTAD1NFGbP1YivOkYCeMdNRz9xRUa8G2BSWptLACIZEaAxE+Yb2qlnp0jIyKh0SM
         5GhVlQUXMx1J321lwIT6dwwlgZc1tJ3pERy/o=
Received: by 10.224.37.140 with SMTP id x12mr5385221qad.235.1248644883066;
        Sun, 26 Jul 2009 14:48:03 -0700 (PDT)
Received: from localhost (c-75-69-254-77.hsd1.nh.comcast.net [75.69.254.77])
        by mx.google.com with ESMTPS id 6sm3346326qwk.34.2009.07.26.14.48.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Jul 2009 14:48:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.497.g2e2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124139>

Update documentation so that users pass --no-rebase to the git-pull
command when using the subtree merge strategy.  Without it, if a user
has specified in their config file that branch.master.rebase=true,
the pull will fail with the following error:

>From /disk2/git_projects/git/Bproject
 * branch            master     -> FETCH_HEAD
First, rewinding head to replay your work on top of it...
fatal: Could not parse object 'c54bafddcae4679e8a675713251ace678f962aa0^'
Unknown exit code (128) from command: git-merge-subtree c54bafddcae4679e8a675713251ace678f962aa0^ -- HEAD c54bafddcae4679e8a675713251ace678f962aa0

The hash value referenced above is the first commit made to the main
repository (not the Bproject subtree).
---
 Documentation/howto/using-merge-subtree.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.txt
index 0953a50..3f5972e 100644
--- a/Documentation/howto/using-merge-subtree.txt
+++ b/Documentation/howto/using-merge-subtree.txt
@@ -37,7 +37,7 @@ $ git merge -s ours --no-commit Bproject/master <2>
 $ git read-tree --prefix=dir-B/ -u Bproject/master <3>
 $ git commit -m "Merge B project as our subdirectory" <4>
 
-$ git pull -s subtree Bproject master <5>
+$ git pull --no-rebase -s subtree Bproject master <5>
 ----------------
 <1> name the other project "Bproject", and fetch.
 <2> prepare for the later step to record the result as a merge.
-- 
1.6.3.3.497.g2e2f
