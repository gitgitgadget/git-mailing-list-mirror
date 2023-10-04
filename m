Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6043BE7C4D0
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 15:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbjJDPWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243163AbjJDPVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2073FD8
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 08:21:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3f97f2239so18020065ad.0
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432908; x=1697037708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROQ9UozEZPA2+mJSw4EWiQmxaUtdl4B3V+VnwxyVx5A=;
        b=nL4jg7+KfSjSJ5j4aFKJ6eIt5YBTRhDhEUPWzJP/2FK6bEdXT3CZweUWddB7fepS0T
         tzRB0psYbs0Yccyh+tEs9RTcC45yj+hHcxCLLu2ur78Exti9oowvkCppU/rCsY6JT7N8
         AT23f5XuwiTfJQkBM11HNzB3s+5N46VJMK1vsvFeTEwffYIeGsdEAHjKNmh+bL7pJO9H
         684+4RF9Qx+lcdWaGfvzDrtro3ilc3neIS2pNlbmcKyG6afO7PpTK9RFiaiTbd/DYtg9
         WG9Zf+rtz1CFvdQffRRNycisoeNzbFpd22K3SpLpSr8bHivxIlvfGO4qbnj3SaGcJAPm
         R7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432908; x=1697037708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROQ9UozEZPA2+mJSw4EWiQmxaUtdl4B3V+VnwxyVx5A=;
        b=sBuLAXgTlh1YkLoXwGCd5TQHg6T2exUC1cSCPB6Yof1i2K2qRzHe3YkC8Ew5gEIEcw
         lA0C16vqZAkWcbHM/ylZNU2HtafQjBgi5QJVeqcSzO5M7MhiRJ8P2Q75Nays7QbdK+m/
         TN8oaR24ZWZr1VlRLRXU97AlYC+5wtKZAWWD1BNIE4fewj9eR2ZLFtTutsG2a4gFGxsH
         8e9zjdBNHnMTclfEo193nuFhBtGNtwa+zOmx7bLF211JcaHWA7pMUNyb8pDxcXyKacwx
         xYhCYNCghweYC9Ah05tIsgAzPhOpug44u7H9o9FvhgG05E2dpW0m31lAClydYPS1pxLj
         Z40g==
X-Gm-Message-State: AOJu0Yzt899PbYIcZOD4vXp/8r0NQReV6iJGlEa34l1/wpmDrXF/uQSg
        OwAAcInQ4goB7a+9z75qQXmnAuA8O1Y=
X-Google-Smtp-Source: AGHT+IGdsgaz87+GogLPKSjrIaBHK8e7q1VGuTdnNHylRnilZGVzYLhjpDNNHkBPjQY5P2ScxgVMAw==
X-Received: by 2002:a17:902:e811:b0:1b8:8af0:416f with SMTP id u17-20020a170902e81100b001b88af0416fmr3162723plg.1.1696432908411;
        Wed, 04 Oct 2023 08:21:48 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001c5f0fe64c2sm3838199plh.56.2023.10.04.08.21.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:21:48 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 2/4] transport-helper: call do_take_over() in process_connect
Date:   Wed,  4 Oct 2023 23:21:41 +0800
Message-Id: <e3dc18caa91bd16d95dc7c2bbd0e6eceedefe636.1696432594.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
References: <xmqqil7yq6ms.fsf@gitster.g> <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The existing pattern among all callers of process_connect() seems to be

        if (process_connect(...)) {
                do_take_over();
                ... dispatch to the underlying method ...
        }
        ... otherwise implement the fallback ...

where the return value from process_connect() is the return value of the
call it makes to process_connect_service().

It is safe to make a refactor by moving the call of do_take_over()
into the function process_connect().

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 2e127d24a5..51088cc03a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -645,6 +645,7 @@ static int process_connect(struct transport *transport,
 	struct helper_data *data = transport->data;
 	const char *name;
 	const char *exec;
+	int ret;
 
 	name = for_push ? "git-receive-pack" : "git-upload-pack";
 	if (for_push)
@@ -652,7 +653,10 @@ static int process_connect(struct transport *transport,
 	else
 		exec = data->transport_options.uploadpack;
 
-	return process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, name, exec);
+	if (ret)
+		do_take_over(transport);
+	return ret;
 }
 
 static int connect_helper(struct transport *transport, const char *name,
@@ -682,10 +686,8 @@ static int fetch_refs(struct transport *transport,
 
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->fetch_refs(transport, nr_heads, to_fetch);
-	}
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
@@ -1142,10 +1144,8 @@ static int push_refs(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 
-	if (process_connect(transport, 1)) {
-		do_take_over(transport);
+	if (process_connect(transport, 1))
 		return transport->vtable->push_refs(transport, remote_refs, flags);
-	}
 
 	if (!remote_refs) {
 		fprintf(stderr,
@@ -1186,11 +1186,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 {
 	get_helper(transport);
 
-	if (process_connect(transport, for_push)) {
-		do_take_over(transport);
+	if (process_connect(transport, for_push))
 		return transport->vtable->get_refs_list(transport, for_push,
 							transport_options);
-	}
 
 	return get_refs_list_using_list(transport, for_push);
 }
@@ -1274,10 +1272,8 @@ static int get_bundle_uri(struct transport *transport)
 {
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->get_bundle_uri(transport);
-	}
 
 	return -1;
 }
-- 
2.40.1.50.gf560bcc116.dirty

