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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA0C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37DD61261
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhETM1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhETM0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF54C0AF7B9
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id et19so17610360ejc.4
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hx9NPV3qPtLVtey0KbAPnexlattqMqA/wEJ0v5UGEs=;
        b=jYy9DnHODH+4SQf+ePzMYaAWvTJ9wK6HS31ZudwIz2lLzF3qODEYySg4kltKiBH9RN
         2Wjj3q3xsBHEiQvVRtxeN0s/iDbQF1vyugEl55AwFBMHQ/Rq89Gri2vOI0Jy4GEvJMqg
         PaJ3oEhrJFYyh8I85kHH953K3SLh9Dx27x5gYYJuyOvn39Ute/HOdd0E79iwcXAH0Jex
         CUTtWxpGOi8RYFkocmCl+U8vgrbmq7RPhzDpLmdeOC5lOXKuyvAGhXpi2J15cZ/wWrlC
         QWNJTUWKNhgSNXi4r3GUHNxUK6kDg6sLvY1psiJxw6yhd8sNT+na97L32jv/nPnGzbur
         d91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hx9NPV3qPtLVtey0KbAPnexlattqMqA/wEJ0v5UGEs=;
        b=DF+TVdOvNVIHqko3W1tfRPWYEsGwQlCPgLlX3936a512ECuG49WDNZ3BO3iQlC2R2c
         oe7wssq3veF+Jgnrsc7rs8JNmUjYJt9sVp720diwyjxspiWj0ogfMwAw/L3Ydag7zlTf
         E+C3tmSj1krDI6KtYEX6mdLRrAbI8HM/5YJvyh9K1d/firDMpJxeEA+8Hb+L2/lsX6Io
         qP8SZ23Ctd/GjEaFKOsDo9qNPpPGrUH0jXiypRjS0o0gHzUVBfxus7PCzS1jGsh3J0Zh
         G2lDZ+1QEsWLiH0dvWet2pskDPMdCos6dsxkK2pnvGDyQpBmWNyxnG6L/Ht9ghDY44Je
         +aPA==
X-Gm-Message-State: AOAM5331B82MCe5GbZXcAbywRcHR0XgnCZ1a+L7fgxB3rzCeVl+ujMGy
        M5mlv0it4wggOXtaJ1M7qXf88BtOjYyVOg==
X-Google-Smtp-Source: ABdhPJwCCm+K33yfujZ9ENFu2pY3dLisUufMolocJYKW00m6JwPhB1ROJJluJOR2jTa3V3kyqjU9+Q==
X-Received: by 2002:a17:906:5d0c:: with SMTP id g12mr4125329ejt.447.1621509801435;
        Thu, 20 May 2021 04:23:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/17] cache.h: move object functions to object-store.h
Date:   Thu, 20 May 2021 13:23:02 +0200
Message-Id: <patch-08.17-12dd453879-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
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
index ba04ff8bd3..32ea1ea047 100644
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
index ec32c23dcb..9117115a50 100644
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
2.32.0.rc0.406.g73369325f8d

