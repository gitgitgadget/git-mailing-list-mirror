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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB467C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7BA61177
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhDIIuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhDIIub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB7C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e7so5602014edu.10
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QX0KPiKe3u6tn0eADMNJ4VFyM+3bJ8Anl2+EbHHFofY=;
        b=UQrwPkIC3yz6Z892Unad5ynNDupuLTrFVb1VGyNGJZZ5LU8kacUYqV81+SntJi7WZY
         p/jeGbpwejDh+WzuR1sX4+Dif0TBPy8jw1Ebw8vXU3kiX8yGNM1M9PoKo5tyKir7lOrV
         kJ9bltjrcfKa8hjw2UvamT339/LoX2tBXDV/ZCNlyJa0RRtpRDDoF0vT6EcqDgZ1gWTO
         92x9cC1GQ8B0OlpjPT/QUQeIVzKt4THq908c4KQFc9BTkCnxyT6pZbPm2DM5dZUpmrWF
         mvBl031JvmP7qvjYhXURh1bH/r6EiR+A0/ZMjrUgaMlAAH4I4XFLr9kYSwTmy0+J4WUZ
         jxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QX0KPiKe3u6tn0eADMNJ4VFyM+3bJ8Anl2+EbHHFofY=;
        b=jezg9AdUpJywqfRzEs6FP+0jcfQARocfOmqKUNNvI3FZP2WjGAHv6gbY+Z7aWrK+D/
         LFTGxydWRQM3gfbFPDOEYoY2zgbgQEBrRSVJFNW3lCOY34Gct3uCUTXZE4q+3EurDABl
         Z6YtmupRoveiFRbSzYLtZ9vIetba1E73BuThlNg9SUzaXr6QRxRqko2mv5KsRI02/u1/
         ObwrbwxWOcePUcUXb4CRnejfEcx0k0ZP5Akxxn1x6o+Yfb4n6g+7AjOXGi8aXxQSQ/Ee
         q8smlHP9MV66vdp8R5H1y9niRFPppDgW9jNr3XiQZ5Es6IdxtqfP1t69W8XvN/Mn+LdQ
         RKWg==
X-Gm-Message-State: AOAM533z/k9rlc7hNO3RecLCXRsrjk1wAMTqySmUowZeBQi2vhjPCm1y
        WMoCHbL6fSFftMsnLAFIfDyl35Ce4rwOtg==
X-Google-Smtp-Source: ABdhPJz/BqkUMqawsApris//LfdxGNeJLMIBYPDpKnJ7Zd8vxYCGb6YUi2QZqnMjCwWARvBD1lTQwQ==
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr16279277edc.360.1617958216812;
        Fri, 09 Apr 2021 01:50:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] object.c: normalize brace style in object_as_type()
Date:   Fri,  9 Apr 2021 10:50:01 +0200
Message-Id: <patch-6.7-e414cfe40c-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normalize the brace style in this function introduced in
8ff226a9d5e (add object_as_type helper for casting objects,
2014-07-13) to be in line with the coding style of the project.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 1573e571de..e3400d1039 100644
--- a/object.c
+++ b/object.c
@@ -196,16 +196,15 @@ char* oid_is_type_or_die_msg(const struct object_id *oid,
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
-	if (obj->type == type)
+	if (obj->type == type) {
 		return obj;
-	else if (obj->type == OBJ_NONE) {
+	} else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
 			init_commit_node((struct commit *) obj);
 		else
 			obj->type = type;
 		return obj;
-	}
-	else {
+	} else {
 		if (!quiet)
 			error(_(object_type_mismatch_msg),
 			      oid_to_hex(&obj->oid),
-- 
2.31.1.592.gdf54ba9003

