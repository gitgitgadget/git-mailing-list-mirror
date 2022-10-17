Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0563C43217
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJQMJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJQMJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729113E08
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so18144156wrr.3
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlRaC34O/vY7zWB/mwUeCn8WNSgsyxRbZeFEuwe/d94=;
        b=AhrBdiaj7N4DY/jknVQU9tWldwP5XJsGA07kQ8aMUYruBHJPg1q4BJ35P9wMMlJLVd
         AvMaH9WEv/G9+sHHHsWodokmxwc/XMBJS7FBMfPGj65auetdPIvK/WKsOEEJ/mlZUvZN
         WtSf9aI3j7V1vTfIgAwKVoJ4qGAvLJCFWvdIVe6imv/Ew9gD1WLjaxgAbYdDIOiKsUXj
         +aj0vaZyHy2QGMLUcDWoy4lre6ZXRaDT5gvoFyieA18joBqSSoc9N1GCIc8MngCYFbU0
         EdfbN4+ZybsEzBwKhBtFUE5t4OZQMH7jPNP9gsfUWAGLAvzAMY50C841pGYeJCa6k2+y
         ukYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlRaC34O/vY7zWB/mwUeCn8WNSgsyxRbZeFEuwe/d94=;
        b=KyvTnL7lqLmOJhWdnYGlOfTDJuCxuDvU3MTiI+0x3OTgPDe2GSk+n8AvYkZoqNwHEs
         ds4yOKegmo6ACE0bHeHJF2UCLoWg8g+lVzi1zbprGSHfqnV9uGjf8HQ8vaVeL/SudQM+
         BOZgljjyOKlWxz65TTGjqdgoDHN9cuvxQBhqGej/5E786nsWtVsfWSFFA11F5ZBTQHU7
         R52Dz9smCgoa/I408Mxw1xvkfmYX2lZ45V5d1f6e23z+JYH3/87c5CCj5Ef83jRIhME4
         Vj5xTftn1+DxhhhJSziqi2vcszzjKN0PUQuvtW1G2qNvzfvEWLoDNNvo6XwgIqHZTnR6
         8f6g==
X-Gm-Message-State: ACrzQf2MU+cnjV7D1g54IgMiimCj2RknWbOvHG8kFp0QQeg2+nEzHftT
        COxDb5nj98EWV5FSoUIJZ9XN8zV3RZXWww==
X-Google-Smtp-Source: AMsMyM53SQmDssu0+COUm+pCMGzCDGg7gjt8ce2batmmo0GFk228C5KziJguBgikYQnfVsZalTl/mg==
X-Received: by 2002:a05:6000:1f9e:b0:22e:61fa:3f1c with SMTP id bw30-20020a0560001f9e00b0022e61fa3f1cmr5899099wrb.546.1666008575521;
        Mon, 17 Oct 2022 05:09:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] git-submodule.sh: dispatch "update" to helper
Date:   Mon, 17 Oct 2022 14:09:20 +0200
Message-Id: <patch-05.10-7d9c13eb637-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dispatch the "update" command directly to "git submodule--helper
update", rather than doing our own argument parsing in
git-submodule.sh. As this is the last cmd_*() function to be removed
from git-submodule.sh we can do some larger cleanup of that file as a
result.

As noted in a preceding commit the only behavior change here should be
the desirable change of better "-h" output, and that this
implementation understands the "--verbose" synonym for "-v". Let's
update the documentation to reflect the new "--verbose" synonym.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 156 +----------------------------------------------
 1 file changed, 2 insertions(+), 154 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7874e33beea..ac2f95c1285 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -31,160 +31,7 @@ export GIT_PROTOCOL_FROM_USER
 
 command=
 quiet=
-force=
-reference=
 cached=
-recursive=
-init=
-require_init=
-remote=
-nofetch=
-rebase=
-merge=
-checkout=
-depth=
-progress=
-dissociate=
-single_branch=
-jobs=
-recommend_shallow=
-filter=
-
-#
-# Update each submodule path to correct revision, using clone and checkout as needed
-#
-# $@ = requested paths (default to all)
-#
-cmd_update()
-{
-	# parse $args after "submodule ... update".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			quiet=1
-			;;
-		--progress)
-			progress=1
-			;;
-		-i|--init)
-			init=1
-			;;
-		--require-init)
-			require_init=1
-			;;
-		--remote)
-			remote=1
-			;;
-		-N|--no-fetch)
-			nofetch=1
-			;;
-		-f|--force)
-			force=$1
-			;;
-		-r|--rebase)
-			rebase=1
-			;;
-		--reference)
-			case "$2" in '') usage ;; esac
-			reference="--reference=$2"
-			shift
-			;;
-		--reference=*)
-			reference="$1"
-			;;
-		--dissociate)
-			dissociate=1
-			;;
-		-m|--merge)
-			merge=1
-			;;
-		--recursive)
-			recursive=1
-			;;
-		--checkout)
-			checkout=1
-			;;
-		--recommend-shallow)
-			recommend_shallow="--recommend-shallow"
-			;;
-		--no-recommend-shallow)
-			recommend_shallow="--no-recommend-shallow"
-			;;
-		--depth)
-			case "$2" in '') usage ;; esac
-			depth="--depth=$2"
-			shift
-			;;
-		--depth=*)
-			depth=$1
-			;;
-		-j|--jobs)
-			case "$2" in '') usage ;; esac
-			jobs="--jobs=$2"
-			shift
-			;;
-		--jobs=*)
-			jobs=$1
-			;;
-		--single-branch)
-			single_branch="--single-branch"
-			;;
-		--no-single-branch)
-			single_branch="--no-single-branch"
-			;;
-		--filter)
-			case "$2" in '') usage ;; esac
-			filter="--filter=$2"
-			shift
-			;;
-		--filter=*)
-			filter="$1"
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${quiet:+--quiet} \
-		${force:+--force} \
-		${progress:+"--progress"} \
-		${remote:+--remote} \
-		${recursive:+--recursive} \
-		${init:+--init} \
-		${nofetch:+--no-fetch} \
-		${wt_prefix:+--prefix "$wt_prefix"} \
-		${rebase:+--rebase} \
-		${merge:+--merge} \
-		${checkout:+--checkout} \
-		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
-		${depth:+"$depth"} \
-		${require_init:+--require-init} \
-		${dissociate:+"--dissociate"} \
-		$single_branch \
-		$recommend_shallow \
-		$jobs \
-		$filter \
-		-- \
-		"$@"
-}
-
-# This loop parses the command line arguments to find the
-# subcommand name to dispatch.  Parsing of the subcommand specific
-# options are primarily done by the subcommand implementations.
-# Subcommand specific options such as --branch and --cached are
-# parsed here as well, for backward compatibility.
 
 while test $# != 0 && test -z "$command"
 do
@@ -233,7 +80,8 @@ absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
 update)
-	cmd_update "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
+		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
 	;;
 add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-- 
2.38.0.1091.gf9d18265e59

