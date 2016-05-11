From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/7] submodule add: label submodules if asked to
Date: Tue, 10 May 2016 17:59:52 -0700
Message-ID: <1462928397-1708-3-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IVd-0001oS-IG
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbcEKBAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:11 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35497 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcEKBAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:08 -0400
Received: by mail-pf0-f178.google.com with SMTP id 77so11632939pfv.2
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/kH72E3ZDukODFlCjKxYC9tZj4mO8c5FPk+NHE/JW1I=;
        b=CiBm8bOPQIcD3VoAJ7ZuAtVOTdY0FVs8aSAEqcTpdvmMyYRlNmSiabg7Jd0pFHsvqT
         10UiERKW8jafymWpe837qQrASzIu8BGV38iyioG0GMf9GEqHcSeNQ04AN2onfueG/lPv
         9jUd+biJcwajntHt/tmlEoLAwmhhosLZiy7UQ1EAA8wdTlNdu4NyA4spLivDV+2pHmlC
         lRHHM5FDNvxUxWK4kpW9Jo4nZihAcYeGelD0R+cNdrwcjn0atTKuvAPGP6iF0Cd2V2g6
         9Xp+CGoY0jSEPSmsb7O8ZNxk9OOeKckGG7pk6rJ0OykvoMxHkAxm+NGGNFxH77I+PHPx
         /Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/kH72E3ZDukODFlCjKxYC9tZj4mO8c5FPk+NHE/JW1I=;
        b=RyVxCMuM1vFZfDCV2wjALTUFFdagsb1tgEv4xvh9fL8J73qBpu5w/ilc+gwHglXsw3
         PWivV461HUaVkVA5gcopyuRXxT0IuRir/ytgqqSJv0QlYF0gFf4YxRQaMWKdBkQr5UMI
         59JdpD6KLUL+HjJwskjZI3zh+IR1f4HbB5vBj8QVkwkpLbAxeYrUPEqmJzKV6spwGaPO
         7nXgGASY/0+Li7GH8IC427Hr+rKcsqaUWF41gvshIuKpqOu4AsGVUU2qzVz0Ykj2zVM1
         Yc6Q8sMGf45VIHNBOv1bHAFC6v/cSzKA+WX3MFhDDZyUUinc0qDK76ZbxJw8M5KQlIA4
         NVbg==
X-Gm-Message-State: AOPr4FWW7mt6Da47vi9OqfGjKIaMRI7MNLTgM8NCHuO+8o3KeXQOVrIrLYE2dnWwV28nG0oZ
X-Received: by 10.98.46.71 with SMTP id u68mr747980pfu.136.1462928407952;
        Tue, 10 May 2016 18:00:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id w187sm7231982pfw.50.2016.05.10.18.00.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:07 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294210>

When adding new submodules, you can specify the labels the submodule
belongs to by giving one or more --label arguments. This will record
each label in the .gitmodules file as a value of the key
"submodule.$NAME.label".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  4 +++-
 git-submodule.sh                | 16 ++++++++++++++-
 t/t7400-submodule-basic.sh      | 44 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 13adebf..9ba8895 100644
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
@@ -101,6 +101,8 @@ is the superproject and submodule repositories will be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
++
+All labels are recorded in the .gitmodules file in the label fields.
 
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
diff --git a/git-submodule.sh b/git-submodule.sh
index 82e95a9..c1213d8 100755
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
@@ -165,6 +166,15 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		-l|--label)
+			git submodule--helper valid-label-name "$2" || exit
+			labels="${labels} $2"
+			shift
+			;;
+		--label=*)
+			git submodule--helper valid-label-name "${1#--label=}" || exit
+			labels="${labels} ${1#--label=}"
+			;;
 		--)
 			shift
 			break
@@ -292,6 +302,10 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	for label in $labels
+	do
+		git config --add -f .gitmodules submodule."$sm_name".label "$label"
+	done &&
 	if test -n "$branch"
 	then
 		git config -f .gitmodules submodule."$sm_name".branch "$branch"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 814ee63..0adc4e4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1056,6 +1056,7 @@ test_expect_success 'submodule with UTF-8 name' '
 '
 
 test_expect_success 'submodule add clone shallow submodule' '
+	test_when_finished "rm -rf super" &&
 	mkdir super &&
 	pwd=$(pwd) &&
 	(
@@ -1094,5 +1095,48 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
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
+		git config -f .gitmodules submodule."submodule".label >../actual &&
+		echo labelA >../expect
+	) &&
+	test_cmp expect actual
+'
+
+cat >expect <<-EOF
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
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule add recording wrong labels reports an error' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		test_must_fail git submodule add --label="labelA labelB" file://"$pwd"/example2 submodule 2>../actual
+	) &&
+	test_i18ngrep alphanumeric actual
+'
 
 test_done
-- 
2.8.0.35.g58985d9.dirty
