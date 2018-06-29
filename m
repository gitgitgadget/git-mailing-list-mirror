Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99751F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936478AbeF2BXL (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:11 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:52047 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936468AbeF2BXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:10 -0400
Received: by mail-vk0-f74.google.com with SMTP id y65-v6so777102vkd.18
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sVdqk55TCKexh3pLN24JLUqGGrz8KUkOkRO1BcHYX5U=;
        b=uXLYGGHyDuczCg90xzI6oq4SDIOmYTfKtXBMnAPTGQS1jirPwB6ayZDC/AbdfZSu6p
         fFJy5h+MgDgS3gH7XXMZ7lzr0VG7JM/jeYgZOcDDMeyUV6NOarATAZ9zfGprW5hUsfHL
         XO+jVqz2Q2wtXpUGzSDD96FSY2hlIiPh8OHivFrOc6hj+Ejd0yfL0h2GC+wTcOmwYyMc
         C3YeiGOpptpdrB1uXojjgAYkD668KBtQtgVbLVEajE3cjS3qSvbgUVzHBPoq0Qid09Vo
         URrIGAp4JTYes5reM67Oe8gLSAdccions46WnWOqCQtX0b4io2gqF4r7Wqf2Lypc/S3O
         HWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sVdqk55TCKexh3pLN24JLUqGGrz8KUkOkRO1BcHYX5U=;
        b=dIcbXeufO2Ky82UTfDWJJ4HgQL3yYVDXjhdp9XQJpnXorddPJYicdqISu+ErBhrN2b
         7Tugm3XOdf0mPZcbneIjrRq51djYRKQafFfHlGmhNZkJ0+B8PCFH7KmWQhlEGqDIFgOy
         qzjw5T1rN4aPPBbsDOo2+r4IFx5rFvUWqsCq5AYlXiPIPixBNO1QYIguDWmE2t1MNArN
         yP3ksZzRi4OZGcFFRL0L+gNHlj0rkoOsV4yf+NuKfuPW91Sk98HcldNKY1fXwQtoPee0
         nCK9Yy7OMW4Vc+vMqvfmKhAaFYSfBTktejqG5U4bwPDL+/os7bPiEJHof/D+6vhy0PtT
         HInw==
X-Gm-Message-State: APt69E108oL7Px4UlV88m0RPcaj9xXwZdKvR6Y+LFCksCDaJCa7stCCB
        EvbJ1UNie0IOsq/TaobSM7Bk5YhVdBDDT2cI8h96WdvQ3cZ1gTJKRre6Ku9W48vm0nQx/vK4P/E
        ONKTNA4Je3E4nwNSgDbJq0UNXiwuiy0+mbq/gUls5D5zKHpz4rnYaHAmF2vzY
X-Google-Smtp-Source: AAOMgpdY5S9jjxrAoC6NWMM63hHYgbVfWNZgD031Jrc0X3Ubibbr/mkinVWfZJ/SVZ1yBfIzYhIgmDaR7fu3
MIME-Version: 1.0
X-Received: by 2002:ab0:4141:: with SMTP id j59-v6mr5210108uad.1.1530235389697;
 Thu, 28 Jun 2018 18:23:09 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:06 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-17-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 16/32] object: allow object_as_type to handle arbitrary repositories
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
index e095d49b379..f41f82c6725 100644
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
index 3faa89578fc..6f3271eb228 100644
--- a/object.h
+++ b/object.h
@@ -114,8 +114,7 @@ struct object *lookup_object_the_repository(const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
-void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
+void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
 
 /*
  * Returns the object, having parsed it to find out what it is.
-- 
2.18.0.399.gad0ab374a1-goog

