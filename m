Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF2C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347016AbiDRR0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiDRR0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816533E13
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so12153383wmb.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GSqMXASLJtEddhTs13pXKC+LhRVWF6Q79Aghg98cJXc=;
        b=myofghFmNVF7iaIOKnMCyAFTQQFSugmhX/oyj2/rRnjYevHqnS+TqlOMrIEc6fWvkR
         jOy+n7Pdf4xfu2acMmdVXMONnZBzPsqx5qNaTIzZvp/WHNvPMvWRxd20VJP3nWgND6Mj
         +KeSERpKlEK2GxHqHi+UJqzOJV0owaeJ9JSN0v9Iw5xNhwjlgKVvE9P47ySCnBLAzFlQ
         V2PeXkzZVvSOJ9SkcH7f3oeLR7FKlXyvUJr5PnQucUdVIXD2yLeegjGv2hpW6OSSd9Qq
         EF6Q8OP+TWilAK0BdG1v6AF16P63whqN1Pn3/AtTUWysx1TBJUDlNFoyGqptP9PAHudt
         ifKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GSqMXASLJtEddhTs13pXKC+LhRVWF6Q79Aghg98cJXc=;
        b=tdyE8IecF8hA45BncyuuGb0jBM/N8J+TiHQPIwVvh0JmajUWsReG2J/U+2hOOu4k9d
         D8t3GFWV714O8lLcduDfvBAeG6BC+KfAHCeMhGn9h2V/n5OmJEPh9Cpspef0zxa1oJf7
         JoQcGb3J+SVgw2KJsimB0OWuV9dbbFuyxgXnLLB+7HFdkSyHJS4/h/52mwLXZQ5wDuKF
         JpzR6/x75bbuu8xlhR6Rm5ZT7Ux+lrhlKTP6rX5nglKQAmnN1z35oEWdY/E5n1rTZ3Rs
         MF6xbq5LLy1GLiDgYp6yGH3ddK/hh45nJuTCw6MXQLw2xoiqyymKPDYMYro3gx+sLw4Y
         DWjA==
X-Gm-Message-State: AOAM530/njYCz/jCfSVrshdvamf+Xk8T/Vs58DOrWoSbVDy0Bsjf3dEF
        0DZEpZK9ebe8kMz8zcF53HV+DK3HKv9ALA==
X-Google-Smtp-Source: ABdhPJyXEApyIFzAAU1QWom5odgR0lDG6v/EZs7x3JxnNK/sdOIQ4+axXiv2i8WJEV44bLkaY9ZoSg==
X-Received: by 2002:a7b:c201:0:b0:38f:f7f5:f6db with SMTP id x1-20020a7bc201000000b0038ff7f5f6dbmr16163358wmi.191.1650302641758;
        Mon, 18 Apr 2022 10:24:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/36] connect.c: refactor sending of agent & object-format
Date:   Mon, 18 Apr 2022 19:23:18 +0200
Message-Id: <RFC-patch-v2-01.36-95c53a3e779-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
2.36.0.rc2.902.g60576bbc845

