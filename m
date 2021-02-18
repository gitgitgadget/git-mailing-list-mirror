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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C6C4332B
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CBB64EB7
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhBRMeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhBRLIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:08:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046BC061788
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u14so2455217wri.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsJst1qMD7GeBxyJRsPiwKmtvLvpeXj+NznIUApS+u0=;
        b=B7wgZBBm96TmORdL85bQgkk5pSFp5ccVt8MwBbBgG9YDpc4JAs5JpqeFiMSmy411y6
         UlRd7c8SVgheEhh62MkUAaGdq9aHz0XidhCJAp+pVmJvPg5NgiErySE1YH8oBAXefSZy
         41tW4p1Y14fQVq6dYDpdPC2purTs83jyiQE3u9KwfSC1cavxK9waoeQvnGS4J1D8G4vC
         c2+xyvcecXNp1QmytMdLnReT7nqviMMZQsMPxxTmTonhDP+ctHjLR1APmBRyqz9wrbE9
         LvEWWimpXJxqb+XNf2k9fEX20/uqtmmMyAvg4Sy9iEWxec52XHhL9oMURCXDjrfirU4N
         HWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsJst1qMD7GeBxyJRsPiwKmtvLvpeXj+NznIUApS+u0=;
        b=AmUznZ6958Ll41H6OG9tC+e8qojm6XUetu0sSbMqULKOF5C1fdSD1R03nnYPZX7Vyo
         XIcKOYaEizdGQkPfPBE0kMnoJ8YOkvmr0l5kGVT1R/an/bjSM8a6c2aN0S/qLAJB0wMB
         s1S1Hv3e1FlfGHBppPrBHNoqZB2YZDNW64ZqLMH0e+vGQGWYPaHmu3S142nN2pYFmR1W
         GRpLHjjF+JfkAS8C1v9zZN7rrbAHjizM+SW7XAaWAdRlZ4tVDT3/IsMFXgXtgtYIINFf
         0wzL0uAJt8f07fcRQsvixCFpiSqaw0+dOrGoVBY60+M0VnuNiiki1o1KKkL9Klc3VW7D
         iJHQ==
X-Gm-Message-State: AOAM5335zkhYXxaQHS15oL2Q/9hM5KOE6bIDdIjbSoH2BYGCTLKWpyRi
        BOp/EZ3lTlD53kmLbjqlC0C8rxihmfi3rg==
X-Google-Smtp-Source: ABdhPJyXxdIA/bPDgqOYCEWPpC9yYfKKexF0zoOhDkAOKbfslHkVHLBlu2Dye1RG+qDoeK9Q9nVmFQ==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr3729102wrs.215.1613645924471;
        Thu, 18 Feb 2021 02:58:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] fsck.h: use "enum object_type" instead of "int"
Date:   Thu, 18 Feb 2021 11:58:32 +0100
Message-Id: <20210218105840.11989-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
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

