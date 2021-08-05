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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8381DC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B32C60C41
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHEB0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHEB0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41733C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so4298287wrr.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/OPCK+F7JNnAuApsfx4c51/f8jN0LurlPT6Acj6JQQ=;
        b=PL4GO3gXWshXafoiw135zvW55ImYsAFsN4TW0Yi18PDX0HgHmOaK/+QyuJmAgfSsm0
         8M4Wkv0Hc5ScKJa5A4TaSrdTQS1U/iBHU0NCErPZmtIO8hVv0iSkgYpgzipRPNTMwi7+
         3KVurEwFJGlGEBUbTbXn1mqWyVNSZH0nywy8DnXj3cPJ2AAVKmqa0Ip0PsQFwFHxLFUZ
         2wah1IqVS6urAhwh2Hw7G5CksAqo+TA7OwFRLifBHpldIVU/0cwaEgKVFjEvvAEufO+I
         Yh2bYCSt8NI2LIdnc0cfsyVun7eyiDocy51Syynfr+3efXDtlTbeYSwv6NTKz5XqN1Ck
         ksCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/OPCK+F7JNnAuApsfx4c51/f8jN0LurlPT6Acj6JQQ=;
        b=DJCS+jBqnZ6enVTzJYiTkIfGHDQh4OXSnp87Hu06RtS9U7R9YikhPnhcxUtrGAva6H
         kK8/VvXOY+thXpYdoy1EUZCCggJvI05K3GHsGsK/+BwkqeXKQCFV6/M3yQhUprues2DS
         lTXeJLbDK39NWUEOM9HTkQOOJOO94u8jBDYOM9/7QwX/nXSUWhz3lhHwKjB/8VBN368U
         kifnw339mld10niPff/sY/hCfZwS2t5RpuynHjzbFnlspeKYQe4Y3tiCx5rzp/uDNKcC
         k7RcyWB7M4/fAf4DyKpBcRaHkVeu2Ea30ynRyeUvSyrxolbacoHscrJ+HS8IeUCFjUMb
         Uctg==
X-Gm-Message-State: AOAM533QgmgxCxQNFkG+k66ljkGZQpWlaqF91imNHxvsxHMaVxFDk6eQ
        C7p88F9IU7NbH4FHwiRLjh5QStHH1sbbrw==
X-Google-Smtp-Source: ABdhPJxm9bGqd/f0e74T6pB/PyNgnB5L6hhEEbLBTIFE/ku/CIcWqcMik/U1krLolWMsy6OnCctdHw==
X-Received: by 2002:a5d:4009:: with SMTP id n9mr2009542wrp.397.1628126749607;
        Wed, 04 Aug 2021 18:25:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/10] serve.[ch]: don't pass "struct strvec *keys" to commands
Date:   Thu,  5 Aug 2021 03:25:38 +0200
Message-Id: <patch-v4-05.10-7714f81d62c-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The serve.c API added in ed10cb952d3 (serve: introduce git-serve,
2018-03-15) was passing in the raw capabilities "keys", but nothing
downstream of it ever used them.

Let's remove that code because it's not needed. If we do end up
needing to pass information about the advertisement in the future
it'll make more sense to have serve.c parse the capabilities keys and
pass the result of its parsing, rather than expecting expecting its
API users to parse the same keys again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ls-refs.c       | 3 +--
 ls-refs.h       | 4 +---
 protocol-caps.c | 3 +--
 protocol-caps.h | 4 +---
 serve.c         | 9 +++------
 upload-pack.c   | 3 +--
 upload-pack.h   | 4 +---
 7 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d8..a1a0250607f 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -138,8 +138,7 @@ static int ls_refs_config(const char *var, const char *value, void *data)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int ls_refs(struct repository *r, struct strvec *keys,
-	    struct packet_reader *request)
+int ls_refs(struct repository *r, struct packet_reader *request)
 {
 	struct ls_refs_data data;
 
diff --git a/ls-refs.h b/ls-refs.h
index a99e4be0bdd..e2243a547bb 100644
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
 int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
 #endif /* LS_REFS_H */
diff --git a/protocol-caps.c b/protocol-caps.c
index 13a9e63a04a..4b345c55046 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -74,8 +74,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	}
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
index 33d00c8c634..967bf17d623 100644
--- a/serve.c
+++ b/serve.c
@@ -60,16 +60,13 @@ struct protocol_capability {
 
 	/*
 	 * Function called when a client requests the capability as a command.
-	 * The function will be provided the capabilities requested via 'keys'
-	 * as well as a struct packet_reader 'request' which the command should
+	 * Will be provided a struct packet_reader 'request' which it should
 	 * use to read the command specific part of the request.  Every command
 	 * MUST read until a flush packet is seen before sending a response.
 	 *
 	 * This field should be NULL for capabilities which are not commands.
 	 */
-	int (*command)(struct repository *r,
-		       struct strvec *keys,
-		       struct packet_reader *request);
+	int (*command)(struct repository *r, struct packet_reader *request);
 };
 
 static struct protocol_capability capabilities[] = {
@@ -294,7 +291,7 @@ static int process_request(void)
 	if (has_capability(&keys, "session-id", &client_sid))
 		trace2_data_string("transfer", NULL, "client-sid", client_sid);
 
-	command->command(the_repository, &keys, &reader);
+	command->command(the_repository, &reader);
 
 	strvec_clear(&keys);
 	return 0;
diff --git a/upload-pack.c b/upload-pack.c
index 297b76fcb43..ed60a9abd60 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1655,8 +1655,7 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r, struct strvec *keys,
-		   struct packet_reader *request)
+int upload_pack_v2(struct repository *r, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
diff --git a/upload-pack.h b/upload-pack.h
index 27ddcdc6cb0..63e3252c98d 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -11,10 +11,8 @@ struct upload_pack_options {
 void upload_pack(struct upload_pack_options *options);
 
 struct repository;
-struct strvec;
 struct packet_reader;
-int upload_pack_v2(struct repository *r, struct strvec *keys,
-		   struct packet_reader *request);
+int upload_pack_v2(struct repository *r, struct packet_reader *request);
 
 struct strbuf;
 int upload_pack_advertise(struct repository *r,
-- 
2.33.0.rc0.597.gc569a812f0a

