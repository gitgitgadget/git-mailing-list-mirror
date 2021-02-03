Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5160C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A5D64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhBCD3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhBCD3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE94C06178A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m13so22583424wro.12
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDnOFW7p/ky7+KVyj8lT1tPoESnNZ9bzBGmd+kLhGR4=;
        b=D6atFW+EUouXrKotI7rHl+S77maeoit6pBbf3+JJX97JPDiakHc5rEfkh3rgBQgfRj
         Ca9z09hQzYSg6Uwib7MLPF9n3TsUTrUYEIvR920jgOHzc3Zov4tQOe3Eu9MzvuAzA2gB
         STZ1Jl5d2Zq0U8I3bewni8jaAYYkIDA18gWU90vgScRzdvinAnssPyhagsMeU3f6P648
         DOnTcqHmPXiYEF8culdvoc5s3meJOTyffHxjBOY1XbJzfkQA2PgVacs6m+Y5FvBaUnhu
         mwtyZRd/B4Y5N1svaBprh/fRptHNSW69CJXJOqr2ioiS5VOSDLpRitN8mHXVKBauezto
         tKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDnOFW7p/ky7+KVyj8lT1tPoESnNZ9bzBGmd+kLhGR4=;
        b=CR+uBLAlKi1f/SCNu1FPjF71bizGY9ZoXCfZl6IvLL9lH0msZNKQeGwd4nEb+cUF+I
         Aj3HmnMMfyMvT3fvc5nkNzecrM95SihBciv6O5fQAlIbaaQH20Qn4gLWm1Jmw4Qtskg1
         ow9nztN0sn30dBFhPGplPXlslLLxa7umrgDiv/X9zjxcbVtHy1jf02KcLWINZaV0cerM
         SK21OOPgs98NeRwUUxOl0NRPQ8s59qa6mdFrBc/V4Zrt+S0xP6zcJz3DlSblDL9nxOIm
         ZGI9dfsv/DHM5/5S8kqb8UFMKBeuFBFZA79yPkqGlYEJ3M+QkkEvbr2aIhWwvLyfuCn8
         k6vg==
X-Gm-Message-State: AOAM5336YnNGa1xC1joTRGBmqt3qCB+m6/L8AuarJcXnITw46OIYZS1l
        xyDHqFJlVm9RkcDOTIsLM8iIPQoU/iB0wg==
X-Google-Smtp-Source: ABdhPJwzsGSjYlpY2RBmDNbG64Jxkfzv7rwS4z3jKu5N37Z/jiFQscBk8OwQ05BGuIuIIzIa/ovn6Q==
X-Received: by 2002:adf:c413:: with SMTP id v19mr1070680wrf.158.1612322901457;
        Tue, 02 Feb 2021 19:28:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/25] grep/pcre2: prepare to add debugging to pcre2_malloc()
Date:   Wed,  3 Feb 2021 04:27:51 +0100
Message-Id: <20210203032811.14979-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change pcre2_malloc() in a way that'll make it easier for a debugging
fprintf() to spew out the allocated pointer. This doesn't introduce
any functional change, it just makes a subsequent commit's diff easier
to read. Changes code added in 513f2b0bbd4 (grep: make PCRE2 aware of
custom allocator, 2019-10-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index b9adcd83e7..f96d86c929 100644
--- a/grep.c
+++ b/grep.c
@@ -45,7 +45,8 @@ static pcre2_general_context *pcre2_global_context;
 
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 {
-	return malloc(size);
+	void *pointer = malloc(size);
+	return pointer;
 }
 
 static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
-- 
2.30.0.284.gd98b1dd5eaa7

