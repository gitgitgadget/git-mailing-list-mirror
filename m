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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C92C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497FA65108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhCPQSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbhCPQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13464C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so7736757wrn.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZvrXnUSR3FGp70tn6p9guMsLgypSNY98WE8DxmiBVQ=;
        b=i3pQBesNtm+0qsfrO9bv+jKFbaF24jTpw5bpx3o5d75rMxZaBELtMm0gBnT50G3ugY
         uApfVPpKxABnwwB0YPEnBTP/HBxMmw9YWQWh/13m7kIu9AOfnBCb1rqYP1UFiCR+E2Q2
         ABMI3d3BrxinKzADWkAecE4uvvfHaVeLBFesavzaoZMLqq8NjExyO0J1mNtb6K6puZLv
         heRqoANMHCH0Jdrh0ozppRf3Q7vUlLcrE1qUAaISuzcogl0ucp0mYFYx3qsKrcZoiTy6
         HtJiJE+CPQon+LeAZUrnXobROyly3rNy2c569aFxG2N5Waoiy7R3PAP6hNZxeDHh8Yrf
         ov3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZvrXnUSR3FGp70tn6p9guMsLgypSNY98WE8DxmiBVQ=;
        b=mzsAeVzHsIHsJZRA7kUHu2RzxGKFhMQQF16xO4BH4t6vR2QNN+y8TdIuXw9X9Dg40m
         eJSV9FpRbbZefzYQtAA1ElMqlVxyYvqLHqwEE7t+eyWCToZN06p7Bm913P+geQn8QpwF
         AJO6Ehy83PatnELoqh1htz67XKvOg4olUamiZ08B5Ub/Ey6DPWtr4uDFniEGOEjjqoeU
         Ag4wK/4p8PmmZJp7XkXP3nTdIE+u07M9b+q+P4X2MrXrPq8rP7s6npKckcKbWUtjnMcY
         yY08uhCbyedxXD/5TIaB8+Zls2z2ZFbIgCTOLsqo64J62k/yfqpgEvaqP87+jQOIqf21
         Yi0A==
X-Gm-Message-State: AOAM531zN7+DBxg2EzyozvvIje1TiQOmt37AK2XlcTh57Cca57KlohFh
        /yYmk5wyKnoBqnL6on+JobU4ZeAAeIQfLg==
X-Google-Smtp-Source: ABdhPJzT+n6SkBxvHSPYLSusbwANK6t1mNMOR2m4Z6OswL8XUNF9rZpSD0DYq1rCru64jLVLcugWGA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr5662873wru.78.1615911479605;
        Tue, 16 Mar 2021 09:17:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/22] fsck.c: rename variables in fsck_set_msg_type() for less confusion
Date:   Tue, 16 Mar 2021 17:17:23 +0100
Message-Id: <20210316161738.30254-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename variables in a function added in 0282f4dced0 (fsck: offer a
function to demote fsck errors to warnings, 2015-06-22).

It was needlessly confusing that it took a "msg_type" argument, but
then later declared another "msg_type" of a different type.

Let's rename that to "severity", and rename "id" to "msg_id" and
"msg_id" to "msg_id_str" etc. This will make a follow-up change
smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b35..0a9ac9ca07 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,27 +203,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 }
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type)
+		const char *msg_id_str, const char *msg_type_str)
 {
-	int id = parse_msg_id(msg_id), type;
+	int msg_id = parse_msg_id(msg_id_str), msg_type;
 
-	if (id < 0)
-		die("Unhandled message id: %s", msg_id);
-	type = parse_msg_type(msg_type);
+	if (msg_id < 0)
+		die("Unhandled message id: %s", msg_id_str);
+	msg_type = parse_msg_type(msg_type_str);
 
-	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
-		die("Cannot demote %s to %s", msg_id, msg_type);
+	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
+		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
 	if (!options->msg_type) {
 		int i;
-		int *msg_type;
-		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
+		int *severity;
+		ALLOC_ARRAY(severity, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			msg_type[i] = fsck_msg_type(i, options);
-		options->msg_type = msg_type;
+			severity[i] = fsck_msg_type(i, options);
+		options->msg_type = severity;
 	}
 
-	options->msg_type[id] = type;
+	options->msg_type[msg_id] = msg_type;
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
-- 
2.31.0.260.g719c683c1d

