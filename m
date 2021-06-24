Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D9DC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79AC610C7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhFXT0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhFXT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4CC061768
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b3so7889552wrm.6
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrmBPbkT1k+hjFDR36da0Ug0ifTyK8RXSZRs6rIwWjw=;
        b=g0boceQTF4hm2fCDoGi+G32RNdrlI68hDXQZRWj3A7xfuzoDaswwI5oQz8QoJ5XACz
         tDRypQMvHLiDr9lzZwol4cc61yF2vwcyLihhTu6+YUTkWJIeSSwwbQ6CAriUN2B2po7e
         HLFSb7HzBZ3H8Z4xWve0Z2XbySLXj4pQMavyDrPhi4umfUnzWe0/Yp0FuF430wVcSqER
         DNYwTxYUolv5H+YtYaAZZhDnVVdoHlZglNpWMThvc4OAQCBu4o+SUMeG8UYJhRJ4o8/T
         oTxvmag+0dWkZnkWhotwRQGuQkgs3X9kCRVtdF8S2NM0w3CYflJmnWcIRKV0ufYoQ+f2
         /62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrmBPbkT1k+hjFDR36da0Ug0ifTyK8RXSZRs6rIwWjw=;
        b=WP7Ch5xznK6VK91A1yDk8RCiTmre7X7MCejy/5eji54987IahYM85UuNSdJZZFhbWx
         8Q5lI4twvJG5H8DV5iPVAsNYnwj9IQMGlzYXkyC3BjMB2szkKxFFOQpHe06wqiuGSTiV
         s3WS0yI5jjfXrOfthikd/3zbG3NnAUZeVyEGzfnIFVHZZYMugv0GCGEDL2F07LTY/+Cl
         5YlW1kcuDEiCJGknEjvYTuQEPTNeiqnCh2qap1mDVaIpO5OrfRq54y1c3xqwR6ZwKaxn
         cDaXXCIDrfVZsGo3PnRf35H4iTz4rTszjXM41+aOrtOD7L7CPMRSeUZCrRM+ag6QWMvK
         Vv6Q==
X-Gm-Message-State: AOAM530/1JUP3uaixVEdjFrAQNHoLH6w0IqWyUOf3G77mpJfCC4otGUd
        sTeD7uwoRKFHbraeqc/xCFYL9PD84ZgbdQ==
X-Google-Smtp-Source: ABdhPJwfBNZB3voeqmt3BgyrnD1UDdV/HQQWVMW6KC921J8qk6LV/FbrEoqLVMySA1jdKI7P59DsvA==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr6348318wru.73.1624562651047;
        Thu, 24 Jun 2021 12:24:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/21] cache.h: move object functions to object-store.h
Date:   Thu, 24 Jun 2021 21:23:46 +0200
Message-Id: <patch-08.21-96310a0bb59-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of some ancient object functions added in
e.g. c4483576b8d (Add "unpack_sha1_header()" helper function,
2005-06-01) from cache.h to object-store.h. This continues work
started in cbd53a2193d (object-store: move object access functions to
object-store.h, 2018-05-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h        | 10 ----------
 object-store.h |  9 +++++++++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index ba04ff8bd36..32ea1ea0474 100644
--- a/cache.h
+++ b/cache.h
@@ -1302,16 +1302,6 @@ char *xdg_cache_home(const char *filename);
 
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-int parse_loose_header(const char *hdr, unsigned long *sizep);
-
-int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type);
-
-int finalize_object_file(const char *tmpfile, const char *filename);
-
-/* Helper to check and "touch" a file */
-int check_and_freshen_file(const char *fn, int freshen);
 
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
diff --git a/object-store.h b/object-store.h
index ec32c23dcb5..9117115a50c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -477,4 +477,13 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+int unpack_loose_header(git_zstream *stream, unsigned char *map,
+			unsigned long mapsize, void *buffer,
+			unsigned long bufsiz);
+int parse_loose_header(const char *hdr, unsigned long *sizep);
+int check_object_signature(struct repository *r, const struct object_id *oid,
+			   void *buf, unsigned long size, const char *type);
+int finalize_object_file(const char *tmpfile, const char *filename);
+int check_and_freshen_file(const char *fn, int freshen);
+
 #endif /* OBJECT_STORE_H */
-- 
2.32.0.606.g2e440ee2c94

