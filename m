From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/15] submodule add: label submodules if asked to
Date: Tue, 26 Apr 2016 13:50:21 -0700
Message-ID: <1461703833-10350-4-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wj-0006WI-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbcDZUuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:51 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33046 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcDZUus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id zm5so12054071pac.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/BHJCAC/SDgCTwiIcF8afFjR7dv2Rn2dkhy9OwGyVw=;
        b=QpaNLkZRfMoarFtX/fTTEixiqtqEDO0Sd/Gprv93tgjyv3yqk9kyLT5wCnTsqApJev
         pr3GYoPuR1arm6xD8dUY7/izPfAZWPSMBKpo1AURF4idxUObmEhnbe62qlakDfENrV2f
         L4gyY+6qhI2z2Ufds+qBsirSRvDRUrxmCvZepulOXkcu8ojzmC8amIo3ZcRQy2Fo28YD
         45/Ecp54o9A69b+XkuHFJRwkxERm/CGlKuLNxJqJ6qsloqlrHDbCrFOGmGKHFNQegGBT
         YB+641AZPYpyANe71cSa/yps1FzHJaffkw+DsnawjSQ02WVhdVAisbZ/9Ig/ll9scJ9I
         B2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/BHJCAC/SDgCTwiIcF8afFjR7dv2Rn2dkhy9OwGyVw=;
        b=e7pCjBfqhqtBwju6dOkvB6vCMVDMaB1XtX86l25vVYoM4MZwlvMx1URVltg5SaE2cM
         VPxQIDgmizEAXI1C4V4kz/24kEr0H9d0RBns+NHHNpWOwsBhyQ8juqn5EJIJkaGTQxkT
         UEg7iWgkrfIxGF9qrj+jZ4tPLAONd2SkWg8sZEClTPariSGEampdGR82UnFaYxetkLZ0
         tuILqRZVANO9Wa0U81Fpro2ixbRPjhvkrbwh21HfSLEsbUP6RpAfM/R/DcB0y9n16+QA
         8iHpJV50dJziNb6DMW5sw0NWbC3zjb/J7N7gHuGdxCrpvVdpr7lwou+7zMvaJSRZ7mRe
         9Y5Q==
X-Gm-Message-State: AOPr4FXlCEcB34Lg1fIijf3Exbu/3sP2uDk3Hal1P0d/tW2s7oeboDpUn79HHbEbiuufRUzp
X-Received: by 10.66.136.10 with SMTP id pw10mr6504874pab.113.1461703847631;
        Tue, 26 Apr 2016 13:50:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id g70sm512215pfb.7.2016.04.26.13.50.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292669>

When adding new submodules, you can specify the
label(s) the submodule belongs to by giving one or more
--label arguments. This will record each label in the
.gitmodules file as a value of the key
"submodule.$NAME.label".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  5 ++++-
 git-submodule.sh                | 14 +++++++++++++-
 t/t7400-submodule-basic.sh      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8c4bbe2..349ead8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
+'git submodule' [--quiet] add [-b <branch>] [-f|--force] [-l|--label <label>]
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
@@ -109,6 +109,9 @@ is the superproject and submodule repositories will be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
++
+If at least one label argument was given, all labels are recorded in the
+.gitmodules file in the label fields.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/git-submodule.sh b/git-submodule.sh
index 82e95a9..d7a5e1a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-l|--label <label>][--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
@@ -130,6 +130,7 @@ cmd_add()
 {
 	# parse $args after "submodule ... add".
 	reference_path=
+	labels=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -165,6 +166,13 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		-l|--label)
+			labels="${labels} $2"
+			shift
+			;;
+		--label=*)
+			labels="${labels} ${1#--label=}"
+			;;
 		--)
 			shift
 			break
@@ -292,6 +300,10 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	for label in $labels
+	do
+		git config --add -f .gitmodules submodule."$sm_name".label "${label}"
+	done &&
 	if test -n "$branch"
 	then
 		git config -f .gitmodules submodule."$sm_name".branch "$branch"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f99f674..e9d1d58 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1040,6 +1040,7 @@ test_expect_success 'submodule with UTF-8 name' '
 '
 
 test_expect_success 'submodule add clone shallow submodule' '
+	test_when_finished "rm -rf super" &&
 	mkdir super &&
 	pwd=$(pwd) &&
 	(
@@ -1078,5 +1079,36 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'submodule add records a label' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule &&
+		git config -f .gitmodules submodule."submodule".label >actual &&
+		echo labelA >expected &&
+		test_cmp expected actual
+	)
+'
+
+cat >expected <<-EOF
+labelA
+labelB
+EOF
+
+test_expect_success 'submodule add records multiple labels' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label=labelA -l labelB file://"$pwd"/example2 submodule &&
+		git config --get-all -f .gitmodules submodule."submodule".label >../actual
+	) &&
+	test_cmp expected actual
+'
 
 test_done
-- 
2.8.0.41.g8d9aeb3
