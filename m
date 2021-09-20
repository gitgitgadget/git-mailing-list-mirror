Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09473C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF70461211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 00:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhIUA4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhIUAyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 20:54:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1DC1030BF
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so32086870wrc.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=098eEX50Z/eS3AZWOiMa5VUm9U4YsE42KDjUAll0ROs=;
        b=XjeJSpYaYdEQjuvRQfHy0VRo3rb6s/fwWLa5pImWraYp7Isk4gUamTxdvpG6P20eY2
         /5Uk/nZLoJELnbb4oTGoiLaah1nhXaF2FiBywwn7pu7Tw+D5eefxDZkcPeYFxluT4VIM
         wge644zxUXLWyCFhBzyicrAcmZHQTA+tMFL4fPywcSuxuTVtoqtCGKW79CNuabT4RISi
         260RYp6NycoPqiNWprYPEaWiQh+4iSL4LEQUTBRYOAm0l2WLkQN1DAX2dP+35HlwrFUX
         f+8X0i2Q6S77R6NKXXosNgVLU3Gz181oyDnx5gpMCGTOlYIp+Vxgvw1wFx1Gs77i3z9k
         iE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=098eEX50Z/eS3AZWOiMa5VUm9U4YsE42KDjUAll0ROs=;
        b=41vgUoMV8ZLynPfIrFRG1NoUPn17he9BZHpJW0Abiyi/tZ1JsWeZf4DUIMyuKep/dk
         +SB7ET8ZwJ5g5VLqgz+2nFtYJHftTH3TXI+xVcksjscG6Q0CtkklsRDKhRhSTG0c4ueB
         iIKzYG5dLeP0wzeAhePsQT97FWdpNuBxEYY1U8xOayXwZCT8nwhHTpkvBdDmk3/Iv+DJ
         LgmMjW0v8TaTvPcFGt5Gi93C2EwpaNkWHlBSPnKmLL3hS0nl4Oa6RUMRmp7FxlDbVHPz
         +h/fD2gaQ0zGvwlu60PUygebg7cTkYqSCY00QDw9+tA3DIxAVft+GPXdyIpi8yrzMZ+x
         7kfw==
X-Gm-Message-State: AOAM530N3cpw+Q5mjY30BuDKXloQu+vhMXIK4thrW9CmQ2avYfD6mWVr
        HGxYSkqsVjPDRJI4xMSyrPTIL06nLkM=
X-Google-Smtp-Source: ABdhPJzI3ddytG73/PTKtncvVjCm+BjUmyY5oHiR0zsjAhDfqoGwuHbplIrr6ObQVPGAjXj+qbaC8w==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr273134wmq.181.1632160660435;
        Mon, 20 Sep 2021 10:57:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm16594294wro.8.2021.09.20.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:57:40 -0700 (PDT)
Message-Id: <450b90dad57c42e37a4edc52dac88caf98021fc6.1632160658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:57:37 +0000
Subject: [PATCH 2/3] sparse-checkout: clear patterns when switching modes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Previously, when a user runs 'git sparse-checkout init --cone', the
existing patterns would remain, even if the patterns were not in cone
mode. This causes confusion as to how the patterns should work when
later 'git sparse-checkout add' commands append to the pattern list.

In fact, the way these patterns were modified was not even a strict
appending of patterns, but mutating and reordering patterns because of
how the paths were interpreted and rewritten.

As a first step, we shall start overwriting the pattern set completely
when switching to cone mode, unless the existing patterns already match
cone mode patterns. The 'use_cone_patterns' member is set to false if
the patterns fail to parse using cone mode restrictions.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 13 +++++++++++--
 t/t1091-sparse-checkout-builtin.sh |  9 ++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b45fd97a98b..fe76c3eedda 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -348,8 +348,17 @@ static int sparse_checkout_init(int argc, const char **argv)
 
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
-		free(sparse_filename);
-		return update_working_directory(NULL);
+		if (pl.use_cone_patterns || !init_opts.cone_mode) {
+			free(sparse_filename);
+			return update_working_directory(NULL);
+		}
+
+		/*
+		 * At this point, note that if res >= 0 but pl.use_cone_patterns
+		 * is false, then we want to override the patterns with the
+		 * initial set of cone mode patterns.
+		 */
+		clear_pattern_list(&pl);
 	}
 
 	if (get_oid("HEAD", &oid)) {
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index a429d2cc671..af0acd32bd9 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -108,7 +108,14 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 	git -C bad-patterns sparse-checkout init &&
 	git -C bad-patterns sparse-checkout add dir &&
 	git -C bad-patterns config core.sparseCheckoutCone true &&
-	git -C bad-patterns sparse-checkout add dir
+	git -C bad-patterns sparse-checkout add dir &&
+
+	git -C bad-patterns sparse-checkout init --cone &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	EOF
+	test_cmp expect bad-patterns/.git/info/sparse-checkout
 '
 
 test_expect_success 'interaction with clone --no-checkout (unborn index)' '
-- 
gitgitgadget

