Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43659C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE38820658
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRRMkDfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCTVGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:06:22 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33398 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTVGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:06:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id o5so5583620pfp.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=Z3X5jepr9ZsL3b2PaimJOOqjf9WC9jdmo+ag1x21hLE=;
        b=kRRMkDfBDF50p75rBoCrLB8MgGGDiqbNovgyw5Al47ifkIwe5Prir3wInz/Q6/s7X+
         H9XvbrNC6dQoZ2AUUatLa35lDJBrXFKeLKrmwflFvvJXtCvkYjffSnHZNcRiVeKVmBA6
         oSq5ZjlSptzLCHhgiJ/6enUZAlfl80+0cXzP8FG0m/25Yu/yGztmI192ocCKARNX/fJk
         w5b37ertrH/J57eT+M730NqzFyn3nqyCzSwtk8iICX25AgX9VFUN6ycrMzapmvAx1zOf
         BKtlHtR7uaWnv0CHzOrXeD0Ua+I74X1KCUKK/nooq6dqOyL+vt9lPw5DF6iYLy0vFiEf
         hAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=Z3X5jepr9ZsL3b2PaimJOOqjf9WC9jdmo+ag1x21hLE=;
        b=jUFeaaQDIUSowoGn9qq6RIzwnxUi4mGLj13YvS82skszUOqtaXIXPLi0KGAmIJSx/F
         SO1I94IpIRDfqC4psEpqGoPtsMo6oJPJY908MkcN3BvxGkS1ZbceFYj9aF3N0nmvGH4r
         BDt1hsqWq9v2mW74TL9t6Y/72FAVgRmru8ZoM6JDj4L5c/0pYG+kV2Yj0u+OQGBmaZdZ
         /HDNa3NzJfiQd9c8WC5AyDIutjQ7mPSu8Vvzluy4ri4l7fv6BQkzJ4Ts+SRMWX4j44Dy
         50N/6m1L0rZHNE2Px+QJL/Us/jAaUqHWqNepXEl3VgnvTrNZrQOBxEIU7LRDbsnXTtTP
         AAVg==
X-Gm-Message-State: ANhLgQ1XeZkkEo+Z9VL79RgD0XcBUiQ1mVGF2Xc5EB+8aalRl72a8L6A
        vSW83Vpo+6mZ4alxAPsZxu1Ln7fwACdEPRQaIX1ilznmkkRM1kZHtUR2rv2vHaPW1MiHRayxEl4
        mZPV2inXUmKMrVWtOHlAWTrhdNUFYEZbM54J92x7z2M8b1T7XwxpY8UO+D2tVJdE=
X-Google-Smtp-Source: ADFU+vu0fo8lKLaQ9SNRPTorJTKVLr7HNziVQmZ21IVoP6ddBrXh5bQjjzNoHkT4TyiEJHGAA66eynXKtLTLZA==
X-Received: by 2002:a17:90a:35ce:: with SMTP id r72mr7135216pjb.126.1584738378384;
 Fri, 20 Mar 2020 14:06:18 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:06:15 -0700
Message-Id: <0f5607a4242cc7b61ad36d0782c9d1250c4d4d7d.1584737973.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] trace2: teach Git to log environment variables
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Via trace2, Git can already log interesting config parameters (see the
trace2_cmd_list_config() function). However, this can grant an
incomplete picture because many config parameters also allow overrides
via environment variables.

To allow for more complete logs, we add a new trace2_cmd_list_env_vars()
function and supporting implementation, modeled after the pre-existing
config param logging implementation.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
As I mentioned in the commit message, I modeled this pretty closely on
the config parameter reporting code. It may make sense to split some of
this out into its own file, particularly the parts in trace2/tr2_cfg.c.
Alternatively, we could also just make the env var reporting part of the
config param reporting. Let me know if you have a preference either way.

 Documentation/config/trace2.txt        |  9 ++++
 Documentation/technical/api-trace2.txt |  3 +-
 git.c                                  |  3 ++
 t/helper/test-tool.c                   |  1 +
 t/t0212-trace2-event.sh                | 37 ++++++++++++++++
 trace2.c                               |  9 ++++
 trace2.h                               | 13 ++++++
 trace2/tr2_cfg.c                       | 58 ++++++++++++++++++++++++++
 trace2/tr2_cfg.h                       |  8 ++++
 trace2/tr2_sysenv.c                    |  2 +
 trace2/tr2_sysenv.h                    |  1 +
 11 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index 4ce0b9a6d1..01d3afd8a8 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -48,6 +48,15 @@ trace2.configParams::
 	May be overridden by the `GIT_TRACE2_CONFIG_PARAMS` environment
 	variable.  Unset by default.
 
+trace2.envVars::
+	A comma-separated list of "important" environment variables that should
+	be recorded in the trace2 output.  For example,
+	`GIT_HTTP_USER_AGENT,GIT_CONFIG` would cause the trace2 output to
+	contain events listing the overrides for HTTP user agent and the
+	location of the Git configuration file (assuming any are set).  May be
+	overriden by the `GIT_TRACE2_ENV_VARS` environment variable.  Unset by
+	default.
+
 trace2.destinationDebug::
 	Boolean.  When true Git will print error messages when a
 	trace target destination cannot be opened for writing.
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 4f07ceadcb..6b6085585d 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -656,7 +656,8 @@ The "exec_id" field is a command-unique id and is only useful if the
 ------------
 
 `"def_param"`::
-	This event is generated to log a global parameter.
+	This event is generated to log a global parameter, such as a config
+	setting, command-line flag, or environment variable.
 +
 ------------
 {
diff --git a/git.c b/git.c
index 7be7ad34bd..b7dbe82b0d 100644
--- a/git.c
+++ b/git.c
@@ -351,6 +351,7 @@ static int handle_alias(int *argcp, const char ***argv)
 
 			trace2_cmd_alias(alias_command, child.args.argv);
 			trace2_cmd_list_config();
+			trace2_cmd_list_env_vars();
 			trace2_cmd_name("_run_shell_alias_");
 
 			ret = run_command(&child);
@@ -388,6 +389,7 @@ static int handle_alias(int *argcp, const char ***argv)
 
 		trace2_cmd_alias(alias_command, new_argv);
 		trace2_cmd_list_config();
+		trace2_cmd_list_env_vars();
 
 		*argv = new_argv;
 		*argcp += count - 1;
@@ -439,6 +441,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	trace_argv_printf(argv, "trace: built-in: git");
 	trace2_cmd_name(p->cmd);
 	trace2_cmd_list_config();
+	trace2_cmd_list_env_vars();
 
 	validate_cache_entries(the_repository->index);
 	status = p->fn(argc, argv, prefix);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c9a232d238..4cdab7eef2 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -111,6 +111,7 @@ int cmd_main(int argc, const char **argv)
 			argc--;
 			trace2_cmd_name(cmds[i].name);
 			trace2_cmd_list_config();
+			trace2_cmd_list_env_vars();
 			return cmds[i].fn(argc, argv);
 		}
 	}
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 7065a1b937..1529155cf0 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -199,6 +199,43 @@ test_expect_success JSON_PP 'event stream, list config' '
 	test_cmp expect actual
 '
 
+# Test listing of all "interesting" environment variables.
+
+test_expect_success JSON_PP 'event stream, list env vars' '
+	test_when_finished "rm trace.event actual expect" &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+		GIT_TRACE2_ENV_VARS="A_VAR,OTHER_VAR,MISSING" \
+		A_VAR=1 OTHER_VAR="hello world" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
+	sed -e "s/^|//" >expect <<-EOF &&
+	|VAR1 = {
+	|  "_SID0_":{
+	|    "argv":[
+	|      "_EXE_",
+	|      "trace2",
+	|      "001return",
+	|      "0"
+	|    ],
+	|    "exit_code":0,
+	|    "hierarchy":"trace2",
+	|    "name":"trace2",
+	|    "params":[
+	|      {
+	|        "param":"A_VAR",
+	|        "value":"1"
+	|      },
+	|      {
+	|        "param":"OTHER_VAR",
+	|        "value":"hello world"
+	|      }
+	|    ],
+	|    "version":"$V"
+	|  }
+	|};
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success JSON_PP 'basic trace2_data' '
 	test_when_finished "rm trace.event actual expect" &&
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool trace2 006data test_category k1 v1 test_category k2 v2 &&
diff --git a/trace2.c b/trace2.c
index c7b4f14d29..2c6b570077 100644
--- a/trace2.c
+++ b/trace2.c
@@ -121,6 +121,7 @@ static void tr2main_atexit_handler(void)
 	tr2_sid_release();
 	tr2_cmd_name_release();
 	tr2_cfg_free_patterns();
+	tr2_cfg_free_env_vars();
 	tr2_sysenv_release();
 
 	trace2_enabled = 0;
@@ -311,6 +312,14 @@ void trace2_cmd_list_config_fl(const char *file, int line)
 	tr2_cfg_list_config_fl(file, line);
 }
 
+void trace2_cmd_list_env_vars_fl(const char *file, int line)
+{
+	if (!trace2_enabled)
+		return;
+
+	tr2_list_env_vars_fl(file, line);
+}
+
 void trace2_cmd_set_config_fl(const char *file, int line, const char *key,
 			      const char *value)
 {
diff --git a/trace2.h b/trace2.h
index e5e81c0533..b18bc5529c 100644
--- a/trace2.h
+++ b/trace2.h
@@ -182,6 +182,19 @@ void trace2_cmd_list_config_fl(const char *file, int line);
 
 #define trace2_cmd_list_config() trace2_cmd_list_config_fl(__FILE__, __LINE__)
 
+/*
+ * Emit one or more 'def_param' events for "important" environment variables.
+ *
+ * Use the TR2_SYSENV_ENV_VARS setting to register a comma-separated list of
+ * environment variables considered important.  For example:
+ *     git config --system trace2.envVars 'GIT_HTTP_USER_AGENT,GIT_CONFIG'
+ * or:
+ *     GIT_TRACE2_ENV_VARS="GIT_HTTP_USER_AGENT,GIT_CONFIG"
+ */
+void trace2_cmd_list_env_vars_fl(const char *file, int line);
+
+#define trace2_cmd_list_env_vars() trace2_cmd_list_env_vars_fl(__FILE__, __LINE__)
+
 /*
  * Emit a "def_param" event for the given config key/value pair IF
  * we consider the key to be "important".
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index caa7f06948..ec9ac1a6ef 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -7,6 +7,10 @@ static struct strbuf **tr2_cfg_patterns;
 static int tr2_cfg_count_patterns;
 static int tr2_cfg_loaded;
 
+static struct strbuf **tr2_cfg_env_vars;
+static int tr2_cfg_env_vars_count;
+static int tr2_cfg_env_vars_loaded;
+
 /*
  * Parse a string containing a comma-delimited list of config keys
  * or wildcard patterns into a list of strbufs.
@@ -46,6 +50,45 @@ void tr2_cfg_free_patterns(void)
 	tr2_cfg_loaded = 0;
 }
 
+/*
+ * Parse a string containing a comma-delimited list of environment variable
+ * names into a list of strbufs.
+ */
+static int tr2_load_env_vars(void)
+{
+	struct strbuf **s;
+	const char *varlist;
+
+	if (tr2_cfg_env_vars_loaded)
+		return tr2_cfg_env_vars_count;
+	tr2_cfg_env_vars_loaded = 1;
+
+	varlist = tr2_sysenv_get(TR2_SYSENV_ENV_VARS);
+	if (!varlist || !*varlist)
+		return tr2_cfg_env_vars_count;
+
+	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
+	for (s = tr2_cfg_env_vars; *s; s++) {
+		struct strbuf *buf = *s;
+
+		if (buf->len && buf->buf[buf->len - 1] == ',')
+			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_newline(*s);
+		strbuf_trim(*s);
+	}
+
+	tr2_cfg_env_vars_count = s - tr2_cfg_env_vars;
+	return tr2_cfg_env_vars_count;
+}
+
+void tr2_cfg_free_env_vars(void)
+{
+	if (tr2_cfg_env_vars)
+		strbuf_list_free(tr2_cfg_env_vars);
+	tr2_cfg_env_vars_count = 0;
+	tr2_cfg_env_vars_loaded = 0;
+}
+
 struct tr2_cfg_data {
 	const char *file;
 	int line;
@@ -79,6 +122,21 @@ void tr2_cfg_list_config_fl(const char *file, int line)
 		read_early_config(tr2_cfg_cb, &data);
 }
 
+void tr2_list_env_vars_fl(const char *file, int line)
+{
+	struct strbuf **s;
+
+	if (tr2_load_env_vars() <= 0)
+		return;
+
+	for (s = tr2_cfg_env_vars; *s; s++) {
+		struct strbuf *buf = *s;
+		const char *val = getenv(buf->buf);
+		if (val && *val)
+			trace2_def_param_fl(file, line, buf->buf, val);
+	}
+}
+
 void tr2_cfg_set_fl(const char *file, int line, const char *key,
 		    const char *value)
 {
diff --git a/trace2/tr2_cfg.h b/trace2/tr2_cfg.h
index d9c98f64dd..a11d71feb5 100644
--- a/trace2/tr2_cfg.h
+++ b/trace2/tr2_cfg.h
@@ -7,6 +7,12 @@
  */
 void tr2_cfg_list_config_fl(const char *file, int line);
 
+/*
+ * Iterate over all "interesting" environment variables and emit 'def_param'
+ * events for them to TRACE2.
+ */
+void tr2_list_env_vars_fl(const char *file, int line);
+
 /*
  * Emit a "def_param" event for the given key/value pair IF we consider
  * the key to be "interesting".
@@ -16,4 +22,6 @@ void tr2_cfg_set_fl(const char *file, int line, const char *key,
 
 void tr2_cfg_free_patterns(void);
 
+void tr2_cfg_free_env_vars(void);
+
 #endif /* TR2_CFG_H */
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 3c3792eca2..a380dcf910 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -29,6 +29,8 @@ struct tr2_sysenv_entry {
 static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
 	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TRACE2_CONFIG_PARAMS",
 				       "trace2.configparams" },
+	[TR2_SYSENV_ENV_VARS]      = { "GIT_TRACE2_ENV_VARS",
+				       "trace2.envvars" },
 
 	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TRACE2_DST_DEBUG",
 				       "trace2.destinationdebug" },
diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
index d4364a7b85..3292ee15bc 100644
--- a/trace2/tr2_sysenv.h
+++ b/trace2/tr2_sysenv.h
@@ -11,6 +11,7 @@
  */
 enum tr2_sysenv_variable {
 	TR2_SYSENV_CFG_PARAM = 0,
+	TR2_SYSENV_ENV_VARS,
 
 	TR2_SYSENV_DST_DEBUG,
 
-- 
2.25.1.696.g5e7596f4ac-goog

