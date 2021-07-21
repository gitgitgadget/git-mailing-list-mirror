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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C3C63793
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EB760FDA
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGUXAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhGUW7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20601C06179B
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d2so3952648wrn.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86QPuNHoNiJaJIf2Wuf3PKYrDObLqDNb+SsZ42wIYp0=;
        b=h31gVjzVa+Sm687L7xD8QnKy6emBg70zHw83+6M9Tyu+yh32fM3wr+PbEII5ImCVna
         J5oHqmz3wSeGWNi+Mot9/ro60Gyu3CEGOWKYmDhBx3TWu8EwFU/oGTkdYCB2bXRwhmwC
         mam6kkk0IkMEn5hfuAmOWR40v2MhLvMINGfYQc/nRoQKgq/2ItfPwJY9a5tQ3OtWYNoE
         m+MLeidbPOmhDA82oH4ybicc4ilVOWkKk1XnDjFUeF7dy+earPlD1F5CBfntd+IfO+7/
         A+2rIkNihKQI0Rx2LWuLs1+36Z6wrUquDlAozHiO/nDcv59Ah3yHJF7B7JVtTTZofknS
         b8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86QPuNHoNiJaJIf2Wuf3PKYrDObLqDNb+SsZ42wIYp0=;
        b=Q17hV/xQBT5QVvjty+BateUquOF8pBWIp0e9Th9t1e07g1Pi2zlQ0g1f38g9Kfv2Sk
         MOmZY2FujDW662XA/EUUBw2XmZoO4m48uol2MzXxw+G+9F6fedwANXbtq2i0HT8QNI+w
         stzK3gmisvKFZjS9wpAUZ6AbhYMHQLwSK8e9JT30GU3cHas8bsqSj2FD7vKcwqlHJc37
         2GboVE4cfe6nGWHsI6Bw2PSnP+arKz4MrVuNThpuSuesOtXuh0MRZmVa016B9u1vFdin
         U6QzfxXtU5O0ULTpbh9LnFdPSqKOKTY/I24Te7ptnNeeoAfygGeLXy+mEqabbZlRiUJN
         0wkg==
X-Gm-Message-State: AOAM530WG+2P6hl3eKzUqmHA3htRvCmh3Jjdt2EcQ/0vUW5BeCHRxMEM
        +RTUaI73UPMWxTyzKoaVc7k5MbFt8soC3g==
X-Google-Smtp-Source: ABdhPJxrVKBHCiiuYKwU5Y2CIMeKHkJbR902OhdEJ4sQbcN79xzZwaQ9Jqh1hgp+Fh8VlbfPidJjfw==
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr45947684wre.300.1626910827419;
        Wed, 21 Jul 2021 16:40:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/12] serve.[ch]: don't pass "struct strvec *keys" to commands
Date:   Thu, 22 Jul 2021 01:40:13 +0200
Message-Id: <patch-12.12-e4eb31b5b8e-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The serve.c API added in ed10cb952d3 (serve: introduce git-serve,
2018-03-15) was passing in the raw capabilities "keys", but nothing
downstream of it ever used them.

Let's remove that code because it's not needed, and because if and
when we need to pass data about the advertisement (I have some WIP
patches for that), it makes much more sense to have the serve.c parse
the capabilities, and then pass specific information we need down than
expecting its API users to re-do their own parsing of the raw data.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ls-refs.c       | 3 +--
 ls-refs.h       | 4 +---
 protocol-caps.c | 3 +--
 protocol-caps.h | 4 +---
 serve.c         | 7 +++----
 upload-pack.c   | 3 +--
 upload-pack.h   | 4 +---
 7 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 02fbcfd9bde..787e3849d97 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -127,8 +127,7 @@ static int ls_refs_config(const char *var, const char *value, void *data)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int ls_refs(struct repository *r, struct strvec *keys,
-	    struct packet_reader *request)
+int ls_refs(struct repository *r, struct packet_reader *request)
 {
 	struct ls_refs_data data;
 
diff --git a/ls-refs.h b/ls-refs.h
index 5fcab0d1dca..32f9e0eddd0 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -2,10 +2,8 @@
 #define LS_REFS_H
 
 struct repository;
-struct strvec;
 struct packet_reader;
-int ls_refs(struct repository *r, struct strvec *keys,
-	    struct packet_reader *request);
+int ls_refs(struct repository *r, struct packet_reader *request);
 int ls_refs_startup_config(const char *var, const char *value, void *data);
 int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
diff --git a/protocol-caps.c b/protocol-caps.c
index 901b6795e42..bbde91810ac 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -75,8 +75,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	strbuf_release(&send_buffer);
 }
 
-int cap_object_info(struct repository *r, struct strvec *keys,
-		    struct packet_reader *request)
+int cap_object_info(struct repository *r, struct packet_reader *request)
 {
 	struct requested_info info;
 	struct packet_writer writer;
diff --git a/protocol-caps.h b/protocol-caps.h
index 0a9f49df115..15c4550360c 100644
--- a/protocol-caps.h
+++ b/protocol-caps.h
@@ -2,9 +2,7 @@
 #define PROTOCOL_CAPS_H
 
 struct repository;
-struct strvec;
 struct packet_reader;
-int cap_object_info(struct repository *r, struct strvec *keys,
-		    struct packet_reader *request);
+int cap_object_info(struct repository *r, struct packet_reader *request);
 
 #endif /* PROTOCOL_CAPS_H */
diff --git a/serve.c b/serve.c
index 162e8cea550..3e82178c0f7 100644
--- a/serve.c
+++ b/serve.c
@@ -50,7 +50,7 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
 }
 
 typedef int (*advertise_fn_t)(struct repository *r, struct strbuf *value);
-typedef int (*command_fn_t)(struct repository *r, struct strvec *keys,
+typedef int (*command_fn_t)(struct repository *r,
 			    struct packet_reader *request);
 
 struct protocol_capability {
@@ -89,8 +89,7 @@ struct protocol_capability {
 
 	/*
 	 * Function called when a client requests the capability as a command.
-	 * The function will be provided the capabilities requested via 'keys'
-	 * as well as a struct packet_reader 'request' which the command should
+	 * Will be provided a struct packet_reader 'request' which it should
 	 * use to read the command specific part of the request.  Every command
 	 * MUST read until a flush packet is seen before sending a response.
 	 *
@@ -160,7 +159,7 @@ static int call_command(struct protocol_capability *command,
 
 	read_startup_config(command);
 
-	return command->command(r, keys, request);
+	return command->command(r, request);
 }
 
 void protocol_v2_advertise_capabilities(void)
diff --git a/upload-pack.c b/upload-pack.c
index b9cfc09795b..097b982c010 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1680,8 +1680,7 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r, struct strvec *keys,
-		   struct packet_reader *request)
+int upload_pack_v2(struct repository *r, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
diff --git a/upload-pack.h b/upload-pack.h
index 52011d9ecff..0ae817c1d0d 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -5,10 +5,8 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		 const int timeout);
 
 struct repository;
-struct strvec;
 struct packet_reader;
-int upload_pack_v2(struct repository *r, struct strvec *keys,
-		   struct packet_reader *request);
+int upload_pack_v2(struct repository *r, struct packet_reader *request);
 
 struct strbuf;
 int upload_pack_advertise(struct repository *r,
-- 
2.32.0.955.ge7c5360f7e7

