Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303EC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345792AbiFJCCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbiFJCBz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA7718360
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s1so11523121wra.9
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PH0DHYFyM1zUOYBJNkj8Rj0V7ppES2EGrEmcZOyc6Zo=;
        b=S13iOPeK+OY3B2wgm24P0kJslKCLnzs//ae9t+OJywms770kTcnY+G2A5Zb9NJA4VZ
         EaUpUqFYGxFQOE8Mn8YPhO4GnmRryGgZTOjlmrNtMuyJEmxIPGGWMIjlfmS2tWT/nMGr
         DEbop+O7EtqPT5WV/pLyEOKRu5ckRRjr8qMI1FgLVk5+KbbwruyV0+YXpTlGzI9dUwlE
         llf/+1rC8Jq6+nQlqeReJIn9r2do7Uqc/D8SFqr2oVbfKy2AapHRLs7JF24jiekdXyML
         WVjzc0pgw2wsnJ6qUYF+nwOZnlwf4Y2kN5g82SVB2YPcuNv9E2PHatLveVqb8hxvEjaW
         u2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PH0DHYFyM1zUOYBJNkj8Rj0V7ppES2EGrEmcZOyc6Zo=;
        b=VwRoEF0nE/G5fwdhq5JaZ8satuD8qadQxTtqfBataI4RxtfAJXEY3hOZoka7ayOMcI
         NnHIuza5STw8n0ibaSg55PtnwFYNZPh10PEOPzsyTjggo7L5onqlBiCvRCk7JW5IdJZs
         ViYwAagTqpN/sM6VsdzlYg48xDMN7eplMXbfkI7PJ66ZPMqxW/veC1MsOB4+oSVwguZM
         OhJe3ZbwqFSia44wiYa9LUa+8ocAnSnKMvl3gKAzhlNHmOCTqwFvQWx+Q/unCPHmfFdM
         r7omQuIsZ0TLLL+r9b3l0U9J/LmEaqzFb6anvd6ftBmpooaXTV/L1rGPmfNPhMpRkELA
         3vMA==
X-Gm-Message-State: AOAM530F9VNUK8JeZxiYfro+vi6TwAtd3h7+k4PB6WMQJy1j6iFyEhX6
        9Ylrp2jI7yjCQ/q82ZoCxHjWRZBajBbE+A==
X-Google-Smtp-Source: ABdhPJwEQZPCLwFtLCf9rg1YFO3b2TRJWJeKWuA6eWTJwUm2ovkxMUnpUND72vewlAHHbR4Wn3dVeA==
X-Received: by 2002:a05:6000:1091:b0:213:b515:f46f with SMTP id y17-20020a056000109100b00213b515f46fmr37736833wrw.632.1654826513228;
        Thu, 09 Jun 2022 19:01:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 09/20] git-submodule.sh: dispatch "sync" to helper
Date:   Fri, 10 Jun 2022 04:01:21 +0200
Message-Id: <RFC-patch-09.20-bd0e4a4f8b8-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the cmd_sync() wrapper for "git submodule--helper sync" in
favor of dispatching the raw command-line directly to the helper.

At this point we've already parsed out the optional "--quiet" flag
that we need to support for "git submodule --quiet" (as opposed to
"git submodule <subcommand> --quiet").

This changes the output we'll display on invalid usage for the better,
before this we'd emit e.g.:

	$ git submodule sync --blah
	usage: git submodule [--quiet] [--cached]
	   or: [...many lines of "or" usage omitted...]

But now we'll emit the much more useful:

	$ git submodule sync --blah
	error: unknown option `blah'
	usage: git submodule sync [--quiet] [--recursive] [<path>]

	    -q, --quiet           suppress output of synchronizing submodule url
	    --recursive           recurse into nested submodules

This is because we'll now get as far as module_sync()'s failing call
to parse_options() when we have invalid usage.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index fb13f818c63..ddc2e4e4032 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -520,39 +520,6 @@ cmd_status()
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
-#
-# Sync remote urls for submodules
-# This makes the value for remote.$remote.url match the value
-# specified in .gitmodules.
-#
-cmd_sync()
-{
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=1
-			shift
-			;;
-		--recursive)
-			recursive=1
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
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
-}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -606,6 +573,10 @@ case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
+sync)
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
+		${GIT_QUIET:+--quiet} "$@"
+	;;
 *)
 	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
 	;;
-- 
2.36.1.1178.gb5b1747c546

