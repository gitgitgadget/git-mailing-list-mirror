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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7717C43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8933065109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhCPQSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbhCPQSD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE4FC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t9so7736176wrn.11
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvQXr8EWUZCeWeNeD/zKglA/tT8vx2hz3jJ7VSqFZek=;
        b=in1xQkwV6HfPWeqUBJtr7AzjTyWX8LHyL0twKeu2PQtxKGMKaaZmEdH3Oga8zI7snG
         UAnvM27tePzMrcUbJCG0i538hxLiDeHGpnFvTJKitSaxqwBkvRqrUNJlhRXEhEf4ZcYz
         O9MrZH7XByHvyGZWYCRcTYWQta7BWNg/iHzkkma6tnlZDw3Z+brXvwiXfjRVpGyItZPa
         CAWDQpyMQTD9kESlU1V7CYhDX/r55pcM8gqH8aHjljvJmBqYRsGjVHkwoFKIpYWnpVao
         Q9Ka3Mz530zDkASaNK6bTLPK0Ygv8az8AyA/+XT/iKjHFd6kLdLOr3i7q18sbLlDMprl
         1HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvQXr8EWUZCeWeNeD/zKglA/tT8vx2hz3jJ7VSqFZek=;
        b=o/pu5khO8vXYWkuM9Ug34orlpa3dwvcstJOKsAu1t2Sg4DG5qMACmzgNDAiXofyT6q
         GU+EtFpuRiz4zebOM7u+czFZlifapkQoYckTDGnTnWNRLZPR5ap4LIRNoYqI9a6nTSOr
         xL0W+u3xFYGA+pu5w2zEs5vXzFWtthVwx7swvpJLGMFkBWnYGMFEtQrJwEgH+3vE/0CS
         AXgq0llm/7iga6CkLf6Uoj1lqrpyPBtAB1qiQsskiRkFXfxy3QiOQ3VE0CrLw86B8Cdq
         EZcPO117HkqzLYA5Os5I+CC6Pz1E4+LwJkQKPTq3GscmR3uapdk1oiwoN3jVMQuF3Tir
         XOyg==
X-Gm-Message-State: AOAM531QzIR5B5GskUoVqmzOrenshgFMCUzkewfeVmG6FnP40yozuycv
        /bUkgnuCwnErLr8Pq7J2ZIBb7KRv9wrWcA==
X-Google-Smtp-Source: ABdhPJw896S8myEVlnlOG75ZwCjjO/WY2CAm1slejh2A7avcl5Bl3SjO2yjGvg9f0WBCENb8buifWA==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr5747637wrx.353.1615911481149;
        Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/22] fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
Date:   Tue, 16 Mar 2021 17:17:25 +0100
Message-Id: <20210316161738.30254-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index b977493f57..6b72ddaa51 100644
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

