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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E6C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3BD64F4F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhCQSV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhCQSVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B78BC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g8so2041598wmd.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/uzG+2biayW9Qu6KLJ09jWl488ZuuVJRpzwFNTW9Dk=;
        b=M7oQuQCnjJOrZB7xmBAZZCgbR2iTwCIlDC0Pl600QEDerriXscBOLToPrh2B5+JpTy
         e1zjjyQPEd+Z76J1/aKViwzAJvYcRihXEaPsTRr92zhn+TVALPqNAkzCuONKy8v8P0uz
         wehm9lXXKPYSHqiaQf7x5MI/8zJkqSL7mbBgCzIvHLNjtJbH2JB5gPNrEdilZFEIRdtf
         INmCT6Zp3FhyJ5N1XBMNIAe07AIbn34GfZibRQUzEKhGoNBtBxEoZDlhD+7QNzW02Tvv
         2cU7y5OSu9ClNoctZu2PLDDqxL+5Rtd85gw7r7FzB/yIdnaFZJSKkYwvHe3Tbpwdp6MJ
         dImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/uzG+2biayW9Qu6KLJ09jWl488ZuuVJRpzwFNTW9Dk=;
        b=XmoHN+WC7bT4oUsJLkCoEgllFtrAQfOKBGuc4Mu5oZH8p+048cbBo0XS7RIz3iT8vt
         q9B9LMWs7XcVAoVFJeCcMh4+l+giQjxDO1vuwKRhNnKHq9mV0Y97f6xf1QLF4pTO433u
         Vhhumdudr9IwYV3QXIInYATedpdHResmj6n49g53XYs0xfYvawFfD7amL7MDXfP8sAZz
         QUrL6T2vnaS3YRCJ1gBnzbzQ3PRwhMMmeXm9rBB8MXUfKDK24MF6cexH73IDthCPgPUc
         rx7hihKQcfVC6YO7ENFSWYfrNQen29HOPAt3riK443eWnLQUtL9MjX4QySDqWHI33qIL
         DhNA==
X-Gm-Message-State: AOAM532mx/WBlrsQMgBnSU8on/qFMer6AwDLDJ3W3moDLu8IUH6DziaL
        y7UNKbQYAli8OnhuRj4VSv93iBDsJsOmPg==
X-Google-Smtp-Source: ABdhPJwvv02Y1WoYGO5X97AKeLcgTHDSanBjttd+d1yNJzsfIAgT/QpljmLehIXt+K/YN1U3k4aY7Q==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr89490wme.161.1616005281650;
        Wed, 17 Mar 2021 11:21:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/19] fsck.c: pass along the fsck_msg_id in the fsck_error callback
Date:   Wed, 17 Mar 2021 19:20:49 +0100
Message-Id: <20210317182054.5986-15-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
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
index 17940a4e24..70ff95837a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -84,7 +84,9 @@ static int objerror(struct object *obj, const char *err)
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
index 56b8efaa89..2b2266a4b7 100644
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
index 052a510ad7..96e63bc772 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -18,6 +18,7 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 				 const struct object_id *oid,
 				 enum object_type object_type,
 				 enum fsck_msg_type msg_type,
+				 enum fsck_msg_id msg_id,
 				 const char *message)
 {
 	switch (msg_type) {
diff --git a/fsck.c b/fsck.c
index 49208ec636..01b2724ac0 100644
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
index 7c868410eb..80b1984f34 100644
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
2.31.0.260.g719c683c1d

