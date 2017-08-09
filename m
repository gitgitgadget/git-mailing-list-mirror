Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F5F20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdHIBXh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:37 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36927 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdHIBXa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:30 -0400
Received: by mail-pg0-f50.google.com with SMTP id y129so21571952pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=33J50cfru41OUoqher2QxFCf1cbRmEj0vhGBZ/uktwk=;
        b=ieWa3XYMsnYV5ezoZkbKLxvlW5qp2ICwfIfZUd/ER+86UN4HWpBrrXETJzkZPvLiq4
         JqQsCjnWelX4yVWOZRjrHWg0+7BqxHhTgcvBPJkLy9YkCgu2GgIIPUTLNcxu2CnJAFM2
         yxwOl4Wap1q3Qz+rg+VaAcVGo84BA0Gi3882NjypvsW68ZJD6m3F599AkYWdfTgu5RVf
         viRWEq5bPgjrDRASjkdiKM3bE3yAbuDqy7Hg0JYHRPbwgOidu5sn7YuQ4YkY8ZeEv+nQ
         C8C/y4KaeJd4/foftPrNohDkRq/YJ2+lIoFu8ynfmzbR3nzkLgi1Z+GeMbgrtDzEgI9d
         aMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=33J50cfru41OUoqher2QxFCf1cbRmEj0vhGBZ/uktwk=;
        b=oBAuQcPubdDipVmUlZoHt0mgCZoWr+NJ8sseL4WP5d/45WAjzQU5DhWniUcMv/dNt8
         Ea6vho1ZcFekF5B3iWDs1xfhuIEAb/Olvkywa0BQT5xzbEZ37ZNDSkFW4W1CbbV+PVRT
         7zwRvuejbQ+H24v6e2M/6tPxlJXhhyJpr/7qpm6gK7ReS57OiUCO/IQnAYLzA5PJMHkN
         gLgDtR/8mP8Sw3mAVByJOMyLv86WxyaCxNUyEVu+sfzyvfLDz4VKwx+FuAx/XnCSb3Os
         6B2fKucwdCs9dInNu3EnlRE81Owx5Y4wsYnn5WvWe6N+wL/3lZjLHUgd/fbeMTbfFunL
         A/tg==
X-Gm-Message-State: AHYfb5jtARAbHHrgpfxUsSUzBFqipDOtwGOXbclctkkWXl59WXhs1Y5f
        /kr4kKHfBcJ3Cb0bTPiwGA==
X-Received: by 10.99.113.17 with SMTP id m17mr5857478pgc.343.1502241809356;
        Tue, 08 Aug 2017 18:23:29 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 24/25] pack: move has_pack_index()
Date:   Tue,  8 Aug 2017 18:22:56 -0700
Message-Id: <e35e5394198a5c23a81400c0f5a9f6ae316755a5.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 2 --
 pack.h      | 2 ++
 packfile.c  | 8 ++++++++
 sha1_file.c | 8 --------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index d96d36d50..656b39d51 100644
--- a/cache.h
+++ b/cache.h
@@ -1225,8 +1225,6 @@ extern int has_object_file_with_flags(const struct object_id *oid, int flags);
  */
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
-extern int has_pack_index(const unsigned char *sha1);
-
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
 /* Helper to check and "touch" a file */
diff --git a/pack.h b/pack.h
index ce0e15deb..2c2a347ba 100644
--- a/pack.h
+++ b/pack.h
@@ -225,4 +225,6 @@ extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
+extern int has_pack_index(const unsigned char *sha1);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 507f65236..28a16206c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1855,3 +1855,11 @@ int has_sha1_pack(const unsigned char *sha1)
 	struct pack_entry e;
 	return find_pack_entry(sha1, &e);
 }
+
+int has_pack_index(const unsigned char *sha1)
+{
+	struct stat st;
+	if (stat(sha1_pack_index_name(sha1), &st))
+		return 0;
+	return 1;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 2610ea057..8584f6cf2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1621,14 +1621,6 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	return ret;
 }
 
-int has_pack_index(const unsigned char *sha1)
-{
-	struct stat st;
-	if (stat(sha1_pack_index_name(sha1), &st))
-		return 0;
-	return 1;
-}
-
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	if (!startup_info->have_repository)
-- 
2.14.0.434.g98096fd7a8-goog

