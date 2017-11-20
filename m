Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227CA202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752993AbdKTVZK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:25:10 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38463 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbdKTVZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:25:08 -0500
Received: by mail-it0-f65.google.com with SMTP id n134so13480003itg.3
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKTh0gc3ubHnFq3ryhGk+qxXRujaYZRfkDlvnNWYEvA=;
        b=cmlT/zg/2AI/GNeBiBa2gMtWO3bm65o1aZugYGc5eO3j+cFDgi4h3uLLEhlQjh+yRr
         MsKWlL8uczaUqeqvuK4OqPUQQYGEwQu/Nq/1nPigFTH3hq1jeDxUaisd8aJ6Qy8jHtWr
         LC9FCsffUUjZiJP5MQgktEfV2vEzo6ogHPScfb/1fXPl37RPhHIkOVNkNOEcCrcQS4JX
         4UWY0ZLd+Kmz8yQvCoe5PtxHi3YVOTrRqLqR35riS5nNnQEmaB7oxSutJmu8Yp1QxbO0
         VYwSyOMqApVneGuwMnyFpkRhoYrw4f4o3qTiFcPNjoFfruttA7GcKo/HeXQz53ekYwl9
         IUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKTh0gc3ubHnFq3ryhGk+qxXRujaYZRfkDlvnNWYEvA=;
        b=K6ADUEyei/5Dd1EheRyHfPFxzOjFytLT+ffvB1u+THYgZiaekGKv2MP0t5XTgNkUrI
         wLbi8K74sWPb8TV6IsXH9M1CKZW0u8GgUOm/YYKCXNOgkOtkNB1ZTw9godqMFJDfx3xV
         s9FyhMxqgN7nyurl9FPOvmr9jLFhaV2PQKB2eKUE4h6R7OtNfgLOqsj/s9wg7AaOLf9Z
         ag86kjMHi67WnQpUmYcHnS5/+kRAUrlSjsqLAR7mOk94xthLwfxwkE2ngE2cn7c5ZG9Z
         V/JnvpNdv8MN46aHSNIflhd6iHsLrYdKsPbuAmQpsJogLtlDJ7KHifKK50LEKeXFghV3
         M7sQ==
X-Gm-Message-State: AJaThX71528w5iRNt7DxkElGRkAtDN9AFoOctRyYQO/R8efd1Uf0dbyR
        e/heKf/Uw9px8MN8976gmMLHnDIn
X-Google-Smtp-Source: AGs4zMZ4yQSsGM8rpLKbcu4AB8EAUZ6TV0BFUpL/leVyLvM7uK0dgD2eoG5Dl65wXoBQr1xZi+tCuw==
X-Received: by 10.36.230.3 with SMTP id e3mr20453399ith.15.1511213107825;
        Mon, 20 Nov 2017 13:25:07 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s16sm5393619itb.15.2017.11.20.13.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:25:07 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:25:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 4/8] connect: split ssh command line options into separate
 function
Message-ID: <20171120212505.5t6vzvkfvhmjqwsd@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git_connect function is growing long.  Split the portion that
discovers an ssh command and options it accepts before the service
name and path to a separate function to make it easier to read.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
As before.

 connect.c | 116 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/connect.c b/connect.c
index 9425229206..a9dc493db2 100644
--- a/connect.c
+++ b/connect.c
@@ -919,6 +919,65 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 	return conn;
 }
 
+/* Prepare a child_process for use by Git's SSH-tunneled transport. */
+static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
+			  const char *port, int flags)
+{
+	const char *ssh;
+	enum ssh_variant variant;
+
+	if (looks_like_command_line_option(ssh_host))
+		die("strange hostname '%s' blocked", ssh_host);
+
+	ssh = get_ssh_command();
+	if (ssh) {
+		variant = determine_ssh_variant(ssh, 1);
+	} else {
+		/*
+		 * GIT_SSH is the no-shell version of
+		 * GIT_SSH_COMMAND (and must remain so for
+		 * historical compatibility).
+		 */
+		conn->use_shell = 0;
+
+		ssh = getenv("GIT_SSH");
+		if (!ssh)
+			ssh = "ssh";
+		variant = determine_ssh_variant(ssh, 0);
+	}
+
+	argv_array_push(&conn->args, ssh);
+
+	if (variant == VARIANT_SSH &&
+	    get_protocol_version_config() > 0) {
+		argv_array_push(&conn->args, "-o");
+		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
+		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
+				 get_protocol_version_config());
+	}
+
+	if (variant != VARIANT_SIMPLE) {
+		if (flags & CONNECT_IPV4)
+			argv_array_push(&conn->args, "-4");
+		else if (flags & CONNECT_IPV6)
+			argv_array_push(&conn->args, "-6");
+	}
+
+	if (variant == VARIANT_TORTOISEPLINK)
+		argv_array_push(&conn->args, "-batch");
+
+	if (port && variant != VARIANT_SIMPLE) {
+		if (variant == VARIANT_SSH)
+			argv_array_push(&conn->args, "-p");
+		else
+			argv_array_push(&conn->args, "-P");
+
+		argv_array_push(&conn->args, port);
+	}
+
+	argv_array_push(&conn->args, ssh_host);
+}
+
 /*
  * This returns the dummy child_process `no_fork` if the transport protocol
  * does not need fork(2), or a struct child_process object if it does.  Once
@@ -972,16 +1031,13 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
-			const char *ssh;
-			enum ssh_variant variant;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
-
 			if (!port)
 				port = get_port(ssh_host);
-
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
@@ -995,57 +1051,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
-
-			if (looks_like_command_line_option(ssh_host))
-				die("strange hostname '%s' blocked", ssh_host);
-
-			ssh = get_ssh_command();
-			if (ssh) {
-				variant = determine_ssh_variant(ssh, 1);
-			} else {
-				/*
-				 * GIT_SSH is the no-shell version of
-				 * GIT_SSH_COMMAND (and must remain so for
-				 * historical compatibility).
-				 */
-				conn->use_shell = 0;
-
-				ssh = getenv("GIT_SSH");
-				if (!ssh)
-					ssh = "ssh";
-				variant = determine_ssh_variant(ssh, 0);
-			}
-
-			argv_array_push(&conn->args, ssh);
-
-			if (variant == VARIANT_SSH &&
-			    get_protocol_version_config() > 0) {
-				argv_array_push(&conn->args, "-o");
-				argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-						 get_protocol_version_config());
-			}
-
-			if (variant != VARIANT_SIMPLE) {
-				if (flags & CONNECT_IPV4)
-					argv_array_push(&conn->args, "-4");
-				else if (flags & CONNECT_IPV6)
-					argv_array_push(&conn->args, "-6");
-			}
-
-			if (variant == VARIANT_TORTOISEPLINK)
-				argv_array_push(&conn->args, "-batch");
-
-			if (port && variant != VARIANT_SIMPLE) {
-				if (variant == VARIANT_SSH)
-					argv_array_push(&conn->args, "-p");
-				else
-					argv_array_push(&conn->args, "-P");
-
-				argv_array_push(&conn->args, port);
-			}
-
-			argv_array_push(&conn->args, ssh_host);
+			fill_ssh_args(conn, ssh_host, port, flags);
 		} else {
 			transport_check_allowed("file");
 			if (get_protocol_version_config() > 0) {
-- 
2.15.0.448.gf294e3d99a

