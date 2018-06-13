Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B131F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935980AbeFMXGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:25 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:37503 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935933AbeFMXGW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:22 -0400
Received: by mail-vk0-f74.google.com with SMTP id j123-v6so1638799vkc.4
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=v5abQfGtcLGMdUqCZQx+LVHcttiZO2Z9wmHRkpYhXmo=;
        b=D9yYq8KAqdKTYOfsfbbrB1nUw5fjknb/6JFF/foMQFfSkS+Bjiiq7f+QusTkmzsp/a
         HOj62yMFRPK1vkixbATuw+jZaZS6fcnSxtf+ZesTIcMJfsTSHhS6kwWZu2UPZJps1lOG
         fGm4HX+gcCnlf3BzYr78dHB0wMQPefd1vW6K4UjoRagiPL/1Mie96IQ5EmVZ5NW02rZV
         dcNtcekdG986H+EgTKTELVonRXpOE+a9aGlS7NT+cW8y5i/uD9YjDKhaXodTP40TFgHh
         SAMh/wyq111J1F0gyfSpfTgp7PBL8ySxUY0eEEMRjKKGmp10TVHxrBQTvYA2XSM53yJk
         w2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=v5abQfGtcLGMdUqCZQx+LVHcttiZO2Z9wmHRkpYhXmo=;
        b=MCFWNQOGPyfiNKFe6mJSvg9YceIpdCpj51enL+MJUE5OYPdpUGfMNbi1+jXKKU5avp
         hI20psA5/wettrDbu7U4R1Ri6/xOLzVBBavRWTa9N9gZ7/nggTlNLZ1dlk4aodPe2fYu
         VhneQ+T2BMbmqlxv0l+M+6z/42JmQ/rx5kkBzDZHhcNeLVWvc3m04WESamgoKogB4q1D
         1t5mGRROJEg0vS9wRXuVi21jenJtBeOozNcoUIv+8AWh2VKJlKrMFvFfoIAkld16x8fr
         pLNQMiyKvTNnZXcdpmqp8lYcW4D6HyCfLEgMcK41zUQxSttqcIGb8Yp2LX2gW3BZ5/mJ
         sRng==
X-Gm-Message-State: APt69E3gMGOod440qtS86O2mlGrz2PUMXMl9PNcYqgwDuQ+gPXfn/rd/
        6qj9wCEVBA/24D6YDXso6zK2tVRfiBbWlsn+AqnbzrG+u92ePnUrf77j/4cugC5fURz3stJnLe4
        yafOkGYngEb9MABFm3z8bGtfZgKDfFdFmnZan0Zme6emf0Xd2kn+/0BUXGop6
X-Google-Smtp-Source: ADUXVKKdbKwEhMG/mIoPtSJ9D5GLV+34u+8g3FN4O6VYJeX0yooRsMou99gHLief0y7/C9hoqiMUxQRmPhzf
MIME-Version: 1.0
X-Received: by 2002:ab0:1b87:: with SMTP id k7-v6mr67830uai.103.1528931181815;
 Wed, 13 Jun 2018 16:06:21 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:11 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-21-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 20/31] tag: allow lookup_tag to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 10 +++++-----
 tag.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index fbb4659325b..46b5882ee12 100644
--- a/tag.c
+++ b/tag.c
@@ -92,13 +92,13 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag_the_repository(const struct object_id *oid)
+struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
-	struct object *obj = lookup_object(the_repository, oid->hash);
+	struct object *obj = lookup_object(r, oid->hash);
 	if (!obj)
-		return create_object(the_repository, oid->hash,
-				     alloc_tag_node(the_repository));
-	return object_as_type(the_repository, obj, OBJ_TAG, 0);
+		return create_object(r, oid->hash,
+				     alloc_tag_node(r));
+	return object_as_type(r, obj, OBJ_TAG, 0);
 }
 
 static timestamp_t parse_tag_date(const char *buf, const char *tail)
diff --git a/tag.h b/tag.h
index 45b0b08b1f6..6a160c91875 100644
--- a/tag.h
+++ b/tag.h
@@ -11,8 +11,7 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-#define lookup_tag(r, o) lookup_tag_##r(o)
-extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
+extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
 #define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
 extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-- 
2.18.0.rc1.244.gcf134e6275-goog

