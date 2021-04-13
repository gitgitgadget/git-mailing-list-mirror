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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C8C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9C6613B2
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhDMJnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhDMJno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:43:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB13C061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so7762668wmg.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewfw7xgFeTprJpEi3XxG/lNB14q3UnJEaQMQEG4/dY4=;
        b=hiMdMXEvqeOXeVitnRl6umWKWxO1zYQRobVGP01CymkY1DyXY+18/T0l5Cuspt3Yf4
         ei75a2W2dQRfHN4e2cTdYkp3jEYkq5nRtcKBJnQD9zPwaeGL2UUk4JQrNqay1N6foym4
         7cVcbtA3WvZL6El8SnUPqyatsw1tGYayt4CqW619n6NIzTstK1CHXj+1jB1/fYww22iT
         itq4xpLhoz24YFZB9rNpMgCr1Q2XOjf96AeZ/CYD/RGdRQpVztCxZSgUD1TwWw0TqBZR
         9NEbCYIGSzDhSB6hwtNdbyEc92PE76nUDfv61C4DSsbSJre2vrpjLB+NmoDy306T99yy
         d0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewfw7xgFeTprJpEi3XxG/lNB14q3UnJEaQMQEG4/dY4=;
        b=c8qSLycTCZ/qiLmfXKxN8x+zGpUUXGTmWWfb6OrzYsX1QquETrd4zzQr217qLylCJ9
         oUQH5Y6goxO8Cx9Z0QhJGiq6COqo6uiU+AuOThbDo/Ui9VGHAKrpLhrpvuraruQybx5x
         Ex6C89uCQH8xFnGxnFK/mAvCuwFmazM3zp6tLE3LMv5TXPRc0e99/8SbOuUlISXMmffI
         9S/M5pg9eMrhe20+H+AWyeNjzKiMx1xbzxwEyH+9/0DepbZADf3B5q6Ff4vctB3Q+QpZ
         XPOIrxreCKNyhiHuB5BKxJQiurNvbUtDDsxF1tL3Tg6IIRa45ViJpx00H+IzGTmIaP/w
         jLEQ==
X-Gm-Message-State: AOAM5301M01uSUXulT8wVgrQ+z22oUH+DXb5MLyIq8bo849e/QTgvQJE
        EWDzhX/hAmtLRoTUnff5Fo7IZ5eEJuxjDg==
X-Google-Smtp-Source: ABdhPJw9uQUyRQ8fz7lXU/+kz/+7Aoyu9RpmCbW3ZbDJWeRu7SR6nfu4A4JpgQSSeMTghTONF3ZK1w==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr3229749wml.103.1618307002202;
        Tue, 13 Apr 2021 02:43:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p14sm4622877wrn.49.2021.04.13.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:43:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] cache.h: move object functions to object-store.h
Date:   Tue, 13 Apr 2021 11:43:04 +0200
Message-Id: <patch-1.6-37c323a2410-20210413T093734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
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
index 148d9ab5f18..f2e7fc615ba 100644
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
2.31.1.645.g989d83ea6a6

