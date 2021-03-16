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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F07C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0054765108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhCPQSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbhCPQSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE01C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 12so5401806wmf.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UH/bG5OnB9ke/iwQjcfkfuNpIKU95iVA6ZwPiYliLI4=;
        b=A3BE24IdAfQSNeOaUvEfHmf+vx1p36oX1f8/Y6Fhivr2TsMiGTEx4Juo+X1KsYF7nQ
         62Uy3e+eBMLvHfZPDT3CJez4OhSnGKEn8PSg1GeETxVWpw+CGozhagFkbO1hDa5fclvz
         PxKgXWc6bMlcbzncPBL5h9tsa5sOTRF24pgPN1RgdYyFeJpNsN0BGxgBjdbew0/Z7BT1
         4U3NFx3HsXeSC0Uuul4zCJEWZFQQcfx9FodgbB68Xcx/vIU4HG7hF4keTyvTTuAGRj8I
         Cu72iREA4xa62j2GofgTfzCE29AbGyAX9Pkhbxso1bgLgXZiyefbUmVIMAdHlZs6yh8j
         NqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UH/bG5OnB9ke/iwQjcfkfuNpIKU95iVA6ZwPiYliLI4=;
        b=b69ZW0j/yPJ3Y0JF7EJGRaWL4pEVE0jNflw9gYsVSbcCe4CNBwCe2ZOI+PVGBSfboD
         I0FzyEUEmzQuiGj75+HzLz2INQQ9UnZIGznir70KPooaegTg3lArojpyweKT+jcpHvY7
         jzBzcKb2vAyI89Jl5GujgCFnYF8vwlof7ZwVT7qmM9SIhzr1TlxxsRAqZYZIm2GLxxaN
         /jGzKTggHK637OLE3hh31r/Mn9FV6V7359a5sEInLQyVXh1FdczM59NFiNwzcjqTkW5k
         UZ6HJSyx7tNh2DJXxl+0gbHNmKcBUihR4s2RBmPTXgDLMLKgPwdGtgjxLOBHvhzKT9VR
         +F6w==
X-Gm-Message-State: AOAM5323CjZiWX9vEFKD09Nr3UYY6no6brXHqA/vzzf10q8JV2zw8u5T
        iE9UZvrc6dF2NbJvOxdwmhu1xRGIOJYOqg==
X-Google-Smtp-Source: ABdhPJw+i//zvywUVifGblq2OaWg4KeaBg5YRCFi/hVKVWY5XjDFbo+hll8r30niOgPqkvriHc07lQ==
X-Received: by 2002:a05:600c:3546:: with SMTP id i6mr399007wmq.104.1615911485925;
        Tue, 16 Mar 2021 09:18:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 14/22] fsck.c: undefine temporary STR macro after use
Date:   Tue, 16 Mar 2021 17:17:30 +0100
Message-Id: <20210316161738.30254-15-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index 2ccf1a2f0f..f4c924ed04 100644
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
2.31.0.260.g719c683c1d

