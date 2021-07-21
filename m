Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109DC6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA6E60FDA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGUW75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhGUW7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE1C0613C1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c12so3903692wrt.3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAhIuEN/SO4U2jb3YZV02g3Mjs167EhiJxdm1qXMXvY=;
        b=Tcmvur0FNd/VHgR8use97niPCZhwyI0byRGM6jqADXY9Hpd/08FxdsSMeGW8Refutu
         oenEgbY9qSvgU6DwsDdbZBrgSBcbAZuFN8MQM4g2RqQ+VH/q0E6ZZYpJJW4f30FmC6CC
         Y853lo3btRR9raZAKkLSYQznH3QwBrdoN+OOAzpMz1KLnawOd9hcoYzivPbmQ8wtH8J2
         M9oMFzmFI1k6n89eiHN2kOqteH0Jh2p08MQokdQeD/UAL761HGmc6F1mPZ+YS82j76eK
         MrPD5OKpocPi3S1lcnQj5tk0N+keKrdgzkAxBJlXxqMzLwTl+oevaon0bxdkkhJ4q6qV
         rHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAhIuEN/SO4U2jb3YZV02g3Mjs167EhiJxdm1qXMXvY=;
        b=XwZFQcYMYU0rEsn6VBY2wHmOEQWuWSa/3k8VLeRuujwMosHHvLuV5DNAkYM18GTaYn
         islI0KaNTws9FlmS/3fp6DKt1jSOvvqKArK8PXFFA3uQ7iCbMT5I7tK96G8zRgrz+bAg
         D1ZyJwMvjhTJqNub0nzaDjmDF0WCYEJaGV7i8may0lR9Xu4Q14doGA+dXIUwQ5kyXT3l
         JwzhJIhMRPJLQl5oSHEjLvg+1TR/miRE5rYcjOxHDjs1q/azL/Bv4DiWREPDfi1Ea+iW
         Qt0mFPJ9xANx1qnHkOb3CWz4L/frxajvuxJHH11MJriNCH4/HJ8YOgDAGyMcXbbHGHS4
         YUBA==
X-Gm-Message-State: AOAM532v9VwIYYdYsXrQ9dLKxTZaHzaVUQ10gyQ3ZSJ4uVp2AgJGsyzX
        EhDc0gL0oFmwEaFVAhJZTeEAPkf50lS8cQ==
X-Google-Smtp-Source: ABdhPJzgDgXJukBFpLqQ5sPJio4su7bAD0xvEeDuqqNvS8HAeP2e7Kxem4+EX/yRBFlXz3f3wsxHSA==
X-Received: by 2002:adf:9084:: with SMTP id i4mr45604497wri.23.1626910823312;
        Wed, 21 Jul 2021 16:40:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/12] serve.c: move version line to advertise_capabilities()
Date:   Thu, 22 Jul 2021 01:40:08 +0200
Message-Id: <patch-07.12-b7928ddbe9b-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advertise_capabilities() is only called from serve() and we always
emit this version line before it, it makes more sense to consider the
capabilities part of a "header" that has the version, so let's move
the writing of the version there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index 3c7c9329a14..10209ab237d 100644
--- a/serve.c
+++ b/serve.c
@@ -168,6 +168,9 @@ static void advertise_capabilities(void)
 	struct strbuf value = STRBUF_INIT;
 	int i;
 
+	/* serve by default supports v2 */
+	packet_write_fmt(1, "version 2\n");
+
 	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 
@@ -360,9 +363,6 @@ static int process_request(void)
 void serve(struct serve_options *options)
 {
 	if (options->advertise_capabilities || !options->stateless_rpc) {
-		/* serve by default supports v2 */
-		packet_write_fmt(1, "version 2\n");
-
 		advertise_capabilities();
 		/*
 		 * If only the list of capabilities was requested exit
-- 
2.32.0.955.ge7c5360f7e7

