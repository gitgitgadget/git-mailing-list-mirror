Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B9520285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbdHXWyC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:54:02 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35931 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdHXWyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:54:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id r133so4709182pgr.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LCdE3GMIp0WTWVakxyvomnC+7geRjXQhWmTsL3qpSmY=;
        b=Ws4ahdirYQeBEraAwPaVFcInqTdyRWlf7LQd7GrPHznMYduNof7HcY9Jb4XETORj40
         yfAdO6TXe6U29wXR5bdwENveKhslRYlm/x+cAa1LRvN3mXLkM10xflsCnimejQc7N5zX
         Rv6pIWPW5UgZ0f2feBwvBG30j9DtgROT43OhaySwwrhI1samjL/fA9BRw1zg2Cu96qtI
         pp027Uyqk56mBJXv9PAM4jlnF1R/1Rt8KuJeJWTZ7kvrAK75azS15CxjaWxDIW9g8Rn5
         QM/1sDts5eqAvbcIaRZkmmayhzinu64G3Oxam40d8F484qypdxPtnP8/z6pXgWmsIEUo
         m+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LCdE3GMIp0WTWVakxyvomnC+7geRjXQhWmTsL3qpSmY=;
        b=VeVtmv5g6Oi8E7pF/2btb37DrsBRMyfGwy1JDSi9e8yVsBfdLKDlxoc2hUus+ieXg/
         m3vwrSAGidiCJ42MaSLOy0eLZPCbuO7F8JgHrmYDQt7GcFz3AT813LIPYciDdCsUdacO
         qFKizDrkG5nfzrexRYp7pRaPDI363S92RJS6Ixz5FVJ6XH5Jn7D8LZ3j8TvS59WmagxM
         9CxQjUbTyU+rywkkll3ljymkpwLa8XsMqbjD85mThsFlSr8ta9rHEdaxjohT48MEV33z
         rEj87ZUA1t0a81uUO+CNPulQLZueoid36DnsTU/vZhXAhVtziH7kWy4TAWqO84IBCJXF
         3j4Q==
X-Gm-Message-State: AHYfb5jiZycGldLtHroYCNukZg/Jsh6wbFZM55pPu7p60Zq+/NYKltEn
        wogRZRjzeDP3wbhyQmVpPg==
X-Google-Smtp-Source: ADKCNb7FCj+exLTmmME1aTjXHm4A3qB+agKI6a8tadsbqncs8BC4WkSVXEIW3VKoZKBhv3EJuTV38g==
X-Received: by 10.84.139.36 with SMTP id 33mr8471654plq.20.1503615238944;
        Thu, 24 Aug 2017 15:53:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:53:58 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 3/7] protocol: tell server that the client understands v2
Date:   Thu, 24 Aug 2017 15:53:24 -0700
Message-Id: <20170824225328.8174-4-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the connection logic to tell a serve that it understands protocol
v2.  This is done in 2 different ways for the built in protocols.

1. git://
   A normal request is structured as "command path/to/repo\0host=..\0"
   and due to a bug in an old version of git-daemon 73bb33a94 (daemon:
   Strictly parse the "extra arg" part of the command, 2009-06-04) we
   aren't able to place any extra args (separated by NULs) besides the
   host.  In order to get around this limitation put protocol version
   information after a second NUL byte so the request is structured
   like: "command path/to/repo\0host=..\0\0version=2\0".  git-daemon can
   then parse out the version number and set GIT_PROTOCOL.

2. ssh://, file://
   Set GIT_PROTOCOL envvar with the desired protocol version.  The
   envvar can be sent across ssh by using '-o SendEnv=GIT_PROTOCOL' and
   having the server whitelist this envvar.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 31 ++++++++++++++++++++++++++-----
 daemon.c  | 28 +++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 49b28b83b..d609267be 100644
--- a/connect.c
+++ b/connect.c
@@ -793,6 +793,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
+		struct strbuf request = STRBUF_INIT;
 		/*
 		 * Set up virtual host information based on where we will
 		 * connect, unless the user has overridden us in
@@ -820,12 +821,23 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
-		packet_write_fmt(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
-			     target_host, 0);
+		strbuf_addf(&request,
+			    "%s %s%chost=%s%c",
+			    prog, path, 0,
+			    target_host, 0);
+
+		/* If using a new version put that stuff here after a second null byte */
+		strbuf_addch(&request, '\0');
+		strbuf_addf(&request, "version=%d%c", 2, '\0');
+		/* subsequent supported versions can also be added */
+		strbuf_addf(&request, "version=%d%c", 3, '\0');
+
+		packet_write(fd[1], request.buf, request.len);
+
 		free(target_host);
+		strbuf_release(&request);
 	} else {
+		const char *const *var;
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
 
@@ -837,7 +849,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		sq_quote_buf(&cmd, path);
 
 		/* remove repo-local variables from the environment */
-		conn->env = local_repo_env;
+		for (var = local_repo_env; *var; var++)
+			argv_array_push(&conn->env_array, *var);
+
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
@@ -890,6 +904,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			argv_array_push(&conn->args, ssh);
+
+			/* protocol v2! */
+			argv_array_push(&conn->args, "-o");
+			argv_array_push(&conn->args, "SendEnv=GIT_PROTOCOL");
+			argv_array_push(&conn->env_array, "GIT_PROTOCOL=2");
+
 			if (flags & CONNECT_IPV4)
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
@@ -904,6 +924,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			argv_array_push(&conn->args, ssh_host);
 		} else {
 			transport_check_allowed("file");
+			argv_array_push(&conn->env_array, "GIT_PROTOCOL=2");
 		}
 		argv_array_push(&conn->args, cmd.buf);
 
diff --git a/daemon.c b/daemon.c
index 30747075f..76a7b2d64 100644
--- a/daemon.c
+++ b/daemon.c
@@ -574,7 +574,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 /*
  * Read the host as supplied by the client connection.
  */
-static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
+static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
@@ -602,6 +602,22 @@ static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 		if (extra_args < end && *extra_args)
 			die("Invalid request");
 	}
+
+	return extra_args;
+}
+
+static void parse_extra_args(const char *extra_args, int buflen)
+{
+	const char *end = extra_args + buflen;
+
+	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
+		const char *arg = extra_args;
+		if (skip_prefix(arg, "version=", &arg))
+			fprintf(stderr, "VERSION=%s\n", arg);
+
+		fprintf(stderr, "%s\n", extra_args);
+
+	}
 }
 
 /*
@@ -716,8 +732,14 @@ static int execute(void)
 		pktlen--;
 	}
 
-	if (len != pktlen)
-		parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
+	if (len != pktlen) {
+		const char *extra_args;
+		/* retreive host */
+		extra_args = parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
+
+		/* determine version */
+		parse_extra_args(extra_args + 1, pktlen - (extra_args - line) - 1);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
-- 
2.14.1.342.g6490525c54-goog

