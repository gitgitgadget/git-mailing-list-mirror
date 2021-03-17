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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF717C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CF764F44
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhCQSV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhCQSVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE0DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j18so2833840wra.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tv9/sGpXcdz5uoZZQ+gyisCOmUir/Kc9Y7V/RQYVCJo=;
        b=MftI7qe76bayoNWVpfUhA2WyFZWkOhk3pG8fQk3eV+czV04raMorfBGujE7TdZVqcp
         FRDlvW9TKU5HEp7uTyGUFvCSPL1jSVlvO4puzXqayKAynTF7FyHsn7bvise4i6VtwGhA
         DiChUberCghq4OJ/grTyEOS/gPiW6lLPgL7q7gsHSMW6Uj57QSTL+W96MHoGf43N7uKA
         oc/HgcFNCdn7L2O1cJMIWoiRbB5ga46jUovwt10i0HfB6m2DyEorTzxlY5dJi+VB0FDb
         /lXRbOugpvqyctCGHF/iJfocKjLBHXa51R75ibjIc1K/HMTWPUZ0S+an+nxNRRwi85gx
         U8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tv9/sGpXcdz5uoZZQ+gyisCOmUir/Kc9Y7V/RQYVCJo=;
        b=Dm4QXl1vC3Cprwqqj7IjzLdTfFsU01Y1F32W4H7Wh413bpJsmM0DMvZrzZGtYkSUjs
         PkFx2X0kzk6O1iduT0XQBcX89ym3Ls6zrYKdmDmmBXVmoKYICQE4Za1VT2/XFKHWjho4
         WAWqLUqFO6qsoeXYiTbvSQaadefkogj0Gw3jUzokKolPHyxL9y+HJ9lGLxQdplq49Lu8
         xT+W7EO5fT7bfPUYnoN2QoTX37WXKj14+b74baIVVaPYCfeNKlE9stN+gq82RoP1L0+c
         iw/bxynvvz4hqIz3mZ6whdVNPcEfmkG87qoyix3c8dZSHBQmhkYwBDM5q8T6bMXPfzoU
         ZbsA==
X-Gm-Message-State: AOAM531N8ReZBjBnyjaEdZW0E/MNGKXWURHqRtgI4hFpFh3ttdrdoxNa
        2ihv9j3dPcKLsmEqtnMb6W828iOAQhhjUA==
X-Google-Smtp-Source: ABdhPJzioJ4lHFZ9I4rxx5JRfEySEgZgjL7pUkOs/byTG98Krj3wO1EHiv8aYvcABBj+KyWtcwG04g==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr5849218wrh.50.1616005272996;
        Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/19] fsck.h: use "enum object_type" instead of "int"
Date:   Wed, 17 Mar 2021 19:20:38 +0100
Message-Id: <20210317182054.5986-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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
index a56a2d0513..ed5f2af6b5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -192,7 +192,8 @@ static int traverse_reachable(void)
 	return !!result;
 }
 
-static int mark_used(struct object *obj, int type, void *data, struct fsck_options *options)
+static int mark_used(struct object *obj, enum object_type object_type,
+		     void *data, struct fsck_options *options)
 {
 	if (!obj)
 		return 1;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bad5748807..69f24fe9f7 100644
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
index dd4a75e030..ca54fd1668 100644
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
index 15e12f292f..e3edaff8e7 100644
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
2.31.0.260.g719c683c1d

