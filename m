Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0027A1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935955AbeFMXGP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:15 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:52839 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935944AbeFMXGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:10 -0400
Received: by mail-ua0-f202.google.com with SMTP id c26-v6so1344322uam.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=i0+PxC7Nqmuy3F+o06aireQr0Nuo1xQ64r2FR0Xr838=;
        b=TiA04v+psPddhyvG+LiGj2uoqkkmZDLLbUF00bQ4ZXLw33Jt8ZVYx/StiGJD6/JmRo
         ZKwgWXajWejyD5XTw4PFOer+fBXVWWRT/oYpYPcC8RqFCM6cvfevM19GmNOhGWMywGTV
         DAkw7fJLECpAW/BBBgJ/wlEjVypU+8nyS/qvG9QOu/lxKinrqvzvq+6A4HBUClYdI6/j
         NeNu28dI3F7IPM0fvg25ijjTj/gc7zmtfuD1dSEcZCjUbPbSf56uVJelWmz8f5YqrNPo
         7FYusCaYUMLY2Rpz7DqDxXeDzzvuVtAifkZakefyjLKySERcKW9A0M8NSBmy8Q7xVf9C
         1ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=i0+PxC7Nqmuy3F+o06aireQr0Nuo1xQ64r2FR0Xr838=;
        b=L+AIcswV4P6K39twEQqpE3F2/8ClxNe/R+q8G0yej4f7bmBiAOOB1DgyvnLre1EeQU
         4gLQ1M5oIFVTgQ9De+x0CFs6953x2mnXcMziO8QMkvKEU8ERbTFMf/cMituPPMHufguO
         BIFSpUUSm7Zc5Q8b6qD3ZVWde3aXILYqgaVi35f5i7fUdIeeze+JAO1oD++ocqvgrMvD
         GDQe8P0w3UJKKMUWzXgMGE7E0hv/LbtXku1SO1jG+35T8J1xzkZuBf61dnjiuQelRwm5
         plAnnfKYQQfJyKfrqZU0axjaIdWtvmekoPWcMMjIAIx4uz2X0WBLnznTWzaiF8npOScx
         UCSg==
X-Gm-Message-State: APt69E3MeT4ZJunlXwVpmhQMHIa1fhGsPV1ofWyb69xrD2TBARSNo503
        iyk9I6DtFuF4Sc/I7l8Opb58y62AQzxZjJD+T31WcbySv3tDW1+u46MrgzKyDvkXE4sQJ1Gg46i
        epGhoBQa9XMKrE5zuJZE8XCUemPCdwGgRhI2RWkwWeNwwisPd6N0KQ3iAt8jW
X-Google-Smtp-Source: ADUXVKKwx1QT6pgrh7Fefxu6P/ECQU+ezpjsMVu+l9J8s+EWSUiqz6j9b5wDJAX8Ae0hxfCQVP8vm6o1yNbJ
MIME-Version: 1.0
X-Received: by 2002:a1f:3c12:: with SMTP id j18-v6mr79397vka.56.1528931169884;
 Wed, 13 Jun 2018 16:06:09 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:06 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-16-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 15/31] object: allow object_as_type to handle arbitrary repositories
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
 object.c | 4 ++--
 object.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index c6779ee596f..876ca4977e2 100644
--- a/object.c
+++ b/object.c
@@ -158,13 +158,13 @@ void *create_object(struct repository *r, const unsigned char *sha1, void *o)
 	return obj;
 }
 
-void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet)
+void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
 		return obj;
 	else if (obj->type == OBJ_NONE) {
 		if (type == OBJ_COMMIT)
-			((struct commit *)obj)->index = alloc_commit_index(the_repository);
+			((struct commit *)obj)->index = alloc_commit_index(r);
 		obj->type = type;
 		return obj;
 	}
diff --git a/object.h b/object.h
index 5425d8e647c..bd25155480f 100644
--- a/object.h
+++ b/object.h
@@ -115,8 +115,7 @@ struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
-void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
+void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
 
 /*
  * Returns the object, having parsed it to find out what it is.
-- 
2.18.0.rc1.244.gcf134e6275-goog

