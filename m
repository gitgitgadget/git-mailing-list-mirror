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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7CC4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7256508A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbhCPQS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbhCPQSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289CC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w11so10752733wrr.10
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5GujOGyCc6XRlnwNp5URnFxXJJA8BzYLaOfJ3L3J4o=;
        b=D+++QcDgGbOYfk62KwWfAKjySaxueeCTbE1G+pLwW2qZku0QLh2evL5EJdB3fgXt2o
         bYClImydSKvOvf76eNGEhdudI7cLqXfNdTqz8Kfr9HW7M7FrcFlaGpaCEUpkNUN0Is1N
         CvBj6xx7/q0PkpoCwHqeSJ1dpvOTf3/8vMqZMTiEGYF115msjhZEmFy3RN/XA5daReRa
         pVxeIwdfTkTXnqU2iXneFHIHdcFRf499swXD9NfPs/Xx/dhVax8wbdj5AXTm7R47P8fm
         pWIN5/JMOj4SHvKNExs4PUFxuZ/agNjIJ+wls+9j6gt4Fs0VZadeyQl6yEwyzrySc4e2
         i8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5GujOGyCc6XRlnwNp5URnFxXJJA8BzYLaOfJ3L3J4o=;
        b=QGxcYbIpmQpy7hqGF24jGXHxcff3hBBUmwkQ1vjoSP4zrpUqB9SFTbuk4/YnX1bH/9
         VDABKlzAXbn+L4qLKaTOXllgAxKHE27p86yu73P6p+WTigcPhlTLM7DhHn/IXGMlEVfn
         mN2xU+G5tWTFxzpGthsUfBsLqzz+U3HM9FRKu5OxOEr9nViBxzgFD8oWoqlHMjBNxtsD
         +vB8lHY9SYW94TWo9NMGoxCG+eBU1DN4BtEUEa0pocXTDlIlLDK+rl3/KzoGdy6grq9Z
         D2HjA/Ui+yg/qYwOJ9xHUWo/BI8XbNRxzF7QwO39ZCaeRwi4vwVApll6gegNM6QZUXeD
         wkgA==
X-Gm-Message-State: AOAM530C1PNq+F5NWTfly/WA74RYXoATlkzWxHoC+cr+yF1SA2NDCiSG
        5lU2HUpR41SeiQV9bEetPAMcSMbLcwvavA==
X-Google-Smtp-Source: ABdhPJy0UdoHJulEekTmucCVEXzy4ZxRGjZEP5aH6oPf11ME/LRCEd241Ba7nQNliHHm28xgh1ibpg==
X-Received: by 2002:adf:ab52:: with SMTP id r18mr5671106wrc.65.1615911477898;
        Tue, 16 Mar 2021 09:17:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/22] fsck.h: indent arguments to of fsck_set_msg_type
Date:   Tue, 16 Mar 2021 17:17:21 +0100
Message-Id: <20210316161738.30254-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index dc35924cbf..5e488cef6b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -11,7 +11,7 @@ struct fsck_options;
 struct object;
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type);
+		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
-- 
2.31.0.260.g719c683c1d

