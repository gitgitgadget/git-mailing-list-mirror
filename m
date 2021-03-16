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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C76C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BC46511C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhCPQTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbhCPQSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20795C061764
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o14so6976204wrm.11
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOJ/WwzjdP5YoN4cI05g8XpERVSTnf1CtrzFMFsUeEA=;
        b=ZGNGEMoqiaUq9Vgu5hIAzHwtBBvn1YwYePdhdtYG6YZG2fH/YA1a7HuNcY7vWxUTPV
         k9o/EM/fxu5rcuylbx3Jvpj2x+OM7x3MQzS1hvYhU7wzJW/vlWEm3CtHvSLjTEWnMVnG
         qkOa4avQB2hqJxy39D+wZxhddxZSv6LM4X6V7nfKwWUjMK5DfWserjurn3CMgaA+5iyy
         0d+NC4sqbntDM7WztUMIOrLpKsF7Ya2fyNZ89Jjt1ziLLM95l3vi9PrBurPTrUx7ipXV
         52s+q1EItQ+e4mksre8ksx0crpaTrvWIrZ3lcDZlZrFnGunPkqP6oh2I7Cl/F6rAgcoL
         TMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOJ/WwzjdP5YoN4cI05g8XpERVSTnf1CtrzFMFsUeEA=;
        b=fiwzCy2JU5Yf9b9ifG52wn3mJSsAiYnEwUydGF0PU6Cx7028nOUWQsXug7lbzZb+LI
         jf5D+Gie4SxcvpuzVQKNoCyeO2cGbcMOs/pePgC4+SP0Z84JTeDllAcpTWY6wzTVO7Wz
         qts1PHwYbujvd/G9vND2xJXYrUMezXC5SpCOi48S1wJsCbWf0BkWHV4w4hf35YioeJ+B
         MIUBISYUY0cJSjpo5mNShduzYGuNB943jNISoT4InteKkB2FiZP6fQYdC7oolVyuLidM
         a03qv/D3WVVmzTZ1h+AU5PlsYQfKTQDdn+UC2x7JMaYdCqfcaqekU7m0wWPOwT/rLgI5
         NIew==
X-Gm-Message-State: AOAM5324MilOYQbzCDI/7ImsQDR4cR3elSs4wwVnZEWs0J3VmscH/uX5
        DxvhTS6fo+XzMHUbkie4MG1S/1FiAW7JIQ==
X-Google-Smtp-Source: ABdhPJxoJYAYEudIBJbeFw1Apzy2SeJi1eRH8gvLAgw7+5GcS7twLHj76jGXD8embAkx/RJJQkVD+w==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr5912459wrm.145.1615911488604;
        Tue, 16 Mar 2021 09:18:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/22] fsck.c: pass along the fsck_msg_id in the fsck_error callback
Date:   Tue, 16 Mar 2021 17:17:33 +0100
Message-Id: <20210316161738.30254-18-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
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
index d6d745dc70..b71fac4cec 100644
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
index 1834394a9b..dc989c356f 100644
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
index 8a66168e51..5a040eb4fd 100644
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
index c3d3b47b88..33ecf3f3f1 100644
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

