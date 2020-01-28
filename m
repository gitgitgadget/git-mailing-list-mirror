Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B36AC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BDE22522
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJgWSHX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgA1S1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:27:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42386 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA1S0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so2534292wrd.9
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7g3RInPRozRcqfiodm1wMBj88ZZT+XDAcmQ//AaX4/c=;
        b=lJgWSHX7TDrSc1e09R6TUF4el8i5aIHY0U0OXTT10fhm6vK4493tZPtRqVz0rmwQg5
         /We+0ERfTgwXqc1AHg3zu0iDpqH0IVguQOdtxPNG0665fWNyBcmEZtO3WkCEtYSsHi4j
         bfbvThofMArfLR1djxW58wTIfUcKyLqsnf5styULFj6Xy1GnLLhA/hJPiif/DpL3ghcW
         JNJqJPpiZbrNz1LWRSNraw7M0YkElolAFswRXJ9d1Rx1lAGnvFTvkpEWnHkTsnc/eIBc
         mmTSR2X9eyNCY6LMZt18rMOR2nScm/Sr5ohdmbsu0aHvAZDzia5YkqJCVelZittXDNkw
         LIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7g3RInPRozRcqfiodm1wMBj88ZZT+XDAcmQ//AaX4/c=;
        b=BPXDcrW/lHE+T1ik4HGZn7BpUt0LIhKuA493c3QB3q50DGbSzdmL4RY7Wjv2FvxbuY
         gbwcafLnzoe2FmI91PXaUL4ocL8PRIb9VCaIvlfnFFPWpyYoctlNO4pDfS/OMONPg+wV
         xbw0BmX1MTpqWIhkN3D2vTxBmuH2u788TZCCeAGbHVeYvJV0I7UbJFQruCXxPtAw23Cj
         qltOmquztYwS6m+G918VAmKRjgcqKUgoZoViwP6hZw6/6U4Mize9YPa29P9oUQ+pprwm
         rMMtoKrPHZ8HzC5t3bZj8b/LdKEuVWp8QRvkaSOtyud26/zBt7MCHD7TIEdZVDyWrCxJ
         +4PQ==
X-Gm-Message-State: APjAAAUnIl1IIGiHybrLhQEdAyjcc5CkgE7lEIL2QJjWjkTxwyfzSzoX
        NnYtFhbIhGwwj6Aj84W+c4re2TlK
X-Google-Smtp-Source: APXvYqzqx0RvlpF3NL4pjxvLyDi8j+/r0uYwSZAhJicxR2tURGKplMaE4Rg50iGySJaia+O5UWZ0DQ==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr31790245wrt.254.1580236010033;
        Tue, 28 Jan 2020 10:26:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm27237975wru.16.2020.01.28.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:49 -0800 (PST)
Message-Id: <aace0645107719f62c611296adc44f8c286d8403.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:38 +0000
Subject: [PATCH v3 07/12] sparse-checkout: detect short patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the shortest pattern the sparse-checkout command will
write into the sparse-checkout file is "/*". This is handled carefully
in add_pattern_to_hashsets(), so warn if any other pattern is this
short. This will assist future pattern checks by allowing us to assume
there are at least three characters in the pattern.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 3 ++-
 t/t1091-sparse-checkout-builtin.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 40fed73a94..c2e585607e 100644
--- a/dir.c
+++ b/dir.c
@@ -651,7 +651,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
-	if (strstr(given->pattern, "**")) {
+	if (given->patternlen <= 2 ||
+	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
 		goto clear_hashmaps;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e2e45dc7fd..2e57534799 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -339,4 +339,13 @@ test_expect_success 'pattern-checks: /A/**/B/' '
 	check_files repo/deep/deeper1 "deepest"
 '
 
+test_expect_success 'pattern-checks: too short' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/a
+	EOF
+	check_read_tree_errors repo "a" "disabling cone pattern matching"
+'
+
 test_done
-- 
gitgitgadget

