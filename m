Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCC2C2D0BF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2498206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0lifen6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfLPPsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:23 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34998 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfLPPsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:21 -0500
Received: by mail-wm1-f50.google.com with SMTP id p17so7251770wmb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5MgGYeWMCCRYnae/q9iD5uMWOQfLIJcWu0JLO6ISVv0=;
        b=l0lifen6BYvK/XFiVXg2Kv/rTotX7m89Nk3c7h/sXBv2JovE5VkI77MEaPcC6THJPq
         6rMNNo/rvXjqXwizyTNPwhChfkpx8/Z/Aga/TqXuPAI2H2t7VKGo8SX2MARQokdaACoS
         2HSd8X0wxl4hDGNn7k4pS7sO6vHTvcmu5Nke1uAQCH3wQR2U+muxDQbAzscFSldVcSFT
         ZaE1gVmkd5Jq38S496XSty9ckSgfmMPkxW4ycGUUpkN9/uaHQs5Z8LWe3b5ar0ZX1f4f
         J3NJKI9srSLtJOLBQbMVgNVDPEl9YrDlbn9dUTowPvDIPsFeAqT9HDeezAOIUAxputaW
         iW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5MgGYeWMCCRYnae/q9iD5uMWOQfLIJcWu0JLO6ISVv0=;
        b=ZqI0+Luue/ad7jB5ApEVgpost1Hl3kbcbaK1+hKI9lsrGi4m1gURrTuzfeZ80HodHF
         MRNA5DmmnFXJfckmMpHxy5S2KMPs8KR46u22R30bwisfW9IpMddj7VafT2uj2602fonh
         lpyN9WDHf36kh5pY6BvTwNKD4yi9YCiNSnAWS9rr2TT9xJxhiLTbL2s5jVx1WDJc02qk
         wIlK1GPQxSen54WrgrrjPZYb1FYxx7Qc8IF1tXtjVjwOMZjdPYJRb/d5WEvC5DzmACk2
         8KBZtLPxiFM1LEyUR22OLw0qgrPy1prY60s7kegZZGoUfRZKhCtkh+OUyNir0CdhkuuN
         /aOw==
X-Gm-Message-State: APjAAAUq5PEtDHon/xJi4fa01zLP4GjsJ/ja9FwJqWHkr6HGsfumyolI
        5lOSb3cLs4uE4+M2aq71qs2Bkkzj
X-Google-Smtp-Source: APXvYqyHa7+5QC5Di0C0Ey4O4nDwnVUuSqMAQ1fAk3l1m5sWoKkJNOSNfvT0yGN/27+Tg4DJlkhfyQ==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr33061172wmc.42.1576511299773;
        Mon, 16 Dec 2019 07:48:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm21699174wrv.39.2019.12.16.07.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:19 -0800 (PST)
Message-Id: <542eb709cac341e038ef04f0107e3d2dbaddf97a.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:48:05 +0000
Subject: [PATCH v2 17/18] t2024: cover more cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

After working on `parse_branchname_arg()` I think that these cases are
worth testing.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2024-checkout-dwim.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index c35d67b697..fd993bf45d 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -156,6 +156,33 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_branch_upstream baz repo_b baz
 '
 
+test_expect_success 'checkout of branch from a single remote succeeds with --' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	git checkout baz -- &&
+	status_uno_is_clean &&
+	test_branch baz &&
+	test_cmp_rev remotes/other_b/baz HEAD &&
+	test_branch_upstream baz repo_b baz
+'
+
+test_expect_success 'dont DWIM with pathspec #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz nonExistingFile 2>err &&
+	test_i18ngrep "did not match any file(s) known to git" err
+'
+
+test_expect_success 'dont DWIM with pathspec #2' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz -- nonExistingFile 2>err &&
+	test_i18ngrep "fatal: invalid reference: baz" err
+'
+
 test_expect_success '--no-guess suppresses branch auto-vivification' '
 	git checkout -B master &&
 	status_uno_is_clean &&
-- 
gitgitgadget

