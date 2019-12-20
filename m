Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D8C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5186A21D7E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB4hxB+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLTRKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44839 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id bx28so8914826edb.11
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SqstD6Ny1wmIne0e4CGcwdjJwhTnn5W/eNQ8HxFO2dQ=;
        b=CB4hxB+zjkUFo3KVZ5+cdj5EbEWR858iNpxBCuqZEIPopMpC+Mpy+Q3ct1QZQZYJNw
         tv3quyklSYQvndC9PFsEMniTaMbV3O6GRScAdTZn+8wwtfFy1owR688XkldHqKuoUWrv
         nenqvSJESg9PaQFYXhhJqdazwYXMBJxT6WolQG37jkrOFXupAZ7d0IrQXGLRGMZKp6pN
         aV+T7yk3c2RL8oDmqW/Cs7kv2mYBJY0W0Sx9m13TKHuTsBNrHCBZ5KWUYB9dyw54hIWI
         fFQ/nGIAZHS5fMglZ/PZ5An2kWbimJzHiG9GgBu8qeh55kxtqopltBt9C1cvY3luOUQG
         fAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SqstD6Ny1wmIne0e4CGcwdjJwhTnn5W/eNQ8HxFO2dQ=;
        b=M9+IzYhm1o7P97MxGHmgCAXQqnZKlFMLqsAEBzt5L9/MwmW7vh58VO0oome5pEEkO8
         8uiaPdkKsbYSRUx2IiQoVVRTsoPsddMIxIcojFOxCAygenqr2glvPYYCPMAckDwDvbi+
         ArUWc/WGEKwkI4Iqxg6KKAVZnIwn3/XWi4vqFgUpFg0a5FkxNmHFWn4qLcUtKoUogCXr
         nbKhqxyc3wZC2cKsRQg3coMICCQ/lfI7VWhpEZz6ubmw7kEa2AQghHkAOw1Z8+RL0si7
         u/RJBxlqV1VYG+AW2ck5zUjhi+kvD2FoxWJRCDrHVG5Esn24gL3m45zcXXmt1WQA2lY3
         Mpwg==
X-Gm-Message-State: APjAAAUQFEBsD1HeV1pXGDniRbmlOOhKUeVreRIe3o1N/a39iXYRTK45
        imbL5z9E9HkjSstrNTvOrmJu9MI+
X-Google-Smtp-Source: APXvYqy63tPa942Jx9H09n1c+NuwujIRSoPEwJyCdX8SNtXfEtNnb8u3u7Rv5GaCi0DFsSnCe+/nvw==
X-Received: by 2002:a50:b82c:: with SMTP id j41mr9417563ede.199.1576861797512;
        Fri, 20 Dec 2019 09:09:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm1032887edq.5.2019.12.20.09.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:57 -0800 (PST)
Message-Id: <340bf71c5cd2086c638a652d1e111876a723fc6a.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:43 +0000
Subject: [PATCH 10/15] rebase: add an --am option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
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
index 9e7e88b147..ab9e16b206 100644
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
@@ -1550,6 +1562,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1910,7 +1926,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc) {
+	if (options.git_am_opts.argc || options.type == REBASE_AM) {
 		/* all am options except -q are compatible only with --am */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
-- 
gitgitgadget

