Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB71202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdJWXRh (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:17:37 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:52021 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJWXRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:17:36 -0400
Received: by mail-io0-f194.google.com with SMTP id b186so21942951iof.8
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IW9uSpvqCO6ij7WfI/S67VOq0Jp1Ujvjk8sWuQfdLDM=;
        b=JsJKJdWMKTyXhUDSt31pSenhvC+w3b+lUHY39Cxj2B7BUU9TH/akRmP2Y/JSFknlMw
         Q14xPy5BbF6hmto57j1vwZBV0hsZXcuUsQeCrJ2ke+117G/MYF1WcjV9xTqVfeeeKnrW
         EjQZlolLJHN8ItdOmcubv8a6dx3n3ktrd4c6DlulVCgAbJlOFj1ZM4opSJFnNCEmgebf
         l6qbMhOTnZ9hwCmoyQqdUEHl2MWNdJ6OkgV3qmLCIXxvw+mE01pGbGcmXoiXxJI0mVFb
         W/EW+BM0SXAL+7Wb/0nIuwCU7j8NBOCBid6D4XGCja+QMHQkiI5vnQjBihCdiJhyNhKy
         VNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IW9uSpvqCO6ij7WfI/S67VOq0Jp1Ujvjk8sWuQfdLDM=;
        b=cWkDeAYlxbDKn/MBcFJLmg1ruTEZVz9q6EF+JqS8AFoq+kY6z8KORVuerlRapt3poe
         mCCzjl+0P63G+xuTcSD59dHrV9Zglubpg6Q9cy5cNSN1ncm84mOzV+k3HYDzSKKT+nD8
         +yZIPmwuUMxh49uZkmiVIBaxa29lLhsqfENa71/bxYAf7IkSCHNDgGQBkPwS0rb4UUkq
         wp7VHuAqgMfdW6CQDdpCyLBVutSZb7397EzOh8GhuClQN7YNPFhxClIkIL5z2Amx5CGo
         wzQ14xPFwyla5PRTpoIdgREukABv/KEETfG1LuEJrbiCNdFmNLEKkLl5El55wGhHgrhu
         PuyQ==
X-Gm-Message-State: AMCzsaWAI7+1k2Pz7Bl9k4TNt1avcP+QSob6JZXguu/gokhvik9Zainh
        iKnnr0TvlrxKF8HtbgM4kmk=
X-Google-Smtp-Source: ABhQp+SEsxvVuGIFMoznS6c53Vd1ic1uvJrZnAVfXgfprf/SN+JCCZlB40DLcpVzXr62EV+8Y5/R5g==
X-Received: by 10.107.68.10 with SMTP id r10mr19350507ioa.202.1508800655917;
        Mon, 23 Oct 2017 16:17:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b12sm3634945iob.6.2017.10.23.16.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 16:17:35 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:17:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: [PATCH 2/5] connect: split ssh command line options into separate
 function
Message-ID: <20171023231733.tattcu2aws7kgous@aiede.mtv.corp.google.com>
References: <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
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
As before, except for the Reviewed-by.

 connect.c | 116 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/connect.c b/connect.c
index 068e70caad..77ab6db3bb 100644
--- a/connect.c
+++ b/connect.c
@@ -908,6 +908,65 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
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
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -961,16 +1020,13 @@ struct child_process *git_connect(int fd[2], const char *url,
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
@@ -984,57 +1040,7 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.15.0.rc1.287.g2b38de12cc-goog

