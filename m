Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84FEC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiGRQsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:48:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D12B18F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:48:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 23so11090601pgc.8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WU3CM1MNuCvkNaElfJEnoIZQtpivC3RDsNeR1HXDTOE=;
        b=Aql9DnPRWiImBzB6laJW7+5ASEfOFEljKnXI615Mf39zDxe3wkkID1UhNTmXCJNBqo
         0kfydcpL022INomUcUKATLsGCFog1FPxX8B5cCXRPVahe7oJEMI7mN7sTO1o5WNM176F
         UhNIfJyAAli42McN8/lz5lo6i++va/2P4Ii1+NFKc3W7T4W3xIiABCUQoRBPSPdea6O/
         C7xYJwn+XwiajGP++mhlq1pIUbFudxV3Lzn9MikHIZe+aasLUmxm0IKnxtMnamcSRsYN
         M7stkvP2xC4okqoE0kDR4nimogIiEC7f+YWlxQceUxW0FfCCWMWNdNBam5BtjjlkKxY3
         8NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WU3CM1MNuCvkNaElfJEnoIZQtpivC3RDsNeR1HXDTOE=;
        b=DWFmzw/pr2YVCk9pWpS/a+5ZKZzAHgixRCKTKJelHCpuK5bNle1GcIG0BHrPrdETft
         5gT/QFyj1z9P6zv6DEgmWiwQp4zp8/o7zgbg8pyN4jUGf8RyHk4Ygmyos9elkMgKzAQ4
         RfvA4MfORUOMvB1aS4kl5Ka9Vi7w8VuV8NtsFfPiOytADoH3QlJ5vTgVLzxDIIOgOKGG
         xZ627/HGczewVvaTJv45y5duG1WCEfIYwmmwNjEdEzng28DWxlp5s7fEZhX4NqX1S8FG
         ARNWVTVfc1sEne727Bj0O3Jq2YPi2gqWYP/MmgZCJvd4OOdG5k2G9EXEB7Gz3JyBPoHu
         u/gg==
X-Gm-Message-State: AJIora9c+hnrbzcEPhgqHhT+VXOv5pL7Kv0Jxojpfcjcn8f320rDOybd
        cuV7Rsl7LeHo/aBXgq3jImoFntXWYADUSQ==
X-Google-Smtp-Source: AGRyM1vtTn2T+QOVqLcybyisBxPujJRWLdgc+6cHyguUBNZXuLOm/KxubEhyCJlvjFvJkNg6wedPIA==
X-Received: by 2002:a63:195d:0:b0:412:50b8:c410 with SMTP id 29-20020a63195d000000b0041250b8c410mr24174553pgz.520.1658162921059;
        Mon, 18 Jul 2022 09:48:41 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9671074pfd.90.2022.07.18.09.48.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:48:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 7/7] tr2: dump names if config exist in multiple scopes
Date:   Tue, 19 Jul 2022 00:46:06 +0800
Message-Id: <a01ae8478d3a8545241c5b064b6d369a330ee59f.1658159746.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com>
References: <cover.1658159745.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we specify GIT_TRACE2_CONFIG_PARAMS or trace2.configparams,
trace2 will prints "interesting" config values to log. Sometimes,
when a config set in multiple scope files, the following output
looks like (the irrelevant fields are omitted here as "..."):

...| def_param    |  ...  | core.multipackindex:false
...| def_param    |  ...  | core.multipackindex:false
...| def_param    |  ...  | core.multipackindex:false

As the log shows, even each config in different scope is dumped, but
we don't know which scope it comes from. Therefore, it's better to
add the scope names as well to make them be more recognizable. For
example, when execute:

    $ GIT_TRACE2_PERF=1 \
    > GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex \
    > git rev-list --test-bitmap HEAD"

The following is the ouput (the irrelevant fields are omitted here
as "..."):

Format normal:
... git.c:461 ... def_param scope:system core.multipackindex=false
... git.c:461 ... def_param scope:global core.multipackindex=false
... git.c:461 ... def_param scope:local core.multipackindex=false

Format perf:

... | def_param    | ... | scope:system | core.multipackindex:false
... | def_param    | ... | scope:global | core.multipackindex:false
... | def_param    | ... | scope:local  | core.multipackindex:false

Format event:

{"event":"def_param", ... ,"scope":"system","param":"core.multipackindex","value":"false"}
{"event":"def_param", ... ,"scope":"global","param":"core.multipackindex","value":"false"}
{"event":"def_param", ... ,"scope":"local","param":"core.multipackindex","value":"false"}

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/api-trace2.txt | 45 ++++++++++++++++++++++++++
 trace2/tr2_tgt_event.c                 |  3 ++
 trace2/tr2_tgt_normal.c                |  5 ++-
 trace2/tr2_tgt_perf.c                  |  9 ++++--
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb13ca3db8..48205a5ac5 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1207,6 +1207,51 @@ at offset 508.
 This example also shows that thread names are assigned in a racy manner
 as each thread starts and allocates TLS storage.
 
+Print Configs::
+
+	  Dump "interesting" config values to trace2 log.
++
+The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
+`trace2.configparams` can be used to output config values which you care
+about. For example, assume that we want to config different `color.ui`
+values in multiple scopes, such as:
++
+----------------
+$ git config --system color.ui never
+$ git config --global color.ui always
+$ git config --local color.ui auto
+$ git config --list --show-scope | grep 'color.ui'
+system  color.ui=never
+global  color.ui=always
+local   color.ui=auto
+----------------
++
+Then, mark the config `color.ui` as "interesting" config with
+`GIT_TRACE2_CONFIG_PARAMS`:
++
+----------------
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
+$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
+$ git version
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |              | ...
+d0 | main                     | start        |     |  0.000284 |           |              | /opt/git/master/bin/git version
+d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
+d0 | main                     | cmd_name     |     |           |           |              | version (version)
+d0 | main                     | exit         |     |  0.000419 |           |              | code:0
+d0 | main                     | atexit       |     |  0.000426 |           |              | code:0
+d0 | main                     | version      |     |           |           |              | ...
+d0 | main                     | start        |     |  0.000275 |           |              | /opt/git/master/bin/git version
+d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
+d0 | main                     | cmd_name     |     |           |           |              | version (version)
+d0 | main                     | def_param    |     |           |           |              | color.ui:never
+d0 | main                     | def_param    |     |           |           |              | color.ui:always
+d0 | main                     | def_param    |     |           |           |              | color.ui:auto
+d0 | main                     | exit         |     |  0.000543 |           |              | code:0
+d0 | main                     | atexit       |     |  0.000549 |           |              | code:0
+----------------
 == Future Work
 
 === Relationship to the Existing Trace Api (api-trace.txt)
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c5c8cfbbaa..37a3163be1 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
 	const char *event_name = "def_param";
 	struct json_writer jw = JSON_WRITER_INIT;
+	enum config_scope scope = current_config_scope();
+	const char *scope_name = config_scope_name(scope);
 
 	jw_object_begin(&jw, 0);
 	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "scope", scope_name);
 	jw_object_string(&jw, "param", param);
 	jw_object_string(&jw, "value", value);
 	jw_end(&jw);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index c42fbade7f..69f8033077 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -298,8 +298,11 @@ static void fn_param_fl(const char *file, int line, const char *param,
 			const char *value)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
+	enum config_scope scope = current_config_scope();
+	const char *scope_name = config_scope_name(scope);
 
-	strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
+	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
+		    value);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a1eff8bea3..8cb792488c 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -441,12 +441,17 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
 	const char *event_name = "def_param";
 	struct strbuf buf_payload = STRBUF_INIT;
+	struct strbuf scope_payload = STRBUF_INIT;
+	enum config_scope scope = current_config_scope();
+	const char *scope_name = config_scope_name(scope);
 
 	strbuf_addf(&buf_payload, "%s:%s", param, value);
+	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
+			 scope_payload.buf, &buf_payload);
 	strbuf_release(&buf_payload);
+	strbuf_release(&scope_payload);
 }
 
 static void fn_repo_fl(const char *file, int line,
-- 
2.35.0.rc0.679.gc613175da2

