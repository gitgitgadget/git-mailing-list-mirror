Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68100C43381
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3554C65020
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCFLFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhCFLE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7EC06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u14so5254947wri.3
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjAr5xoHe0RxFe2dp39RSPWuxthcirzgVV/+qNt9XgE=;
        b=aIrL69aP7clu5MCfKAiniaDoMVBbzVuqTnhbzHC0BRLTOzQukRd9wzV3SGnPBIbkE9
         1iSRtQMKHx0wmVJ980GDTWvonFswDNfyYioV1YLyv0l8uLZrV8ghGvE8YVu3eTSLYNec
         HTfZa6Zj+zF4M4rnG9gf1bpGF24X9puzLMNrbgexGrTr1f3j7BcBOlN2DMvAfY6osBOb
         amOwrdjfsyGnO9MjcmXGfzVSGium5TZHDcmptLaHNogE+VCUkiOyRZTtetJn1rIejPMk
         Fbz1M8pS7mUEckj8ycE4NcgPMlNCNSR0TOafDo1gSjLRms0r+SMiasw8zOM0cTIXBxm3
         hnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjAr5xoHe0RxFe2dp39RSPWuxthcirzgVV/+qNt9XgE=;
        b=sv/WRsl7TG8DHGEW6ErA3Z30LyevzzqN8FxZwcTgazxdDJ0lfMgp1qgCTlXC4AX0Tv
         SXZomLViAkBjg2/xcjL/1hhZuz3GzAms+A+oB6y1Imv2XRH4Rg+b8jHMPrF9E3uCD+kE
         CvpscjISjeo1mK5AL0gzgFCrOWl/ZNyLFFic2TdJD6iNcgIUwVTrvCRfOo3bY/DI++K1
         QiJlMCtUQ4RiNxiPgROcT/aV4rOQ1XHU5uQNC/EO3XuQN/mWWMCA/0O6GJzxf+S4XGuJ
         ZFDx/yvPOu4fn6N9wukqQM+6qdFrJ1YNshjSbKgCoIXVrnsGHFsHnU3kgAPpzX6oNxx8
         aJzA==
X-Gm-Message-State: AOAM533/jXnvu2Kn8ET1wJLRgWIH1Oq2yZ2SLCTKleR1pS//faTTmKND
        j3iwPe21RqLZJ905N0NCeAMmTo8Vsm+MoA==
X-Google-Smtp-Source: ABdhPJzh+uY6le4/ZoGdGIRGBim6uRLDjNwzWVCIt/kJdDKQ1DvF7Hqtl06p90OYTtdkXFj4ZmqH7A==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr13463654wrw.323.1615028696520;
        Sat, 06 Mar 2021 03:04:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/22] fsck.h: use "enum object_type" instead of "int"
Date:   Sat,  6 Mar 2021 12:04:23 +0100
Message-Id: <20210306110439.27694-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
index bad57488079..69f24fe9f76 100644
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
index 5e488cef6b3..f67edd8f1f9 100644
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
2.31.0.rc0.126.g04f22c5b82

