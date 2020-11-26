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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B44C64E7A
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519D22145D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlqu8MQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391801AbgKZWXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbgKZWXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4180AC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so3685922wrb.9
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7DqChdgkDIOcmUV2R1ooVv5JMni3yZPaAeRb7uAV4k=;
        b=Mlqu8MQ8jk3Y24jUoGifc1/3ICWhj6XNDJZ9M/ruYbWmj7xZB9i6/qEjiqEgrSLAVF
         qyxI9LqGyQcHcNyMk3KYLn+dZMCVcNgPdV5qSykZ98PJ2eHXffmHYaF0mWp+QUNmZ1CQ
         JktbgZLFZRHwo1iDoirwOxu8WDslxtND+hR0xY3vIyfBXCIx6hCU2UASyWRfHPXEhaiz
         7rCSkgnHaqRDqYL7qcu3bAcvEmJcvupy7pNs/KbY6C3fIK7zsLGTCqSpHJMUiWcl9xp3
         HuMnOeF8WisFrwM2LOQ/fyh/fTtm2vKKeCksBLwdlqyg5ygmWg3llyEXPOkNOCtJwtXB
         s1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7DqChdgkDIOcmUV2R1ooVv5JMni3yZPaAeRb7uAV4k=;
        b=c7N9tvaDJyLeMzS9RaXJ34deNfjw1GecurrRqmBKSGJ3tqWI7+NdHiWf7edi/dZ6NU
         bVVIRb97MF8Y6bmEzt0zvsr2czou38gOECpHM4VgzNc3GDcdJVxYbJQGQaW6zhQvNg9U
         KueXW6vTSJcU3NTfeBwC9gIHkMgaAe5W513jQD4Pvei78tM7qQgebzDmzksPElcBRxzb
         0l4AJaAzCSG7KY/x+VUYwuFXKmfOztNa99AuF1+LsStm/KLeZojCFYx+GvX5TSjgbnCL
         ZLNQIhEDbDc88HfwwS7HK1AMdocq3nNYvFbGEz0Ni55k/bYLHjg5KjIrqWgEKenUsPSc
         Kpxw==
X-Gm-Message-State: AOAM532CGd6OQDQb9172QyBdSKiLbi22TTjuTjOSOWpIl+OcKqKqLNWK
        NgxDHYV1z1k/dZr0OMT26vGMdmtGBCkKFg==
X-Google-Smtp-Source: ABdhPJycWsqXAFrG+7zpCU5oPaeGkpJFTOCDid9t1MSnS3dODmoV55OTuzCIqMR7Ipxtg3XtJ3YUlQ==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr6649408wru.68.1606429392750;
        Thu, 26 Nov 2020 14:23:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] mktag: remove redundant braces in one-line body "if"
Date:   Thu, 26 Nov 2020 23:22:51 +0100
Message-Id: <20201126222257.5629-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This minor stylistic churn is usually something we'd avoid, but if we
don't do this then the file after changes in subsequent commits will
only have this minor style inconsistency, so let's change this while
we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 603b55aca0..dc354828f7 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,9 +161,8 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 0) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
-	}
 
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
-- 
2.29.2.222.g5d2a92d10f8

