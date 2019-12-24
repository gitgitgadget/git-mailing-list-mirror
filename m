Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F715C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF946206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaRGTEFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLXTzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33371 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLXTzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so18677285edq.0
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qk1xF7AiYAKNTqc/J1ZzwcIahg5CzNWuSjSJP3bYwHs=;
        b=LaRGTEFWL4zCJDXzmPbvfcoaj1eYCjRd8JQlympQzTfbJrLIvUQSRX7+5eIn+7s8wA
         wX2az6dTKWVJJ1VDMhvSihpMfCBLtX1GmDZ1djb+SK5QbV68STa7NcQCkvwTHpQIc2Gj
         /LnG9cZfdVvz1IYoc4nKgvTNwSEORYcAnE6wbfvU/Bf0crDEJ1CytYxmGsupljFQpc2j
         6gJoX9taRR42UXLKdGGD/L/l5Vf3mqhgWfUaqi2xtnOGIKyy4xFhifKYPoWbc1bAgYgY
         4IxFOuOCpl/0wYSDNJA1oQoH/Qm7uZFhspRB0+4bXJ7Qp6t+tyAWLkgQ+AC661EvKmxI
         TwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qk1xF7AiYAKNTqc/J1ZzwcIahg5CzNWuSjSJP3bYwHs=;
        b=lHKtfL35D6pnwbFQ1F7I9IUC8gwI8VEeDWQQUiaJZ9cWSx47Rm7/3o3VRyYuw9yGyU
         +oaLwHgMRJs17Y2kqIXmS6EWTJwEnlyiCRLvkqJfdhQvd8hSva4d15CPd+LsjLt80lOd
         P8nExH799JFAnIGnwtoy+0azmft4DtjTbFDUWE79U1T4m3z8tAoobf/7CAbkNhuKz5VL
         hRVZiwsPOzy1OjWA1Aggof9I+peIVhRUReEEBzxTwkTFa8gf+f6owxVj3LqaddilT740
         zuYXjPeIys/fEoBU8rQ/mY+SleZJQkREzRipls0GUMFmVxKd7+06Pen275pSb5YaGKLI
         C2dw==
X-Gm-Message-State: APjAAAV/0kWILAH9UmpdyI9QQvxdMoHVsunELFVfNOL+F9hOdvgeVRzv
        wX/smVFZe01t/onPsr/YdxnKOCTh
X-Google-Smtp-Source: APXvYqxrkBJtOVcBDvqDM5ceCL61iIz9wliQF0f5UaTBmlBUxOq2bLz7tW4/AQW/HJP1ie7G3WkT8A==
X-Received: by 2002:a17:906:1903:: with SMTP id a3mr39263525eje.102.1577217311939;
        Tue, 24 Dec 2019 11:55:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm2772626ejb.84.2019.12.24.11.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:11 -0800 (PST)
Message-Id: <8bec6df51af83665698ba6dae8d5b3a01fabe21f.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:58 +0000
Subject: [PATCH v3 14/15] rebase: make the backend configurable via config
 setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
index b7915fc0cb..d602b2da4c 100644
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
@@ -103,6 +104,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
+		.default_backend = "am",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1298,6 +1300,10 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.backend")) {
+		return git_config_string(&opts->default_backend, var, value);
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -1928,9 +1934,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1943,10 +1963,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

