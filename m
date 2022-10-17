Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77478C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJQMJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJQMJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2D11C0A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so18124349wrb.8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5tDlZAfs9NG7IjOyYYDM1266ReOwwGb9qNWRapPp04=;
        b=LBmxegU50Fh9EG+dPQYDYsV8BCaIh0YID3CeqyqsmLvgLHGYK1qvY1U4fGUGxwhgUu
         4+D/hr+cJ0CksYWaT7FxUpOVPqCg3f8gnOlH29QJT1nWBj/7GTmdwQAeiqL9e6eMeY2I
         s0Sx5BnnXBxOEi4pFU5Kup316H+dEXUnJjmTq6jQP4GoUPdiNTMOPBLpVxybA/d/CZGw
         Sgq80TcF0ttuuPYWR2cKQtqqSQWAQ0xBKQfv+4nOLrH5dc57xCPkLZk0sEvLx7S8Rx+K
         /0EFHtWRvqhPLF+qJwzDkhd9aJC5xN81TDa+NdgAXEVbTqckcM/fQZDoSFJmXIKvz6Y2
         qEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5tDlZAfs9NG7IjOyYYDM1266ReOwwGb9qNWRapPp04=;
        b=oZPX5UrJbKx5CSbib33ctRux3BRjbzWH9rZ2TETmQ4CH0JUuiiu7EOY6kRufFb6gS+
         FYVNL4POl23oRYrGBiGfvSzDZq9awWin4wi/8tSeoEMu4hB4ZZuebCN1V5U+gFymOo6D
         3BJANFqlIvNkhmu1AbUDe1NjkkKsQO++sJwVfK/JiGA+xCPdjuBr9s9eLWCK3BdpbOCT
         BtdRkJn9WIEcIDY1NEPVD3aNauVWQhxGQPsH12GeiNYZvuLMuL6h4XUubB326ZJsPOJl
         cQRBSP1gCJjDNdczI1PewwAcxXAPo5jNCsbrm4Eo0vG2ttAFLwxoHSmkiAKO04vCFZjj
         GAiA==
X-Gm-Message-State: ACrzQf0ugipBUNQOhmxHwBWsFrejiuNAnw0pigY5cNdOvMPLBXPRchpD
        kEOMqSlFDdr2Av26QFziPFKzz/CKo2Fu6A==
X-Google-Smtp-Source: AMsMyM5+fyoBvIpD5VQjBQ2ngPKvjsLYcnkiw149Eoz8oFVCl4ILgWqXf3ZK7sNGWmTTfp3pnN+Szw==
X-Received: by 2002:adf:efc5:0:b0:22e:4a6:2d5b with SMTP id i5-20020adfefc5000000b0022e04a62d5bmr6103894wrp.293.1666008572014;
        Mon, 17 Oct 2022 05:09:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] git-submodule.sh: dispatch "sync" to helper
Date:   Mon, 17 Oct 2022 14:09:17 +0200
Message-Id: <patch-02.10-46bf600820b-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
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
index b851d64aa62..3fdfe864d37 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -521,39 +521,6 @@ cmd_status()
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
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
-			quiet=1
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
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
-}
 
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
@@ -607,6 +574,10 @@ case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
+sync)
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
+		${quiet:+--quiet} "$@"
+	;;
 *)
 	"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
 	;;
-- 
2.38.0.1091.gf9d18265e59

