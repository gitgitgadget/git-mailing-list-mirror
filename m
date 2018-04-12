Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFB81F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeDLAVv (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36002 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeDLAVq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id 91-v6so2606421pld.3
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=drrSJMjEKhktVBXymTc31AeRL5hNvpFWTVkRSqYzTvM=;
        b=M3qLK6DJu7gfPD62fmEIDmHNCdG3hziYUvqpvF8G+tcs6jHoXB1jXi4yQ8QWX1ogiq
         nE11REd7OXRJ1WA5SR0IztYiRMDyPj/bB10+h2K/53WmJ2lywQswaN+7GiFLjQty/KqX
         zuPobMZqIfkoMP8UUNqappTpLdPaRT9VcRW/vp6gJlVq3puXUQa9YvyHbVKG3rETtIva
         4ZaeoRdeQ6TjXf1BK4U19K4buHuP8vUFkLxO06PHuQvFbUkQSVnzexdkkzSLeCzwgHFh
         H8Y3JGV5eJSiPM61WkMLnumcj/nMYmOyo7JaJy4jGUffmZVCsJoMv9M+hdgmbjpxGNBs
         mmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=drrSJMjEKhktVBXymTc31AeRL5hNvpFWTVkRSqYzTvM=;
        b=JvN0pFRHWgJbx0evqUR9onvXePQN6qtPZw4ag5RLa8tmzcVXevY6wVclIB67uGmk1r
         97VQBJPeXz8LpIozeeJ9Mjh9aQYZJtw8HhFd/wQ/lFMpk7piYNNak/Q/6Wy+x+UA7W8g
         siuKq33v0sDGtxyyP7U9b7BXkq4jG72jyJW3Z596H+70DDz/3jgo3j6u8IBF35e2+vMq
         KiLcEyVKVbrmlhAf7/SjN/RG84oKfWYKKSzbPM5kZou/VmwbWZg8r+VqpG/54BdcwvmC
         WMI38IKDlCNzC/8pismKGnp6obfZlmvbvw1ZuNGzyJyxeKwRgaZ65mRcW22lQ81pe7xr
         PneA==
X-Gm-Message-State: ALQs6tB7oPzN2nlmp71/oHRyyLs58Kl+scIsC9rTwN6z6o+YIFxKjD5E
        JXHvhxmvQaxUJVkK6vTGPPT0EQ==
X-Google-Smtp-Source: AIpwx48/thp3sS3gRlYr7GgSYd6EngNK8An4am+l9iQVVENeoqpXN8fuDRoiqp9zLDtNNnFIsA9bXA==
X-Received: by 2002:a17:902:b903:: with SMTP id bf3-v6mr4162593plb.37.1523492506080;
        Wed, 11 Apr 2018 17:21:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t23sm4354675pgu.41.2018.04.11.17.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 15/15] replace-object: allow lookup_replace_object to handle arbitrary repositories
Date:   Wed, 11 Apr 2018 17:21:18 -0700
Message-Id: <20180412002118.102976-16-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/replace-object.h b/replace-object.h
index 3520fd7ff7..9f607a929b 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -23,14 +23,14 @@ extern const struct object_id *do_lookup_replace_object(struct repository *r,
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
-static inline const struct object_id *lookup_replace_object_the_repository(const struct object_id *oid)
+static inline const struct object_id *lookup_replace_object(struct repository *r,
+							    const struct object_id *oid)
 {
 	if (!check_replace_refs ||
-	    (the_repository->objects->replace_map &&
-	     the_repository->objects->replace_map->map.tablesize == 0))
+	    (r->objects->replace_map &&
+	     r->objects->replace_map->map.tablesize == 0))
 		return oid;
-	return do_lookup_replace_object(the_repository, oid);
+	return do_lookup_replace_object(r, oid);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.17.0.484.g0c8726318c-goog

