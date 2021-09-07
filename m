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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8353C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09D5610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbhIGK7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbhIGK7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310DC0617AF
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m9so13797774wrb.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b50x62CCPDWTvLOp8Jd/k0/8MoLuR0GKk/efBGc78v0=;
        b=AlBrzbb5n4DDNUQq1wzlVDH/MhheV7dhrdqKobx+7pxat64SLf4OizpH4DPJIPKaYd
         FJRVKR0dNfurZ5m0KOvBgYBjsxqyRnzmjc9RLAoyOuwpbgWog4vpt5mwz8/NCBuY7EJN
         NTcKiR4EnYLmzCS9gYdqWZ+MSi54YwtaZwOR3eyCJ2s7pfYIMvswwfeNBlSJ7/0dpss/
         xH4C6rxKQlOXaymmaiqdo/Xxh8+iYujexcBfn/xYpP9nFv0va25o95TI1ivE7i66ywZP
         l3VhxYywTrrmYVHwMK97AU2mHHwMCskw1WHgboeUBjzXAgvQ9tZgiOUaYIIb7ojkzGW/
         fxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b50x62CCPDWTvLOp8Jd/k0/8MoLuR0GKk/efBGc78v0=;
        b=aOBLxvrxav5EdwXqA4fCdjjdzKBIJhd2Lh7Vjoexmh6sh1aFgYT/JVtMRJX7vu58S5
         Tn96EXzJdMTpyIXY29pFwauatoP14N6fP1abQMZjcRdE2VatNy/k60Ib651jKXR6IFca
         X5oBjR0WlsA2FT3wO8Ps3/iXMb9JpuyjNMV4Gp2OU2HlzwLjGLsgFRMAD8ZcnjwaO7U9
         5MT6kcxitV2EOB6ETJPFyxsIie2ds6avtRX7a6OgF45If8R5JblFUhdwv2Jf5fQj42+k
         4vWq9wKKYKg+NzPqBx+mu0A5VdPsxCgWpEMQYksx0A0MqQiuRgdXnp4S6LIkp4LeT9rZ
         ixbQ==
X-Gm-Message-State: AOAM533FBy0SuljTDDODNSB+8U1E8fG5zdqO2dKV+bKzxJ0LK66Qe8Ne
        N4/BPfqm0DgHpsIlbrjXsZM5O2kpFmOFtQ==
X-Google-Smtp-Source: ABdhPJyp3pT0EjvFT2w+zO1i+d3fKz6HVS/cZ2eoGqA+UBQ0dCcutO8FmCRnVKhF+PrKDtnd/kqyTQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr18277911wrp.94.1631012312314;
        Tue, 07 Sep 2021 03:58:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 09/22] cache.h: move object functions to object-store.h
Date:   Tue,  7 Sep 2021 12:58:04 +0200
Message-Id: <patch-v6-09.22-5b9278e7bb4-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
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
index d23de693680..11a04a93436 100644
--- a/cache.h
+++ b/cache.h
@@ -1313,16 +1313,6 @@ char *xdg_cache_home(const char *filename);
 
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
index d24915ced1b..eb4876ec983 100644
--- a/object-store.h
+++ b/object-store.h
@@ -485,4 +485,13 @@ int for_each_object_in_pack(struct packed_git *p,
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
2.33.0.815.g21c7aaf6073

