Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B9C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiGKMpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiGKMow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854F6302
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x184so4675094pfx.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HeCfvWUxOThV/EfkESGLoJlxn2nTjBhLtC5JGLuwpK4=;
        b=GtjKE3wg0z0b7RCT1KhjXsMaZJyxVQzzkBJSDBHT7l5Ze6Y/qQRFNYENfsWRxIppoH
         74A4OLvKbIf93l3fbCJnKBy3GfLmX+nsAXNYa8t8cQP3rxEdmNNaMX5/aw7IPr90Ef3I
         vxgO1P/UE6CHPYB3xKNn10KPFptyeseUot9Jsm/xV7ival7fUQyYrA1NowIVkxY7eN1p
         IiuKGwcLT0uIGfmiAJYk3hbjFQVPEVBhe+af7+M7Ua2U8lgXggtZMrqe6ogMXb+wnF5b
         /00gk49aQkIwOipDAwnpiOLV1aJ06j2oKP31mQXvyMgGANZe6lUTN0FTT7STjy6bJjbv
         CssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HeCfvWUxOThV/EfkESGLoJlxn2nTjBhLtC5JGLuwpK4=;
        b=z+70igqqxQBE74jpax5rCKX2vSnS6RmbNMHtAprjSjXmdwESbSUMV+5JtO3CgWFnP7
         h5F7iK9KR6BYKHrusV14z9S+YM2sQV4f6tP+RPvnPm6sCsss5eYgf+rDEvUxI6I7eLuo
         3XSB4u0QbXjE4Cpot/C3jEG0N7xlL3GPur2QbT97LeD0D3GBJ0kOK30MDZxbmrHHEFwv
         aSfZIN+aVIeutP46pOThZp8zTBP0GE1csGXmi6C/iQ5X5SHdeROhvWYM2dZo/t4K2L2z
         iylnO67x2qUlgcp2DkDpvJSZj00SCxR2rIet7hXREl3UQt0Qoc5773n8fZ08HqqGzX6f
         qquw==
X-Gm-Message-State: AJIora/89Un3vf0G40PUePx9Qd0E00w9deLLBDRXs/1es92It7XZsanh
        Jef6qAvH2/wn8LTN8Kb+9T4=
X-Google-Smtp-Source: AGRyM1txNwTVqvW4ZS4I5AWRArbPiDCYjOEYnUSzsgVOI26ci9mRgynMRl3fydGsU8xM2S9sFyuVPg==
X-Received: by 2002:a63:4b20:0:b0:401:ae11:2593 with SMTP id y32-20020a634b20000000b00401ae112593mr16186193pga.375.1657543474807;
        Mon, 11 Jul 2022 05:44:34 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 7/7] tr2: dump names if config exist in multiple scopes
Date:   Mon, 11 Jul 2022 20:44:03 +0800
Message-Id: <c45ead51ffc5a9176493d627da8332d35a31d87c.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
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
 trace2/tr2_tgt_event.c  | 3 +++
 trace2/tr2_tgt_normal.c | 5 ++++-
 trace2/tr2_tgt_perf.c   | 9 +++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

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
2.35.0.rc0.676.g60105b7097.dirty

