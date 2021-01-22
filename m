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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091DC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D320023106
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAVNKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbhAVNEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:04:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318BC06178B
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so5032172wrz.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3tMIyV1e5H7KibNfv8wSK28+QZ3PH8wQIwxwCCv8pUg=;
        b=Boy8cQm8ptlsJIrilo/AHMAgYpnh+eHBoYH+tLfKqYkSHjBFokU22gNEKGd71k1Cgw
         HrVNeeJWTlUZwtycQ54uxODNem6yWttl9eyRbHcLDkQSu4MlDKNG4N/F07zNzCtdfJ4k
         /CjulU9OlDxjF07TBSa4yzDh2TjSH148ZVhk1jWUh3qx6hJLRg7uUj8/+coUetiSnRIq
         cI4aIqY1qH7ukrap7pX4D2X0nq880CoGwWub52v90IX1VjrPdMafFRlBE2xPuVt+BcQc
         ULJ+PkW14HI19662T/D30Yh3PAFWCPPkLRPqQ6DbvICoYsiKodQ9VXLTtLUJOUiUDF7P
         R78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3tMIyV1e5H7KibNfv8wSK28+QZ3PH8wQIwxwCCv8pUg=;
        b=ebgbzoBrBNWDhl5Vn56QmM8oQtKq8jROpF2uOLuINMoksOq6K0eR9ukm/YyBFyOn2E
         yG8azK4njvNllopR4u65koAfZzceiGfpokglTwJVeMN3p6PbiULTEIBIdcCEA294gOmw
         JBW/V8xwwxD8trw6CKA7eMTSIEX6dBeVqIXQ8D5aOsExOcPAUgtd5RIGJKd3PgwAoY23
         aAW7nqI+fzHwUJNiWcOjYMqbREBQla244kXzWzvH06sWvK5TGnN84gbR65cLWLdbHunV
         z+n5msmbZ6Z9DdLwblPmQz8eb7H2feIHMENT5yKqTBMbEEQs3QbPUU/32zezPJxutw1j
         S+JQ==
X-Gm-Message-State: AOAM532aGJiGCDDACi3Y9bJcu09tMZB/uznPz3R3io21ZxxwDXRCnRm+
        SrpK4cFTLADgyV3eXj2YBk4KqxJiotw=
X-Google-Smtp-Source: ABdhPJw7UURN4Sb2m670+T+DSg2IikPKf/7YziMExqRSv00Bd8TbBqjGUg5aID79Q1J75Td0XRRJwg==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr4440179wrp.312.1611320644028;
        Fri, 22 Jan 2021 05:04:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm11532321wmk.20.2021.01.22.05.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:03 -0800 (PST)
Message-Id: <31095f9aa0ecd29193cc4d612d1953653c04b8ae.1611320639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:54 +0000
Subject: [PATCH v2 3/8] fsmonitor: de-duplicate BUG()s around dirty bits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
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

