From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] git submodule: Teach add to label submodules
Date: Fri, 22 Jan 2016 16:31:40 -0800
Message-ID: <1453509103-16470-3-git-send-email-sbeller@google.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:32:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMm7e-0006pu-L8
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbcAWAb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:31:59 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36741 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbcAWAbu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:31:50 -0500
Received: by mail-pf0-f176.google.com with SMTP id n128so50002619pfn.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QyLuFTVrNX6piKNrqOQJKBwhEyA9VxS/+pWu3TYGh5g=;
        b=ecqd58WktSl823E4TcaxM8LSPgmHtLrKeylHhVpnrCof/ETeaKaR09OlVaPvm+azrf
         BPZOEDJjie211nnwWawMQW/ZuI+itB2FOF425rMFE5ITQU2Qc1kDRQbPeDLJ3MQjsuqV
         cfyUCDJZjj4QQ0L062bJ/2tFJro0R3RhK0d8u58HsMF0V+f8IQJ7m04Ox9veKFj8BOv7
         eJ7G95bynUWvPNQRivzroFSCAZxfqVHtPKoZKzJ854EzCjSHHxSEpH3Jv3sKcJ/nAMUU
         WvIk1mUxOvMQt0PKvxh4FQXqvDmu9LM2JTV+WRN+ReoJvc+jbIC9XZGN5pUKRQQhVdDf
         05Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QyLuFTVrNX6piKNrqOQJKBwhEyA9VxS/+pWu3TYGh5g=;
        b=X5pzOtaLEx9nRPsgkEp1Pf+eKNKj+0tJFNvz02fD+gM5mCGeyUU/R94jG+Du++QXqb
         Nw4C2djMwTIQD3++QCdi+44CZv/sLc47fYPnaAIBS1HavSilPcNkwacxhB/N1Wko5dwu
         z6vUUbqBXu08iiL2ws+Oa3As1i+A/30VptheNzPs1Q9yHBsTHyaE0ipwSuzaOqep0nP+
         +6TjNB8QaWI2AW0BECXHfX2B5i86EsNGDduyuAlD9Ir2VNUZ6y0OrKJtZRSbra8/HPeO
         2hoSkpAYBhW7RF4K0P8QwO7zjhrD9g1h4awIKB95mswQ0NJqx8V3GDoGGRYJyKLzeEPs
         1GUA==
X-Gm-Message-State: AG10YOS71jVmDa5S+Jot+7j0hwaIS0PkMp/Zsmqql1Re9EkIAbc8qdPOnexu3HOcAWhtNC0U
X-Received: by 10.98.42.74 with SMTP id q71mr8385883pfq.18.1453509110141;
        Fri, 22 Jan 2016 16:31:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id tv6sm12293060pab.4.2016.01.22.16.31.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:31:49 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g77a36b9.dirty
In-Reply-To: <1453509103-16470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284615>

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
index 6fce0dc..65b740c 100755
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
index 5991e3c..01d54e3 100755
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
+test_expect_success 'submodule add records multiple lables' '
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
2.7.0.rc0.42.g77a36b9.dirty
