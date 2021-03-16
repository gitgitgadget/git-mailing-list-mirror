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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAF7C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E7965106
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhCPQSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbhCPQSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239CC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e9so7741395wrw.10
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLAiRuRu64Y3lZpUoso5lquaEiBZ9TQvktgCtzp7Q44=;
        b=cOau4CwNi9Pq50DwtTuJ1vDoLrbgX81wHbL4s5bNZiDWupsxlJUgDJlZuXN+NsSbsl
         ocJxVOMDYiOLa0fRIPnH90XxvHBlxvNMQJwYcICQFGwxBLjTU9GmnAnD85O33OH1snA9
         POaWqYM+U8ZrIUpnZHvof8zRramE3aNAIxXfvn5E+N7bYQ/ECZ9XxRkRgELyVgzd/W3G
         l3giZWBS/PMM5eubeMqngmqhJeAyRDvVkrXQr64AaB4E0G7nodn8j7B7bU7h4g6eGgmQ
         nF/nHFnbPtWET81cli/aytN33rKvYMvi6OCUn+nLG/aNeQXVfYg3iCwpjL+dIitYPBEd
         +nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLAiRuRu64Y3lZpUoso5lquaEiBZ9TQvktgCtzp7Q44=;
        b=a3NaKGJVPLw1G8R3yP7KSFZT9IuqyD4/fHANKPnoHBtJo7TLdlC0KSMwWGCBiauxes
         qTpS9Tq+dp/HZPzY3qglDXf/XF13dy5ds5PO41dwSLINmxTUHBfiEi6Lhu4IFCb2lzbY
         1WWScwXN2JLkYze7bKmVAIL019lhQVj3lSKQhNkBhzIkHcL2QBCGaeCLK34B04aNTyC5
         kUDwIA5PB4u7ntvXJKDOler7Q+YOUA/ZICq5U8T3WIUaq4PkVlWqz4UVQ0C4euuvt2kJ
         HB4KHhVBT1cKlhDRwxPjpljzVHk2BVorXuiSa7B9zHD7I9hOWQohrJRPS/7KGqWFp/74
         HfYA==
X-Gm-Message-State: AOAM5302RLC80UTdKhVV4wo1pasahGUtwnwqF7wiV9nlhrgsxvFrtyW0
        SzoZR8YhIitkyt2LCPx4SUR+RN2I9aij2g==
X-Google-Smtp-Source: ABdhPJy4s45ULi3Y3hxbTVNXsB4DwqnblTFrWI295XZYRW26o63ptOe0cNN3/GUqWYRzIPrrXWC7Qg==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr5570415wrg.180.1615911480447;
        Tue, 16 Mar 2021 09:18:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/22] fsck.c: move definition of msg_id into append_msg_id()
Date:   Tue, 16 Mar 2021 17:17:24 +0100
Message-Id: <20210316161738.30254-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index 0a9ac9ca07..b977493f57 100644
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

