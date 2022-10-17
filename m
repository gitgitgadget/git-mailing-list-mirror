Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF46C43217
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJQMJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJQMJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411851263E
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f11so18120787wrm.6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKO30MFC/pZjL1nxcB277ZbnXlHboD8ynvGLp4HK+NI=;
        b=Kt3mPezcZ0N5zkDATziw2LvYAXnvdcHgQVPtdv96KsPfuXs5/7KCBIWK7bXMlMzmjR
         g1e/CMbQpfBL3JpVFbrRuYMPGgPCr9yGV7d0sXhMeSmbaUpnDACzyNDOAfBpXKfBysO6
         +td0dMwWnbWYY6JQF/Xw7ZAs8ep7hz9lnaYi3XHF4Xm/pUAXgvnf85JBs+CnFbXJ9r/G
         RQevYsswg9bjz6DNxhE0JNEaRIYapkZtHaIyEUDOl7am3QUX78P/vnFY8rnh6cTw0OUK
         X2t6DkHkWTS9MOp5oGKLV5ps/86NuGiHgZzt9hQfFBsc7zgTXBWXWtn9HEuy3RVoZDJG
         05Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKO30MFC/pZjL1nxcB277ZbnXlHboD8ynvGLp4HK+NI=;
        b=edSJbHsrWzwGkLqf1nVGD0b3ode/O6sgUXwE7L66JU0W/CN8HuvLFMUHjRQ86IMn8K
         TFXFH6PD2pA3XfOoTFNNHWXanTNTGtAwTkxipzsEebMAQwVpD99+GpUUrW7SRzMh+H0x
         0CsWEW1vfpWqpu6vuMlBmicEWn8KeAMQe5bLoSk2bNJy13FqLnvWDSv+SjFTaXeAqr5h
         DEDTKywrfSRoriPLTEr02OosyxKhKpyWZRyAc9JtVZTAKL7n0f97WXUvM94fMqM/n5NF
         Cw8Qeu6u0rHl0e03qRfNNjtd2Y4ShfP8YrIk+9CuCfk9PInkYYWiQV6iwdJIIuYYjit3
         G+7A==
X-Gm-Message-State: ACrzQf1XJHJ+uU8sNzIcwoU/KVijOh8fTftz0/XodE2GUM9RxyjqQafC
        cWv8BPS8Twig0o0O7KMqtmJ6OKGsnL0JnQ==
X-Google-Smtp-Source: AMsMyM7+RhgnfRHYFVzgAywxIMVgaP3xP7578ctuKHPCN8GX5hJMvPT3cSFVpvwbcbp0GscfBGrYQQ==
X-Received: by 2002:a05:6000:52:b0:22e:5894:e212 with SMTP id k18-20020a056000005200b0022e5894e212mr5809570wrx.266.1666008573352;
        Mon, 17 Oct 2022 05:09:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] git-submodule.sh: dispatch directly to helper
Date:   Mon, 17 Oct 2022 14:09:18 +0200
Message-Id: <patch-03.10-97cb470c96a-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
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
index 3fdfe864d37..2bdff5119c1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -31,20 +31,17 @@ export GIT_PROTOCOL_FROM_USER
 
 command=
 quiet=
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
 rebase=
 merge=
 checkout=
-custom_name=
 depth=
 progress=
 dissociate=
@@ -53,86 +50,7 @@ jobs=
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
-			quiet=1
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
-}
 
-#
 # Execute an arbitrary command sequence in each checked out
 # submodule
 #
@@ -163,73 +81,6 @@ cmd_foreach()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
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
-			quiet=1
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${quiet:+--quiet} -- "$@"
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
-			quiet=1
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${quiet:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
-}
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -360,168 +211,6 @@ cmd_update()
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
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
-			quiet=1
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${quiet:+--quiet} -- "$@"
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
-			quiet=1
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
-}
-
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -574,11 +263,11 @@ case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
-sync)
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${quiet:+--quiet} "$@"
+foreach | update)
+	"cmd_$command" "$@"
 	;;
-*)
-	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
+add | init | deinit | set-branch | set-url | status | summary | sync)
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
+		${quiet:+--quiet} ${cached:+--cached} "$@"
 	;;
 esac
-- 
2.38.0.1091.gf9d18265e59

