Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD53C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiKQLam (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKQLag (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379C942998
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t17so715960pjo.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh4cvVseARQgAC7cBURaZyijkuBDTKBviI67fsY+1Z8=;
        b=ElY5jKXKDg/zhIrAQVLXPXZjktT2GkRd5ZahsPXivSdrirs7MtKBUohmJupl5vEu+h
         Mr/sPLimSNONXn1wox7GEeHoncoU1+awqCGrb6M27wc1/NF7ESOqzXFCbFtUE1l77Kgh
         VpNaZy4zPYQbFFrBfHgP6524B2MaunsYBgyBWUSV/HwSpLjp5rcmK8w1GfG1GoU7IqnZ
         Qs0KpkHEX14qBW00HU/J2VzqfGJ/rWwsbd/D1gBPQFWuT1HSfJzsTg25PX1TFdhAu8uR
         y7sSmhrU4vz8j/P6h+8/8ZJCalHL+nk0EcMtgCwm75dEVQzC9LcYLPgLjd2kYeTtb1Gg
         lOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh4cvVseARQgAC7cBURaZyijkuBDTKBviI67fsY+1Z8=;
        b=f0EjFnvRR50szUyv/tkVcnxL6hJkEUwclTIRglke2eCQYLbmtJ5AMyKER+daaxx2Pk
         /STWGC/rvWswmG8M1xeVa1psHYu9aSM8qO+LRo/KX25u6y7SzgLWmc9POrDmaTmgN3Ja
         Bl3nBaywoxLiyybq2Qz92zoKAFBmv5K6qHbDwHq+Sy2jQmkTBUzUp8IVIPl9pVasDdus
         ZPj8kveiaWYDCO2+ziu/q7QcCDxHJwqqzeBtuxjAHNyu9FIlVROr1aZRnWykUqvJkNOR
         yBuelF2GxaJ6FAew2olisG3tsDU4CeuDPTykaICN74CCnVPAnGkxol8WyhVg574j7GMz
         el0Q==
X-Gm-Message-State: ANoB5pnTheCJM8lKFMiMAwLCArwPuaDk6JSfpegncOxnjrLuETfn94ly
        IQBvS6lLKGc3d5WKZyDGOpnvt8LSMExKYw==
X-Google-Smtp-Source: AA0mqf4hbLnU7TGVggFLd+T4s3Ce6vnZmCaYJXnq4is0eE4qfOt0psLkHk9Cn7PDUBGkgDKkx6z/AA==
X-Received: by 2002:a17:90a:ac07:b0:20a:f75d:b9af with SMTP id o7-20020a17090aac0700b0020af75db9afmr8097543pjq.222.1668684634584;
        Thu, 17 Nov 2022 03:30:34 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:34 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 1/6] ls-tree: cleanup the redundant SPACE
Date:   Thu, 17 Nov 2022 19:30:18 +0800
Message-Id: <20221117113023.65865-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

An redundant space was found in ls-tree.c, which is no doubt
a small change, but it might be OK to make a commit on its own.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..8256fc0bc97 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -32,7 +32,7 @@ struct show_tree_data {
 	struct strbuf *base;
 };
 
-static const  char * const ls_tree_usage[] = {
+static const char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
-- 
2.38.1.426.g770fc8806cb.dirty

