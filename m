Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0900C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B964C613EE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhGJHvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhGJHvL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:51:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D00C0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso7405035pjb.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hMhBFJQPHez2p+VUkMy7MTjVGNjH7aB3klPAb+OALU=;
        b=T/WgGEDzKnOA+dYSumrWGS/yhjvNEocPdG+cfNc83AbpCaOl7dFPk2TmMZ8uOjEyn5
         swT1n/B7Y4NikPuzeKEZXIGzj9kNEGOqf4gg26RBdzrK7ZePJW7egBDTD+LzKn5clAJZ
         k1v0Ft5QsACZvuzYwLpK09XwAYUDJhraF1kGbq94ppcaSXov1p4wTnagnEkLtaGVINZb
         ALMpZvQdmnPpsyC65O3ywv/7ygjddLlwPioBtiuJpnPl+/wCTodeQKW+UU5pYxHkOcKw
         LonCNa5AHeng0lb3Qjtya5Im0DeEJImrxT9zSwttBd2fmNFaJN0hfWKS/upxfm+/NPLk
         FdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hMhBFJQPHez2p+VUkMy7MTjVGNjH7aB3klPAb+OALU=;
        b=FkQrJ/yeD9CmWqpdfU8l2zviFm/zPyNxKB+87uONflwIJXfOEwYgLj2o8F2HvM3oLC
         EjLSeXDNY4PE8dtKq1x7rDKkc187kqufG+mt+71kJC6CulRUixBtOUgVBrMGvT6hu6p/
         CCf2gQhyDfuPee+mGjHPRGzCPno/94/sBaPQK85ZAnglUdZuUIFXivmfbz5sf4G9xUPA
         HFac6oxUbYAHU9y+hCH/ojIBFACdORmsaTrNqq50vfptCiUebI4KTGMiIjyF/2imu0NN
         bGNIU7by1a+fD0TMfC0vpkgj1U9jGBFsAczs/d3UpJa4yETnDSEf7Uag5ePYLCQRIsWj
         fM2A==
X-Gm-Message-State: AOAM531xsgGx1Cm2M39JepqwLQxXXGjGQgKq6sZuLPf+eV5+fMVj8huX
        bl39uU7ilfxH40OhXFOEPrSr3vMShS5y6nA3
X-Google-Smtp-Source: ABdhPJzuFC9yjdmZB4o+YQ+tRvelhO2d22tosN97zcvVyQaSlQWZbDpVH/rpwS1wBP+AWEgvWQ5tIQ==
X-Received: by 2002:a17:902:76cc:b029:129:275f:aaed with SMTP id j12-20020a17090276ccb0290129275faaedmr34608666plt.49.1625903305366;
        Sat, 10 Jul 2021 00:48:25 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 125sm8811327pfg.52.2021.07.10.00.48.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 00:48:25 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH v3 2/4] submodule: prefix die messages with 'fatal'
Date:   Sat, 10 Jul 2021 13:17:59 +0530
Message-Id: <20210710074801.19917-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210710074801.19917-1-raykar.ath@gmail.com>
References: <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210710074801.19917-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard `die()` function that is used in C code prefixes all the
messages passed to it with 'fatal: '. This does not happen with the
`die` used in 'git-submodule.sh'.

Let's prefix each of the shell die messages with 'fatal: ' so that when
they are converted to C code, the error messages stay the same as before
the conversion.

Note that the shell version of `die` exits with error code 1, while the
C version exits with error code 128. In practice, this does not change
any behaviour, as no functionality in 'submodule add' and 'submodule
update' relies on the value of the exit code.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 git-submodule.sh            | 38 ++++++++++++++++++-------------------
 t/t7400-submodule-basic.sh  |  4 ++--
 t/t7406-submodule-update.sh | 10 +++++-----
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4678378424..69bcb4fab2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -147,7 +147,7 @@ cmd_add()
 
 	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
 	then
-		 die "$(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
+		 die "fatal: $(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
 	fi
 
 	if test -n "$reference_path"
@@ -176,7 +176,7 @@ cmd_add()
 	case "$repo" in
 	./*|../*)
 		test -z "$wt_prefix" ||
-		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
+		die "fatal: $(gettext "Relative path can only be used from the toplevel of the working tree")"
 
 		# dereference source url relative to parent's url
 		realrepo=$(git submodule--helper resolve-relative-url "$repo") || exit
@@ -186,7 +186,7 @@ cmd_add()
 		realrepo=$repo
 		;;
 	*)
-		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
+		die "fatal: $(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
 	;;
 	esac
 
@@ -205,17 +205,17 @@ cmd_add()
 	if test -z "$force"
 	then
 		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
-		die "$(eval_gettext "'\$sm_path' already exists in the index")"
+		die "fatal: $(eval_gettext "'\$sm_path' already exists in the index")"
 	else
 		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
-		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
+		die "fatal: $(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
 	fi
 
 	if test -d "$sm_path" &&
 		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
 	then
 	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
-	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out")"
+	    die "fatal: $(eval_gettext "'\$sm_path' does not have a commit checked out")"
 	fi
 
 	if test -z "$force"
@@ -238,7 +238,7 @@ cmd_add()
 
 	if ! git submodule--helper check-name "$sm_name"
 	then
-		die "$(eval_gettext "'$sm_name' is not a valid submodule name")"
+		die "fatal: $(eval_gettext "'$sm_name' is not a valid submodule name")"
 	fi
 
 	# perhaps the path exists and is already a git repo, else clone it
@@ -281,7 +281,7 @@ or you are unsure what this means choose another name with the '--name' option."
 	git config submodule."$sm_name".url "$realrepo"
 
 	git add --no-warn-embedded-repo $force "$sm_path" ||
-	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
+	die "fatal: $(eval_gettext "Failed to add submodule '\$sm_path'")"
 
 	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
 	git submodule--helper config submodule."$sm_name".url "$repo" &&
@@ -290,7 +290,7 @@ or you are unsure what this means choose another name with the '--name' option."
 		git submodule--helper config submodule."$sm_name".branch "$branch"
 	fi &&
 	git add --force .gitmodules ||
-	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
+	die "fatal: $(eval_gettext "Failed to register submodule '\$sm_path'")"
 
 	# NEEDSWORK: In a multi-working-tree world, this needs to be
 	# set in the per-worktree config.
@@ -565,7 +565,7 @@ cmd_update()
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
+			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
 
 		if test -n "$remote"
@@ -575,12 +575,12 @@ cmd_update()
 			then
 				# Fetch remote before determining tracking $sha1
 				fetch_in_submodule "$sm_path" $depth ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
 			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
 			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
+			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
 		if test "$subsha1" != "$sha1" || test -n "$force"
@@ -604,36 +604,36 @@ cmd_update()
 				# not be reachable from any of the refs
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
-				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
+				die "fatal: $(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
 				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
+				die_msg="fatal: $(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
 				;;
 			rebase)
 				command="git rebase ${GIT_QUIET:+--quiet}"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
+				die_msg="fatal: $(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
 				command="git merge ${GIT_QUIET:+--quiet}"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
+				die_msg="fatal: $(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			!*)
 				command="${update_module#!}"
-				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
+				die_msg="fatal: $(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
 				must_die_on_failure=yes
 				;;
 			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
+				die "fatal: $(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
 			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
@@ -660,7 +660,7 @@ cmd_update()
 			res=$?
 			if test $res -gt 0
 			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
+				die_msg="fatal: $(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
 				if test $res -ne 2
 				then
 					err="${err};$die_msg"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7aa7fefdfa..cb1b8e35db 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -51,7 +51,7 @@ test_expect_success 'submodule update aborts on missing gitmodules url' '
 
 test_expect_success 'add aborts on repository with no commits' '
 	cat >expect <<-\EOF &&
-	'"'repo-no-commits'"' does not have a commit checked out
+	fatal: '"'repo-no-commits'"' does not have a commit checked out
 	EOF
 	git init repo-no-commits &&
 	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
@@ -199,7 +199,7 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 test_expect_success 'submodule add to path with tracked content fails' '
 	(
 		cd addtest &&
-		echo "'\''dir-tracked'\'' already exists in the index" >expect &&
+		echo "fatal: '\''dir-tracked'\'' already exists in the index" >expect &&
 		mkdir dir-tracked &&
 		test_commit foo dir-tracked/bar &&
 		test_must_fail git submodule add "$submodurl" dir-tracked >actual 2>&1 &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f4f61fe554..11cccbb333 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -448,7 +448,7 @@ test_expect_success 'fsck detects command in .gitmodules' '
 '
 
 cat << EOF >expect
-Execution of 'false $submodulesha1' failed in submodule path 'submodule'
+fatal: Execution of 'false $submodulesha1' failed in submodule path 'submodule'
 EOF
 
 test_expect_success 'submodule update - command in .git/config catches failure' '
@@ -465,7 +465,7 @@ test_expect_success 'submodule update - command in .git/config catches failure'
 '
 
 cat << EOF >expect
-Execution of 'false $submodulesha1' failed in submodule path '../submodule'
+fatal: Execution of 'false $submodulesha1' failed in submodule path '../submodule'
 EOF
 
 test_expect_success 'submodule update - command in .git/config catches failure -- subdirectory' '
@@ -484,7 +484,7 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 
 test_expect_success 'submodule update - command run for initial population of submodule' '
 	cat >expect <<-EOF &&
-	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
+	fatal: Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
 	EOF
 	rm -rf super/submodule &&
 	test_must_fail git -C super submodule update 2>actual &&
@@ -493,8 +493,8 @@ test_expect_success 'submodule update - command run for initial population of su
 '
 
 cat << EOF >expect
-Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
-Failed to recurse into submodule path '../super'
+fatal: Execution of 'false $submodulesha1' failed in submodule path '../super/submodule'
+fatal: Failed to recurse into submodule path '../super'
 EOF
 
 test_expect_success 'recursive submodule update - command in .git/config catches failure -- subdirectory' '
-- 
2.32.0

