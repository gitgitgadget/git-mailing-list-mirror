Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0AC2D0D0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C86206CB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc3DhTC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLWSuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33977 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfLWSuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id l8so16132906edw.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+RYvTrbrY2Vje09F3fIO6N2bOPnlcbiySWaMlI4TgVY=;
        b=Xc3DhTC3ggxPqks8TAdRzEU45LP0W7f7TjXQmkF5H/p6ozB/Cn8dLAhpojekXjkVLf
         wEjn52NuHoTse5/wuFkb0rDGh9D+I5Db3OcoHHmC1gO8lcsoG1+9HdFF8RI7iKrU+ILq
         bAm2FVn94zyMUmGdTBuLUBuY08RBhyaVE4/7azlz5R+XU/RmXLoe0vqDp7TDDMGtSEIV
         ryIhklsn3nXlF5U0U5DK7LhfcuV+EJ5kdIP9hHvAzNEnC5gL3iXWrFaM7pxHDMYEYOw/
         p2EsATXIPRd580vGezhmP7UYbuXpyMgj8FXEB2QhDbru2ZdG1zh+lgpvV3zXT/ZNLdT/
         xEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+RYvTrbrY2Vje09F3fIO6N2bOPnlcbiySWaMlI4TgVY=;
        b=cAz/hAnxyJOfG2Wg0Cum7BwvU9xuyf6O2c+CdpxaqNIOn/MBV3kz5noriH8ro2GgV+
         zx/vLnFc36vp8ld85RvayAjLb0G83o/c3Gu7LG/IS2V+MOOIZ2viwmphmVFgI+pZYja/
         2vNKXx0qDKfI1ia/kBJd+nRGDnvFHwQVKWs1uzsh/1VItpLyjxakmGKeQ+AC1iElUxh1
         ztaXX+PuQj2qhuDwyhu9JKnqkxgO9/uKbxe+k773+aCjev/EPMWA/0oRMLwfRFuW0UY7
         q/UTzAJv4+RXgB+Sxy5yJ88fjOj6NHiLZbGT33aE2U4NX9D4C9cES3A+dOufAbGenpt9
         C2tg==
X-Gm-Message-State: APjAAAW+qQuvhwtqIXOqAjWMalLVAR1Qq2RCvSpf2AXMD06ccmlBnvJE
        HDjufHi6IaGTgVDbNK/eqY1gtpuD
X-Google-Smtp-Source: APXvYqzDxb2v4fFTtPbW8epIhg6Cp+En8usD0BOSGYpZpkICAVUAyrlsFmHthtLCD57wcyW2NE1/8Q==
X-Received: by 2002:a17:906:1cc6:: with SMTP id i6mr884498ejh.31.1577127008415;
        Mon, 23 Dec 2019 10:50:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2sm2293389edi.95.2019.12.23.10.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:08 -0800 (PST)
Message-Id: <1df11f0b5105b1f602fdd723e0f74565e436faba.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:54 +0000
Subject: [PATCH v2 10/15] rebase: add an --am option
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

Currently, this option doesn't do anything except error out if any
options requiring the interactive-backend are also passed.  However,
when we make the default backend configurable later in this series, this
flag will provide a way to override the config setting.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 11 ++++++++++-
 builtin/rebase.c             | 18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f1ace07c38..cf1ac2e359 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,6 +258,13 @@ See also INCOMPATIBLE OPTIONS below.
 	original branch. The index and working tree are also left
 	unchanged as a result.
 
+--am:
+	Use git-am internally to rebase.  This option may become a
+	no-op in the future once the interactive backend handles
+	everything the am one does.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --empty={drop,keep,ask}::
 	How to handle commits that become empty (because they contain a
 	subset of already upstream changes) or start empty.  With drop
@@ -372,7 +379,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.
+	ever ignored.  Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -417,6 +424,7 @@ with `--keep-base` in order to drop those commits from your branch.
 --whitespace=<option>::
 	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
+	Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -567,6 +575,7 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
+ * --am
  * --whitespace
  * -C
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d2b99e9908..b7915fc0cb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1361,6 +1361,18 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	return res && is_linear_history(onto, head);
 }
 
+static int parse_opt_am(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	opts->type = REBASE_AM;
+
+	return 0;
+}
+
 /* -i followed by -m is still -i */
 static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 {
@@ -1546,6 +1558,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
+		{ OPTION_CALLBACK, 0, "am", &options, NULL,
+			N_("use apply-mail strategies to rebase"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_am },
 		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
 			N_("use merging strategies to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
@@ -1906,7 +1922,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc) {
+	if (options.git_am_opts.argc || options.type == REBASE_AM) {
 		/* all am options except -q are compatible only with --am */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
-- 
gitgitgadget

