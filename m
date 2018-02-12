Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9D91F404
	for <e@80x24.org>; Mon, 12 Feb 2018 03:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeBLDRH (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 22:17:07 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36839 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbeBLDRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 22:17:05 -0500
Received: by mail-it0-f66.google.com with SMTP id n206so4921597itg.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 19:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CHOkMzOQCpPF+wXZOzQ/mAifGVnVLi8UPWlnSbL/T98=;
        b=UFJ+E2k2fAve8tmLyYgDqIRmlCcrZziQ2jJvi0zFf/PD76bQ+QQ1JK1GR5b2yFTmlw
         5yYZt9JhLCLWnCL2ZLRQTDoAzUK92T3x4r/851KqOCL4ZqO67fV/q7eKh4jrvMuiqOYn
         nsyg/HN1qqoCL1XkZhlRlB39ptnXm6xQncxFq0cGjQ6zpxqV0uIEo0JUUXUHeYyd+EQD
         +A1gzoyBNMWNAy0ae5WBLCaZPu+k8nT4h0Hfw78l+A9XQsMnO+bbKPbjrtBCXBc9Szmo
         Ly9JoSvTEz1hIh+68MWqWo6ztm23VhJZEttvplJjiEczXg1e+pBoMmxgytY6YxPF9odk
         ugrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CHOkMzOQCpPF+wXZOzQ/mAifGVnVLi8UPWlnSbL/T98=;
        b=kLuiqDGd1+Fu1D4nb2EmAaMsnaFMh4ktpQjFGB5IceNzQQ+NqnrczMjb0eJeTyFvuy
         bhVsDz2GoWMsIX9zyN1VrOPNBZUtXult6B1qPi12RFrDXPEm3ygRvKZ669lN5rfgYUrf
         1zAzNzkE9WyGlRqVIzgArg1nG7wnMf/kiPjCJZtQ/3E9RGrbYRzN8a36uuIW0EYZl7SO
         LqoUuJohrK3NFv38gIgBGWrpsQVj0ypyMAqxoxNlGL/FURjakrQaHDFGJTyapUVpt9Kz
         61axKJODFGwj75NBk2WCLrM4kOx7qId0qE2oLrdrGjrFArMJLM+LVPdUU9IRjJHNLhLD
         ysWw==
X-Gm-Message-State: APf1xPAn6ET6tViAsidD3VQ06DU/tjQHEHVny/X6z6yFdpjJ4M/++6t+
        MOP+5O+Lo1PClCxxyg4r124yfQ==
X-Google-Smtp-Source: AH8x225b15RVFX/z3KRT3w0RSqll30eycybgwTqt5Q74Fzjn/Q2ouqQrFYgKqlH0W0Muu2keGn3pYg==
X-Received: by 10.36.43.20 with SMTP id h20mr4010758ita.42.1518405424182;
        Sun, 11 Feb 2018 19:17:04 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 15sm1754139itx.18.2018.02.11.19.17.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 11 Feb 2018 19:17:03 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] run-command: teach 'run_hook' about alternate worktrees
Date:   Sun, 11 Feb 2018 22:15:25 -0500
Message-Id: <20180212031526.40039-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180212031526.40039-1-sunshine@sunshineco.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git commands which run hooks do so at the top level of the worktree in
which the command itself was invoked. However, the 'git worktree'
command may need to run hooks within some other directory. For
instance, when "git worktree add" runs the 'post-checkout' hook, the
hook must be run within the newly-created worktree, not within the
worktree from which "git worktree add" was invoked.

To support this case, add 'run-hook' overloads which allow the
worktree directory to be specified.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 run-command.c | 23 +++++++++++++++++++++--
 run-command.h |  4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 31fc5ea86e..0e3995bbf9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1197,7 +1197,8 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-int run_hook_ve(const char *const *env, const char *name, va_list args)
+int run_hook_cd_ve(const char *dir, const char *const *env, const char *name,
+		   va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
@@ -1206,9 +1207,10 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	if (!p)
 		return 0;
 
-	argv_array_push(&hook.args, p);
+	argv_array_push(&hook.args, absolute_path(p));
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&hook.args, p);
+	hook.dir = dir;
 	hook.env = env;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
@@ -1216,6 +1218,23 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	return run_command(&hook);
 }
 
+int run_hook_ve(const char *const *env, const char *name, va_list args)
+{
+	return run_hook_cd_ve(NULL, env, name, args);
+}
+
+int run_hook_cd_le(const char *dir, const char *const *env, const char *name, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, name);
+	ret = run_hook_cd_ve(dir, env, name, args);
+	va_end(args);
+
+	return ret;
+}
+
 int run_hook_le(const char *const *env, const char *name, ...)
 {
 	va_list args;
diff --git a/run-command.h b/run-command.h
index 3932420ec8..8beddffea8 100644
--- a/run-command.h
+++ b/run-command.h
@@ -66,7 +66,11 @@ int run_command(struct child_process *);
 extern const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
 extern int run_hook_le(const char *const *env, const char *name, ...);
+extern int run_hook_cd_le(const char *dir, const char *const *env,
+			  const char *name, ...);
 extern int run_hook_ve(const char *const *env, const char *name, va_list args);
+extern int run_hook_cd_ve(const char *dir, const char *const *env,
+			  const char *name, va_list args);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
-- 
2.16.1.291.g4437f3f132

