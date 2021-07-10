Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0EDC11F68
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08896613BE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhGJNka (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhGJNkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307AC0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f9so10817819wrq.11
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVPni73gs4971ioW1BEa0MP28Oob9sM+2za5h3/p1t4=;
        b=qxaBLB1hNdxGYMf2h3ASnCqxXiMCV70PMnRqhgyU0wtP4Rpc2HlHuc+2REAqwvPQG8
         jM4AEjhscsPw6c5XxjdE1nYIN9At2Jasl9lQDX+rGgiYtAKvKTwwz69KegroS1e7k+9O
         j53NZ+D4cfMtBTu2Wqczuu5RxIkJYi7lVROwudfVbAJfmOzakh3D3y8NzCbOOhe8FEQ+
         C6j/iqdy5xDw/ODXJXKIvO2i090xJcTL9Wc9gZMp29NufZB9eh0C5uAhhzBZ2K/42jE7
         SER7W486KrM/ViCmM6AwQA+KLHxUy5Oh9oFz+1kPZHMznh/zDvWAOasBbzLmViVIq2Sc
         yIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVPni73gs4971ioW1BEa0MP28Oob9sM+2za5h3/p1t4=;
        b=Uc7bA0gLaYq5RnZYOFtSZtt6FsiART8AIN2SL5WvK4YarxQTDbF7S284dko22k0WQ6
         YlxgfMf7+EQ13KUulyvfKo1Vi4bj1zepUOUvD8d1rL5/m63x0fXT/NdeI4kC2uIfHxaz
         Bg/upfm3JlLmIcy433Gx2+yVlXgf7tqrCiN5xFk4A+9lYErEEy27Kwz/rN2koQVQfuNz
         Voqcgqws8+SOW/uo4ydvXkGcYGVCFJcVSub+2CMe3PaH2SPpMz2smd2Ie7EKAd2SRE/+
         fBofU/5HsbBPBX5PBR1N9yv+RQ46Z7VaCHF/IV5qJijhFrmQsOIjsxUCEEve7137UCpX
         JkLA==
X-Gm-Message-State: AOAM531ahwwLfVWgwh9n6GBc2KLeuqElxyBxnryiqviFtpTt7HO9Ncas
        ryDSFjCADJvSIwGy4Nbim7pBJ3niJ0x6rg==
X-Google-Smtp-Source: ABdhPJwDPMO6p+h8JkxvjASwMCYBedJu+DeyK9IV4IwmfYZkpf9etieTVBS9eN8XZt78j5kdgVORzA==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr29183801wrn.304.1625924256221;
        Sat, 10 Jul 2021 06:37:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/21] cache.h: move object functions to object-store.h
Date:   Sat, 10 Jul 2021 15:37:11 +0200
Message-Id: <patch-08.21-387d7f08e61-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
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
2.32.0.636.g43e71d69cff

