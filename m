Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B705120401
	for <e@80x24.org>; Thu, 22 Jun 2017 00:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbdFVAkq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:40:46 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35353 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFVAkp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:45 -0400
Received: by mail-pg0-f53.google.com with SMTP id 132so791558pgb.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=O6hs6Khjm3VUwZ4CfE6z6+MhQziuSlRi+/sFoy5gBmI=;
        b=dKfQt7c6DaxTenRGF4rwNUyQQHS7oLaldpsi5MdkZFlE2AvpLkoirIkx6DvYRg0cCs
         tpdYB1VJ7Zlpm6m5+S68QeVh3TFXuxCVr8tJSL+IG9Kt4KLNS3/uSyTw9yUmRV96dZCV
         MU1ImWe08VrgkRizWb97Hnzua880aosue/caLr80+rPNqGJoMr54+tAka6ITBlqR0GFE
         /UsiQVUaD0YDNK7ANJMzL3xVatkxhmUDvsyPyFk83igt1NmfLoPt2cQmNh+tuq3IyPvh
         TVNQspe7l5rrsR/8XXWEkpSWcQttK2lidiRSTAI6nJpH7JQXfu6ja6lnm1ISldY6sV89
         262g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=O6hs6Khjm3VUwZ4CfE6z6+MhQziuSlRi+/sFoy5gBmI=;
        b=ZICQc40elMRVkKBSVR9Q728vLuJZY+NuNl0QdueNz6YXXdKNkLSvxSKoZJ//ONHR9g
         kWCic3H4OsKY1icgEmkf34iK8w+ur1g3l/v37ux1hnXbpFR43uSmS4bSoCd6gI+xd2J3
         ig8DwTN0vknWtFmS5WugMzyQ7R7THc1A7+JmgD6v9Qo1amiahV8ZV00LcRI03gaN1vr6
         mDY1gfqub3Vo39UbYwNxrxYmjxYxIwn1tGpbLqag0/NA68nOX+CvOGDNfnWrrbjVCaJe
         gO1D1/F4KsOG4dJcbb5Tjprkfyap+UlnAN4Zho7EzWVG6SZO8slcH4PFFIF4OwqWvB38
         7r6w==
X-Gm-Message-State: AKS2vOzd6M7ZrWdpJ88uEH3icwU12ayjr+dnnxYauU+BjZ+fVgWREQmc
        muZyxaZR1emCQxtvOsY+OQ==
X-Received: by 10.98.196.155 with SMTP id h27mr38657430pfk.226.1498092043799;
        Wed, 21 Jun 2017 17:40:43 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:42 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 8/8] sha1_file: refactor has_sha1_file_with_flags
Date:   Wed, 21 Jun 2017 17:40:24 -0700
Message-Id: <a4f04b3ec9cc1ba08a5dd7f459dce95411fb03e2.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1498091579.git.jonathantanmy@google.com>
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1498091579.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

has_sha1_file_with_flags() implements many mechanisms in common with
sha1_object_info_extended(). Make has_sha1_file_with_flags() a
convenience function for sha1_object_info_extended() instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c      | 10 ++++++----
 builtin/index-pack.c |  3 ++-
 cache.h              | 11 +++--------
 sha1_file.c          | 12 ++----------
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 47708451b..96d5146c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -242,9 +242,11 @@ static void find_non_local_tags(struct transport *transport,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !has_object_file_with_flags(&ref->old_oid, HAS_SHA1_QUICK) &&
+			    !has_object_file_with_flags(&ref->old_oid,
+							OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, ref->old_oid.hash) &&
-			    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
+			    !has_sha1_file_with_flags(item->util,
+						      OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, item->util))
 				item->util = NULL;
 			item = NULL;
@@ -258,7 +260,7 @@ static void find_non_local_tags(struct transport *transport,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
+		    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
 		    !will_fetch(head, item->util))
 			item->util = NULL;
 
@@ -279,7 +281,7 @@ static void find_non_local_tags(struct transport *transport,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
+	    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
 	    !will_fetch(head, item->util))
 		item->util = NULL;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0..587bc80c9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -794,7 +794,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed = has_sha1_file_with_flags(oid->hash, HAS_SHA1_QUICK);
+		collision_test_needed =
+			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);
 		read_unlock();
 	}
 
diff --git a/cache.h b/cache.h
index 7cf2ca466..3ae9769aa 100644
--- a/cache.h
+++ b/cache.h
@@ -1268,15 +1268,10 @@ int read_loose_object(const char *path,
 		      void **contents);
 
 /*
- * Return true iff we have an object named sha1, whether local or in
- * an alternate object database, and whether packed or loose.  This
- * function does not respect replace references.
- *
- * If the QUICK flag is set, do not re-check the pack directory
- * when we cannot find the object (this means we may give a false
- * negative answer if another process is simultaneously repacking).
+ * Convenience for sha1_object_info_extended() with a NULL struct
+ * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
+ * nonzero flags to also set other flags.
  */
-#define HAS_SHA1_QUICK 0x1
 extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
 static inline int has_sha1_file(const unsigned char *sha1)
 {
diff --git a/sha1_file.c b/sha1_file.c
index bf6b64ec8..778f01d92 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3494,18 +3494,10 @@ int has_sha1_pack(const unsigned char *sha1)
 
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
-	struct pack_entry e;
-
 	if (!startup_info->have_repository)
 		return 0;
-	if (find_pack_entry(sha1, &e))
-		return 1;
-	if (has_loose_object(sha1))
-		return 1;
-	if (flags & HAS_SHA1_QUICK)
-		return 0;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e);
+	return sha1_object_info_extended(sha1, NULL,
+					 flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
 int has_object_file(const struct object_id *oid)
-- 
2.13.1.611.g7e3b11ae1-goog

