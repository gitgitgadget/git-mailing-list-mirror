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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1064C433EB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50856196D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhC1NQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhC1NQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C7C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so7179778wml.2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ooc0gDUBZ8i80fVgZ25amsyHysLLBmREx3xHMXO2MiQ=;
        b=CvxvBM5mkafCYlvWNnqn9C7HwAceMElpAfAnBVE2gqPAP1y7w8NagZcf8RUhHz05Mp
         id4fwjsxG78j85kdlJydpH/Gz6V+M7DjzKyqykuCfE8zAJ+ecTB+7GuWSGBT+cJ/3QDc
         UO/zcJrTkcfbwexhUaKWg5i6B2aXnQdiE/wWlK5Z2G2mIJjyDz+Xd5mElBkX8gCmW0hs
         yHbBDEpUDRHOFpAjPnLk1+m7lKVfjukTVbXFT0dvNVuqJUC+hGw2c9xmdVwxAvG/ZlOn
         T9z4Mm74i+AgJ+67nqLB5ig0wY2xPLZJV/0gKDdsEFEw9JEELSbC/Dq2N24oHk6jp5R6
         pV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ooc0gDUBZ8i80fVgZ25amsyHysLLBmREx3xHMXO2MiQ=;
        b=WrPNfZG6+cYmAm+An9v4wdDYLUKhAeGiuhn2bondlrXogPKRh+OF0eGLymGQ2Fizxx
         G1kmnE40H8Kt5Y6HB8rQoHnEU5fBC9V9qZGDkaZJuPE1JWLne/dwrxfUfhrQASQPxN5M
         VuJCoIjk0C8cX5EvFaN38O/a0xMlAxK8rV7bP0VXpTER/Xf9hscaFZiSY67QPHUg4WQR
         p3nRAKy7coHYq2cFzxYfSxquvzTgDoIggCQwE0oKG4UKCACMk9tPUqBUH4oObLnX49zI
         P7nNzHzDUKuq9N0peIMd9mEpc/xxbjJo3pZ24jrSQ2Onad86n5OXu6J3JL3h0M07P1sH
         68aA==
X-Gm-Message-State: AOAM530khSVsn+xRKY66Wn49hoLZ4QOyLZaKpe2JxkHEDyet1PT2BdWb
        +WnrH5aevdBwwci2GKLn1Ocbhgny1z+1eA==
X-Google-Smtp-Source: ABdhPJw9+f7RJoH4hceVMW++Jf5OYys5HS13CdLzgh09BMxY9eUw4FTi0Xb363ZO05hk3q/p7+2ptw==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr20697078wmh.15.1616937365870;
        Sun, 28 Mar 2021 06:16:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/19] fsck.c: pass along the fsck_msg_id in the fsck_error callback
Date:   Sun, 28 Mar 2021 15:15:46 +0200
Message-Id: <patch-14.20-563e6a0e5e6-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index 17940a4e24a..70ff95837ae 100644
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
index 8338b832b63..2f93957fb5e 100644
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
index 052a510ad7f..96e63bc772a 100644
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
index 150fe467e43..23a77fe2e0f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -227,7 +227,7 @@ static int report(struct fsck_options *options,
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(options, oid, object_type,
-				     msg_type, sb.buf);
+				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -1180,7 +1180,9 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
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
index 66c4a71139a..fa2d4955ab3 100644
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
2.31.1.445.g087790d4945

