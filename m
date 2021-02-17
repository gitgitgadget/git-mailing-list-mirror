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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2353AC433E9
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F061964E45
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhBQToC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhBQTnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792EFC0613D6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:07 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i23so18087088ejg.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsJst1qMD7GeBxyJRsPiwKmtvLvpeXj+NznIUApS+u0=;
        b=gccIPJ3w0rMUZCFKajLqDl8HERKQUfxXXIJsjg0A0tXQ7H1Nu7yud+u65AKPUrh5C3
         1aF0vheDfHppEi+gqxPquATicCdhZWVUtDdBfSM/x44QzlHeS18QLgTeRhRYWU89w0e7
         QaOmJshiXZ5GkYbaXhjBf1rpbFHh1ZqZmhQRGpADJS3nDA6nz8McgBAfuNJ773pTBjAL
         6OOQ6OfgfUGICtGwnBe1PxBV4tgmCqDWxYUY0VXD1kEcgc6Vi2n+l0sCsh1uxizXpi1u
         gxPNGOPRsozDOu3RYCzlTFRKDN0at0I8OPVRWWN/LaT5mLH/o7LUDnt37XDeDzrYbkiX
         vHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsJst1qMD7GeBxyJRsPiwKmtvLvpeXj+NznIUApS+u0=;
        b=NGr934ytF8vrKcyVgxTbm56AyZOZ11vrfmEbU76I6dMvfC33CUK2wInpKRfPPfGdYV
         XX+RTQxksiDMDOzI8dKsRbjicVtDnKbvV0urQIBQ4XZ7dzPvwsTXpCfQMqPZqml06R77
         p4mCZSWGnJ69pBOMLhmLY+iHeWOl/slAUFXGDa6AKaZpPnRdIT03PUKZ8q9FabfnWOf6
         eO0s5U5caOhbJQPJ2cFuq8uJJ5tdJYT1CFfz1CgBYNN+HaRsUriOR0JFSSYntKQDQI5w
         ZQbtBSbIZsJRGXM89kVLnqcNB6RGzb6qigB4NC/MN/2fcOlNYqvNSx+Cx25X8gMQP4h4
         nDQg==
X-Gm-Message-State: AOAM530vqEUp1YhfU7EoYI1bQTo5tiq/PqL8+7KRxZvQnzWi3X/ydXDK
        rm5dx+zlJcYIfpcbKOPoPuP+bco2oQAFDg==
X-Google-Smtp-Source: ABdhPJy8kvFQTPmat94+YNoK6tpw+cakQhLdTpUiRcxvrdQlX0XwbOJ3AD/7iAmv4OINAtFZgDBtDg==
X-Received: by 2002:a17:906:2652:: with SMTP id i18mr510513ejc.213.1613590984840;
        Wed, 17 Feb 2021 11:43:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/14] fsck.h: use use "enum object_type" instead of "int"
Date:   Wed, 17 Feb 2021 20:42:34 +0100
Message-Id: <20210217194246.25342-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the fsck_walk_func to use an "enum object_type" instead of an
"int" type. The types are compatible, and ever since this was added in
355885d5315 (add generic, type aware object chain walker, 2008-02-25)
we've used entries from object_type (OBJ_BLOB etc.).

So this doesn't really change anything as far as the generated code is
concerned, it just gives the compiler more information and makes this
easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c           | 3 ++-
 builtin/index-pack.c     | 3 ++-
 builtin/unpack-objects.c | 3 ++-
 fsck.h                   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 821e7798c70..68f0329e69e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -197,7 +197,8 @@ static int traverse_reachable(void)
 	return !!result;
 }
 
-static int mark_used(struct object *obj, int type, void *data, struct fsck_options *options)
+static int mark_used(struct object *obj, enum object_type object_type,
+		     void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return 1;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 54f74c48741..2f291a14d4a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -212,7 +212,8 @@ static void cleanup_thread(void)
 	free(thread_data);
 }
 
-static int mark_link(struct object *obj, int type, void *data, struct fsck_options *options)
+static int mark_link(struct object *obj, enum object_type type,
+		     void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dd4a75e030d..ca54fd16688 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -187,7 +187,8 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
  * that have reachability requirements and calls this function.
  * Verify its reachability and validity recursively and write it out.
  */
-static int check_object(struct object *obj, int type, void *data, struct fsck_options *options)
+static int check_object(struct object *obj, enum object_type type,
+			void *data, struct fsck_options *options)
 {
 	struct obj_buffer *obj_buf;
 
diff --git a/fsck.h b/fsck.h
index df0b64a2163..0c75789d219 100644
--- a/fsck.h
+++ b/fsck.h
@@ -23,7 +23,8 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
  *     <0	error signaled and abort
  *     >0	error signaled and do not abort
  */
-typedef int (*fsck_walk_func)(struct object *obj, int type, void *data, struct fsck_options *options);
+typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
+			      void *data, struct fsck_options *options);
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct fsck_options *o,
-- 
2.30.0.284.gd98b1dd5eaa7

