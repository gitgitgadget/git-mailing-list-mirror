Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D9120437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbdJPRz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:57 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:48535 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753676AbdJPRzu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:50 -0400
Received: by mail-it0-f52.google.com with SMTP id c3so2276521itc.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHqlIdSuv2YjxPONq8cvlSb+dmsQAztYTFiccf+DNLI=;
        b=A2S/thPRz7fMKVOfxoG5E0TE4aKd74G6cS8ucHhMLSfaBdUh9DRfnQea4fV/k13VYL
         kwmJAHM8nin8Zmf542AtiJKG7RrMofdqpHYh9Sb/BWmKH+AJYV++Vswnjop4LMWcMfVM
         D2/2iDxJ1Bn0q0eS8m58oXc4IqeQpsX40TMJihh4HO5EYo6FfWbM5JEnSiaM6JgH7vyF
         I4MfLjkNhlU5YKcD0ON+F4LNDKuNETeOxGZwKzEKK97yCsK/UySJ+hav8LdWdQ0Jk0Wk
         fC+6LwudLDtsa+iMu6bjX7v0aeGU7bpOQ3bjRbc7aIkdDMj1W8q8ZvjVXdrjMUgHr0pd
         TfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHqlIdSuv2YjxPONq8cvlSb+dmsQAztYTFiccf+DNLI=;
        b=NVLGMqgRE4uR0e4erdibB+JIcwxd0nxWfTcKMNY1hH65D4hwLeP1bOs19TQpIOsuDZ
         H3z5Txx/1FMHEDPR2S0TpBsTJA+QtVauM2JN++T1pw8HDb0JKQlBFoFrOxkLU8JEj/7q
         zOk0T39X1G4BVxEDDEnNEIAK1iSl6yk6w6KfXTLQS67leN2Y7Fl1p5xGTv/Xm9Menwo1
         JqjvqEnqd8RyxV/Wj0Tvfdlo8ko49vU9fBNxhtzP27U2Hutqgu11ijZ/CePpat+Ulvhk
         OMqKrbfTFTz1AT2TcV/s2RXB3itleN3No4KO0+euQctD7lOKU1OjwCkgEcSwlysatVJA
         bK5Q==
X-Gm-Message-State: AMCzsaX1OMxnSkKw8dlMJZV18dJVLr5KRwk/nUoN5vSUV9A2xHN7DJsv
        q7J6cTRWW+jWBf79d4lW5RA/5I5NKA8=
X-Google-Smtp-Source: ABhQp+QNi3/BVDvf5U7PnEwNvXarUZN1Zd2IV69VdUSSWa1ofhQgpbNEl3UAaYUT1CIQkrYVioJkrg==
X-Received: by 10.36.105.17 with SMTP id e17mr2360985itc.46.1508176549274;
        Mon, 16 Oct 2017 10:55:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 04/11] daemon: recognize hidden request arguments
Date:   Mon, 16 Oct 2017 10:55:25 -0700
Message-Id: <20171016175532.73459-5-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A normal request to git-daemon is structured as
"command path/to/repo\0host=..\0" and due to a bug introduced in
49ba83fb6 (Add virtualization support to git-daemon, 2006-09-19) we
aren't able to place any extra arguments (separated by NULs) besides the
host otherwise the parsing of those arguments would enter an infinite
loop.  This bug was fixed in 73bb33a94 (daemon: Strictly parse the
"extra arg" part of the command, 2009-06-04) but a check was put in
place to disallow extra arguments so that new clients wouldn't trigger
this bug in older servers.

In order to get around this limitation teach git-daemon to recognize
additional request arguments hidden behind a second NUL byte.  Requests
can then be structured like:
"command path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
can then parse out the extra arguments and set 'GIT_PROTOCOL'
accordingly.

By placing these extra arguments behind a second NUL byte we can skirt
around both the infinite loop bug in 49ba83fb6 (Add virtualization
support to git-daemon, 2006-09-19) as well as the explicit disallowing
of extra arguments introduced in 73bb33a94 (daemon: Strictly parse the
"extra arg" part of the command, 2009-06-04) because both of these
versions of git-daemon check for a single NUL byte after the host
argument before terminating the argument parsing.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 daemon.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index 30747075f..e37e343d0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -282,7 +282,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-typedef int (*daemon_service_fn)(void);
+typedef int (*daemon_service_fn)(const struct argv_array *env);
 struct daemon_service {
 	const char *name;
 	const char *config_name;
@@ -363,7 +363,7 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
 }
 
 static int run_service(const char *dir, struct daemon_service *service,
-		       struct hostinfo *hi)
+		       struct hostinfo *hi, const struct argv_array *env)
 {
 	const char *path;
 	int enabled = service->enabled;
@@ -422,7 +422,7 @@ static int run_service(const char *dir, struct daemon_service *service,
 	 */
 	signal(SIGTERM, SIG_IGN);
 
-	return service->fn();
+	return service->fn(env);
 }
 
 static void copy_to_log(int fd)
@@ -462,25 +462,34 @@ static int run_service_command(struct child_process *cld)
 	return finish_command(cld);
 }
 
-static int upload_pack(void)
+static int upload_pack(const struct argv_array *env)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
 	argv_array_pushl(&cld.args, "upload-pack", "--strict", NULL);
 	argv_array_pushf(&cld.args, "--timeout=%u", timeout);
+
+	argv_array_pushv(&cld.env_array, env->argv);
+
 	return run_service_command(&cld);
 }
 
-static int upload_archive(void)
+static int upload_archive(const struct argv_array *env)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
 	argv_array_push(&cld.args, "upload-archive");
+
+	argv_array_pushv(&cld.env_array, env->argv);
+
 	return run_service_command(&cld);
 }
 
-static int receive_pack(void)
+static int receive_pack(const struct argv_array *env)
 {
 	struct child_process cld = CHILD_PROCESS_INIT;
 	argv_array_push(&cld.args, "receive-pack");
+
+	argv_array_pushv(&cld.env_array, env->argv);
+
 	return run_service_command(&cld);
 }
 
@@ -573,8 +582,11 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 
 /*
  * Read the host as supplied by the client connection.
+ *
+ * Returns a pointer to the character after the NUL byte terminating the host
+ * arguemnt, or 'extra_args' if there is no host arguemnt.
  */
-static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
+static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
@@ -602,6 +614,43 @@ static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 		if (extra_args < end && *extra_args)
 			die("Invalid request");
 	}
+
+	return extra_args;
+}
+
+static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
+			     char *extra_args, int buflen)
+{
+	const char *end = extra_args + buflen;
+	struct strbuf git_protocol = STRBUF_INIT;
+
+	/* First look for the host argument */
+	extra_args = parse_host_arg(hi, extra_args, buflen);
+
+	/* Look for additional arguments places after a second NUL byte */
+	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
+		const char *arg = extra_args;
+
+		/*
+		 * Parse the extra arguments, adding most to 'git_protocol'
+		 * which will be used to set the 'GIT_PROTOCOL' envvar in the
+		 * service that will be run.
+		 *
+		 * If there ends up being a particular arg in the future that
+		 * git-daemon needs to parse specificly (like the 'host' arg)
+		 * then it can be parsed here and not added to 'git_protocol'.
+		 */
+		if (*arg) {
+			if (git_protocol.len > 0)
+				strbuf_addch(&git_protocol, ':');
+			strbuf_addstr(&git_protocol, arg);
+		}
+	}
+
+	if (git_protocol.len > 0)
+		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
+				 git_protocol.buf);
+	strbuf_release(&git_protocol);
 }
 
 /*
@@ -695,6 +744,7 @@ static int execute(void)
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi;
+	struct argv_array env = ARGV_ARRAY_INIT;
 
 	hostinfo_init(&hi);
 
@@ -716,8 +766,9 @@ static int execute(void)
 		pktlen--;
 	}
 
+	/* parse additional args hidden behind a NUL byte */
 	if (len != pktlen)
-		parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
+		parse_extra_args(&hi, &env, line + len + 1, pktlen - len - 1);
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
@@ -730,13 +781,15 @@ static int execute(void)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			int rc = run_service(arg, s, &hi);
+			int rc = run_service(arg, s, &hi, &env);
 			hostinfo_clear(&hi);
+			argv_array_clear(&env);
 			return rc;
 		}
 	}
 
 	hostinfo_clear(&hi);
+	argv_array_clear(&env);
 	logerror("Protocol error: '%s'", line);
 	return -1;
 }
-- 
2.15.0.rc0.271.g36b669edcc-goog

