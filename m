From: Stefan Zager <szager@google.com>
Subject: [PATCH] Make 'git submodule update --force' always check out
 submodules.
Date: Wed, 25 Jul 2012 10:41:54 -0700
Message-ID: <20120822233610.710C01C2DAF@stefro.sfo.corp.google.com>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Aug 23 01:36:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4KTD-0001ri-7Q
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 01:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010Ab2HVXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 19:36:13 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:36602 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2HVXgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 19:36:12 -0400
Received: by qafl39 with SMTP id l39so28942qaf.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:date:subject:message-id:to;
        bh=pcftGP2srLoZyfOh5uE0xRudTfikCDm7bFGRtjdAZFU=;
        b=PaJqNgc5Ue/ZV/pH3uzvbzm7RQplmYFjVEqfGuNSSGy4pj/XYkrdMe7XWNnDaLx0nf
         s4HkJtDKAA9/QlrIlmgIEcCcbUmY2g5rUYw2eAX7edcNUIrHA7WOdxtvunMKULLiQfmH
         tUCwFiVl/FFVRkDVHqOOlXwMJj6QK1famQjwzO/HaNT8hZb4DA65mMeZm08B5WARvwri
         LTH7GwimwhMLPMrZOukdKv/Hwaqe31YwhLnG9O5BdYbVTZBVpBbAHO/49agO1LQcxANf
         /RiLq9X6l3hWLag3Dgt1jLcNSggx2y50RHrAP3eHq4xtDJLpSPTmO/Vq5mjRjJnrx2Xq
         5rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:date:subject:message-id:to:x-gm-message-state;
        bh=pcftGP2srLoZyfOh5uE0xRudTfikCDm7bFGRtjdAZFU=;
        b=l1CFK43IXP0prom9ABMN/KMly6Yj1tS2vTCrncrPUPGLImUbeWKB308XNrhuwqtfgk
         1bHime02pywML3Oxwk4EAOzYmNca1gpujyPLbz3dYnUJTEH+YVUV4Hn2k7CaNeo+IpTb
         4vF5ARtkbZodEiSLy9Eh8IGao+jOrzK7GMng5CKOj5MM4vy7GoFChne1GHNArixB+vAM
         toLhUKdctNuZsitz9Iz8WHsPQK4jM8rG2RM8NFObJ2I3JuzSCPNysnllSgSjqPWIs7I3
         I0JEKIODGQ0GK9Lc12K2TX8/9apYrwa172o99NCj/2NvoqJDUUsR1dPWbNHmTiN3QCAI
         hZDQ==
Received: by 10.236.153.6 with SMTP id e6mr13439780yhk.20.1345678571072;
        Wed, 22 Aug 2012 16:36:11 -0700 (PDT)
Received: by 10.236.153.6 with SMTP id e6mr13439774yhk.20.1345678571021;
        Wed, 22 Aug 2012 16:36:11 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id u67si1570434yhi.7.2012.08.22.16.36.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 22 Aug 2012 16:36:11 -0700 (PDT)
Received: from stefro.sfo.corp.google.com (stefro.sfo.corp.google.com [172.31.52.143])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id E470F1E0043;
	Wed, 22 Aug 2012 16:36:10 -0700 (PDT)
Received: by stefro.sfo.corp.google.com (Postfix, from userid 138314)
	id 710C01C2DAF; Wed, 22 Aug 2012 16:36:10 -0700 (PDT)
X-Gm-Message-State: ALoCoQmDV55VOxtJhGDOcc/VTqXOvotPr+uItnsdsTIdL5+lFvoesUS6OfsJ4rfY3JzWWttYCNP4E41X7bLPP0zfiki9R4XK0VuR0z7hl1+LfzTDIKlK5NwUcPBR/mCtOD7FEzwh14MmsfflJvAbvhym2cYGcXbj+WbuoVBpIQajzUlqr/ZbfV17wgH7m2yLnb/zYuuqQKxP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204105>

Currently, it will only do a checkout if the sha1 registered in the containing
repository doesn't match the HEAD of the submodule, regardless of whether the
submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
strong indicator that the state of the submodule is suspect, and should be reset
to HEAD.

Signed-off-by: Stefan Zager <szager@google.com>
---
 Documentation/git-submodule.txt |  9 ++++++++-
 git-submodule.sh                |  2 +-
 t/t7406-submodule-update.sh     | 12 ++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index fbbbcb2..2de7bf0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -149,6 +149,11 @@ submodule with the `--init` option.
 +
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
++
+If `--force` is specified, the submodule will be checked out (using
+`git checkout --force` if appropriate), even if the commit specified in the
+index of the containing repository already matches the commit checked out in
+the submodule.
 
 summary::
 	Show commit summary between the given commit (defaults to HEAD) and
@@ -210,7 +215,9 @@ OPTIONS
 	This option is only valid for add and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
 	When running update, throw away local changes in submodules when
-	switching to a different commit.
+	switching to a different commit; and always run a checkout operation
+	in the submodule, even if the commit listed in the index of the
+	containing repository matches the commit checked out in the submodule.
 
 --cached::
 	This option is only valid for status and summary commands.  These
diff --git a/git-submodule.sh b/git-submodule.sh
index aac575e..3aa7644 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -578,7 +578,7 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
 		fi
 
-		if test "$subsha1" != "$sha1"
+		if test "$subsha1" != "$sha1" -o -n "$force"
 		then
 			subforce=$force
 			# If we don't already have a -f flag and the submodule has never been checked out
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index ce61d4c..9706436 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -123,6 +123,18 @@ test_expect_success 'submodule update should throw away changes with --force ' '
 	)
 '
 
+test_expect_success 'submodule update --force forcibly checks out submodules' '
+	(cd super &&
+	 (cd submodule &&
+	  rm -f file
+	 ) &&
+	 git submodule update --force submodule &&
+	 (cd submodule &&
+	  test "$(git status -s file)" = ""
+	 )
+	)
+'
+
 test_expect_success 'submodule update --rebase staying on master' '
 	(cd super/submodule &&
 	  git checkout master
-- 
1.7.12.2.gf3df7bf.dirty
