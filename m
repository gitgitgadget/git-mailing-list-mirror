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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F77BC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E536E60F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhGZXEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhGZXEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4535C061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p5so7889453wro.7
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sX3TrWBCaOi/pxUMAFl7QWUvxgRa6IEo9UtCw9XEgqM=;
        b=kShMefcx4slrBFIf0p/UrihHMn2VlkCd3yk2srj4XbI8A97Ap8hEf/CFhrHM2t+mnm
         1J0BrvFyup9ytkGp7o329Y/wHNQfzfcg1wWTNLHCQYRfXAB0R+gqBMfm8Z7NvAU5UTcK
         rzbytloSoH4+VHuycB1Dh5RXaUtoZ+sTsiiQDATdiI8TSpaCIcd4Kvl8gLNBWNxD4TaY
         He/VnXVfiTfHo6ojJe9xp74s267RlFPi44Y4KEc4BB59YXMbzQk7ymWqcVGYLIMZ5KMh
         6he0TegFa0S50Yb95cLDLMBZOvqsChI3Mmku3CScVDKXehJlGe4I6vaBGM60fLty78AV
         x3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX3TrWBCaOi/pxUMAFl7QWUvxgRa6IEo9UtCw9XEgqM=;
        b=EkwdCiS1XRnO0nc1jDTG93Q9bnZyYotsazRzRBRCsheU5xlW7xV0TnoRsFqttEXfoQ
         hXUMC4HDJpxG/DXmmbVYysC0F6Fu2YzccH//LDEWZQXIk4cUMfXzjz03j6ETPG2mzD+2
         frQY8lTHx9wr1LehT2RGiCXhFe/T1zuyx2KCtwNi61MQSRrSWOxaRgaGlaV4P85meO8e
         GGoYsnFC1X9rgWjVognjKtFeyL1f70PcS4jDuQIJnmQR6yQW1Kok7TE+CQSoCYn6WNR3
         SPrALj5MdChYsSyz5zEpeQToVmK5YLTKkQ0dUom9ahhKGMZHErFRHK2hAC4AlkATvBgh
         3tng==
X-Gm-Message-State: AOAM5325g84GRKUtB6kwixfpIORxVeBK4VQgal66TbrG0J4pD0tym3Ss
        Trrtp40jxydpuEOWX82N2ALhaFA/CoMwpg==
X-Google-Smtp-Source: ABdhPJzb5wISTtxDnbdplbQhxltvhPP0mgpyntLHRvd4KYXoIGblnSLZ3AvLfosffOm9bqlDJmrDiQ==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr21959696wrs.2.1627343074290;
        Mon, 26 Jul 2021 16:44:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/11] refs/debug: re-indent argument list for "prepare"
Date:   Tue, 27 Jul 2021 01:44:21 +0200
Message-Id: <patch-05.11-685b48328a-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-indent this argument list that's been mis-indented since it was
added in 34c319970d1 (refs/debug: trace into reflog expiry too,
2021-04-23). This makes a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 7db4abccc3..449ac3e6cc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -364,8 +364,8 @@ struct debug_reflog_expiry_should_prune {
 };
 
 static void debug_reflog_expiry_prepare(const char *refname,
-				    const struct object_id *oid,
-				    void *cb_data)
+					const struct object_id *oid,
+					void *cb_data)
 {
 	struct debug_reflog_expiry_should_prune *prune = cb_data;
 	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s\n", refname);
-- 
2.32.0.956.g6b0c84ceda8

