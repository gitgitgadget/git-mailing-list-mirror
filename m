Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E85C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2729F22512
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgLNXV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgLNXVK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:21:10 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E9CC0617A6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:29 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w4so13828246pgg.13
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79tTbPZOShGYYys7xQgdks7p8Jf/crJ9P9t9KXsl4U4=;
        b=RgsXqnw2hhqr/aB7i7dlQA3inLgkAZUTJhQbgwGbKNDE03S5H5FCcI1hu1iAP7gvOh
         jIQWyQ73xx66/QilPqudhDg7KDd0HO8DXdy1MSJVgP3F8weH62Mau132RpQV/IpBrYUN
         829D+52daEP48vOoXXPJSg3qS4qumacUJTVLAJzBL/+GjxmEJp0fBH5HhMSOCq7fbVx2
         PhO+3Dpa7ZjqCHOfxehM7gMVV6/tALpitdtZGDMpce4UPuUy0hRY9JAbDNIxVNSbcAy8
         sZ50ADvlUNX3jFIVw7Ojl0nYtjT4MMo0O9yNPajxSG5cZEar/14KWDr0Np5NBV3B89Wh
         PmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79tTbPZOShGYYys7xQgdks7p8Jf/crJ9P9t9KXsl4U4=;
        b=hEejq1Asxrx8upHasP9adBREas5mD5/qa4wfegpDhRnuOT5O2X4RMsxJMIlP3lZoLV
         gZ8OfA9W0N5hcfOCQPuohnA0+tz+PjxXySiaqNPucBrAVWUfYve6588X1bqWqbC0G0vk
         U77HyT3Ythg9cfwki4Wm9Es9B9tTVe1cDsl/gFlGYwpnO9ulEDURlGp+hJ81ESEN5C1b
         eNOtZsYsov4pG9z4LWxeBBvYXf/AZ+vLmwGZtCz2FQHmzArbupPSWSdD6aWq2oHBfw60
         acoa+gdPGrBbRJz68D43A/SfUalaIz+l099CHdaVJn6cncd2WDiigJ9X5YA+cE4IGEZH
         zSXA==
X-Gm-Message-State: AOAM531ttqcXy5Z0zdubCJe+Asv4brJHDvv7h2tFtnl9JajZdP0ofLuu
        wsvhnajdS6BU77gYLssXtZGR0hGKvmQBuA==
X-Google-Smtp-Source: ABdhPJwIRxo8An2LaiZMqOyn0a/50UJ+WftcHmB2+h0I/WfM6aBStDrkJCJaciI2887YnfzqEI1Hsw==
X-Received: by 2002:a65:450d:: with SMTP id n13mr3505628pgq.208.1607988029212;
        Mon, 14 Dec 2020 15:20:29 -0800 (PST)
Received: from localhost.localdomain ([27.56.186.8])
        by smtp.gmail.com with ESMTPSA id z10sm21282983pfr.204.2020.12.14.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:20:28 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v3 2/3] submodule: port submodule subcommand 'add' from shell to C
Date:   Tue, 15 Dec 2020 04:49:38 +0530
Message-Id: <20201214231939.644175-3-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214231939.644175-1-periperidip@gmail.com>
References: <20201214231939.644175-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'add' to a builtin and call it via
'git-submodule.sh'.

Also, since the command die()s out in case of absence of commits in the
submodule, the keyword 'fatal' is prefixed in the error messages.
Therefore, prepend the keyword in the expected output of test t7400.6.

While at it, eliminate the extra preprocessor directive
`#include "dir.h"` at the start of 'submodule--helper.c'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Stefan Beller <stefanbeller@gmail.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c |   2 +-
 git-submodule.sh            | 161 +-----------------------------------
 t/t7400-submodule-basic.sh  |   2 +-
 3 files changed, 3 insertions(+), 162 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4dfad35d77..4f1d892b9a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -19,7 +19,6 @@
 #include "diffcore.h"
 #include "diff.h"
 #include "object-store.h"
-#include "dir.h"
 #include "advice.h"
 
 #define OPT_QUIET (1 << 0)
@@ -3185,6 +3184,7 @@ static struct cmd_struct commands[] = {
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
 	{"set-branch", module_set_branch, 0},
+	{"add", module_add, SUPPORT_SUPER_PREFIX},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index eb90f18229..b586f9532d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -145,166 +145,7 @@ cmd_add()
 		shift
 	done
 
-	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
-	then
-		 die "$(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
-	fi
-
-	if test -n "$reference_path"
-	then
-		is_absolute_path "$reference_path" ||
-		reference_path="$wt_prefix$reference_path"
-
-		reference="--reference=$reference_path"
-	fi
-
-	repo=$1
-	sm_path=$2
-
-	if test -z "$sm_path"; then
-		sm_path=$(printf '%s\n' "$repo" |
-			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-	fi
-
-	if test -z "$repo" || test -z "$sm_path"; then
-		usage
-	fi
-
-	is_absolute_path "$sm_path" || sm_path="$wt_prefix$sm_path"
-
-	# assure repo is absolute or relative to parent
-	case "$repo" in
-	./*|../*)
-		test -z "$wt_prefix" ||
-		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
-
-		# dereference source url relative to parent's url
-		realrepo=$(git submodule--helper resolve-relative-url "$repo") || exit
-		;;
-	*:*|/*)
-		# absolute url
-		realrepo=$repo
-		;;
-	*)
-		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
-	;;
-	esac
-
-	# normalize path:
-	# multiple //; leading ./; /./; /../; trailing /
-	sm_path=$(printf '%s/\n' "$sm_path" |
-		sed -e '
-			s|//*|/|g
-			s|^\(\./\)*||
-			s|/\(\./\)*|/|g
-			:start
-			s|\([^/]*\)/\.\./||
-			tstart
-			s|/*$||
-		')
-	if test -z "$force"
-	then
-		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
-		die "$(eval_gettext "'\$sm_path' already exists in the index")"
-	else
-		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
-		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
-	fi
-
-	if test -d "$sm_path" &&
-		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
-	then
-	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
-	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out")"
-	fi
-
-	if test -z "$force"
-	then
-	    dryerr=$(git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" 2>&1 >/dev/null)
-	    res=$?
-	    if test $res -ne 0
-	    then
-		 echo >&2 "$dryerr"
-		 exit $res
-	    fi
-	fi
-
-	if test -n "$custom_name"
-	then
-		sm_name="$custom_name"
-	else
-		sm_name="$sm_path"
-	fi
-
-	if ! git submodule--helper check-name "$sm_name"
-	then
-		die "$(eval_gettext "'$sm_name' is not a valid submodule name")"
-	fi
-
-	# perhaps the path exists and is already a git repo, else clone it
-	if test -e "$sm_path"
-	then
-		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
-		then
-			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
-		else
-			die "$(eval_gettext "'\$sm_path' already exists and is not a valid git repo")"
-		fi
-
-	else
-		if test -d ".git/modules/$sm_name"
-		then
-			if test -z "$force"
-			then
-				eval_gettextln >&2 "A git directory for '\$sm_name' is found locally with remote(s):"
-				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
-				die "$(eval_gettextln "\
-If you want to reuse this local git directory instead of cloning again from
-  \$realrepo
-use the '--force' option. If the local git directory is not the correct repo
-or you are unsure what this means choose another name with the '--name' option.")"
-			else
-				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
-			fi
-		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
-		(
-			sanitize_submodule_env
-			cd "$sm_path" &&
-			# ash fails to wordsplit ${branch:+-b "$branch"...}
-			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
-			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
-	fi
-	git config submodule."$sm_name".url "$realrepo"
-
-	git add --no-warn-embedded-repo $force "$sm_path" ||
-	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
-
-	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
-	git submodule--helper config submodule."$sm_name".url "$repo" &&
-	if test -n "$branch"
-	then
-		git submodule--helper config submodule."$sm_name".branch "$branch"
-	fi &&
-	git add --force .gitmodules ||
-	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
-
-	# NEEDSWORK: In a multi-working-tree world, this needs to be
-	# set in the per-worktree config.
-	if git config --get submodule.active >/dev/null
-	then
-		# If the submodule being adding isn't already covered by the
-		# current configured pathspec, set the submodule's active flag
-		if ! git submodule--helper is-active "$sm_path"
-		then
-			git config submodule."$sm_name".active "true"
-		fi
-	else
-		git config submodule."$sm_name".active "true"
-	fi
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${force:+--force} ${GIT_QUIET:+--quiet} ${progress:+--progress} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fec7e0299d..4ab8298385 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -48,7 +48,7 @@ test_expect_success 'submodule update aborts on missing gitmodules url' '
 
 test_expect_success 'add aborts on repository with no commits' '
 	cat >expect <<-\EOF &&
-	'"'repo-no-commits'"' does not have a commit checked out
+	fatal: '"'repo-no-commits'"' does not have a commit checked out
 	EOF
 	git init repo-no-commits &&
 	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
-- 
2.25.1

