Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29801F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBFASb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:18:31 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35632 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFAS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:29 -0500
Received: by mail-pl0-f68.google.com with SMTP id j19so126966pll.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qhc3AQ9lIYdW0uzN1zA/C2MZxxNe1a3X7jxDc8zGvSk=;
        b=uOCiInFHay3HH1eQohXzk350W+OU6CzX1dQJWaoRyjPXSvwEML7IXZ3APjSnz1ieoE
         8cdimZSE/a5ORzlq5CAsiafnCqg4lTujZ3nEJxl8XEyUMw5ZQZo7sPhB2UJEgKUI/lIk
         Qt4V23H2laq0kTYzwQ5ROMDWf8ik5/VnD2F+Y+Rty+ebMQdE3L36i914+uJ/HFXzVC3X
         a6yR8Eg3atg9+SP4NzHJVvxrjIch6AFmsFPJ7MYlaS5qfxH3Y5onY3CIAQcwemebHgCA
         onQ80lcY/caDbzDfUqeafzhRkr8HwzmslFb7ZntsKHpOmO4JM9sYU+1cXBfss8J79/Og
         VPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qhc3AQ9lIYdW0uzN1zA/C2MZxxNe1a3X7jxDc8zGvSk=;
        b=f4q8KfV9i6j3uFMpWZUnvVGy88bKTE7sy/85xkIUYHL7UBSx+Ocb3HY4mtHuLVgdsS
         fUpdylQ9K3PxnEQMkR79fUOhX34s0olPV0pNsxu+q0UkGa7iscn5C8UoOtVPea6ACLEP
         yJAAExMveOXXzsrVqkPUrzKoX+9y71JiK0/NrrA9GFvWxQdzStD2YDOET8W+rGFfhIO4
         epww4Y6S08WOyhddECkTM2xwXyltxpWhp/+flKeHAvGneb6aDb+zpUADl0WGDwoI93Xd
         Zs831XU0X/0T71vfMVLoQ/J6jxvCLC/8YOZg89nbImW7GaNojgkrs+bP5zoNxg+XV981
         un3g==
X-Gm-Message-State: APf1xPD84lB3qQ4d7iXPKhW875+0OZEypOuORrJPvbSGzlWh9YUJqLKp
        11yQPDRgAkTxnjxgJcBMuZ1p8fMBN3E=
X-Google-Smtp-Source: AH8x2254G+zMEpMqiPPixJ/I97uFSSzgQZBzfJvbPHGP0CF3h/Ik/mc1c4+3Ingi9zQWJ/z+5CXf3A==
X-Received: by 2002:a17:902:d905:: with SMTP id c5-v6mr517071plz.225.1517876307903;
        Mon, 05 Feb 2018 16:18:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v28sm14565967pgc.47.2018.02.05.16.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:18:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 103/194] object: allow lookup_unknown_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:18 -0800
Message-Id: <20180206001749.218943-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 7 ++++---
 object.h | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/object.c b/object.c
index 3eb12bec49..9edddbe1d4 100644
--- a/object.c
+++ b/object.c
@@ -174,11 +174,12 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 	}
 }
 
-struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
+struct object *lookup_unknown_object(struct repository *r,
+				     const unsigned char *sha1)
 {
-	struct object *obj = lookup_object(the_repository, sha1);
+	struct object *obj = lookup_object(r, sha1);
 	if (!obj)
-		obj = create_object(the_repository, sha1,
+		obj = create_object(r, sha1,
 				    alloc_object_node());
 	return obj;
 }
diff --git a/object.h b/object.h
index 083111d7b7..dd009a03ec 100644
--- a/object.h
+++ b/object.h
@@ -130,8 +130,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
 struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
-#define lookup_unknown_object(r, s) lookup_unknown_object_##r(s)
-struct object *lookup_unknown_object_the_repository(const unsigned char *sha1);
+struct object *lookup_unknown_object(struct repository *r, const unsigned char *sha1);
 
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
-- 
2.15.1.433.g936d1b9894.dirty

