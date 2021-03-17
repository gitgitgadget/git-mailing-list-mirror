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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B2C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C066164F6A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhCQSV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhCQSVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97CC06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5769562wma.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtIwibjrPTzGKWdE3IE2iHjmv2W1UPSv+r4i1zRSv6s=;
        b=LDTpHQ4/u+nEx2wbLZ56NOOQQA8zjxr294sdybnEyXv4F9aLYWeKKcETiU4zlfMXq5
         wO50B8S29BuARzeiksyYdijTDxHdDzF12T00WCzuBObrIg82MP15l/fDVdOQPHiesGHt
         7Y52HlkZqAiPHkw9FQgL5IUcRFyxzGWVe1tfOmHsGulhYULooy5dcCTBalWdG1cJlZ8L
         WayANGZzEg1SUyA8EDv/kefcXHaDII4DUD532Y2W6e81Id2bJg3J3Ajio9Nh+S4NGnjE
         bRQ6dJI/8ocxNE9XliT6t7693NX9JIFCNMwXwGlmPZalV3HbQ+1z2c2V430ZGuvvvfiR
         lr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtIwibjrPTzGKWdE3IE2iHjmv2W1UPSv+r4i1zRSv6s=;
        b=HeNzabbfp8JLyxa+eblXyaWkGvya0en3VrZftG/fd5vorm4DZv4+v0dr37DYqIELpK
         YIlcNBbaNaH6MfxnCIGREaCfbJD+jvYjxORDNrwlmbW2SY775MoUGUg+jBZ1ZXZoFF9O
         hLM7myFn2NcJ/4opOfjMqsCklTB+2do+/9+CkSkmEPGvJ1UMSYC9bqUm4chISVVt6QpF
         t5YEiFvY0R8qGOs2xLrfn6DDHUcn050vmEWgRDqCfOS2CmOBoD/Zudsn772UtNBLshcp
         YwXsfCScV2a+2k2BLyjXz/kNzjhhB49LHpSe56BMa3kmk1xLbYiw7b8A/4I9kStFwjkP
         DBzA==
X-Gm-Message-State: AOAM533GgBtZh3FJ8eXfEQEvEoDe66BvVkt/+k6DQL6dr2QKAWPIiHfh
        k+OS7r1ga+5clLcH3/R6+T3J28D/LNUMZg==
X-Google-Smtp-Source: ABdhPJz99yNU4RNpgxecF6rvrMO2RqHQxWShJovCQ2mgMW6jnjPM9scHj7frvAyIikYHjCQCvzetPQ==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr100050wmg.87.1616005274512;
        Wed, 17 Mar 2021 11:21:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/19] fsck.c: move definition of msg_id into append_msg_id()
Date:   Wed, 17 Mar 2021 19:20:40 +0100
Message-Id: <20210317182054.5986-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 71ab8fa840f (fsck: report the ID of the
error/warning, 2015-06-22) to resolve the msg_id to a string in the
function that wants it, instead of doing it in report().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 7cc722a25c..ffb9115ddb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,8 +264,9 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static void append_msg_id(struct strbuf *sb, const char *msg_id)
+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
 {
+	const char *msg_id = msg_id_info[id].id_string;
 	for (;;) {
 		char c = *(msg_id)++;
 
@@ -308,7 +309,7 @@ static int report(struct fsck_options *options,
 	else if (msg_type == FSCK_INFO)
 		msg_type = FSCK_WARN;
 
-	append_msg_id(&sb, msg_id_info[id].id_string);
+	append_msg_id(&sb, id);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.31.0.260.g719c683c1d

