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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16614C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10B523C19
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgLIUCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbgLIUCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:02:41 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF58C061794
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:02:01 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y17so3075958wrr.10
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCKf2NBbDpDsTMTjqpZ3kMR5PrX6KPli2kTefNDk+II=;
        b=Fi1VXLQ1wdWKYlLJl7Yiu7se3NVvAIxGK0ZQMbrhb99bfd0haWT9WY6O671aHwAbLC
         fGajGM6W1X+2pohUQEdgl6OT3pF7oKebrCC7VwMJK1mL1mXYt0nCMxUqooQWHqTEzKAn
         SlWQ9WMug6kjWGDTO8ARiPW5ezpLblWj294gXyr34pAdaVZKklMD70oevb4YoPO5lFmv
         KEVddcss1/0IToWNo3CKWYd37RW1ND2SkMQGXDrfxy86H+szZKtAoerSCEGBojPpki1i
         T8v45EcJrDzGiqo1GBEfryJkN9vP/zTed6rqKJH7aXNUAIcQCIGyt0gYMNIpTQmdCedT
         6O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCKf2NBbDpDsTMTjqpZ3kMR5PrX6KPli2kTefNDk+II=;
        b=ns43m2lqMy/f8brpVtasExvm8dvObV8dTlmZsPzjiZddgeFbU7JrxUnK8TTV+Vt/58
         eA2W/vj65E5lIaCcgics1mfakvvf1akJXdCPfnPOZ/5H9BiMv18qFqLYXZAVv2PUNhe4
         X3Nch7lg3QKmE/vOKqvGyiDTwC2KO2MCijkBqiSNZKSxWw/pR0SFq2te/NjHAMsz6ZAV
         HvijEEpx7s/sTsj6BbwtX3IHSt3XssxOQMKB2cIJT3zd68K8nGqSpPbaDuqd7J7sAmic
         odXW2OpuC9wgAOOundDdmJXXNnkA+0wGrqhNaAQcYowkIF2pDpoA3wSyGw73sflakIO2
         uRiQ==
X-Gm-Message-State: AOAM532zbjbGk64r8BO3xg+FOYQwm2vIqtK6sqP5dH1MZtEl3tlh3t2i
        FN/eWCG40k8Br//5NrJXRIAGDGO1O/cx1w==
X-Google-Smtp-Source: ABdhPJxrXRVLt3d5JbIn6dxym5q8U+mH6MhEB7tTmfs5pidD6FWmjHXOVTaXg86AOk6Vl1167JYaKw==
X-Received: by 2002:adf:e481:: with SMTP id i1mr4398254wrm.282.1607544119791;
        Wed, 09 Dec 2020 12:01:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:01:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] mktag: use default strbuf_read() hint
Date:   Wed,  9 Dec 2020 21:01:32 +0100
Message-Id: <20201209200140.29425-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoded hint of 2^12 to 0. The default strbuf hint is
perfectly fine here, and the only reason we were hardcoding it is
because it survived migration from a pre-strbuf fixed-sized buffer.

See fd17f5b5f77 (Replace all read_fd use with strbuf_read, and get rid
of it., 2007-09-10) for that migration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4982d3a93ef..ff7ac8e0e5d 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,7 +161,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 4096) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0) {
 		die_errno("could not read from stdin");
 	}
 
-- 
2.29.2.222.g5d2a92d10f8

