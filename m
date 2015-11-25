From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] git submodule add can add a submodule with groups
Date: Tue, 24 Nov 2015 17:32:16 -0800
Message-ID: <1448415139-23675-3-git-send-email-sbeller@google.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:32:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Owh-0005gz-3A
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbbKYBc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:32:29 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36551 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362AbbKYBcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:32:24 -0500
Received: by pacdm15 with SMTP id dm15so39564382pac.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bE0+39eUSnch+3afPojlRHkJHkAf07g88KtNR5sB7sk=;
        b=MDRc7AwCMVTComPIh7c1d1UqVJ5Lues0cPC7fEcolPzbZNw6WUYoP5ASmIyjTQapzT
         JjAHX4n1cJvdd0kB64TD6p/x8lYxbdE6nx2R+WKHuuoSbWoe6y/FEb3lLlvDqkB29gQC
         6LgU09JKwz27KKT/g8O6FvlhF7G/sY4yTaJE241BvjwurWAaaTXokSBEZuDfFLUdhcSE
         EwsFvECVb7Ua2fIEcfX5+AUde86+Jqk5xCxu31yYqeCJJAT6c67Ee5TZjymqFnM6+VRh
         Nfr/4d+9aDmEsF7EcqcvVIhWMah5I8qkGc6yu/P4CUzKMdmqM+bul1vh8poYNPz5wdhr
         ip4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bE0+39eUSnch+3afPojlRHkJHkAf07g88KtNR5sB7sk=;
        b=OXxE8uIJ8GGGLviZJcHEeG3PKb/1HqqUvQIOUuiWJmHcjehlX6QfQK07YCvYMEdX26
         /CZVVglPvQ5XrQojq6RnccHlSJl/3h+WNuZcj6MzieAhXxWVmyKfcEhoixxea8m+eYL1
         VeZRUk0GSVxRgp/K4TPPExLkue/TC90j+sdzqLFbBaCPhhTo2I9K6zCrIAqIcRK/WEQj
         IvGNJk78VWGpH0pbLgrdTZl3COSvqLsiElgjrqF8+5q7hfdjtxFCaq2wXwbrxvKS2yFn
         WqkwQYBDclEGpTQJvXzP9KnSz8JVoNGdNlTOFy6XW9NYCu0/lvlHWAJR2YwZMKtbh8/Z
         ESRg==
X-Gm-Message-State: ALoCoQlsbVaLh+AOQ8ZwJEVmxlPrVjwGjGbqL6IoM8h12q6wNL6Pvo/YzpDe9Ofc9HbGpMIEBXro
X-Received: by 10.98.80.20 with SMTP id e20mr27140320pfb.23.1448415143948;
        Tue, 24 Nov 2015 17:32:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id e25sm16819569pfb.64.2015.11.24.17.32.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:32:23 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448415139-23675-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281671>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  8 +++++++-
 git-submodule.sh                |  9 +++++++++
 t/t7400-submodule-basic.sh      | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a87ff72..b434d8d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
+'git submodule' [--quiet] add [-b <branch>] [-f|--force] [-g <group>][--name <name>]
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
@@ -59,6 +59,9 @@ instead of treating the other project as a submodule. Directories
 that come from both projects can be cloned and checked out as a whole
 if you choose to go that route.
 
+If you manage a large set of submodules, but do not require all of them
+to be checked out, you should look into the submodule groups feature.
+
 COMMANDS
 --------
 add::
@@ -101,6 +104,9 @@ is the superproject and submodule repositories will be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
++
+If at least one group argument was given, all groups are recorded in the
+.gitmodules file in the groups field.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/git-submodule.sh b/git-submodule.sh
index 10c5af9..bbdcf78 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -203,6 +203,7 @@ cmd_add()
 {
 	# parse $args after "submodule ... add".
 	reference_path=
+	submodule_groups=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -238,6 +239,10 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		-g|--group)
+			submodule_groups=${submodule_groups:+${submodule_groups},}"$2"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -365,6 +370,10 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	if test -n "$submodule_groups"
+	then
+		git config -f .gitmodules submodule."$sm_name".groups "${submodule_groups}"
+	fi &&
 	if test -n "$branch"
 	then
 		git config -f .gitmodules submodule."$sm_name".branch "$branch"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5991e3c..a422df3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -986,6 +986,7 @@ test_expect_success 'submodule with UTF-8 name' '
 '
 
 test_expect_success 'submodule add clone shallow submodule' '
+	test_when_finished "rm -rf super" &&
 	mkdir super &&
 	pwd=$(pwd) &&
 	(
@@ -999,5 +1000,32 @@ test_expect_success 'submodule add clone shallow submodule' '
 	)
 '
 
+test_expect_success 'submodule add records a group' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git config -f .gitmodules submodule."submodule".groups >actual &&
+		echo groupA >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule add records groups' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA -g groupB file://"$pwd"/example2 submodule &&
+		git config -f .gitmodules submodule."submodule".groups >actual &&
+		echo groupA,groupB >expected &&
+		test_cmp expected actual
+	)
+'
 
 test_done
-- 
2.6.1.261.g0d9c4c1
