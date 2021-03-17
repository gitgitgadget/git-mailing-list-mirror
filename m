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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA4AC43331
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0645964F4F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhCQSV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhCQSVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A6BC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p19so2055456wmq.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AzMYsrTTeSkoMQVPos8db6WQ8cf7xhTQpaVmxgqEyM=;
        b=eMlzH6iujoeAkqdldiNgR6HjkDh2kz6Hj3ZssEZKEInuElwvNsho2yalfX08MNfnNF
         /zG8m6yJcFO8fwQKLC7tQXXRdcjERAnuRRtJjlL6eP6wQweGE3+mDEo8+dtFIz4uCHFc
         Jcb6AMKnlSxMNEi7Jg86Kq1quZW5FPyoh2uVY6ReQ9CirGWTt1yZ7vT7hcv3aEBhkpbb
         txO8Q7C6CuvjjBI1E8tNoXB9MOAwbr/4o3SS/oVmns8MfTsHgPxsD7iakGnn5J/qBqD5
         t/JGKZHViXovG3V+sBa/IkO7MswsNSm8Ca4oKTQt95AwCA2ONeEyJm4MuBmMFMRmS/Cn
         wOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AzMYsrTTeSkoMQVPos8db6WQ8cf7xhTQpaVmxgqEyM=;
        b=iJ9DV2Efai5HEUfZNG+gPp+qYJYZ5L+arL25EguqqHDQ1M8UBMm3d/LLTEQRKrYhMw
         hx02QRC1ABOkyc3lewOpScBEbrMOiPos8rQPbr53ooc52YVx1MMONBEwwQ4Hp6s3RKjo
         LHPQTX+v+HL5VFllzlsUuPWR4fYYw9nM3AxZc5dQlCJRz/IPOg+IP1dXmGKKHS9oTE0h
         nJfuqXKobUkQMULZaNgywdk5DStA7+MC26FfEgGLbQ8WdrWrBAYOLHerazbTO5srKpLy
         RKz+oTN1QnmLx4AjjhDyfi6Wa3XgAJT6HFpAdHyFkfpTC5cBGGQ9nTT7bbQxHyhWA+tI
         bKoQ==
X-Gm-Message-State: AOAM533/0DY8x9FXUMzWeqlIxtZpW7qOp3O1vqqn6lXv+zrY03DFatGI
        k26xQU8wsxV2Hzv0a+Ha1xZIF1s1amhV/w==
X-Google-Smtp-Source: ABdhPJxBkHFxfzk04qlhrE6YQIzVcNiOxHmFuqWl/ap31Vvr00eX0SoZQCBrfX29fQi2aJ2676F5dA==
X-Received: by 2002:a1c:9817:: with SMTP id a23mr107254wme.57.1616005275254;
        Wed, 17 Mar 2021 11:21:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.14
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
Subject: [PATCH v5 06/19] fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
Date:   Wed, 17 Mar 2021 19:20:41 +0100
Message-Id: <20210317182054.5986-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the remaining variables of type fsck_msg_id from "id" to
"msg_id". This change is relatively small, and is worth the churn for
a later change where we have different id's in the "report" function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index ffb9115ddb..a9a8783aeb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,19 +264,19 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id msg_id)
 {
-	const char *msg_id = msg_id_info[id].id_string;
+	const char *msg_id_str = msg_id_info[msg_id].id_string;
 	for (;;) {
-		char c = *(msg_id)++;
+		char c = *(msg_id_str)++;
 
 		if (!c)
 			break;
 		if (c != '_')
 			strbuf_addch(sb, tolower(c));
 		else {
-			assert(*msg_id);
-			strbuf_addch(sb, *(msg_id)++);
+			assert(*msg_id_str);
+			strbuf_addch(sb, *(msg_id_str)++);
 		}
 	}
 
@@ -292,11 +292,11 @@ static int object_on_skiplist(struct fsck_options *opts,
 __attribute__((format (printf, 5, 6)))
 static int report(struct fsck_options *options,
 		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id id, const char *fmt, ...)
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(id, options), result;
+	int msg_type = fsck_msg_type(msg_id, options), result;
 
 	if (msg_type == FSCK_IGNORE)
 		return 0;
@@ -309,7 +309,7 @@ static int report(struct fsck_options *options,
 	else if (msg_type == FSCK_INFO)
 		msg_type = FSCK_WARN;
 
-	append_msg_id(&sb, id);
+	append_msg_id(&sb, msg_id);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.31.0.260.g719c683c1d

