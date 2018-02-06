Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D18E1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBFAaE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:30:04 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41026 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeBFAaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:01 -0500
Received: by mail-pg0-f66.google.com with SMTP id 141so175976pgd.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cqupwFoybwwZ/Sui3zp9R8rpZ5PUcHyVHzOECUkllHU=;
        b=SsU96J/w87CTQWEVZxvilf7VV+gJcYCKHG7UwpFhneEAEcUGnz0lpq8UWv1uT9dpaF
         NkL7pclnNpFzGXhilA54XqDRhxYTlvZ6VK0xjTu81X1PrKmPaYLKlI+YE8pvp9ysagSe
         7DeMkVKwg3bzrbEMk9yfXItfvg6oyAyO6EDgzKBU7G7hrvO5DZBhjO4ssibL6wrRE/Yg
         NlZ0m7r2eGHdoZgUDX/tDWx5jw8FDXigGjbk8CyavNY4cQiFENAtzELuMxZbX0s2j2d4
         j2BC9iDtIfEeCHdGHPPavhWIf85/8mZrZwKqbBIsxU5pC6SvK//eC1yd8LxRyvTqAY+B
         UvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cqupwFoybwwZ/Sui3zp9R8rpZ5PUcHyVHzOECUkllHU=;
        b=rQVh/KySaSmddwP7f1ZfFpqRci2Rs+vOJFtcwLNiVDKjxR23pGuueSf44IlHAK7b+k
         GOu0c++WJ1l/ZSdYEpMNrh6oCPvME8DfZ3/gWk3p4cYOBthD+Y5xfhz8HF9WzLRyzh6t
         7fEpgxQz3LoQeUnrxnRfZP2yTr/mr7Vq+g73q3QuoqFSCWTDLaPyJ3x+itw5vH9d1RQt
         NrKRIUt126el2TkmTaKP6mlHlsSH5dyBJKGjRgIBcnka5HkUxWKc8BQ23aGiDbY3MUku
         fzL5Z9NqY42nMUJM1SKx7/IVSfigbnMKlLUI3PdiqvL2j/ylgw1n8TLtRpg/uplqnE18
         BeFw==
X-Gm-Message-State: APf1xPCV88xA8g3vhN6S6Mo5eBd3P4MKP5zgF+Y/GxqDv92+9+mL3CIF
        yHMSHfxMIO4dBKHTzi08PUpmTTcskv0=
X-Google-Smtp-Source: AH8x226Yh2mNMn8jAAkOX7a+O55EH4NjxJOV1hbZ8A1c6Eang2eIkSaCRURLvBq2iirvt2KKdcIFCQ==
X-Received: by 10.98.157.213 with SMTP id a82mr558038pfk.242.1517877000189;
        Mon, 05 Feb 2018 16:30:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j6sm18796219pfg.90.2018.02.05.16.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 174/194] tag: allow lookup_tag to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:29 -0800
Message-Id: <20180206001749.218943-76-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
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
index e0b695cb60..52009bf454 100644
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
index 4f45695e1e..d23af572d8 100644
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
2.15.1.433.g936d1b9894.dirty

