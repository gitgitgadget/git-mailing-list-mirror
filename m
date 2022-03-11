Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35098C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350278AbiCKQZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350254AbiCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2702108761
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so13694062wrg.11
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njeOfpQ5Pl+tiJg5qLKUagkvcUMPqLWuYzEZN9f+OTQ=;
        b=AT1WtpV51AyciAdvpNTQ+Gp3UdQ7pPyz0E6LafW5c2YPK0VkbpekUHVYuzR2FyT6/6
         DMN79RXkHGkGlYTAwxSC2ErD8bNSqFTZqUVMk+7rRZprLgd39m6G/hMXqBKgsE144a8M
         Y1ODGkvRtK34sSRBYzdx+iyxys9ZWszIvRy3truCsJkhHLV+rBv1HTIUXBzgasF1uxo2
         rG9ml4B3V5ckRgLOoCmmiXLBuuLTxPrLzGTsWy3XP79L2TkYetXeR9i3sB1NFPi8XK36
         pclic9Nv9mGvq1+0ayeKVa7cmudQrQP9AViVZdMqJc4Vr7x8S/vv51lN+CxQS0AL1nro
         YnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njeOfpQ5Pl+tiJg5qLKUagkvcUMPqLWuYzEZN9f+OTQ=;
        b=glRKxlSr58AJfqofZ+js7n4Vx1qjXHs0+LPCTsJXjmv75DqdDZC2NYesX1g7vtVui3
         jX6NlRbBiPiQT+8+wYWAuG8dmEBC2NnOsM1CsgeVzG9uM+ZQkqUn2S0cgp0byBNN7VmZ
         4J5NS47oYceoV9D8pTOivHDjN341/n7QEZpIOgycMYwmrCREeAiIFbRtn0xz5FsBL5Qp
         bs8iyFC+5gr8NFDz/4KW87nDuPMP8oAuKR+TT3R44o1FI00MXc8xO0IkmsQnKDGmp1Vi
         WHjdqWhxJnhWSuLjl46NBD6HMRVbZ++ht31MrnH+LwGlALscfpYlWOHxQtPVLJZp38a7
         w1gw==
X-Gm-Message-State: AOAM530Tchb/4L8k8UtSj4X8q2hT5NXOvYkoWOmwvckovsxWkYa9algL
        fKr6+7Ymr3b884/T9WBfIZojA/TeHp8spg==
X-Google-Smtp-Source: ABdhPJxmk10Y6o7VLAebtOBt1ocwnwNV2dWOP44o7xUm6y35dz7wE/FG/k0dqIGm3xUgd16VPo+5Fw==
X-Received: by 2002:adf:b74b:0:b0:1ed:e1d3:e053 with SMTP id n11-20020adfb74b000000b001ede1d3e053mr7986395wre.131.1647015874252;
        Fri, 11 Mar 2022 08:24:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 04/13] connect.c: refactor sending of agent & object-format
Date:   Fri, 11 Mar 2022 17:24:16 +0100
Message-Id: <RFC-patch-v2-04.13-f64aefa9ece-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
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
index afc79a6236e..e6d0b1d34bd 100644
--- a/connect.c
+++ b/connect.c
@@ -473,6 +473,24 @@ void check_stateless_delimiter(int stateless_rpc,
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
@@ -480,7 +498,6 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     int stateless_rpc)
 {
 	int i;
-	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
@@ -490,18 +507,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
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
2.35.1.1337.g7e32d794afe

