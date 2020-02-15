Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF528C76195
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A340020718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLEx9wQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBOVhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37891 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgBOVgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so15115009wrh.5
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hbUII9xEJWLRTvnSRMlVPOQoTvuwP3CVkCP0W1Vl2Ps=;
        b=pLEx9wQ9Z2Y8wlaCj+qaj8N1/6n6hDMrAd9WWPhJaUYLtSEOXwgQgwjwm5SOEZ6f50
         W8St5ZlRdVyPx6K4HHPhI1rQe8quIH4ATRgMuoh/MZAJnNcKdj89SxHjbPgzGs+DIs/b
         f/FaDJBYJ9MEV1RXvjFTgJpv4W/YMdja6l3l8lDK6JzREFEE+W5iVOw6OSIU7WBeSNmg
         6n8aU73Zw6RXQgOzX5FytI6FCmqpW1m58f+9Jy6P5KRAagY2azcTV9mh9Bw+GnHpLZUY
         YqdpoegYbgt8aYvj7yHc23eWvvAYZeOeV45zXlK/TdlD8WmZfyJKz0Pdno7G1oT0iL/g
         wW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hbUII9xEJWLRTvnSRMlVPOQoTvuwP3CVkCP0W1Vl2Ps=;
        b=uS7Ly7pJtlgCeT9iVagZj+vVvquu7Oe5f4DMvh+QVmPz6B4k9vkfm+8RHVJapOBEAz
         hnkF65SWS5L6aDYuBsLiI1oHmmdB19xsJIvHVlQopu89cajFVLoQ4pnMonsZ4vnVKDtx
         wmt5BD3e3q7KA5OTUeGieEQvettyFe2TAbsqEWdkJQu0wPg9+SN6+CynI0Qnwt6qPBfl
         yPhvekV/CB13acLSyTmKaWrVBEr9gFtQyz9aDXbTzakw/IO9BEzR482JYcj1gCUYbpMX
         3OURAqqmcyqOPVRiiu29Ih3zC8i4OOfoxytk0/iIeXwzClrlGnUHfRHnXebChJ+FgWLd
         uRuA==
X-Gm-Message-State: APjAAAWXOC5oIrn7GwAWqtsDR6wzflZfD7q58H4LMX8Wuphd8oz23Zcw
        otSap7V7U5v55hCi1YKw+3CF2bZr
X-Google-Smtp-Source: APXvYqxbn1ic3QPCBGnluQoXg0yF3zspWST+6qfHWfgIMGe9hcxl7L8ZQ9ZFFm4asXTJQhbFmw3zag==
X-Received: by 2002:adf:8442:: with SMTP id 60mr11836997wrf.416.1581802613016;
        Sat, 15 Feb 2020 13:36:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm12775197wrt.37.2020.02.15.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:52 -0800 (PST)
Message-Id: <de1b0aaca88674d95083a22c09be44c5cdaea663.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:34 +0000
Subject: [PATCH v5 13/20] rebase: add an --am option
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
index 6e2569cd8a7..93092da3bf6 100644
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
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
@@ -378,7 +385,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.
+	ever ignored.  Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -418,6 +425,7 @@ with `--keep-base` in order to drop those commits from your branch.
 --whitespace=<option>::
 	These flags are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
+	Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -561,6 +569,7 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
+ * --am
  * --committer-date-is-author-date
  * --ignore-date
  * --ignore-whitespace
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a2f05f783d8..77abe674cb9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1335,6 +1335,18 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
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
@@ -1519,6 +1531,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1878,7 +1894,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc) {
+	if (options.git_am_opts.argc || options.type == REBASE_AM) {
 		/* all am options except -q are compatible only with --am */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
-- 
gitgitgadget

