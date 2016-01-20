From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] git submodule: Teach add to accept --group
Date: Tue, 19 Jan 2016 19:34:37 -0800
Message-ID: <1453260880-628-2-git-send-email-sbeller@google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 04:34:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjXq-0004dV-2f
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935037AbcATDes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:34:48 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33769 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933912AbcATDeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:34:46 -0500
Received: by mail-pa0-f48.google.com with SMTP id cy9so462592911pac.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 19:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8sXbUWFTOClAPGHO39ejzicHEYTjrgGxPhx6wdhpLX4=;
        b=lOaTJ/qdtTbO1CF6WUNSgSrWs4MaPY1CHNbYM+OMYolioEbdJzyud9gKVtQYr+itxo
         oFqMVyZxei9TUs/PBUs/pd0cJtSiyDu2eY7RfNnYEPFPoLAW0kNNyGR4BHDf14pwLw+t
         /kILDY8Hu7/+DejGbuhaijgdENbCB5dq3WsOCnK8L74QtpIsTCBKSZBRivb+Whc9RE3N
         8MQ87oErV8O7i6xdbN+zkTIvq8iep61hQiwn96e2Uia+ZMdb203GORz4ptQKNzFOIlE1
         P2VLPYgwYSJYzAEu5qHAoZ7egdygph6ivugbRPhQ9CO+VYP8FeTr65yXsbTIOganZpFm
         ealw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8sXbUWFTOClAPGHO39ejzicHEYTjrgGxPhx6wdhpLX4=;
        b=AIUYyyWguG6GXUvELuJNx0eeSHhvCwK2Myqx68YACN/hBd9b96k1+3nrMio+zavURb
         cGRjsTtTsfA4Pu7g6lP4clOHF38gDxROMVNRGzhZF4N3yLSIV/HnzYbhlWJZv2gwsmZU
         BGYnRLTa6TjD/wYBxivcOPwIbaWVy+fs2WIF2VLydoOlZmtOs2sA3MSh+V5Xh1H9fdoc
         qlP48BpRbyEAvPnJyPy57wSL6oPjQ/D7U/CnyG3DY2r8oYMs9rvMkl3abstJx/LgPsHg
         ztTMJJUZ/IVgTnR+f1wcJa3SwrYYlTw+0sS2F7d6Iiu4y55kJ6NUUCwc15oaZOoDl9uc
         nPgQ==
X-Gm-Message-State: ALoCoQmaXoKTOd5MmdehzYqvYtWbD9EHdYSQ30ObdWc35l96JuW9BAx4ZwVCveVyruZ8ZzQEc7lZWFuFQ3iyuWVratC60weCRQ==
X-Received: by 10.66.237.35 with SMTP id uz3mr49500851pac.96.1453260885208;
        Tue, 19 Jan 2016 19:34:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id n27sm44650232pfb.53.2016.01.19.19.34.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 19:34:44 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
In-Reply-To: <1453260880-628-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284422>

When adding new submodules, you can specify the
group(s) the submodule belongs to by giving one or more
--group arguments. This will record each group in the
.gitmodules file as a value of the key
"submodule.$NAME.group".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  8 +++++++-
 git-submodule.sh                | 15 +++++++++++++++
 t/t7400-submodule-basic.sh      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 13adebf..135c739 100644
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
index 6fce0dc..ab0f209 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -130,6 +130,7 @@ cmd_add()
 {
 	# parse $args after "submodule ... add".
 	reference_path=
+	submodule_groups=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -165,6 +166,10 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		-g|--group)
+			submodule_groups=${submodule_groups:+${submodule_groups};}"$2"
+			shift
+			;;
 		--)
 			shift
 			break
@@ -292,6 +297,16 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	if test -n "$submodule_groups"
+	then
+		OIFS=$IFS
+		IFS=';'
+		for group in $submodule_groups
+		do
+			git config --add -f .gitmodules submodule."$sm_name".group "${group}"
+		done
+		IFS=$OIFS
+	fi &&
 	if test -n "$branch"
 	then
 		git config -f .gitmodules submodule."$sm_name".branch "$branch"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5991e3c..b468278 100755
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
 
+test_expect_success 'submodule add records a group' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git config -f .gitmodules submodule."submodule".group >actual &&
+		echo groupA >expected &&
+		test_cmp expected actual
+	)
+'
+
+cat >expected <<-EOF
+groupA
+groupB
+EOF
+
+test_expect_success 'submodule add records groups' '
+	test_when_finished "rm -rf super" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA -g groupB file://"$pwd"/example2 submodule &&
+		git config --get-all -f .gitmodules submodule."submodule".group >../actual
+	) &&
+	test_cmp expected actual
+'
 
 test_done
-- 
2.7.0.rc0.41.g89994f2.dirty
