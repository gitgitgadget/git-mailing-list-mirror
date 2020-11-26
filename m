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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E49C64E75
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894282168B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK/oKdbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgKZB3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZB3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:05 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2599C061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:04 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so486611wmg.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7DqChdgkDIOcmUV2R1ooVv5JMni3yZPaAeRb7uAV4k=;
        b=rK/oKdbrbshMbHXSCR5fFjg7ob9NNSnYAwVVhnmywbjYaR9ehWZoeBYDF/7sVlSpkF
         3c/KytptYb8pL3M0C2h7BB6SEPADzuctzkUGVZlsCKkzC4EAqtVRXVG+BGavhiC+v4Ii
         VAJ+M/lq+9/p2ACwB+K9BeoK6s8ew7yZHgbc6vVWnDXwHefeF5PIEb8bD7tPjny4g5TK
         ywnb03Q2FlcUw9L1YwemDhjqK4IQd9cLDNQAUPy+lNS0MgyTCBJnXltASie3YXErCXAM
         1Bngs3M6gwwYSVODqPcNEkDBLnTDFe0Ofhbm/Fk6pM7L6OWL9LL3JU6977qs3w8L2lQa
         qkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7DqChdgkDIOcmUV2R1ooVv5JMni3yZPaAeRb7uAV4k=;
        b=MeNh5oFsfPwp18YqPq5SZWjdZsoDwGdRH32KiNs56D0q9ITUPIfwNUNJwcmtql5DEg
         SjgNqj4dY8/DUPnrnD5PEVx5/b299qhHWydKHcYpWsK/mkRfN4YMNwbP+SFOaWCtUHYN
         NiwuZqRyTTmfIbO+kT2Ps8AmDxnzE3FBJgfyLMqBryBeWeGmhRiysQZpLePifrp9VuKT
         +/yvC/z4B/OFFAyoBVYakuUhnRt3YvHu3RUEL14RQkrr0dnkUHeqMPToEzRpuzvNv1fg
         22quU6M/mvMvHXyF9Ux0kUC2O9qlTmEiTTufd0l6UeF++0bxeQ6W2L0oySLbRHGMTn6b
         fwEQ==
X-Gm-Message-State: AOAM532AKALp2I83wevliBVgSX+DdYoYMDDEO1XrtvxcpumGk3p8sn8C
        ef3C3T9z88dYNvssbcpisUVJCkkQEKtsoA==
X-Google-Smtp-Source: ABdhPJzCgFN29pJzXI4frPo5Ntr2PbRbZ6ynsKP8tdDT7kLN7m2dXvR2r5STiQndOC/DtH9H6k493g==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr494769wmg.64.1606354143428;
        Wed, 25 Nov 2020 17:29:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 03/12] mktag: remove redundant braces in one-line body "if"
Date:   Thu, 26 Nov 2020 02:28:45 +0100
Message-Id: <20201126012854.399-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
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

