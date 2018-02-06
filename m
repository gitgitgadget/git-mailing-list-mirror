Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712AA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBFAXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:23:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45483 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeBFAXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:23:49 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so154593pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ziT6kxqtjrQsv88995QZqNrhqQskyj0lq5TgAxeLnO8=;
        b=os1Vdl6/WzzIuoIoe3TzlC7NM3U4FaIrf5FOW98zmHevLHv3d+1K1SxI8pZK8ZpvxV
         Q+o+P+EgWywgLsCRvkanqWzwtp9jFLWJcmfJ3nyOEaZ6tUr2CiKdMx/eJSdpn2VkKg67
         3+b47bE2yWQgzisEHKdMRbqhgXWxpJaI2wS1xHI0CjtJU61zjg9t3IcN+EtkcRPGvXOw
         Vo1oem0dKmENQdslcqbl9RXsl7xqaNMvroXirmD1X42u7rj31h1S3UK8gLjT3/UNTgdF
         88vUN+D87w5VWb1ctNYzdqq68GA1Th+gYPaogmo4KSMn15X0PyVxYRlxR2dByxKGUGig
         z60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ziT6kxqtjrQsv88995QZqNrhqQskyj0lq5TgAxeLnO8=;
        b=heGoN1FYNySWqwIuo8oL+ORUHJve9Ub+CJjQ2e5YTuQmnVgSBp27qFeyF+0ZIHS0Jj
         nhKz5yLyAzM2uxxo0uOA2AU5Vu4N82kGLnr9Ajo4FYryE9WN/R2Rqy4wlAHEeN7DH5C6
         Gh0GAYf7E+kOJAq3JJS7rCoHyPmlRt+nUZyxJetclNmhLK+MhtxSJtSWcXFjGzKivB++
         aGnsiwvEWBekXOAV5zNMWuvtVp7Tth6/Yzrg3WojdcyPdC1OFtesCLn4u6wFkGVby8gm
         ZGnSbLSPm06RBbcf4vbZKf3GgRbnqjjHeJ+r5QIOLtygJCHaKiRlmt317As6tdgc0H3x
         eAfQ==
X-Gm-Message-State: APf1xPAyDvkgDyhcu5P/++dl14CJBWk4ACwRbImS+yOrgQKWtH4ZInn8
        /0Q8eZGfp5VXBqZjolKCGCIdoJbjM5Y=
X-Google-Smtp-Source: AH8x2270x9E7ZsvzYJ6HxkkilNECgbhDQGjlvrwlFgGA6KPjmM++KDYimLiC+BOU6wkXIhj/uiv/Qw==
X-Received: by 10.99.173.5 with SMTP id g5mr426524pgf.391.1517876628341;
        Mon, 05 Feb 2018 16:23:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o63sm989220pfa.101.2018.02.05.16.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:23:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 137/194] object: allow object_as_type to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:52 -0800
Message-Id: <20180206001749.218943-39-sbeller@google.com>
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
 object.c | 4 ++--
 object.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index e84447f229..db15de6623 100644
--- a/object.c
+++ b/object.c
@@ -155,13 +155,13 @@ void *create_object(struct repository *r, const unsigned char *sha1, void *o)
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
index 587db55dfe..513f5eaef4 100644
--- a/object.h
+++ b/object.h
@@ -124,8 +124,7 @@ struct object *lookup_object(struct repository *r, const unsigned char *sha1);
 
 extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
-#define object_as_type(r, o, t, q) object_as_type_##r(o, t, q)
-void *object_as_type_the_repository(struct object *obj, enum object_type type, int quiet);
+void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
 
 /*
  * Resolves 'sha1' to an object of the specified type and returns the
-- 
2.15.1.433.g936d1b9894.dirty

