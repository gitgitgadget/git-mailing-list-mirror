Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC79C4360C
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEAB65047
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCFLFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCFLFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC01C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:05 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so827470wmi.3
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ke62rNLdI3L3ckW7C+aa/uBQr/edne2QOvOX7ZR2xtg=;
        b=Izap1t/Dk1HM7ctkgA+CDa7a5YXnRjIedOWLwQMefk/f0V9cL0SIQc6SQhucz7gxbB
         kFjJeUzzVpEwGvXEDsagmFAonlXcntYDWnbrEn6UTpOHG3ZMAeYtCliVIqH904u7quR4
         b+qJrQFT9goRX+DsLXXM3vwitoEyamfqz13S0OSdVflAmz2lepJSSlqcDo0U+31/jsvu
         ILcub+GQtjdMAKHhtenuhNcYXpq4OXAPZ/v/rylsBrMW5A5Z+iJX35jnDq9PFKxkjO50
         bW3AiQSgluwUK7iZtwmC0vruhZyYBZCRa0f0zbz5cF9zhwRQrQ/pap09aO+8uTI7Xfa/
         ZmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ke62rNLdI3L3ckW7C+aa/uBQr/edne2QOvOX7ZR2xtg=;
        b=XtRy2mXRy+DtJrbxUVEgqyrJmVqapL+3JYKGvtMUC5GCdoT2IqRyMLNZojneobbMi6
         7Ico5N67ypgZe377SesZ1LmANiKEe0NWhRAHIiWZhCgHN5lsmFN6TOH4gd1jbqOeWiHR
         5uj67rB3E3u7OAV5pC0rBT8h2Qf84F5QL6JpM03x2E39SMy1B8dMt5gG3B5sU0wBvuXk
         TN49x1ukXlx4yCklb2vtsxSSRYZN1t06npNPuhl74NkfYbUCj7HuQjft9hVFR51t3QsE
         FUT3nH6RpjAcXZ0jMUzs0G8QtUpVmoZf01ZM+WrMAWV6GF+jPQKGQBDb97IPvXfGdQYy
         GuRg==
X-Gm-Message-State: AOAM533dWsuxSJ7QRn4VPOegc7/NHv5eqds/5k1QHNSjkyFFjX5lxzto
        Shkbpt284tNynXsC4gYgCd2pPW1eYmosPw==
X-Google-Smtp-Source: ABdhPJzA80vqF1osaSkXjj8wYb+TfiTUmR4C4+VEus3bhGdvixTOq3iAq2bDKtUlGnmya+ZjmGPQ/Q==
X-Received: by 2002:a1c:2390:: with SMTP id j138mr12460999wmj.72.1615028703648;
        Sat, 06 Mar 2021 03:05:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/22] fsck.c: undefine temporary STR macro after use
Date:   Sat,  6 Mar 2021 12:04:31 +0100
Message-Id: <20210306110439.27694-15-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f417eed8cde (fsck: provide a function to parse fsck message IDs,
2015-06-22) the "STR" macro was introduced, but that short macro name
was not undefined after use as was done earlier in the same series for
the MSG_ID macro in c99ba492f1c (fsck: introduce identifiers for fsck
messages, 2015-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck.c b/fsck.c
index 2ccf1a2f0fd..f4c924ed044 100644
--- a/fsck.c
+++ b/fsck.c
@@ -100,6 +100,7 @@ static struct {
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
+#undef STR
 
 static void prepare_msg_ids(void)
 {
-- 
2.31.0.rc0.126.g04f22c5b82

