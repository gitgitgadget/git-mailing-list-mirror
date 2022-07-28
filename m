Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7692DC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 23:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiG1XCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiG1XC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 19:02:28 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC867CB9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b17-20020a170903229100b0016d3e892112so1922279plh.6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=0Q852NMClbQ/F2QDiq4pWETxcpEwn60IQD9uB4ZHKLs=;
        b=odM4amiGbN1r9X7al/0upaIEY+88eGe50AqanqCIBl8iAQmF+qgz2rf0XaOf5Qg6pM
         57+kMBxHUi2Yis/4hqMQ/l9s1gqnI2GDl+wO6ocWeR7PimqMEMLgYZSB0y8JGGbdWiOS
         MOTl7Jr/Sj688o44pwy0Fz2I8SQsBmrQ+l+OlmN3kpoyHN3y8E0zlRWY6W9SLvPOtsny
         6dmGobUAeMizfSjsjSHjzynix7b3c2FvjPClwR6orhFtWfRhkHlXj2S63PQqbmz5xw9N
         hnQAn3srMiUmE7rLFyEcAoiqk7ZHwCzQoiU6TV8QxM5DLT1cFjzR/uhEsQREeGfessh0
         v8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=0Q852NMClbQ/F2QDiq4pWETxcpEwn60IQD9uB4ZHKLs=;
        b=j7PPXBri052TzBHHsLYom9EaiUHXbYzfxp6CtAcuXYPYeN0rs1MjPIsrZfBl0a+HJa
         Dc+c/AnyMR50Khvs1KTw6lXLsQqfApuf/cIvGOAg07RDb11Y3FNK5aocBIEr1emI+1qH
         2zwdVSeQTWx3Ek7GpfrShsXC5cqn1g3mIbstjcVk8kkrnfffphfGU4jMaQb0bzwXUr+w
         1wfHZlhKG68TPOV3uOaR318Af3NiE0VZsGMgt5UbaH9NOUUKlS9A4RQopEzsHJlaedtD
         2fOlo+HNqKnwO8NrIKMMLYigus1iGd6B0VpCoprgRxi/2sEtw8MhTpQCSWUOjZF50sN0
         vAWw==
X-Gm-Message-State: AJIora8pjpxEiX15gRG+lxkuHdQUax+GdVmaY3mqbB5U9EirU2WeLMO3
        kkFQSZeEpLC9NFuQHLmpVNDI50AhEV+64RjEXOzHQOVZxIVnQK2vWjSrEIQRRZXmOeaT0FOVTgZ
        /wprAXg9iPZUuWLA43jWK51eI+10Z6rr9Ss7G1buSk5JS0utq3JmUoiGVZX7/9VpRjA==
X-Google-Smtp-Source: AGRyM1s695rm2mttgsOxB2BlonlpBuw9eBgAFXAui/ZLuBIjuaOL6HEH5ARXzOHzMld9amclXffLeUTFZ+b6TZo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:be4:b0:52b:c1f1:cf75 with SMTP
 id x36-20020a056a000be400b0052bc1f1cf75mr1022395pfu.51.1659049346917; Thu, 28
 Jul 2022 16:02:26 -0700 (PDT)
Date:   Thu, 28 Jul 2022 23:02:05 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220728230210.2952731-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v5 1/6] fetch-pack: refactor packet writing
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will need to write capabilities for another command,
so refactor write_fetch_command_and_capabilities() to be used by both
fetch and future command.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..5176420b62 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1261,13 +1261,13 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
+static void write_command_and_capabilities(struct strbuf *req_buf,
+						 const struct string_list *server_options, const char* command)
 {
 	const char *hash_name;
 
-	if (server_supports_v2("fetch", 1))
-		packet_buf_write(req_buf, "command=fetch");
+	if (server_supports_v2(command, 1))
+		packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id", 0))
@@ -1303,7 +1303,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, args->server_options, "fetch");
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2090,7 +2090,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 		int received_ready = 0;
 
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, server_options, "fetch");
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.37.1.455.g008518b4e5-goog

