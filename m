Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1545FC433E2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BB961883
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhC1C6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhC1C6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:58:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A24C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x7so9361464wrw.10
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UaYfY9p5BnippUhLpsnJ1jPdc1VO8laE8BQGU81zLI=;
        b=bpcM7WPYc2UdhIpDCnCLC8xWKdApAn+w21pS/drVIYuL5w/WBxnniK+vXAjEVl9hjU
         yngDcxWl7wMGJXF9XPH59zo0ODacxh08Hf3WfEYuk+GV4cOWF1Nxq04NQ5QzwU0XJ+xI
         cP3KUz8nEQFMU2ye/AleewAvFYg6nu4uBj2jLDmSkzx8vBQF1uvyMSFHqZaDPOY5r4dj
         LnJiPYZ8zKK3hc3FJ1lFQY3GfngBuAuFz2GB342341BH48yYJhe3xlXGDzsRikn+XPiU
         qVuqb+4PooqNUVW60cWf674/No1mtWVTXtUOWAR4xhqI3fN4K0pWpO38ICH82Qv2sgUK
         aYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UaYfY9p5BnippUhLpsnJ1jPdc1VO8laE8BQGU81zLI=;
        b=Z+J7WRa5wT2xQ7wVWni8+W4pkmOQ0qh+raaErWPq4GsYUJKbEE71u+X62TzG42VvN3
         LymxN3ZfXelC6LSF0wLrgUkUoYuzd1qt83KxGqElwV63dTVZeCpEjv5nr8NLcaAc9FSG
         XzofUo0jjRMdVGUOGJ55FmJk60TJV/Q0hKSMornTtr4BVR913ACFirOuponBWjs8/J0r
         Moe0offDNodZ3PeXEp6pEIuh4jLrWa1LuSy83m98JXW6ru2mNNF+ee1BhdRof/ZLyRa8
         kUM56gAMwLYjhJ+XXHG34cSDv5A0KhXNYC2ej8V7bW6kdpvYmp/7vVpVtv2rvAaQK1yw
         +5qA==
X-Gm-Message-State: AOAM5326wezWwdbxBvSt5Zsc/m8fgimdNyTU+RjpOO5a6mncsb/SK/Nz
        v8uadgfpAHZO4n4bq3sRPlzHNGeIuWgLwQ==
X-Google-Smtp-Source: ABdhPJxXfrTviYoYYYZmESEXHp/DFRN6khv9JK8ObCGik3tZ9fPt/Accd/sJXfq0Yl3e9vglwp3lRQ==
X-Received: by 2002:adf:f908:: with SMTP id b8mr21094952wrr.184.1616900316915;
        Sat, 27 Mar 2021 19:58:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y1sm17629421wmq.29.2021.03.27.19.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:58:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] cache.h: move object functions to object-store.h
Date:   Sun, 28 Mar 2021 04:58:29 +0200
Message-Id: <patch-1.6-f8f00db8d31-20210328T025618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com> <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
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
index 6fda8091f11..0e387f84f67 100644
--- a/cache.h
+++ b/cache.h
@@ -1279,16 +1279,6 @@ char *xdg_cache_home(const char *filename);
 
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
2.31.1.445.g91d8e479b0a

