Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9D920286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdIMVzM (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:12 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:46821 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdIMVzG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:06 -0400
Received: by mail-pg0-f45.google.com with SMTP id i130so2814972pgc.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fegXSvDvXkgaaozfDBBfYrKUkzygTqDNGOXicgkKWEo=;
        b=EmTiWkzW+Ye/oEUMXQuZIsGG4OC80lBr3GlBFcc94B2OdeG4iwFXO7ufMxm0MOlFyQ
         71Txz760QJcf/wXZlUKWyLWa/Qw059Dt88PoSOg8Gman18mUCBlmULtgN0h9ehPGeLUl
         Ib8xwA4ODqZMNJ6DrEuYQ4W9MiYlrGlp6/PmPpCTXkhLlSXwgFn7J2eopOaAGOmPk70m
         E9dW4b1zXJ7e5Mv2Zej4qfrfmiySuYeTmzclDoTWuTfQYcEEvTlj5Wa8mxmQGljOmtgh
         tKE8UslCCnU7zAyDli2xXhTXEGV+cFu1LU6K/1yNLCZ7qn7OoP567KAHgyxhyzRitcyU
         mIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fegXSvDvXkgaaozfDBBfYrKUkzygTqDNGOXicgkKWEo=;
        b=Lc6TH6ANedWlZTsgPYDZl6uBlaR0/ePRsL/bN0QFT9gRRsPOfNDjLJFNhA8giCW4iK
         LBB1Z0pmyHVo7bJly6mmJvgnbkORosp3Xc7k8kZ774alTqqwCb5LDx2p4NKuxaRoOjTz
         umCHZy3/8GrJ5d4Ngsopvlj5PbmKBWE2hQ/4HV1XVf+0Oi4aFLOqu3rdSvrY4EdY3VA5
         En9WzvBQbxFvqLyOuj6XvJyvEo/EVMZia7gPshdMFHadhs6khn3FvxQtrjZXzvKe2dUO
         31DXwjxhGHOFIrTq9oWe/M9qE31a6gJtf2HQ1fj1gdywJn609hVL9/gowKIokziVy/3z
         9Udg==
X-Gm-Message-State: AHPjjUhz8xqA9ptAiP/MLNX5wJXP1U3MYFQORJHcqh9G2zSynUaIyASJ
        cBQYQcF3Ws9LHsJw3ZtxDg==
X-Google-Smtp-Source: ADKCNb4HOPUca2i8Vk61nPTWmF5envvAicKuNmIrZBAkzKop9x1YpHi8xtc0zooq2A+aFj1LCbhS1g==
X-Received: by 10.99.1.10 with SMTP id 10mr18837184pgb.377.1505339704716;
        Wed, 13 Sep 2017 14:55:04 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/8] daemon: recognize hidden request arguments
Date:   Wed, 13 Sep 2017 14:54:43 -0700
Message-Id: <20170913215448.84674-4-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A normal request to git-daemon is structured as
"command path/to/repo\0host=..\0" and due to a bug in an old version of
git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
command, 2009-06-04) we aren't able to place any extra args (separated
by NULs) besides the host.

In order to get around this limitation teach git-daemon to recognize
additional request arguments hidden behind a second NUL byte.  Requests
can then be structured like:
"command path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
can then parse out the extra arguments and set 'GIT_PROTOCOL'
accordingly.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 daemon.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/daemon.c b/daemon.c
index 30747075f..250dbf82c 100644
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
 
@@ -574,7 +583,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 /*
  * Read the host as supplied by the client connection.
  */
-static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
+static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
@@ -602,6 +611,39 @@ static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 		if (extra_args < end && *extra_args)
 			die("Invalid request");
 	}
+
+	return extra_args;
+}
+
+static void parse_extra_args(struct argv_array *env, const char *extra_args,
+			     int buflen)
+{
+	const char *end = extra_args + buflen;
+	struct strbuf git_protocol = STRBUF_INIT;
+
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
@@ -695,6 +737,7 @@ static int execute(void)
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi;
+	struct argv_array env = ARGV_ARRAY_INIT;
 
 	hostinfo_init(&hi);
 
@@ -716,8 +759,14 @@ static int execute(void)
 		pktlen--;
 	}
 
-	if (len != pktlen)
-		parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
+	if (len != pktlen) {
+		const char *extra_args;
+		/* retrieve host */
+		extra_args = parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
+
+		/* parse additional args hidden behind a second NUL byte */
+		parse_extra_args(&env, extra_args + 1, pktlen - (extra_args - line) - 1);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
@@ -730,13 +779,15 @@ static int execute(void)
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
2.14.1.690.gbb1197296e-goog

