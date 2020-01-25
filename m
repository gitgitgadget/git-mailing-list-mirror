Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F2DC35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77012075D
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uE0jeeOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgAYAj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:39:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41062 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbgAYAj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so4178571wrw.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=saMlTNkKEqcBRL5aUOy1TDYQZGXm7gjU9li+Opxvdcs=;
        b=uE0jeeOHg7nNefR3v53KXJA2tkA0a9VtmA3GyjsV21gW9ItyyZYzr4oh32T1y96bTu
         bRIITVP6Xr+xK3vOGXTqn9Y7IZ0iKmcP9sEMprbUxIWHT0nFQaIJP+yS/WZeRlBTVDhQ
         f4s9ucRFVTlUu83B2XBZd7eufEIjZf/tRVxfpc+aqUEsoz8eyexnqDNwcOANPMoS5vLE
         MtIWV02F2EUmbO4iZMZSG4QMecAsTIaWyIOV7pJGVdIkDkjRtQr/e+uOnx150zwqoVr+
         TcppZ0Gs7GekI8R4v12Y6w8siBmGSxuSaxdspZbK2FnzgWb7kfrQvyPpLWGsDAVB7HJH
         9D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=saMlTNkKEqcBRL5aUOy1TDYQZGXm7gjU9li+Opxvdcs=;
        b=DOsvnbTeXQ3dkHGXPqm2zWdTuE+dGhSdfBnex5iSoAeUr9tQ/2qihsI9dlmcAm5OPV
         X8/RA+EFnBwWsGWoifK5Np2eOWOLBMcXXCltUhoyAaCdAKo5/KC1Rndv/SPyrFJ11HD5
         V0N+N7R4WoKjcXKGZMj1ezG4Na5PX4zGZHuxMPkasX6GRaXd48iBCYwHqLnlL9a/lOT+
         V7fveHOtYfWoCRgOtGYWBeoFLMBdkREhu0VIaqpAoltBEpoePC7MwnJSD2ZzLVVEdvG9
         Aw2ajdHKW/pUVXRBnVmpY3B3oiWchuofUtY9TaX2sxVKoT2updXB8ZOLYTDjH2r3skdb
         kdkQ==
X-Gm-Message-State: APjAAAUQltT+DzfutMEeY2Rei3XS0W8vhoNo2gfrPFXvOF4cMpQC3n10
        oMpOn+YQm8NSMsKUhvw1use6uwDi
X-Google-Smtp-Source: APXvYqz0kKS9nBhM4KUGDfmqjGduB+f1Whrtm6hU/9WaoTZJ3+zNdqGO/ZYrcS1egBEy3JBcBYUo5w==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr7029657wrm.402.1579912766936;
        Fri, 24 Jan 2020 16:39:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm9290601wmf.14.2020.01.24.16.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 16:39:26 -0800 (PST)
Message-Id: <f5a81a4d25e112a2785d081a609eddf514e91d95.1579912764.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Jan 2020 00:39:19 +0000
Subject: [PATCH v5 1/6] config: fix typo in variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

In git config use of the end_null variable to determine if we should be
null terminating our output.  While it is correct to say a string is
"null terminated" the character is actually the "nul" character, so this
malapropism is being fixed.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 builtin/config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..52a904cfb1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -29,7 +29,7 @@ static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
-static int end_null;
+static int end_nul;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
@@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
@@ -178,11 +178,11 @@ static void check_argc(int argc, int min, int max)
 
 static void show_config_origin(struct strbuf *buf)
 {
-	const char term = end_null ? '\0' : '\t';
+	const char term = end_nul ? '\0' : '\t';
 
 	strbuf_addstr(buf, current_config_origin_type());
 	strbuf_addch(buf, ':');
-	if (end_null)
+	if (end_nul)
 		strbuf_addstr(buf, current_config_name());
 	else
 		quote_c_style(current_config_name(), buf, NULL, 0);
@@ -678,7 +678,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.git_dir = get_git_dir();
 	}
 
-	if (end_null) {
+	if (end_nul) {
 		term = '\0';
 		delim = '\n';
 		key_delim = '\n';
-- 
gitgitgadget

