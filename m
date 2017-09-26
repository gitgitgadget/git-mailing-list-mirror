Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4B420281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032782AbdIZX45 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:57 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:52659 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032774AbdIZX4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:53 -0400
Received: by mail-pf0-f174.google.com with SMTP id p87so6323307pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voc6wZSr+tzlGZXQuIHyDHsgOZzzwM6V5ylRc5Vne30=;
        b=jLK+Zt7WaKUkXKkNugAifvFZOtAfMLSwAB0G/rVDsfY803sSnm53tRCuvJHBsYsYSn
         OSF7gYWnA225ROwt8p20X3uBvvK2j2IyISx3rdNxuI06h+og5I4HXUylQWY86vM7KIRG
         w2dX1zxV8XXDRBlxicytiFxkWSd+GXLDIeW496ha6v/cXMTUtokjlyy1yv2zUl7eOPX1
         H2wcek8tGYno8705jUb+FTmmynboZ7qUnuJCLMHNm2Lc9YpHlr8YhPqK6v4UZhHZAFKl
         miadhnek9m2zj4UYlCqW+0EROqu6OiwlY8/jhNrvKayyhk1mvuEYs0HD7TmF20mx1W8F
         u+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voc6wZSr+tzlGZXQuIHyDHsgOZzzwM6V5ylRc5Vne30=;
        b=glz6FmdCW8b6Kb0vH5LAWknSUZTyCpN6nC7eUiQSlnyuzBIApCu9EzEXnTz+WwWavg
         eEuRFyEfXuAsCZjDTIcrBhAqS+FHM2hmCa25fFTyORzUcAEcCzGbJWsFBPjo9Cg7nYm1
         kuC3pPNgAOmNgIWR6IhTf9F63GelbFgs6WPB1kS7BkvAkcv5ug7YqEIWTUR+vWfsLSTd
         LqvMVPyvivMEDJzdDrE19053Bp7JSBKupEYLdIEmcHGDpzaf4IEluMBcJmo0RhBSVWGg
         y8mEC7AgrZecoBnis/SpyEV+zVneUUJfXm6Y17Jmbe1vpp7CdNHuTT2pobwlKQnzl5yH
         4N8A==
X-Gm-Message-State: AHPjjUhglM7y+yi93qZd6cs0bb6d1f9kMG5gCSqTtE/BH4ltgqe7t5E3
        0PZ5EzB6H+Iqpqufd0WvMWoa34R+nLc=
X-Google-Smtp-Source: AOwi7QBb/ZUGtKAg2c0IIkT+Q+9i5NJ3eqp1+9RbVP/CkGNzrnjBrFiqhI6B0HZf/7Io+saGb2L1nQ==
X-Received: by 10.84.218.71 with SMTP id f7mr12048363plm.145.1506470212268;
        Tue, 26 Sep 2017 16:56:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 4/9] daemon: recognize hidden request arguments
Date:   Tue, 26 Sep 2017 16:56:22 -0700
Message-Id: <20170926235627.79606-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
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
 daemon.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index 30747075f..36cc794c9 100644
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
@@ -602,6 +611,43 @@ static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
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
@@ -695,6 +741,7 @@ static int execute(void)
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi;
+	struct argv_array env = ARGV_ARRAY_INIT;
 
 	hostinfo_init(&hi);
 
@@ -716,8 +763,9 @@ static int execute(void)
 		pktlen--;
 	}
 
+	/* parse additional args hidden behind a NUL byte */
 	if (len != pktlen)
-		parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
+		parse_extra_args(&hi, &env, line + len + 1, pktlen - len - 1);
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
@@ -730,13 +778,15 @@ static int execute(void)
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
2.14.1.992.g2c7b836f3a-goog

