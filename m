Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D933C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702F164EC3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBAWDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBAWDN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A3C0617A7
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l12so18303302wry.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tUd9omKSffFRsXV7K6/6DEhbnGyQp25YksuiGbwNKKg=;
        b=nCRfBZqF3NGu82P8kUXz3MIX9DNfsAQwEMkrVAU9/FCcTSAuqctBhFd2OE2c6bnqeb
         pxXPBcC+CWLbrJPKNDCd+6aDLConU+JuN1R+iaZU1m7zpfZuVSgy9KNi9mEeJ1mOdULQ
         dNO9n/K7QoxzG+ZjwNyUKxRv+wTEZ4pJpKtGRzbcNw9UU7tzFBBpkReUpNr8Jo7Dp7xV
         tk2aFQ3a4HyFumf9lf38PID2CQjei+us86RKs0XYEEL2Hu4CsVlX0onkeqGqXkReKYHC
         diKNF6TN9CswZHu35tJm9h06Pt37+GABrPXCeU50TAYRNzmjYOTLwVH6qyzrIiO96WkI
         LKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tUd9omKSffFRsXV7K6/6DEhbnGyQp25YksuiGbwNKKg=;
        b=Ca7dQu45KES+NBRI4fiB6aTnJ6ONg0PQuZVce38FqM+STBiJb2HQmxoy0B8aGrekDc
         UmbDALcwKzZnDXWUk/dNGdX4DYSyexHZsI+s+RuwBZivDME7aV40KjxfxS9FOSh3zkq8
         Hj8fbd5vHj1z4ZSyTqpD+OUf4vsZQ3F+OOncjpA5SvL7AdsHatCTJDuNx1vk9y5beyYJ
         idhPy7J59OY0MYntZr3oEWo9d2mmXSIaXlGMHQSg6A5cJZRpJyHLxUnlZySRyYgcQ6eJ
         o1El7Mcr7P78eCguE3iSnJ2TZe4oLA4Ms8yb4edD12ImsAinQiEzYv6v5h2CvXLZx1Ic
         jeyw==
X-Gm-Message-State: AOAM533GnXK/2byG230Ky8gRukpsQUaaN8P46ff2+R2nV5/emT+aBZGX
        2yt2lON5gU6CQ+qJIPn+RYTibhbzzgE=
X-Google-Smtp-Source: ABdhPJxis1lSKH347647RJoxcGxBIeVZeT99gLyprveNkDQ4tdhh4JVQADBBkN6PMeeLAt0A/rV3Vg==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr20358364wrm.207.1612216952495;
        Mon, 01 Feb 2021 14:02:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm24688046wrr.56.2021.02.01.14.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:31 -0800 (PST)
Message-Id: <edb88ffe39e1f4e69432c0feb9b803d6cbe77f87.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:18 +0000
Subject: [PATCH 09/11] fsmonitor: log FSMN token when reading and writing the
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 7a2be24cd43..3105dc370ab 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -87,7 +87,11 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
-	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
+	trace2_data_string("index", NULL, "extension/fsmn/read/token",
+			   istate->fsmonitor_last_update);
+	trace_printf_key(&trace_fsmonitor,
+			 "read fsmonitor extension successful '%s'",
+			 istate->fsmonitor_last_update);
 	return 0;
 }
 
@@ -133,7 +137,11 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	put_be32(&ewah_size, sb->len - ewah_start);
 	memcpy(sb->buf + fixup, &ewah_size, sizeof(uint32_t));
 
-	trace_printf_key(&trace_fsmonitor, "write fsmonitor extension successful");
+	trace2_data_string("index", NULL, "extension/fsmn/write/token",
+			   istate->fsmonitor_last_update);
+	trace_printf_key(&trace_fsmonitor,
+			 "write fsmonitor extension successful '%s'",
+			 istate->fsmonitor_last_update);
 }
 
 /*
-- 
gitgitgadget

