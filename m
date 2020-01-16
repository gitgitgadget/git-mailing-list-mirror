Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE4BC33CBA
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D62207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvlFTpx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgAPGO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgAPGOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so6359869wmi.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Shu+iexOHXqrC2/8jtAWnQSIReIgaWWzTKSnm7uvZrs=;
        b=ZvlFTpx4Ifk1WhE+72lEU4uXf2n2OxIBEFrDs7iwW5LkpyP4EhmQAfHp13v3GAc65C
         dIkiDGGq78UE64T+eoFOHT35TZQ/O8WUkgNiLWgYTiPt7CaK169CfkhdQP+BBKJr2mGO
         soj+gkBU4OB2HJKCRisLvS1VpzZyRtH/Zkvd70yVfeSBfspdmPVMuVNQ/G6V+Gh1Da7y
         DL6o6gwrm4/8N++1v6RSyBicXQJFVjopvYkzGuTYxkrKKAxM4q1oKp7A0YZXvhDF9f2o
         +vOzcfvO8acf6n3tgqkRw/lSc774VW2LApdq8qTOeef/NkNDgmwG1SU3RmlqoMbrbS+Q
         2Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Shu+iexOHXqrC2/8jtAWnQSIReIgaWWzTKSnm7uvZrs=;
        b=RfmDP76rZVSHH72jIa40hsrAIZevESqttGeinv9GFiK7BwSxj8ce02iNxKqCXSd3lJ
         Wf/7YMZOAox2qI3MZoHIECfxaQS4KwWERz9dOEmWfGQgdXVSw8bNkorMWNNZfzRmgTCy
         ROyXfQj+K09gRi079u9ZLqxKAxBSzNC1RCbLUoeBxWAF4KojFMoHLmG71lHqMEh73coF
         2WUISCb101kTNiQ32sKKAa3zXRmNwJzAaOIJedCenw58wLoWacW/PPvkUgSVC+O2GIPL
         nadCk5D6sVkkc9MjqlSqrvT7rW58gj7UI7ceKxMGLIDQVtt8qvhjQ24CBmt+uMKKaCSK
         yRmA==
X-Gm-Message-State: APjAAAXld2uMGpnuOUR5kcHphL1ko7t8/kVclOT+q4FnFVc5gOmXtOU/
        SKALRQ/NbGN/vZiMRyJx6NzxJDb4
X-Google-Smtp-Source: APXvYqyfmm/5KkRFpY/4P7O3qHD3Duyl7AqgN+RoD3RpGFcP5G3hhJAvdKLBlpLx9eTAbsrEthuTlg==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr4269379wmj.36.1579155289142;
        Wed, 15 Jan 2020 22:14:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm28625624wrq.92.2020.01.15.22.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:48 -0800 (PST)
Message-Id: <9b4ac83d2d09aea5d6072a9ee29687e97a3573aa.1579155274.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:32 +0000
Subject: [PATCH v4 18/19] rebase: make the backend configurable via config
 setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/rebase.txt |  8 ++++++++
 builtin/rebase.c                | 31 ++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index d98e32d812..e6ae30c999 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -5,6 +5,14 @@ rebase.useBuiltin::
 	is always used. Setting this will emit a warning, to alert any
 	remaining users that setting this now does nothing.
 
+rebase.backend::
+	Default backend to use for rebasing.  Possible choices are
+	'am' or 'merge' (note that the merge backend is sometimes also
+	refered to as the interactive backend or the interactive
+	machinery elsewhere in the docs).  Also, in the future, if the
+	merge backend gains all remaining capabilities of the am
+	backend, this setting may become unused.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ecd23d3ee7..b96de5809e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -60,6 +60,7 @@ enum empty_type {
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
+	const char *default_backend;
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
@@ -100,6 +101,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
+		.default_backend = "am",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1272,6 +1274,10 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.backend")) {
+		return git_config_string(&opts->default_backend, var, value);
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -1900,9 +1906,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
 				break;
 
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
+		if (i >= 0) {
+			if (is_interactive(&options))
+				die(_("cannot combine am options with either "
+				      "interactive or merge options"));
+			else
+				options.type = REBASE_AM;
+		}
+	}
+
+	if (options.type == REBASE_UNSPECIFIED) {
+		if (!strcmp(options.default_backend, "merge"))
+			options.type = REBASE_MERGE;
+		else if (!strcmp(options.default_backend, "am"))
+			options.type = REBASE_AM;
+		else
+			die(_("Unknown rebase backend: %s"),
+			    options.default_backend);
 	}
 
 	switch (options.type) {
@@ -1915,10 +1935,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.state_dir = apply_dir();
 		break;
 	default:
-		/* the default rebase backend is `--am` */
-		options.type = REBASE_AM;
-		options.state_dir = apply_dir();
-		break;
+		BUG("options.type was just set above; should be unreachable.");
 	}
 
 	if (options.empty == EMPTY_UNSPECIFIED) {
-- 
gitgitgadget

