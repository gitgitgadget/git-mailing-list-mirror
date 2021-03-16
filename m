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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE2C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0058765105
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhCPQSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhCPQSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427BFC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so10789838wrt.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBCmIkWtBmNrWWPR0WtxQafc5Roe9t3epbPWHb3M448=;
        b=QMnlwdXpqLTxesGdLCIm3i4SVt18kgrGg/nU3xuKvJAxTO0NDD4k7N9FLUVJ88v2vS
         1LjOpjORfNkGSTai5jXIksAvLj7XuE73VD6K4d/aiRCVrVmXXTZr7DiD48d+RtHjLLqz
         Y77BGpZ1NG2a2s0Knv7lqQw7AoQRLwMo7nnnj46TA5TerM7tA4u7lWPhOP+mSwchddqD
         +lHT+YWyozfDX++Fk5eSbo/KyRtEvXfxKgmKwDifnL0GA0B+NIr72QnhN9oaa7StVVyk
         QWi3gbSBauEiVQFv+UdGcmT38qglSGhDrUSRb9tKdOHeXVMncwQasNTE4w3ujzJYcUs+
         /WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBCmIkWtBmNrWWPR0WtxQafc5Roe9t3epbPWHb3M448=;
        b=Y9hBxi4pmwmbLTX+rQyNdr2TDDynFQlq6Y4yTIW3B/2HkFAvHaNMgPOpLl64Y7rrA2
         jPsaiVjIjXyECvFGwkJq8+e7qQjODaJq7ZxupTuHnAfUGN95FAeJmF8itoOHI2hQBsvv
         dP7Ktu6nfJroSJTkZhO3vfCZh/uiRSUGQrwBcxPDwp5oYMZnJOzxIgNtlparO9cJuqhl
         YnXqCQ63Yv/uF5Tnq1KEyq5/D0TKV69Dczuuw5V9lZ1qD1D/0CahTyHbYj1bZcKyiwTb
         mgCn3ZEAgg+bJuoNHK14uZFmaB0G2dIoH5f2JwFBS6XnoQ5X3gixAxY7FLHxcFlaW8Ua
         9dBA==
X-Gm-Message-State: AOAM531DYVMFDPOb04cXeYH42rLf/1irS/zyZ4x2W31FtEd/QTVaxp1c
        4QVpA66J8msIb5n+GTHerSOs5SQ1j+s/lQ==
X-Google-Smtp-Source: ABdhPJzAO+kJtzcwQDBFcMOQvdte1bC60Ober8rSVB+Vs8/xsKWaiNVe3PZZ+Fd2bqQqTch0zjZSzA==
X-Received: by 2002:adf:ee8f:: with SMTP id b15mr5686613wro.314.1615911478716;
        Tue, 16 Mar 2021 09:17:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/22] fsck.h: use "enum object_type" instead of "int"
Date:   Tue, 16 Mar 2021 17:17:22 +0100
Message-Id: <20210316161738.30254-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index 821e7798c7..68f0329e69 100644
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
index 5e488cef6b..f67edd8f1f 100644
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

