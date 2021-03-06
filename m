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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E0C43603
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071926501A
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCFLFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhCFLFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA7EC061760
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a25-20020a1cf0190000b029010b1cbe2dd0so825621wmb.2
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dvUDEQc4tvoHEDIvRQPo+YCQta4LMQC9BMR73SCEOB8=;
        b=Z9Nr0pHUkec8zIP/g0RbdUMRO6juNs4o4QLI242g/NJ7hbsOheUsY56WyRWwJGaxmz
         Yrgm5lcth4s4eDRhKN6v5rYafwgef4SfPq7/FN6H0ZncugrZNx3/h4V6KPcmSJHjlfXU
         lq0iklrXAwiRavf02gJjNtWwwiEMUrkCn5dRUNP3CDUjn8rEQrpICf0CjFfThubokjaz
         ABqZfb+WMyrgb5EXW23kkzrG1bwi4htHA9S/B/lGY01F57Eu5/8PBTDriH77lRJT7v82
         Df62HnK/d4DDXUW+Qr98rSFYFVi8AwGXYzCyCAuud/ErUaG4FKSjf7sAk3+kaFXkzeTP
         BR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dvUDEQc4tvoHEDIvRQPo+YCQta4LMQC9BMR73SCEOB8=;
        b=Ath0uPvvEt/EnKedh+uj6hxAVK/t8nNZYfQuRmvZBCqBMD7I4m5QwFgfo49Vy1/Ngb
         KceTMjblPmh0nUbmTfrELz6WAlsglziE/nKedSj/pGlfeKg9fU2nmYm2PGFS+fBfZ5Ny
         FR2vsxU3u5g8RtfBwLKsVl64tdlwdw3nH4llI096LvFyEzDxl43Po28PiJdKtIUPMpRk
         5WEDt+0ZEL+aK7m/6LKtgpU9N1YeusmNRkjsKRWXvmcDPXZbYNzP9lF5lUDhwQffYUgo
         0x8ikcGQpIWkRgcqLEsXbesPce42NENecezQ4d0smajmOQXmr92+l4e9dL1f629hfa6+
         lR3Q==
X-Gm-Message-State: AOAM5302cXsuR4vaPnV77UrUkc/FacrWEnhhs7NXmytERKS4hRLGvJhI
        lWn8V4+ARLwFbLIVB8NJPiOP3y3ifR9l9A==
X-Google-Smtp-Source: ABdhPJwRQSKgjpxDExGEjQQjQ3Z7RSFhhJmYVn8hdHtMXgcmU7N1+WFXPntnjcg2g4iE7Lq9MhGY4g==
X-Received: by 2002:a1c:bdc2:: with SMTP id n185mr13332770wmf.128.1615028705853;
        Sat, 06 Mar 2021 03:05:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/22] fsck.c: pass along the fsck_msg_id in the fsck_error callback
Date:   Sat,  6 Mar 2021 12:04:34 +0100
Message-Id: <20210306110439.27694-18-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the fsck_error callback to also pass along the
fsck_msg_id. Before this change the only way to get the message id was
to parse it back out of the "message".

Let's pass it down explicitly for the benefit of callers that might
want to use it, as discussed in [1].

Passing the msg_type is now redundant, as you can always get it back
from the msg_id, but I'm not changing that convention. It's really
common to need the msg_type, and the report() function itself (which
calls "fsck_error") needs to call fsck_msg_type() to discover
it. Let's not needlessly re-do that work in the user callback.

1. https://lore.kernel.org/git/87blcja2ha.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c       | 4 +++-
 builtin/index-pack.c | 3 ++-
 builtin/mktag.c      | 1 +
 fsck.c               | 6 ++++--
 fsck.h               | 6 ++++--
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d6d745dc702..b71fac4ceca 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,7 +89,9 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_error_func(struct fsck_options *o,
 			   const struct object_id *oid,
 			   enum object_type object_type,
-			   enum fsck_msg_type msg_type, const char *message)
+			   enum fsck_msg_type msg_type,
+			   enum fsck_msg_id msg_id,
+			   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 56b8efaa89b..2b2266a4b7d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1717,6 +1717,7 @@ static int print_dangling_gitmodules(struct fsck_options *o,
 				     const struct object_id *oid,
 				     enum object_type object_type,
 				     enum fsck_msg_type msg_type,
+				     enum fsck_msg_id msg_id,
 				     const char *message)
 {
 	/*
@@ -1727,7 +1728,7 @@ static int print_dangling_gitmodules(struct fsck_options *o,
 		printf("%s\n", oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, message);
+	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
 }
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1834394a9b6..dc989c356f5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -23,6 +23,7 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
 				 enum object_type object_type,
 				 enum fsck_msg_type msg_type,
+				 enum fsck_msg_id msg_id,
 				 const char *message)
 {
 	switch (msg_type) {
diff --git a/fsck.c b/fsck.c
index 8a66168e516..5a040eb4fd5 100644
--- a/fsck.c
+++ b/fsck.c
@@ -245,7 +245,7 @@ static int report(struct fsck_options *options,
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(options, oid, object_type,
-				     msg_type, sb.buf);
+				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -1198,7 +1198,9 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type,
-			enum fsck_msg_type msg_type, const char *message)
+			enum fsck_msg_type msg_type,
+			enum fsck_msg_id msg_id,
+			const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
diff --git a/fsck.h b/fsck.h
index c3d3b47b88b..33ecf3f3f16 100644
--- a/fsck.h
+++ b/fsck.h
@@ -101,11 +101,13 @@ typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
-			  enum fsck_msg_type msg_type, const char *message);
+			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+			  const char *message);
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
-			enum fsck_msg_type msg_type, const char *message);
+			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+			const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
-- 
2.31.0.rc0.126.g04f22c5b82

