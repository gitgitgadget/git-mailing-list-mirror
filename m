Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907AF1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeDFXWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38371 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeDFXWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id k6-v6so1533267pls.5
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dHgvLzuigvUdDADtBwDpBJhMgm1DJp/xz7FRlWrmKbU=;
        b=kJ7sBwDzgVkrieZlBbhIex1ep8PZhe1u9EDyUxVxMG/92w9dMhAGeupapqr+YjAPXG
         lQOsr/SnXXpU877vPCLrNjBG5uZ7sVmanwhkr8ws+P3xhwhCpz9QucrkA5Svx93dh9oY
         Pz75yQsfT+tvyyC/hhexL88JR3sFuGEmZ729YNgU8CWRIv+4CCGJWo4S/H8leJMYXZ0Q
         PwyX9/HA6kzxtAdqCLYw/IJ9Ttcb8QVjo9vtoL1s9CF4nfEpkoaYIulXp2n4oJX13VFx
         71fo1d6hfll+/OUHOv3/CtyuSxBmvOsAKvyLXz+NbOPrcIyJrfSZ17qcQOfmNvBWxp/B
         GpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dHgvLzuigvUdDADtBwDpBJhMgm1DJp/xz7FRlWrmKbU=;
        b=EDNnO+lJNb1hA7h8Rs7tugOo5lvR8+lG7i9n7Tn2L6x9H9VKRq6KSw88eQgvMDy5cF
         yL9RquI81uvBCfUg2AKFrXK7JTNMVgAxI3dJ/jSxjdoZk78UtQHpboldMvSpN1ilHCnd
         LIZV/aJwquWXDtXwcoj/8oQPIjxn2YBRaT9GW/uEKAhaQTiOoR1P3btZaHVYIHMvSJqU
         /x2jAj9eMYskwdDW1s6UT6P0CR1LeU6n3VBaMSMUob+7HxFFh2UDnNTfVubE/IHjIdPt
         r7ey9L7YT9duroivnIuS32tcPALd+sScBiJVts0F2z3IMtd/G+PV4GAsQKjyG4QRFjBs
         HiSQ==
X-Gm-Message-State: AElRT7GlMtrw1h2rLR2Ef7RYeSjq1vPFTXySsaTaYHyiOB4o/7C6tlVo
        NI+8JsT/3gy6O/20QyAkSZF4Mw==
X-Google-Smtp-Source: AIpwx4/+1cYzSBGr/zDOWWZgV9YicMtC4xysdqqkM18IIwI12+gYamXOHrvG0AzRik6hqJrZPAIpaQ==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10-v6mr29425456plt.387.1523056937244;
        Fri, 06 Apr 2018 16:22:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r70sm22426985pfe.22.2018.04.06.16.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/19] replace-object: allow lookup_replace_object to handle arbitrary repositories
Date:   Fri,  6 Apr 2018 16:21:36 -0700
Message-Id: <20180406232136.253950-20-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/replace-object.h b/replace-object.h
index e15f0725cb..e7511ea54c 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -22,14 +22,14 @@ extern const unsigned char *do_lookup_replace_object(struct repository *r, const
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
-static inline const unsigned char *lookup_replace_object_the_repository(const unsigned char *sha1)
+static inline const unsigned char *lookup_replace_object(struct repository *r,
+							 const unsigned char *sha1)
 {
 	if (!check_replace_refs ||
-	    (the_repository->objects->replacements.prepared &&
-	     the_repository->objects->replacements.nr == 0))
+	    (r->objects->replacements.prepared &&
+	     r->objects->replacements.nr == 0))
 		return sha1;
-	return do_lookup_replace_object(the_repository, sha1);
+	return do_lookup_replace_object(r, sha1);
 }
 
 #endif /* REPLACE_OBJECT_H */
-- 
2.17.0.484.g0c8726318c-goog

