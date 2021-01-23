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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF70C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5925F23139
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAWT7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbhAWT7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50BC06178B
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so8376951wrz.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ohpT1dyG20gefcxLzQYcOZmK85UKoGo+762jzBHebhM=;
        b=GSs1jB2zzAo3ixnyPhrl3fFKucunFeitlmxxns08wCF/IRms9yJOnXjyPBU+hCkzp3
         0KfwauBlPTpE5tKiOBS6sN2jjrIGhel6D9eNJ9Oqjq5oSMON23mNayix2t3p6Ujlrimu
         7x86X+ESfM91G7tT0efRUaMUncRN+VTsxF868yPP/JrTBhAa7KvL+ZejkyKZ4f2ZsTZD
         Xymz1T9PZZ/HGymcUcXZcPgpW8RTM7gdU1mLdudOkb4kfTy8e+mCFb9Jw9n9c8EDLckb
         8OWKCCrvXpP2qAv34MzAw9NmDehui2pPcKrBBjv0Vz9YsaYo8HdrICbVch82vaaTA4MJ
         jJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ohpT1dyG20gefcxLzQYcOZmK85UKoGo+762jzBHebhM=;
        b=Oq9TpZlD92N79rh97oH3BB3VOxbiJqpTz0KmB6AWXgQRL7lUGRkUjqmeYXAWF968r4
         SKe5MYPOSyBi15F7A+lOOekAGuGdM4Z0e+6uOMHZKtpfp+R9HLxBFkDrFMVcQpoYMGCJ
         OrLu6GsSFljBPUTshACUOEWLI1cGCsaYv3TRO/l7JmJ9SL8hmDZIKLB33BgcPkFNBIBQ
         lY3l704x+cHzMLhxDBWBlioaquxclpXbr6hvAjFj9sj7AyrOLE+Czw4uTD4g+h/U+hoJ
         cnTEhIl7OvuXYld1T+WQhY31iwqiGoPakg2D0TyCYrEwCjp2AxfK+HowpEk3GSCs6ABl
         e7tQ==
X-Gm-Message-State: AOAM533jWLl4lVd9hMF1ofT8/ij27+81zBzDmyJWoWBBt2DMoDR3YAD9
        rV4INJYxVCmziIlK1T7kqijLqkJKsFY=
X-Google-Smtp-Source: ABdhPJz+RG1++iKUaBQJfF7Lu62Zrvz5bRYX5gf2hGdJgwUJAOk4HydkMOPOd4+vGlHvivTh2Lh7GA==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr189014wrh.260.1611431904702;
        Sat, 23 Jan 2021 11:58:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm16617552wrj.11.2021.01.23.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:24 -0800 (PST)
Message-Id: <4e688d25f8c7949dd3edbdb47b924450d9a50796.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:14 +0000
Subject: [PATCH v3 4/9] fsmonitor: de-duplicate BUG()s around dirty bits
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

Be sure to add one when checking if a position if valid, since the
minimum is a bound on the expected size.

The end result is that the code is simpler to read while also preserving
these assertions for developers in the FSMonitor space.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 fsmonitor.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ca031c3abb8..fe9e9d7baf4 100644
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
+	assert_index_minimum(istate, pos + 1);
 
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

