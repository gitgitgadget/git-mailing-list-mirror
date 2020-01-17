Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E5BC33CB6
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0A2073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRDtf4al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAQPbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:31:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45448 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAQPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:31:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so23086454wrj.12
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 07:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=saMlTNkKEqcBRL5aUOy1TDYQZGXm7gjU9li+Opxvdcs=;
        b=XRDtf4alwiVZ7F1Sns9GBAUNr3KIUQ8ajvmGLsjooqrR9ztPKx3AYO5eNzl3SszOyX
         g4fDE18fyYitUJWzVp2dU0NBaEywJIeLWQiOxHA4iVqdzMcjZJnhw8PZrZtVhqVxowU2
         InuL5kT4R+m229w8uKC4omOxRUrD8Y4amJkkqeQdowMdSA947N0RTGtseZ37t+G/DcNB
         xWAn2iEyV/KlwNjRwgheoddnnwzGvhnl8/aORUZokfl7Yeqg+qAmUalgk2q7MZHMd9VQ
         QemJ23+jGHv+W7WBLYujsY0fIcNJJVMOhnFN/FQb96cy6iLyH19PX8FXtHE0QfX/LvwB
         uXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=saMlTNkKEqcBRL5aUOy1TDYQZGXm7gjU9li+Opxvdcs=;
        b=l73C/Y2kHnAD2/eacTx2PG+ZESVB0vxSj7wFjVOpFilErYIw1mE2Esr72nC8dz8F+k
         w3TMH3bTecgsB4gNfHYXTO+fkDpOuebOTIMOjMX2SIh/WmVx90NS5hbw9R63y/nvNsal
         twCBkhHmGvh4DFb9JFByIl9csXrhS4Qj9qB3S0v96p/kAYlLgvwu5v8bOE1fCN6DMIAK
         Fu2iJNLANEcBEOkqdBhP2T8dwX0XE64nqC+JvZ/5Ge1Z3xISkVhdCNSjkzy+4ZZEYSCT
         ltXj7DZePQV/cIpRaGntFD619M8YZWQyH45KrxaB5sUmmmKHpoKEAApt5Tud9hXe6hOv
         8O9w==
X-Gm-Message-State: APjAAAUI6RM/WF+JwE0T7lY0Q3yTZVl3VvHHB7gldJw7w5xS2K8T1xDE
        TH6NoYP6CZvctVBBYFLzIgpVdwLL
X-Google-Smtp-Source: APXvYqxAy1Jj5C/WWWfprTipWjBt0t5wdLJBV3CCmhkVl9+v9Yfgsy/JQ3HJZlFO7D1dfPdZCGVoCg==
X-Received: by 2002:adf:a48e:: with SMTP id g14mr3727780wrb.409.1579275104638;
        Fri, 17 Jan 2020 07:31:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm34342784wrx.59.2020.01.17.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:31:43 -0800 (PST)
Message-Id: <f5a81a4d25e112a2785d081a609eddf514e91d95.1579275102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 15:31:39 +0000
Subject: [PATCH v3 1/4] config: fix typo in variable name
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

