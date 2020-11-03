Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E520C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384F922268
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZ1Dgy32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgKCA1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCA1L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:27:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B18C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 16:27:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j19so15991943ybg.6
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JvrsL1CcVJLTqs272iqMdhgxjX9sVSShYbAQ9uxiXgc=;
        b=cZ1Dgy32E3Mon5rK5Uhg9axw0O6EaILEGtHZga39wM0l1MXPpzvYTMKEdExGxJZs44
         v4sQzIp1aH6gTBJ71gGSef9vjLCRkZ3+GSwKduAl7418RT6TlxJe7scqjBvgSdMwH7ry
         kcTTbN6q7s8pbdRWDQcOqunIpVmYxuTt4RCghDDG5A+aOOv3l7ElDGwIXPpZpjGrjHGp
         NZOstWOSJE9f3MBHIBxT6LAtRwdgMvji1Urh1wDapsaImBTNK0wNZLnF8MTUPy9XFoB0
         X6voJThuRu0XmfRSyL8OmgJzPu1t3rfhNgysnRlzJDu3q6h/opeGoLRFahjOb241SYcL
         liIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JvrsL1CcVJLTqs272iqMdhgxjX9sVSShYbAQ9uxiXgc=;
        b=MqYm2ndc1UZUf+iiiNaeAKcvUh9oe/YoMm1TEmzKBdwOndyVYvyDMWWW6PI1mZlclI
         rJ0PtjDE2upN1mmV+Tl5wq7sLEEUGrPNzL3sQIEFGQwQtikrAZBsgXEDcMzeblJ5gm1J
         1jWemJkzK8DWaqGLGIn+rdxxrdjUVY0bcqexEz+XzVPoI+VoGwFm2BGkEOa8pjjwxWg/
         q3D0mQUc58stD71jlee13WIgCFGbB6EM7BfdfqlpWfP5n89INurGYmLAeVkffaBD5/hj
         NiElLKnWOhnSYii+0GWBn7OjSxo/KF6e4QF2wf42OzIwA/fRphGlStNOvAQmMb39s+7J
         h3uQ==
X-Gm-Message-State: AOAM532uwGbu0pjH7PETKL/o/Lbvlhh6+MyZSLCLE/Ew8gD4NMlXTHEI
        jxT3vypc9AHnno3KDeSArz4FClx7BGkeKNMmMW1qaQVKqilyyZMsDPVsBTfCM3Vbe931YjyiY7K
        fD21DYVqX96z5CP0jUqQ8hYlDRpvqjmBcn/fiM69S4d7dIIxH9ujX5QfTH1hnz8cUiBNVxuT0hc
        E2
X-Google-Smtp-Source: ABdhPJzTQGlM1vtcHLkNke/PFlicGR7Bt5KUzG+Qr8xqdzCRs8YAKKA8ilDVfbq4Y9mhAK6hRBebmvQhuSQ2PPQ2911C
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:dc3:: with SMTP id
 186mr25946535ybn.207.1604363230136; Mon, 02 Nov 2020 16:27:10 -0800 (PST)
Date:   Mon,  2 Nov 2020 16:26:10 -0800
In-Reply-To: <cover.1604362701.git.jonathantanmy@google.com>
Message-Id: <7893cfba05a663370f353cdf60aa1df24b386c04.1604362701.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1604362701.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 1/4] connect: refactor building of Extra Parameters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build the Extra Parameters string ("version=%d") in only one place
(git_connect()) instead of two (git_connect() and push_ssh_options()).
This is in preparation for a subsequent patch, which will change how the
Extra Parameters are built.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 connect.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index 8b8f56cf6d..5221f1764c 100644
--- a/connect.c
+++ b/connect.c
@@ -1201,14 +1201,13 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
  */
 static void push_ssh_options(struct strvec *args, struct strvec *env,
 			     enum ssh_variant variant, const char *port,
-			     enum protocol_version version, int flags)
+			     const char *extra_parameters, int flags)
 {
-	if (variant == VARIANT_SSH &&
-	    version > 0) {
+	if (variant == VARIANT_SSH && extra_parameters) {
 		strvec_push(args, "-o");
 		strvec_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
-		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-			     version);
+		strvec_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
+			     extra_parameters);
 	}
 
 	if (flags & CONNECT_IPV4) {
@@ -1261,7 +1260,7 @@ static void push_ssh_options(struct strvec *args, struct strvec *env,
 
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
-			  const char *port, enum protocol_version version,
+			  const char *port, const char *extra_parameters,
 			  int flags)
 {
 	const char *ssh;
@@ -1296,14 +1295,14 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 		strvec_push(&detect.args, ssh);
 		strvec_push(&detect.args, "-G");
 		push_ssh_options(&detect.args, &detect.env_array,
-				 VARIANT_SSH, port, version, flags);
+				 VARIANT_SSH, port, extra_parameters, flags);
 		strvec_push(&detect.args, ssh_host);
 
 		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
 	strvec_push(&conn->args, ssh);
-	push_ssh_options(&conn->args, &conn->env_array, variant, port, version, flags);
+	push_ssh_options(&conn->args, &conn->env_array, variant, port, extra_parameters, flags);
 	strvec_push(&conn->args, ssh_host);
 }
 
@@ -1352,6 +1351,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
+		struct strbuf extra_parameters = STRBUF_INIT;
 
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
@@ -1367,6 +1367,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		for (var = local_repo_env; *var; var++)
 			strvec_push(&conn->env_array, *var);
 
+		if (version > 0)
+			strbuf_addf(&extra_parameters, "version=%d", version);
+
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
@@ -1392,15 +1395,16 @@ struct child_process *git_connect(int fd[2], const char *url,
 				return NULL;
 			}
 			conn->trace2_child_class = "transport/ssh";
-			fill_ssh_args(conn, ssh_host, port, version, flags);
+			fill_ssh_args(conn, ssh_host, port,
+				      extra_parameters.len ? extra_parameters.buf : NULL,
+				      flags);
 		} else {
 			transport_check_allowed("file");
 			conn->trace2_child_class = "transport/file";
-			if (version > 0) {
+			if (extra_parameters.len)
 				strvec_pushf(&conn->env_array,
-					     GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-					     version);
-			}
+					     GIT_PROTOCOL_ENVIRONMENT "=%s",
+					     extra_parameters.buf);
 		}
 		strvec_push(&conn->args, cmd.buf);
 
@@ -1409,6 +1413,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		fd[0] = conn->out; /* read from child's stdout */
 		fd[1] = conn->in;  /* write to child's stdin */
+		strbuf_release(&extra_parameters);
 		strbuf_release(&cmd);
 	}
 	free(hostandport);
-- 
2.29.1.341.ge80a0c044ae-goog

