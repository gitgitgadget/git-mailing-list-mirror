Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF9C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbiFJCC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiFJCCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3CA6D1B6
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so378443wmz.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ct8LL4il4KO8GCD+7JiXZvXAzvuCFYMD33knjbIjgKs=;
        b=GrXGfQ48HV6VaKdDcsM9Cb5CJYwq7BBK+Cj3SAqO17Q884xtVoUW24OnHcmUdvr57W
         WrU68J2GlYwZtd2yAdKJuy54m5pO8uk/CXxqpTjSOSqUnxLW+sbU/pK48PM3nLzLXisB
         EOXC5FxOXwWOqXIpArhwR79CGgbCUrzgmXJa24xYyZnABFq3jVSchwO5Fvx98M+ThYpX
         BwH15e8jOKE1kTM6zIJBCNNOkCrIm/0PduuiX/8c3qulFrte2ymnLb1ilHP13n4Af6To
         dOYr+r6bXkAe4x7JZnPVr8OHKqApFmV3Iz9qm/nPD4F+x3OKoKjxmI7MagjluKZEik9N
         3sVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ct8LL4il4KO8GCD+7JiXZvXAzvuCFYMD33knjbIjgKs=;
        b=lxim5PIzMk0xuVYVdgVOP7nNHp96uYAd/qvH8h2yQGIxA71xchkYvnJlSRgnfFRolk
         56i17QSIPAN+PuFZGI7p4AGY4z/0+0VCSk83LcLmJcVUvWt6IUxDjHrGh1qPuJUOTx5H
         oqmRVKoRqUzTOvkU6O5DsBRkFALJKHp+T+sNEwIL4CCfaBJUceNoAp8UqmDJ0GZalGb5
         9fmBBsnWoZErnW8iAcLXbZMY1JSu055XpeWP540ysO6JOfQyrjgaVO+4XRp/WIr1KE9o
         SjKwS2sdl9d5RFQzYf8iZaE8TlhkirCels0Kvqffvv5QEVBLQQ07B/CiIdePt45s8zpi
         mU9w==
X-Gm-Message-State: AOAM533ZEkFCIp1DtLLyCyiPhBp8pPBgLd/EHeO2c+qkyVTXCB5+39et
        LTY6aqRaGVENkb52SIWeBv7SjuozFagL2A==
X-Google-Smtp-Source: ABdhPJwB/ZED+Hk1tR8/oAKF/DPwZpqNjVs1M9G5BeyCUwZEOcQP2GE/P0IoaTHQB7e9GWJjbyK5WQ==
X-Received: by 2002:a1c:e903:0:b0:397:36b8:795a with SMTP id q3-20020a1ce903000000b0039736b8795amr6249068wmc.98.1654826514779;
        Thu, 09 Jun 2022 19:01:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 10/20] git-submodule.sh: dispatch directly to helper
Date:   Fri, 10 Jun 2022 04:01:22 +0200
Message-Id: <RFC-patch-10.20-498a1fd275b-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the dispatching logic in "git-submodule.sh" for the "add",
"init", "deinit", "set-branch", "set-url", "summary" and "status"
sub-commands to do away with the argument parsing in git-submodule.sh,
and instead dispatch directly to "git submodule--helper".

As in a preceding commit the only functional change here should be
that on invalid options we'll now emit more targeted "-h" output.

The isnumber() helper function was only used in the now-removed
cmd_summary(), the same goes for the $files variable. The $custom_name
and $branch variables were only used in cmd_add().

Since there are no dashed commands anymore in git-submodule.sh we can
get rid of the "$(echo | sed ...)" one-liner to change e.g. "set-url"
to "set_url".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 321 +----------------------------------------------
 1 file changed, 5 insertions(+), 316 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ddc2e4e4032..61e4f17b805 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,18 +30,15 @@ GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
 command=
-branch=
 force=
 reference=
 cached=
 recursive=
 init=
 require_init=
-files=
 remote=
 nofetch=
 update=
-custom_name=
 depth=
 progress=
 dissociate=
@@ -50,86 +47,7 @@ jobs=
 recommend_shallow=
 filter=
 
-isnumber()
-{
-	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
-}
-
-#
-# Add a new submodule to the working tree, .gitmodules and the index
-#
-# $@ = repo path
-#
-# optional branch is stored in global branch variable
-#
-cmd_add()
-{
-	# parse $args after "submodule ... add".
-	reference_path=
-	while test $# -ne 0
-	do
-		case "$1" in
-		-b | --branch)
-			case "$2" in '') usage ;; esac
-			branch=$2
-			shift
-			;;
-		-f | --force)
-			force=$1
-			;;
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		--progress)
-			progress=1
-			;;
-		--reference)
-			case "$2" in '') usage ;; esac
-			reference_path=$2
-			shift
-			;;
-		--reference=*)
-			reference_path="${1#--reference=}"
-			;;
-		--dissociate)
-			dissociate=1
-			;;
-		--name)
-			case "$2" in '') usage ;; esac
-			custom_name=$2
-			shift
-			;;
-		--depth)
-			case "$2" in '') usage ;; esac
-			depth="--depth=$2"
-			shift
-			;;
-		--depth=*)
-			depth=$1
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	if test -z "$1"
-	then
-		usage
-	fi
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
-}
 
-#
 # Execute an arbitrary command sequence in each checked out
 # submodule
 #
@@ -160,73 +78,6 @@ cmd_foreach()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
-#
-# Register submodules in .git/config
-#
-# $@ = requested paths (default to all)
-#
-cmd_init()
-{
-	# parse $args after "submodule ... init".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
-}
-
-#
-# Unregister submodules from .git/config and remove their work tree
-#
-cmd_deinit()
-{
-	# parse $args after "submodule ... deinit".
-	deinit_all=
-	while test $# -ne 0
-	do
-		case "$1" in
-		-f|--force)
-			force=$1
-			;;
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		--all)
-			deinit_all=t
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
-}
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -359,168 +210,6 @@ cmd_update()
 		"$@"
 }
 
-#
-# Configures a submodule's default branch
-#
-# $@ = requested path
-#
-cmd_set_branch() {
-	default=
-	branch=
-
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			# we don't do anything with this but we need to accept it
-			;;
-		-d|--default)
-			default=1
-			;;
-		-b|--branch)
-			case "$2" in '') usage ;; esac
-			branch=$2
-			shift
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
-}
-
-#
-# Configures a submodule's remote url
-#
-# $@ = requested path, requested url
-#
-cmd_set_url() {
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
-}
-
-#
-# Show commit summary for submodules in index or working tree
-#
-# If '--cached' is given, show summary between index and given commit,
-# or between working tree and given commit
-#
-# $@ = [commit (default 'HEAD'),] requested paths (default all)
-#
-cmd_summary() {
-	summary_limit=-1
-	for_status=
-	diff_cmd=diff-index
-
-	# parse $args after "submodule ... summary".
-	while test $# -ne 0
-	do
-		case "$1" in
-		--cached)
-			cached=1
-			;;
-		--files)
-			files="$1"
-			;;
-		--for-status)
-			for_status="$1"
-			;;
-		-n|--summary-limit)
-			summary_limit="$2"
-			isnumber "$summary_limit" || usage
-			shift
-			;;
-		--summary-limit=*)
-			summary_limit="${1#--summary-limit=}"
-			isnumber "$summary_limit" || usage
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
-}
-#
-# List all submodules, prefixed with:
-#  - submodule not initialized
-#  + different revision checked out
-#
-# If --cached was specified the revision in the index will be printed
-# instead of the currently checked out revision.
-#
-# $@ = requested paths (default to all)
-#
-cmd_status()
-{
-	# parse $args after "submodule ... status".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		--cached)
-			cached=1
-			;;
-		--recursive)
-			recursive=1
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
-}
-
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -573,11 +262,11 @@ case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
-sync)
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${GIT_QUIET:+--quiet} "$@"
+foreach | update)
+	"cmd_$command" "$@"
 	;;
-*)
-	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
+add | init | deinit | set-branch | set-url | status | summary | sync)
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
+		${GIT_QUIET:+--quiet} ${cached:+--cached} "$@"
 	;;
 esac
-- 
2.36.1.1178.gb5b1747c546

