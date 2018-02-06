Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C201F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBFASD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:18:03 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36608 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeBFASA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:00 -0500
Received: by mail-pl0-f65.google.com with SMTP id v3so124668plg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UPdzn03V8EGSQem1euE4Gl8hhx4clJXZdvZFchEUy94=;
        b=O6UUXybzw1xhoWOnQQVfXaXZwFJg04PrZySbIIiTMTv1Vbanv0nJ9ba4a+Yoyf+Ykx
         iRGvB33Ci+xwUV97MIRG9JuL7aJB/Y+bpcMTXDNdZP9LKs0C30njI1rYXDyRHp0KSBHl
         QEo95vPXC7l1hmafD+kLBhFwWD1JiJxUvzIUcrXRxm702b6WHkmxi4RJKSMjkbog+Ovj
         PAQ5B9sJzch3D3/5jFMXm9mo6BC6UUVKrx1AztjN1Z2hcuX9pt2ZlBOLuBOhlN6jrk8k
         0hnOoj2dp/iSihf1njLYyQJQrz6OG69IYeK4MJc9ZcuK+gYQhiBtoOamIHGAd3gOAeAi
         jvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UPdzn03V8EGSQem1euE4Gl8hhx4clJXZdvZFchEUy94=;
        b=Z6HMJBoCz2wZV3Ahdm7iKX1//oKaAYkn2Bmx4d0ePhxnaSOSVztioskFXd3ZmzoWGP
         AvLriUPAcAqUqx1hBoSic5t0CndC7kLp9uaAz6fTz0kHG1QtIaSkfEL3U1z/0aw5ZCk1
         ntOIveJHO397Ms0Khid8R7V78WyygICiWlYkICwEEHsF91LDHFPXTtosfPaAIzhMAVAV
         9SuisonYsLt898SSnsK/yvwwuTRJwR34Z8i9pe+ZpdCgKOrMGMe3wOe7UpEbIUVGyt5l
         TTmm7d/OKj2xZ3OJbz08RVGis+z/Hx+Ju18CZ3YcC4vHAOdbOeMAhvLx1smTiVZaYsS+
         uxLA==
X-Gm-Message-State: APf1xPC4XZFMn0BHwJAVYPfzM9IhXYaSEE6hztJntyTuM2BH4G+FdSKv
        e/RYJR/RgWpQBOmjnqccf0rrtrlK0p0=
X-Google-Smtp-Source: AH8x224YDxyVbS70qceU212Nt5kntbNNNvZCVCp0Kx3gJAp71fiDorYSqFwgNq79rg18aX1bYwXdPA==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23-v6mr565771plo.74.1517876279069;
        Mon, 05 Feb 2018 16:17:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r29sm9633136pfb.40.2018.02.05.16.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:17:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 100/194] object: allow create_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:15 -0800
Message-Id: <20180206001749.218943-2-sbeller@google.com>
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
 object.c | 12 ++++++------
 object.h |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index be5d6c0931..de19d814c1 100644
--- a/object.c
+++ b/object.c
@@ -139,7 +139,7 @@ static void grow_object_hash(struct repository *r)
 	r->parsed_objects.obj_hash_size = new_hash_size;
 }
 
-void *create_object_the_repository(const unsigned char *sha1, void *o)
+void *create_object(struct repository *r, const unsigned char *sha1, void *o)
 {
 	struct object *obj = o;
 
@@ -147,12 +147,12 @@ void *create_object_the_repository(const unsigned char *sha1, void *o)
 	obj->flags = 0;
 	hashcpy(obj->oid.hash, sha1);
 
-	if (the_repository->parsed_objects.obj_hash_size - 1 <= the_repository->parsed_objects.nr_objs * 2)
-		grow_object_hash(the_repository);
+	if (r->parsed_objects.obj_hash_size - 1 <= r->parsed_objects.nr_objs * 2)
+		grow_object_hash(r);
 
-	insert_obj_hash(obj, the_repository->parsed_objects.obj_hash,
-			the_repository->parsed_objects.obj_hash_size);
-	the_repository->parsed_objects.nr_objs++;
+	insert_obj_hash(obj, r->parsed_objects.obj_hash,
+			r->parsed_objects.obj_hash_size);
+	r->parsed_objects.nr_objs++;
 	return obj;
 }
 
diff --git a/object.h b/object.h
index b667404f88..699adcf161 100644
--- a/object.h
+++ b/object.h
@@ -105,8 +105,7 @@ extern struct object *get_indexed_object(unsigned int);
 #define lookup_object(r, s) lookup_object_##r(s)
 struct object *lookup_object_the_repository(const unsigned char *sha1);
 
-#define create_object(r, s, o) create_object_##r(s, o)
-extern void *create_object_the_repository(const unsigned char *sha1, void *obj);
+extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
-- 
2.15.1.433.g936d1b9894.dirty

