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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96610C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815BC6104F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhHEPIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbhHEPHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D83C061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b13so7023774wrs.3
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CR5UmrmRUux5yP3B4QxqMrRhlY/t/mCix8RY9b8Pv8=;
        b=L9/HMiJJi3UFR3mwYZChp6OPy0op8lquWbw0A0bLzIkR20DfgdAh5KkR2Az0YX+R/Q
         9faP0QP4K3Eb1rC2+zztev9v7Rv2+hmNNU63sn+S/8Kw1Fl8hvCO7kT3xT0Kg8WqW97/
         rAJvPZQzqdvJQS/fJ+mS1S4xczEG539VqFEuXYj7OGQtHgoSM/JYzkmSr1lihpHvRXUe
         azTCJKVYEJUf9qZ0nKv3PSLPXX/fZ1fCY/+iiIUyWEUjFQ+lT5iqomwCrtngLsoQNnj/
         k2MltLexFtVV91RDD1JDW3DbP6LjQ3w1CT0K3Lov7v/J6sZnSFZrkkcDiW4+Z/jPJWSs
         o9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CR5UmrmRUux5yP3B4QxqMrRhlY/t/mCix8RY9b8Pv8=;
        b=OxMs1GMhyZCwIgI2/1X8NtKXine6s+LZrEGcq5Tq9lTMwMQQVUfi/LUgaxK3ffCZjv
         naRIYInWvhT7PPaISCYPOsn6KT9JwOp1WnS41kiaxVMtNz9Rdlr6jTw6LwOX8eoC9D0j
         TJVZGB4ZFwTBkpULzu3FtEl8O0mFOKv5dqD2m+sMFxdLQsU99YOA4HjK+14ickVevdUV
         OJinTkiuF5cWUFCHSp1V0LP0cPqQvmFmeRhmkb2hI8AgR0j4e4yWFKNB8TgstoAYfPtI
         EL5g7YkfxFowJ2CIGhMOmXgEGh2oOQTmdLlJMdexKc5msF//npSwKXEDOiV2meDojDRT
         qUwg==
X-Gm-Message-State: AOAM530cHws9n/qvqT+cMmsmxaGwnP6WrMn/Ws1odI10uRMizFflxXzy
        lCBMrm8SsEnUBkTBIfwe9hsGxha4eS/FeA==
X-Google-Smtp-Source: ABdhPJwohvmmtvzzCZ/C43GyAuRdmKN62OB2iUy6GiKXHP1kLGpGuBrJEYpXU8NLE5FavL1oBEqd+w==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr5739119wrv.418.1628176058484;
        Thu, 05 Aug 2021 08:07:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 03/13] connect.c: refactor sending of agent & object-format
Date:   Thu,  5 Aug 2021 17:07:19 +0200
Message-Id: <RFC-patch-03.13-fc5c725307-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the sending of the "agent" and "object-format" capabilities
into a function.

This was added in its current form in ab67235bc4 (connect: parse v2
refs with correct hash algorithm, 2020-05-25). When we connect to a v2
server we need to know about its object-format, and it needs to know
about ours. Since most things in connect.c and transport.c piggy-back
on the eager getting of remote refs via the handshake() those commands
can make use of the just-sent-over object-format by ls-refs.

But I'm about to add a command that may come after ls-refs, and may
not, but we need the server to know about our user-agent and
object-format. So let's split this into a function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 connect.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index 70b13389ba..18dfeae2b8 100644
--- a/connect.c
+++ b/connect.c
@@ -471,6 +471,24 @@ void check_stateless_delimiter(int stateless_rpc,
 		die("%s", error);
 }
 
+static void send_capabilities(int fd_out, struct packet_reader *reader)
+{
+	const char *hash_name;
+
+	if (server_supports_v2("agent", 0))
+		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
+
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown object format '%s' specified by server"), hash_name);
+		reader->hash_algo = &hash_algos[hash_algo];
+		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
+	} else {
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	}
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
@@ -478,7 +496,6 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     int stateless_rpc)
 {
 	int i;
-	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	char **unborn_head_target = transport_options ?
@@ -488,18 +505,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (server_supports_v2("ls-refs", 1))
 		packet_write_fmt(fd_out, "command=ls-refs\n");
 
-	if (server_supports_v2("agent", 0))
-		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
-
-	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("unknown object format '%s' specified by server"), hash_name);
-		reader->hash_algo = &hash_algos[hash_algo];
-		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
-	} else {
-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
-	}
+	/* Send capabilities */
+	send_capabilities(fd_out, reader);
 
 	if (server_options && server_options->nr &&
 	    server_supports_v2("server-option", 1))
-- 
2.33.0.rc0.646.g585563e77f

