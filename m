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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505CC433E4
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5416196D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhC1NQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhC1NP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:15:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780AC0613B3
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d191so5242088wmd.2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXj6Ek9ALNXQS4Hl3+wqsvdtt64DFll1XZfoMMXbJnw=;
        b=jKTQc69SU6JaI7bTS0Jt+IjEEqv7L1NEe3QO/L6pCSl+Hulj5Ev2aK08G2MFqYxPww
         Tmo5eKn8Vz5Ct90w7H/85o+dyAtEDb1q4n3WJ1MfNMnspARa1vvD4pymP0rB9JqmpFSl
         6CoFzKyF4sR9aq5oSDwQhU5wBxH8CFZng4whiGpweqHPH2Wowp7PrZnnpp+ULZ8/EY3N
         yUa81q8UCnWj/HFWWtElzlTTPsenGwe6/5N1CAFPNnIpQFmzcjtKvkahH58dQqFScfDa
         eF+X+XWoD2T6bHfiyDmSy339WGln5Qh3NszG5eRGFYr7M3JLVbJWIrH43xClADc47KRg
         dIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXj6Ek9ALNXQS4Hl3+wqsvdtt64DFll1XZfoMMXbJnw=;
        b=ne34K/AeDx8THVMcKFKAVVVddHuJPcOjGuKqYIiLXW3N67G11dDFDmrjXxgqRwcq4/
         IgON+0YhGZwInwzoY01CNrSISybh7OWP3ERRe+s7DSRk0KJXWI8kuJdZcMfkI+NULMaC
         g11hHotzZQ0jhKgP1aFvStZF+aPdVdv8muCL9NeR/trkcZgLUsq98jehUsbqH2WAQBt3
         A/+JgeaRgJy8WbhjpFMSKZW79h4b12CZpDC8WKSMS1zGbv7usGy9sbb4mAj5FJ0cBfSY
         AMKC5upfUjeIlR2QOQUxhzux8SaOAwFgEQGAFfXAJDVIB5EeMQPUWZuW2Bjg+y+kZqaB
         eJ/g==
X-Gm-Message-State: AOAM531uNVrreUpS6tn15fZaGGhOR3jXXdsTPP7a4NscYTuhSFHs91PR
        qUXcSg6JODkcjvO+jANESlqzjTCRH7SDCg==
X-Google-Smtp-Source: ABdhPJzw4oDu24BCeiuQvmgM6gMbzeF+bNKNCKQpGuVOhui3Y7H37AoHVo/G4xTUqPx/l2Bmn8Kehw==
X-Received: by 2002:a1c:60c2:: with SMTP id u185mr20583884wmb.157.1616937356541;
        Sun, 28 Mar 2021 06:15:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/19] fsck.h: use "enum object_type" instead of "int"
Date:   Sun, 28 Mar 2021 15:15:35 +0200
Message-Id: <patch-03.20-a721c396c50-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index a56a2d0513a..ed5f2af6b5c 100644
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
index 21899687e2c..f6e1178df90 100644
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
index a4ba2ebac69..4a70b17f8fb 100644
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
index 73e8b9f3e4e..f20f1259e84 100644
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
2.31.1.445.g087790d4945

