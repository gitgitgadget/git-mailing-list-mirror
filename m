Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D810A1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 10:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeAJKsq (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 05:48:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37876 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeAJKsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 05:48:43 -0500
Received: by mail-pl0-f67.google.com with SMTP id s3so7039520plp.4
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 02:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Scm7wJ7aC33MDqzVa0hzBWnZZpOXKj+2sQrWvR1Ckrc=;
        b=kKOjlcTReb5l/xLS1G80ZY4t7gCzzcG6Vm1fa0PR3fk6lFX+OYqrjDmCeQQXThgVhm
         1o2yq+cBww0MI0HV1UqMufZ5CZcPgueR/CK8LWAt8/xDRKFYwmkE4e3hysCj6iVYGKtu
         Tz3TAuur7pQYGo1hMNoNddGftywpxmjSm4ti1zG5SlRjyhl88AW7ZxE4bDAnI1qljwcX
         GyZs0U1l3Qar8EaG9Gd7KnCRBhY4PkAXGY1GgnbiDGN8JYUL8Sd0aVjy0c+bqEQTGRBC
         v1S72ZZEvRiit+JTwZZDsGsIYVs64HpXvgHYoT2TviSmGS34q4tnt9Zil0+jCHaBgOax
         G1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Scm7wJ7aC33MDqzVa0hzBWnZZpOXKj+2sQrWvR1Ckrc=;
        b=Ev9WH7ZV1HLzzE2PNVGIWjK3N48BkBzMFPG6YbEVyNBVpjW6ZVzzeRXybVAx/sTi4E
         7iVd7WOLkyfSPDBObn/tyvBridUpIdAUHrb92B/29GN2DeKkcWc3kWPHCAsLKT2Zr5QO
         FsaqV+WgA8dh21zlojcPGArfwJ28oWogzIPQJAWthtUpj+dlVnBQq7F8roHWqzKbf0nX
         NiVf+7l9P6sSWcJpqi5P2xy2IBRcsUajOWqlR9pzuvqNMQlcHWttO7cRsk069KDaJZmW
         dGcZk6J72Doj+1JO5vgim3cN5oCKnbsn6wXzUgYWvS6WFzXdWmCfdkXcA6qKVFD5eeoy
         p/SA==
X-Gm-Message-State: AKGB3mLacRE/oQldCRmvAOJ6PoNs82pgKV5AQ1i+0Q0OnVqVBbvjAf8n
        SThkWPBXpobE5sYYsNJvldg0Wg==
X-Google-Smtp-Source: ACJfBot5KFHUd7UDshigE2Hbkayr+t+6pvGrKHmI7CbVtd/YIwrbiklRgCAdVD9BXl8ON4fP0al8rw==
X-Received: by 10.84.244.135 with SMTP id h7mr13907592pll.222.1515581322976;
        Wed, 10 Jan 2018 02:48:42 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id v23sm33473522pfe.72.2018.01.10.02.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 02:48:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 10 Jan 2018 17:48:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] run-command.c: print env vars when GIT_TRACE is set
Date:   Wed, 10 Jan 2018 17:48:35 +0700
Message-Id: <20180110104835.22905-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally submodule code could execute new commands with GIT_DIR set
to some submodule. GIT_TRACE prints just the command line which makes it
hard to tell that it's not really executed on this repository.

Print env variables in this case. Note that the code deliberately ignore
variables unsetting because there are so many of them (to keep git
environment clean for the next process) and really hard to read.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 A minor thing that I ignored in this patch is quoting the environment
 variables. For me it's meh. Perhaps I should just dumb the env
 without quoting at all.

 run-command.c |  3 ++-
 trace.c       | 38 +++++++++++++++++++++++++++++++++++---
 trace.h       | 18 +++++++++++++++---
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 31fc5ea86e..235367087d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -624,7 +624,8 @@ int start_command(struct child_process *cmd)
 		cmd->err = fderr[0];
 	}
 
-	trace_argv_printf(cmd->argv, "trace: run_command:");
+	trace_env_argv_printf(cmd->env, cmd->argv, "trace: run_command:");
+
 	fflush(NULL);
 
 #ifndef GIT_WINDOWS_NATIVE
diff --git a/trace.c b/trace.c
index b7530b51a9..d8967b66e8 100644
--- a/trace.c
+++ b/trace.c
@@ -146,7 +146,26 @@ static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
 	print_trace_line(key, &buf);
 }
 
+static void concatenate_env(struct strbuf *dst, const char *const *env)
+{
+	int i;
+
+	/* Copy into destination buffer. */
+	strbuf_grow(dst, 255);
+	for (i = 0; env[i]; ++i) {
+		/*
+		 * the main interesting is setting new vars
+		 * e.g. GIT_DIR, ignore the unsetting to reduce noise.
+		 */
+		if (!strchr(env[i], '='))
+			continue;
+		strbuf_addch(dst, ' ');
+		sq_quote_buf(dst, env[i]);
+	}
+}
+
 static void trace_argv_vprintf_fl(const char *file, int line,
+				  const char *const *env,
 				  const char **argv, const char *format,
 				  va_list ap)
 {
@@ -157,6 +176,9 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	strbuf_vaddf(&buf, format, ap);
 
+	if (env)
+		concatenate_env(&buf, env);
+
 	sq_quote_argv(&buf, argv, 0);
 	print_trace_line(&trace_default_key, &buf);
 }
@@ -214,7 +236,16 @@ void trace_argv_printf(const char **argv, const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_argv_vprintf_fl(NULL, 0, argv, format, ap);
+	trace_argv_vprintf_fl(NULL, 0, NULL, argv, format, ap);
+	va_end(ap);
+}
+
+void trace_env_argv_printf(const char *const *env, const char **argv,
+			   const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	trace_argv_vprintf_fl(NULL, 0, env, argv, format, ap);
 	va_end(ap);
 }
 
@@ -251,12 +282,13 @@ void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 	va_end(ap);
 }
 
-void trace_argv_printf_fl(const char *file, int line, const char **argv,
+void trace_argv_printf_fl(const char *file, int line,
+			  const char *const *env, const char **argv,
 			  const char *format, ...)
 {
 	va_list ap;
 	va_start(ap, format);
-	trace_argv_vprintf_fl(file, line, argv, format, ap);
+	trace_argv_vprintf_fl(file, line, env, argv, format, ap);
 	va_end(ap);
 }
 
diff --git a/trace.h b/trace.h
index 88055abef7..830d9dcd19 100644
--- a/trace.h
+++ b/trace.h
@@ -34,6 +34,10 @@ extern void trace_printf_key(struct trace_key *key, const char *format, ...);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 
+__attribute__((format (printf, 3, 4)))
+extern void trace_env_argv_printf(const char * const*env, const char **argv,
+				  const char *format, ...);
+
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
 /* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
@@ -93,7 +97,14 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 	do {								    \
 		if (trace_pass_fl(&trace_default_key))			    \
 			trace_argv_printf_fl(TRACE_CONTEXT, __LINE__,	    \
-					    argv, __VA_ARGS__);		    \
+					     NULL, argv, __VA_ARGS__);	    \
+	} while (0)
+
+#define trace_env_argv_printf(env, argv, ...)				    \
+	do {								    \
+		if (trace_pass_fl(&trace_default_key))			    \
+			trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, 	    \
+					     env, argv, __VA_ARGS__); 	    \
 	} while (0)
 
 #define trace_strbuf(key, data)						    \
@@ -121,8 +132,9 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 __attribute__((format (printf, 4, 5)))
 extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 				const char *format, ...);
-__attribute__((format (printf, 4, 5)))
-extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
+__attribute__((format (printf, 5, 6)))
+extern void trace_argv_printf_fl(const char *file, int line,
+				 const char *const *env, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
-- 
2.15.1.600.g899a5f85c6

