Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC2C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A050523358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbhATQzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403913AbhATQyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:54:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E6C0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a12so23741140wrv.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3tMIyV1e5H7KibNfv8wSK28+QZ3PH8wQIwxwCCv8pUg=;
        b=h0fNgGhKlyAu0s9wZVwkgSt1FokDrb2Yh1Nd5crgRHgCXNl19m4YNsGBDClL1VGkDk
         FsWcmZjTOE99xKLafM3VMEkv/+CKKq+L4sUeGGqXhCMLeindW0MDF0Zk+NwJGQmenOH6
         QhoX59ZTayoP7vDzxJkDXwtiNmI1On057tev4tmFhIHGlfWGsx9oaApg4UEWsMySvSlk
         yuy8x2ye/ib9StvJeDfPH3/QHq6185uiNYtXk8xRkaOvxtZZd9zt2vwYL9vfRyxMMaTS
         4+DEPSbI/4oMeKFdTA2DxVw0sqmagqt3mCJyqVU55KYT5hdiGlN1Lm7BouLljVNSMNgY
         e3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3tMIyV1e5H7KibNfv8wSK28+QZ3PH8wQIwxwCCv8pUg=;
        b=PkZeLIbqnhJdthpuhvvGNecQAagXtYYxFX+UMWJYWxll33WhKlBMA3w4yx1EmPcpUL
         hXbYzohpiNB2KslHeKK75Mj/5mxjVIbAU0Zf23/m8dLKt1GzKKHOQkH0EiRJDjM+w0s3
         o8HhnpuiZ3AaKR0vnFCxP7McuZgJwxIxfqwrk3PkxwT1wKpMsK2BaMYSZXEFG6nmSS2d
         mmOMp78wWz+Y64yG3oiLSwuJUQcFMbCeJAmF2roCMJTdnF5liVbLw/33xO87wcRsVEkW
         du1kNkuWe3H0ByzwTQ+E5GGp3MzuoVT8A5C1pfbcvU9TU0UHmUmFEYTGmh4TpzCydClA
         LGow==
X-Gm-Message-State: AOAM530sdnKHk8cfTqSG3RwxYa8fFvI3t69MUmg3Hc6Da27PnvByP9Yd
        LmMLE+DULVsGBTISC8EAhLw1Bdwlv1o=
X-Google-Smtp-Source: ABdhPJxOkho8uHZof8L4XQnZAdaK0o09rJAUbtH1IEzOGidPFdwaw/rRgtAXx0783SaIcbe/lj6Nsg==
X-Received: by 2002:adf:f684:: with SMTP id v4mr10398931wrp.387.1611161643690;
        Wed, 20 Jan 2021 08:54:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm5776714wrg.76.2021.01.20.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:03 -0800 (PST)
Message-Id: <838922de2e9756c00f4a159b2b8722ae4d28b011.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:53 +0000
Subject: [PATCH 3/9] fsmonitor: de-duplicate BUG()s around dirty bits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index has an fsmonitor_dirty bitmap that records which index entries
are "dirty" based on the response from the FSMonitor. If this bitmap
ever grows larger than the index, then there was an error in how it was
constructed, and it was probably a developer's bug.

There are several BUG() statements that are very similar, so replace
these uses with a simpler assert_index_minimum(). Since there is one
caller that uses a custom 'pos' value instead of the bit_size member, we
cannot simplify it too much. However, the error string is identical in
each, so this simplifies things.

The end result is that the code is simpler to read while also preserving
these assertions for developers in the FSMonitor space.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 fsmonitor.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ca031c3abb8..52a50a9545a 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -13,14 +13,19 @@
 
 struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
 
+static void assert_index_minimum(struct index_state *istate, size_t pos)
+{
+	if (pos > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
+		    (uintmax_t)pos, istate->cache_nr);
+}
+
 static void fsmonitor_ewah_callback(size_t pos, void *is)
 {
 	struct index_state *istate = (struct index_state *)is;
 	struct cache_entry *ce;
 
-	if (pos >= istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
-		    (uintmax_t)pos, istate->cache_nr);
+	assert_index_minimum(istate, pos);
 
 	ce = istate->cache[pos];
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
@@ -82,10 +87,8 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
-	if (!istate->split_index &&
-	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index)
+		assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
 
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
@@ -110,10 +113,8 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
-	if (!istate->split_index &&
-	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index)
+		assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
 
 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
@@ -335,9 +336,7 @@ void tweak_fsmonitor(struct index_state *istate)
 			}
 
 			/* Mark all previously saved entries as dirty */
-			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+			assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
 			refresh_fsmonitor(istate);
-- 
gitgitgadget

