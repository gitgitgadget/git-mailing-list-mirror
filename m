Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6ADC11F6B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A5E613DC
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhGJNkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhGJNk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79DAC0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l7so15550436wrv.7
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QnITdhbhJb6RSVllzyHVCA++wj+9v8pQ16hg9kwVic=;
        b=el6qHkYwh8BRKG5cpSKbRvZznhBNbKba2ZRLoHxQ85pCdyc5ig56/1z7JF4SgOtcUJ
         i7jGLibH2vwMkCmfCkCqB7ahDha5G8rL2IPaAr6GwoRqgvfCFILuYtXq6HQ3dRdPrpcv
         10MraHcaRhQg+Z50su/ZUGs8jwuHJ88+QHAtdSQCcrwlwc/XiSnRDKmIc5edRd+Dub8b
         55r+8k0VS9RZGEs34A+PITrFbnmLtgcHYr0KPpMoCpL8E8Mp1pAxTlEv0ZlW6uTRJrKq
         v4xWLoAT4UdqscT3TUam02ZYUxn+FF7lx6DwIztTgII//tDOLpQN/d3e9Igd680G+6jV
         Go1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QnITdhbhJb6RSVllzyHVCA++wj+9v8pQ16hg9kwVic=;
        b=NzF/MVH4Ugqv915I9iXm8aNpkV5dyTef0tHTeUqnAXIx06+3anB+Vyae+Qm8Yu/YHg
         YWf4CbMuUqeiqQU89IQ2FgIo+3ENA1LWjDeKaeHcVAuRWOyjhOBNYmzvdZCUekYRVuKF
         cC6tr20aTsWptsL2SvElcRt0vF/F7fr2qq1AavN7tjQ8ih/81qo68q4pKWxBWjnzhoNk
         Gq0WuF7T7dFm347qMf/s2FnWj/f4HOxBscluoAhBCs5CD9NkVlDo7Unfyz/vSlO7eFRu
         YMMCuOoV2zEqftEuLOX3h341qqN8pVdJCZECXtoqsdYzfM1/S44cZVBvNgZfqHVbOPxA
         BZHg==
X-Gm-Message-State: AOAM533YZm6RfYXhWk7IXpB/LFk327HMdn29TuwEMjZNmGv4mTZnNR+0
        ybGtbEYhcVHCJla5qOa4yuXgf08iBxY2UA==
X-Google-Smtp-Source: ABdhPJyo8sRI6fEPXwkPBKTvFpo2rDQNTRWNeQDBMtDxFGc4tuhSrx/cN0RSlLkyQOvcd3901PhPPA==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr1891011wrt.295.1625924260151;
        Sat, 10 Jul 2021 06:37:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/21] object-file.c: split up ternary in parse_loose_header()
Date:   Sat, 10 Jul 2021 15:37:16 +0200
Message-Id: <patch-13.21-0d8385d8d12-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This minor formatting change serves to make a subsequent patch easier
to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index ef3a1517fed..e51cf2ca33e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1381,7 +1381,10 @@ int parse_loose_header(const char *hdr,
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type;
+	if (*hdr)
+		return -1;
+
+	return type;
 }
 
 static int loose_object_info(struct repository *r,
-- 
2.32.0.636.g43e71d69cff

