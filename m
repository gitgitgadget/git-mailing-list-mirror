Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37EB20D0C
	for <e@80x24.org>; Thu, 22 Jun 2017 00:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdFVAks (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:40:48 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33851 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFVAkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:47 -0400
Received: by mail-pg0-f46.google.com with SMTP id e187so806224pgc.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lVhpogfqK/YKOgU6jUBaS78q7K4vozS18Hz93oeS6sM=;
        b=jH4jyCuE0je2dwQabW1pMOAbYRu8e2ZKSxNctVhdt7wuj9NxpDPyp1xSW0qIEMG8Eu
         m9Iw5llmTyaQHsUQAsbqmUOuUu5j6FlRCueF22yms29hGxA69JsCNQ9xk517bsct9i6v
         NkdL+WjJOqc+b5qQNVSOu/HRsXy9ujjoqi9dJk11cPO591ajch509Sga7Q58REsVi2st
         06/pOICWIErzEUZOpX1lemul+diSnjwRDUAFK/HNBPFiKJy7ehWuGowUr6mGxkK6fOyO
         z8iqge8P0bzOXs8rrIjuloKtPvMmtBb2nmtzLOOsO529rsL3cDTlIS00SsflcOPD2QjJ
         KkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lVhpogfqK/YKOgU6jUBaS78q7K4vozS18Hz93oeS6sM=;
        b=GH32B3EuBov/GgO4YPFZt7/tb7ntrLRDx3bxm3a8EJXwd8KT9rg+wR1Orw39VKhj32
         qAg9TQPQfMp8BFB30guokUJ7dRywZoTpet+ZeywIWmIQ1yjYSIJqoHHvdND3adwRA2mS
         mmy6OjcdgAJ+MdfAWAhPGW8uP/Muz8bd3gYlPOb/kwX/kunxsylik2B3TcWwiDv811IG
         IvEP7AVmx9YBxPAAcVunanoXZf3z59bbgOnssuN87Vsq2wMdZ1uqxVj1B6u5qBhV0on+
         dYODBCAuMRqQmR6xzNYuLJgYZc8gPy8m+Q6MT8ZT54yopH+ukftxKKb3wDYr4PbTo9Kc
         sahA==
X-Gm-Message-State: AKS2vOyDJoIaaI8xtABQCvM3seLkRr/nQNrWQnVkWfs5djejEt1Z0dZK
        VEx6RqkghjuEDnhGa1xnFg==
X-Received: by 10.98.75.79 with SMTP id y76mr38578389pfa.39.1498092040591;
        Wed, 21 Jun 2017 17:40:40 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:39 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 6/8] sha1_file: improve sha1_object_info_extended
Date:   Wed, 21 Jun 2017 17:40:22 -0700
Message-Id: <a736148af2689676cb5a7e64a35bcbc9ad060fd5.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1498091579.git.jonathantanmy@google.com>
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1498091579.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve sha1_object_info_extended() by supporting additional flags. This
allows has_sha1_file_with_flags() to be modified to use
sha1_object_info_extended() in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  4 ++++
 sha1_file.c | 43 ++++++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 48aea923b..7cf2ca466 100644
--- a/cache.h
+++ b/cache.h
@@ -1863,6 +1863,10 @@ struct object_info {
 #define OBJECT_INFO_LOOKUP_REPLACE 1
 /* Allow reading from a loose object file of unknown/bogus type */
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not check cached storage */
+#define OBJECT_INFO_SKIP_CACHED 4
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
diff --git a/sha1_file.c b/sha1_file.c
index 615a27dac..b6bc02f09 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2977,29 +2977,30 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
-	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
 
-	co = find_cached_object(real);
-	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_sha1)
-			hashclr(oi->delta_base_sha1);
-		if (oi->typename)
-			strbuf_addstr(oi->typename, typename(co->type));
-		if (oi->contentp)
-			*oi->contentp = xmemdupz(co->buf, co->size);
-		oi->whence = OI_CACHED;
-		return 0;
+	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
+		struct cached_object *co = find_cached_object(real);
+		if (co) {
+			if (oi->typep)
+				*(oi->typep) = co->type;
+			if (oi->sizep)
+				*(oi->sizep) = co->size;
+			if (oi->disk_sizep)
+				*(oi->disk_sizep) = 0;
+			if (oi->delta_base_sha1)
+				hashclr(oi->delta_base_sha1);
+			if (oi->typename)
+				strbuf_addstr(oi->typename, typename(co->type));
+			if (oi->contentp)
+				*oi->contentp = xmemdupz(co->buf, co->size);
+			oi->whence = OI_CACHED;
+			return 0;
+		}
 	}
 
 	if (!find_pack_entry(real, &e)) {
@@ -3010,9 +3011,13 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 
 		/* Not a loose object; someone else may have just packed it. */
-		reprepare_packed_git();
-		if (!find_pack_entry(real, &e))
+		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
+		} else {
+			reprepare_packed_git();
+			if (!find_pack_entry(real, &e))
+				return -1;
+		}
 	}
 
 	rtype = packed_object_info(e.p, e.offset, oi);
-- 
2.13.1.611.g7e3b11ae1-goog

