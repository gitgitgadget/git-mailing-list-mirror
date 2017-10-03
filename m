Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E4F2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdJCUPd (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:33 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:51134 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdJCUPb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:31 -0400
Received: by mail-pf0-f170.google.com with SMTP id m63so5133649pfk.7
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Exr6NgxJwmjD2gy0Pj045ukJ+HNrbJ9ZZjkwdZEE85Y=;
        b=h2I0q7iyqJ5owmINn3C8UJK9/VX+DdZQUNr4AX401B7Lqyj8IzW4qwCxG1IMBHHyMt
         p8uE7pkIxEWW5M482mf3cHOvc0rPcr2qsNnCAn+joiXXk3aiVjKITEOEBML+/3JPqcdH
         lBVeNXhN7mBo7xC+XVhzZ367NiiNwBMejBoA9XXOOasKsp0HQ9ZCjGNTiXo2RcTHbrmk
         Qo0Vj8E5k9v+/fQjVsHPyrIFlbwRobzhDPjVIV5p0XQtV/4DBbcsvact7Y+Sc5SuU45G
         q/GXyaxgd+9/TKoigtQypfIImXG27NOXeH8lKmgq83l42aokBgVXUZ48QxqP2CQr4Rcr
         Tz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Exr6NgxJwmjD2gy0Pj045ukJ+HNrbJ9ZZjkwdZEE85Y=;
        b=TDDqku5a5oKouCoPH/uMuydUN6S6aWgUG800D/9ViQooySENpGqPuqQCXkW8c7fGTy
         UM3nsZbKMJkbpPrf+iVLfiIV7MXT+Yh7m26HuP31lDUZNmy0u53gHt7Kpr3YBo/Ex/Xg
         V81QzXhiTsgC8xqioN9unzcbe7Fl2hvzka++60c+pEf0NrHG43nTLyaUr0KPx+hwPBG6
         LdyjYm8t3lDutgdq3DsrWLHVY1kIlBptccrbj/xDljs+xtHlnCqPG7bINwj1y8oULD8o
         ZwCRJtpwOT59MYVZN2+8s2jE73QhY4hQyYU37+9vkP7Wd3K+lslyDCztElyV4aT49lGX
         TCDw==
X-Gm-Message-State: AMCzsaXecZzXTnUSfxlPAr6VOqPO3mueaFJCNnHFQEJKNxYH9MtbkLao
        jHteHUdZrZT3QcWH7YqqSR7INBNon1c=
X-Google-Smtp-Source: AOwi7QDJ4FlWMDkGGV+RV8xiZaRmEIIRSTDxurkRYhZD+FApMBm7Do3Qk67BR8VB8ty4ipGGmGnMNg==
X-Received: by 10.98.51.70 with SMTP id z67mr1129372pfz.301.1507061729531;
        Tue, 03 Oct 2017 13:15:29 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 04/10] daemon: recognize hidden request arguments
Date:   Tue,  3 Oct 2017 13:15:01 -0700
Message-Id: <20171003201507.3589-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
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
2.14.2.920.gcf0c67979c-goog

