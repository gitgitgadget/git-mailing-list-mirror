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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA3C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903CC6135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbhDLVIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbhDLVIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68854C06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so5292130wrt.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YIfeJaOwJ2PF4AvCIcf7mIqwTKwspa0fWugQUcTQFgU=;
        b=Tpi/Wu9DoY2lKhArje/+PMkhtrbO9ugMdIW6eSDV24Vz88Tuck00LAC2c1rh9gTw/U
         jUt2Avhqb9Fde26xAnd24Cl5skFIthywti2/xRM5t6+czuX2+bu74euQeaUSM11Tu5zB
         tyhzbVbAS5FQYriQ+XFmucocNmhi5mwAXk6RVOlfUvwr4fmFz/hQ/oxtnK/aVxDcYbvo
         EgQNiUgZdawo3mELlxkdCOP1tE+SarcMcYIFpgRtxOjkFOeNbN11iUuUlbR5VC4G8E96
         1ImpTXgL2Yvq0b0SVRgRg8Yw9ESTEJg9x0zQlzqaPKmRUoTqeUC+JoMwdWJllPBWV/fJ
         IDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YIfeJaOwJ2PF4AvCIcf7mIqwTKwspa0fWugQUcTQFgU=;
        b=k/UsNzGIiRb7joWCZPJFiBUpnC3fzujK78cLrnWGogr+PHoilB0rW16DK6Mzw7DiQd
         /rp0i7qiSNWcWTWyuqSjxPppkwVlIlTFnDaBE0LxQZ4kgZqNsBXSwh8qymq4RPcIFRFD
         G8TXu9zvXHyST4LaKMyIdG6MwfkvGqPAExaxMJAsBIWJ+t35j2MVyvzo+VLDiPlROPJd
         UpiU59YlccC6mvDrb2p9BdIAkwXQlbPyAYh/p4EWqPxK9xRQg8C9xWAAjaQ1K97IFco4
         4sBxEhgCUz+09jARAGVAYAEHu9gwtqsSZQNkGFU5IzRN6B48xhlQaCdtMN+lkyve+h3u
         Z/sA==
X-Gm-Message-State: AOAM532gYhD3clEZD7OyxrSNE9wIMiSX1Kh3RuLwX0WlXiUCCNby5qdb
        l5GfT3h4duL8Eze/9FqYDX9yZQvpdHw=
X-Google-Smtp-Source: ABdhPJyyyuDpjmZujFp9tZmBbPx9AAsfdR8w8+rv4ciIQIN34Gnfn52LsnYIjHxFx+S2k9j6lhViIQ==
X-Received: by 2002:a05:6000:190:: with SMTP id p16mr34880715wrx.70.1618261703273;
        Mon, 12 Apr 2021 14:08:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm18113993wrh.5.2021.04.12.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:22 -0700 (PDT)
Message-Id: <0082855b59617f6f04f36024d79e99c4d8f303b7.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:57 +0000
Subject: [PATCH v3 06/26] checkout-index: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before we iterate over all cache entries, ensure that the index is not
sparse. This loop in checkout_all() might be safe to iterate over a
sparse index, but let's put this protection here until it can be
carefully tested.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 023e49e271c2..2c2936a9dae0 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -119,6 +119,8 @@ static void checkout_all(const char *prefix, int prefix_length)
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce) != checkout_stage
-- 
gitgitgadget

