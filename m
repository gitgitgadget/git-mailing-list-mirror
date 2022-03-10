Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A262C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiCJN6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiCJN6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D024141FF7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so3435372wmb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qo0XRDn9CWFxeoswMkxUtUpU2NAJRZIfnj/z5vohKz8=;
        b=gOLxJksW4V1NCY8M97k9wTsNvpMALMkBR8KAoH/zMVOvSHIk2ALGoOLmj48JTQvA8Q
         H+FbZ1pq/W2UO6Q325kGRA4OylZsYYtmy1CD0EtNYRyIxNGdBy4T7A5pDCtPTdBvuaKV
         DV6OC4DVIGN8wHpBgPNQ8VOnyobGE8XSembGkM0tL1OkchxlPFZekevKAL7Gsw8Abe48
         zqf5S18YDYFQ3NDxPAxitC9+TVshRK1oT9ZXxZcADWg3kYNlIsNALIsGun9t/batNjjB
         q3jEWuY+0cieUQdESGjCrgljZ4C7pxZ1ZQkJniSLs7AbW3KNk/SFy9UlAJrdLqKZYlj+
         QXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qo0XRDn9CWFxeoswMkxUtUpU2NAJRZIfnj/z5vohKz8=;
        b=P+bCUSax2GZAmizcEqzE1ynEikSQjRMWbG3Ebj71EtbyaORUukcRdehcakOvVb10wb
         fN+XTOHWx/4Y/EW6GPGOac4I6W88tQ3/j58DpFiOp25tmwi7HOqD21cGht3HoSIPO2dq
         6f2/113jkB7+7mOouZYM4lSvqHMy08IJ2R+8z8+MgYqpGIkDhDHpO2dO8eRY0qV2GmF+
         YS4kO1MKBgn1RTBN3gTDR30BWlIqtDUkpIG7OAaYOfKvlKOmuueXR2DpZ3YaTz3H+21i
         PHuUYCyyRiDgUUvsgefaS39O32pSwJQGFNFKDaL4habLiANI8RbY/7BOBDzTCd7yieoh
         hPnQ==
X-Gm-Message-State: AOAM530atcDvqaWeIZKVO9xGcwp73EwmZyRX1SynZUHuH89f+LWyt/0q
        dYtGxsLJyZJQRwxN4OPLqW1tC4v1JusUqA==
X-Google-Smtp-Source: ABdhPJwizK0TE1kseq0/n9FiPuJMaIRSqJfSr8/VS4q6bqDn1OTynFcOHS2qKiVtAIpC4dqSUmVfAg==
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr11634176wmk.109.1646920629798;
        Thu, 10 Mar 2022 05:57:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 2/7] ls-tree tests: exhaustively test fast & slow path for --format
Date:   Thu, 10 Mar 2022 14:56:58 +0100
Message-Id: <patch-2.7-782be37daa6-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these tests adapted from my initial version in [1] to
exhaustively test both the fast and slow paths of --format.

In [1] there was a "GIT_TEST_LS_TREE_FORMAT_BACKEND" variable to
ensure that we had test coverage for passing tests that would
otherwise use show_tree() through show_tree_fmt(), and thus that the
formatting mechanism could handle all the same cases as the
non-formatting options.

Somewhere in subsequent re-rolls of that we seem to have drifted away
from what the goal of these tests should be. We're trying to ensure
correctness of show_tree_fmt(). We can't tell if we "hit [the]
fast-path" here, and instead of having an explicit test for that, we
can just add it to something our "test_ls_tree_format" tests for.

1. https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cb717d08be87e3239117c6c667cb32caabaad33d.1646390152.git.dyroneteng@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3104-ls-tree-format.sh | 89 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 56 deletions(-)

diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index b86941c2024..12105115eaf 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -22,79 +22,56 @@ test_ls_tree_format () {
 	opts=$2 &&
 	fmtopts=$3 &&
 	shift 2 &&
-	git ls-tree $opts -r HEAD >expect.raw &&
-	sed "s/^/> /" >expect <expect.raw &&
-	git ls-tree --format="> $format" -r $fmtopts HEAD >actual &&
-	test_cmp expect actual
+
+	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
+		git ls-tree $opts -r HEAD >expect &&
+		git ls-tree --format="$format" -r $fmtopts HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "ls-tree '--format=<$format>' on optimized v.s. non-optimized path" '
+		git ls-tree --format="$format" -r $fmtopts HEAD >expect &&
+		git ls-tree --format="> $format" -r $fmtopts HEAD >actual.raw &&
+		sed "s/^> //" >actual <actual.raw &&
+		test_cmp expect actual
+	'
 }
 
-test_expect_success 'ls-tree --format=<default-like>' '
-	test_ls_tree_format \
-		"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
-		""
-'
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
+	""
 
-test_expect_success 'ls-tree --format=<long-like>' '
-	test_ls_tree_format \
-		"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
-		"--long"
-'
+test_ls_tree_format \
+	"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
+	"--long"
 
-test_expect_success 'ls-tree --format=<name-only-like>' '
-	test_ls_tree_format \
-		"%(path)" \
-		"--name-only"
-'
+test_ls_tree_format \
+	"%(path)" \
+	"--name-only"
 
-test_expect_success 'ls-tree --format=<object-only-like>' '
-	test_ls_tree_format \
-		"%(objectname)" \
-		"--object-only"
-'
+test_ls_tree_format \
+	"%(objectname)" \
+	"--object-only"
+
+test_ls_tree_format \
+	"%(objectname)" \
+	"--object-only --abbrev" \
+	"--abbrev"
 
-test_expect_success 'ls-tree --format=<object-only-like> --abbrev' '
-	test_ls_tree_format \
-		"%(objectname)" \
-		"--object-only --abbrev" \
-		"--abbrev"
-'
 
-test_expect_success 'ls-tree combine --format=<default-like> and -t' '
-	test_ls_tree_format \
+test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"-t" \
 	"-t"
-'
 
-test_expect_success 'ls-tree combine --format=<default-like> and --full-name' '
-	test_ls_tree_format \
+test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"--full-name" \
 	"--full-name"
-'
 
-test_expect_success 'ls-tree combine --format=<default-like> and --full-tree' '
-	test_ls_tree_format \
+test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"--full-tree" \
 	"--full-tree"
-'
-
-test_expect_success 'ls-tree hit fast-path with --format=<default-like>' '
-	git ls-tree -r HEAD >expect &&
-	git ls-tree --format="%(objectmode) %(objecttype) %(objectname)%x09%(path)" -r HEAD >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
-	git ls-tree -r --name-only HEAD >expect &&
-	git ls-tree --format="%(path)" -r HEAD >actual &&
-	test_cmp expect actual
-'
 
-test_expect_success 'ls-tree hit fast-path with --format=<object-only-like>' '
-	git ls-tree -r --object-only HEAD >expect &&
-	git ls-tree --format="%(objectname)" -r HEAD >actual &&
-	test_cmp expect actual
-'
 test_done
-- 
2.35.1.1295.g6b025d3e231

