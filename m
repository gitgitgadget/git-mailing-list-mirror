From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 1/7] git submodule: teach `add` to label submodules
Date: Mon, 21 Mar 2016 19:06:06 -0700
Message-ID: <1458612372-10966-2-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiI-0000cY-2i
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbcCVCG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:26 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36060 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbcCVCGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:25 -0400
Received: by mail-pf0-f177.google.com with SMTP id u190so288902565pfb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oqDXspsCb3bVDdjiGvAIBnJQRadcfNHhf5RJBCZPZOA=;
        b=VW/hR2TQ4ENC76F0pf5jcUtue22tSbDUSc3WZkitE//TKCamAfgWzWlP+NR9DVWonc
         /VIg1ytCHqqbh4vO3GbttYd+CynhmMoMd6X0c6R/dPeX5/qkJIlBHu8Mpo6XEJfXUYj0
         pAfRZJqx7yVmh27n96H/I/he/4LTWUp99j+O/0pCxSo7cr7JqGJ9r8A8Wzz1ES05+C8a
         h0l7E+b6bgRPxGlYGFMJ7XA2571XwV29XWdmLrW678acs+uIV8mo4ZDiQGyk/pruBHGO
         OijGr7AxjbyZo4z0Kv1aeRJsaQ/DR6CxxAzFTwk3cIrLT/AVYb4iqyA88AW9SZEb+vpA
         fq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oqDXspsCb3bVDdjiGvAIBnJQRadcfNHhf5RJBCZPZOA=;
        b=nA8DgRIiaT4WHehjkcWdLMGiwba2ZM6j4anlQY0cK5PotWOnkoHGcCHQUWx7ZBdJge
         8eyLxjlZAyar8XN3hhaSPNfAiOAKldw4lNXv0Brr/uo2j5KNJTyKP1sj0b/KYHsffaP8
         D29xhcNgJLvVlDcZqN/7iSIf2Rwjj7NQ7a9FABdEXbcNHpAa9SqwrCvrl4Nh6nSef8dk
         WPF2oXAkLbhjYjZzEBj6LlwZpgYL/1Br2kfqdyOKFQyzsy/iVqKRd20f/JWr6xLO5O+w
         YVlUcRFeOYvfjO3kJaQWBVIL8kfUL7bRK8eCbnUjHd1cENOT//nbp2BbMNeP43y4Eukt
         rnNA==
X-Gm-Message-State: AD7BkJLQyNzYRpsFMlgr6iqbAcX+ZUMbZ03gVemiAQ/7QDHSgWyzdhKUic9V7GBYgwkjlSXH
X-Received: by 10.66.160.231 with SMTP id xn7mr50762308pab.134.1458612384495;
        Mon, 21 Mar 2016 19:06:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id vy6sm43696544pac.38.2016.03.21.19.06.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:23 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289483>

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
index 13adebf..c0744eb 100644
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
@@ -101,6 +101,9 @@ is the superproject and submodule repositories will be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
++
+If at least one label argument was given, all labels are recorded in the
+.gitmodules file in the label fields.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/git-submodule.sh b/git-submodule.sh
index 97a3097..def1e1c 100755
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
index 5991e3c..fc948fd 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -986,6 +986,7 @@ test_expect_success 'submodule with UTF-8 name' '
 '
 
 test_expect_success 'submodule add clone shallow submodule' '
+	test_when_finished "rm -rf super" &&
 	mkdir super &&
 	pwd=$(pwd) &&
 	(
@@ -999,5 +1000,36 @@ test_expect_success 'submodule add clone shallow submodule' '
 	)
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
2.7.0.rc0.45.g6b4c145
