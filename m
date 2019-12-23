Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AACAC2D0D8
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680AD20643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKI5BnLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLWSuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38123 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLWSuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so16119262edr.5
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qk1xF7AiYAKNTqc/J1ZzwcIahg5CzNWuSjSJP3bYwHs=;
        b=iKI5BnLx4gyc968EPNH0eoCvh+Q9a4luae4XbhQBipIzINeLYDtepvmyxctedKwrk3
         hm2IRONO+Y6RVVNhdQSbbB4UJzdHZtR/FmcIglVH97kB5pfjlnRi/8kIU6T4Rv8r8m/j
         useQt8cfr90XYGtjRH/hQ6bZIQfJlyKWEAraU6xLxVg06BcGsQkZogcYRtCuW3Qq+jBd
         CrlMJ9Bf5YiYznBnk+PM0SIe7mUtToJ51IiFUaTSRMeBX+dQmrbEceYQkGZhKX0Ieswt
         66MeIn9MGVDSOJ4c2F3k+zRgVVUB0YaU/ODOdZpqLozs7QOBRV0PhjVBXpuv3ksrGRuB
         D+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qk1xF7AiYAKNTqc/J1ZzwcIahg5CzNWuSjSJP3bYwHs=;
        b=OEJOcgklEwKxIWgKELQ8a1N8/df6KOgRFCDishJ6Pg3Sp/p4lN7/AN19KtcoA24IIe
         WLqgTNeAxfdvS2AO7pUNfOpQutHg2tSVEZNTLl5JPlzkmRuv4G0/tciWJg4uAXNh+LoP
         IU63B1mlk4IDHBKFGS8q1hW51xC9R3mIaFdbsx0kNShTM+w4mbYG1xflUAZ+QCn/pkdP
         IeSVniaS1zT8Q69PFdGrvfq61Zlh7lIkTGYG819ZEPzVXyJ/v8MhqZO68lEb0gXYl96p
         2sYPxMQOImM/9V0VNe9MirIATj9EPR92nriv57dPLm/TZEbPqJD1S8iC91zUYhVitiB/
         rP7g==
X-Gm-Message-State: APjAAAVVAEJDkd1FYctArbowGtK8kxADqq0UrCRCRtd4hQ/VSsKRCnYC
        qQWXea0CfDi8Bt732MX25K8WWkzb
X-Google-Smtp-Source: APXvYqypSmELYH8uJQrT5EzzqWh/bNniHQUkxxy0eGIfVD9CSTMWXPwX7utq/GsWl3ra7lPo3Yctvg==
X-Received: by 2002:a17:906:71a:: with SMTP id y26mr34080822ejb.48.1577127011238;
        Mon, 23 Dec 2019 10:50:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm2365825ejr.23.2019.12.23.10.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:10 -0800 (PST)
Message-Id: <ec782e711c56673a70ed735980a3e4b74c45a61c.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:58 +0000
Subject: [PATCH v2 14/15] rebase: make the backend configurable via config
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

