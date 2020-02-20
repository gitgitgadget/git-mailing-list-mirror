Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E2C11D07
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B75B206E2
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWrZYjzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgBTOP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:15:29 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:32891 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgBTOP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:15:28 -0500
Received: by mail-wr1-f54.google.com with SMTP id u6so4870580wrt.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNAGJxfV0TyhQghtJnVVnHa7xXHb+lobNGL8nHTF+TE=;
        b=RWrZYjzV6VlZqh7MS9A+zs0ut5OZY60OAXHzJEiRdfvF8So2/GDZ8EDoc8VDId+Zm3
         9fMGkMEbxI83pFr0M2sSDG33/MuQDosn/bpI0+V92QNpFCe5YYD2PlIDRLfE03vg7NRL
         vVghmgY4a4xGzWuhbw3JfXlt4bm8jIIB+fDG853/NgydSGQ2lvJtCbWOXcalbl7Jzb19
         n2rtZwVnlA86S8lgxB+rm1jNXXq51SaiNhHJ33KSMM6Fmk87WBnsggv/z8InSVK8wZcq
         KE9qfE9L39Wa3zKGSvcAZ17/Wxvfd8huKDlLE1PyZ9OQ3N69ANv807qLOa1W69MDKUbH
         mLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rNAGJxfV0TyhQghtJnVVnHa7xXHb+lobNGL8nHTF+TE=;
        b=fhWJxrs/JoQG66ZPFfGxZEa4hxPYNyeI1QOEcHITna+GHQBVBOmXg5aQUErkmQW5oL
         acSB/lj/RPkNQmLM+fWoNFUs8Ho7B4Q+1izzYiA0eRnMocWyNxKtHIi8qQM3I2Nu40Us
         f044VHLrDM9N6XhOgnlLfRpX5z9ypvWm1IpTnhGnbJO2i+PuXhhbsXjKjCDWGrKw//RI
         eKhKgequh10Uro+ShBa2bvqWg2y3vwJ9TJuBeTAxDpeuBrixXk6Rp+CKEosmynv1F7Bn
         0/0knXOP1U7Yp0l4pvFU1zbeGIer7w2cld1NsTKPWRV99u1912Lz1K4p536wqUHYdWoH
         7Gxw==
X-Gm-Message-State: APjAAAVHwhLTS6XpkfkB8zMZQjcC6i5d/hK4O71gI3C8yJJPM3RJlibu
        sCBg61KUTJgkbnHf+IhT8UBsz5pM
X-Google-Smtp-Source: APXvYqxiGAY1tapUURb3ysLeMe2Ttb1QZqP/spsrUsgXndZszbWbT+fYKSWhKM9JUOBSJc3nE0/XcA==
X-Received: by 2002:adf:f109:: with SMTP id r9mr41679357wro.406.1582208125802;
        Thu, 20 Feb 2020 06:15:25 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id v15sm4933614wrf.7.2020.02.20.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:15:25 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH v2 4/5] am: support --show-current-patch=raw as a synonym for--show-current-patch
Date:   Thu, 20 Feb 2020 15:15:18 +0100
Message-Id: <20200220141519.28315-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220141519.28315-1-pbonzini@redhat.com>
References: <20200220141519.28315-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

When "git am --show-current-patch" was added in commit 984913a210 ("am:
add --show-current-patch", 2018-02-12), "git am" started recommending it
as a replacement for .git/rebase-merge/patch.  Unfortunately the suggestion
is somewhat misguided; for example, the output "git am --show-current-patch"
cannot be passed to "git apply" if it is encoded as quoted-printable or
base64.  To simplify worktree operations and to avoid that users poke into
.git, it would be better if "git am" also provided a mode that copies
.git/rebase-merge/patch to stdout.

One possibility could be to have completely separate options, introducing
for example --show-current-message (for .git/rebase-apply/NNNN)
and --show-current-diff (for .git/rebase-apply/patch), while possibly
deprecating --show-current-patch.

That would even remove the need for the first two patches in the series.
However, the long common prefix would have prevented using an abbreviated
option such as "--show".  Therefore, I chose instead to add a string
argument to --show-current-patch.  The new argument is optional, so that
"git am --show-current-patch"'s behavior remains backwards-compatible.

The next choice to make is how to handle multiple --show-current-patch
options.  Right now, something like "git am --abort --show-current-patch"
is rejected, and the previous suggestion would likewise have naturally
rejected a command line like

	git am --show-current-message --show-current-diff

Therefore, I decided to also reject for example

	git am --show-current-patch=diff --show-current-patch=raw

In other words the whole of --show-current-patch=xxx (including the
optional argument) is treated as the command mode.  I found this to be
more consistent and intuitive, even though it differs from the usual
"last one wins" semantics of the git command line.

Add the code to parse submodes based on the above design, where for now
"raw" is the only valid submode.  "raw" prints the full e-mail message
just like "git am --show-current-patch".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: - improve commit messages [Junio]
	- replace abort with BUG [Eric]

 Documentation/git-am.txt               |  9 ++--
 builtin/am.c                           | 59 +++++++++++++++++++++++---
 contrib/completion/git-completion.bash |  5 +++
 t/t4150-am.sh                          | 10 +++++
 4 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 11ca61b00b..590b711536 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort | --quit | --show-current-patch)
+'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=raw])
 
 DESCRIPTION
 -----------
@@ -176,9 +176,10 @@ default.   You can use `--no-utf8` to override this.
 	Abort the patching operation but keep HEAD and the index
 	untouched.
 
---show-current-patch::
-	Show the entire e-mail message "git am" has stopped at, because
-	of conflicts.
+--show-current-patch[=raw]::
+	Show the raw contents of the e-mail message at which `git am`
+	has stopped due to conflicts.  The argument must be omitted or
+	`raw`.
 
 DISCUSSION
 ----------
diff --git a/builtin/am.c b/builtin/am.c
index bd3cda8bec..54b04da86d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -81,6 +81,10 @@ enum signoff_type {
 	SIGNOFF_EXPLICIT /* --signoff was set on the command-line */
 };
 
+enum show_patch_type {
+	SHOW_PATCH_RAW = 0,
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -2061,7 +2065,7 @@ static void am_abort(struct am_state *state)
 	am_destroy(state);
 }
 
-static int show_patch(struct am_state *state)
+static int show_patch(struct am_state *state, enum show_patch_type sub_mode)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *patch_path;
@@ -2078,7 +2082,14 @@ static int show_patch(struct am_state *state)
 		return ret;
 	}
 
-	patch_path = am_path(state, msgnum(state));
+	switch (sub_mode) {
+	case SHOW_PATCH_RAW:
+		patch_path = am_path(state, msgnum(state));
+		break;
+	default:
+		BUG("invalid mode for --show-current-patch");
+	}
+
 	len = strbuf_read_file(&sb, patch_path, 0);
 	if (len < 0)
 		die_errno(_("failed to read '%s'"), patch_path);
@@ -2130,8 +2141,42 @@ enum resume_type {
 
 struct resume_mode {
 	enum resume_type mode;
+	enum show_patch_type sub_mode;
 };
 
+static int parse_opt_show_current_patch(const struct option *opt, const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+	struct resume_mode *resume = container_of(opt_value, struct resume_mode, mode);
+
+	/*
+	 * Please update $__git_showcurrentpatch in git-completion.bash
+	 * when you add new options
+	 */
+	const char *valid_modes[] = {
+		[SHOW_PATCH_RAW] = "raw"
+	};
+	int new_value = SHOW_PATCH_RAW;
+
+	if (arg) {
+		for (new_value = 0; new_value < ARRAY_SIZE(valid_modes); new_value++) {
+			if (!strcmp(arg, valid_modes[new_value]))
+				break;
+		}
+		if (new_value >= ARRAY_SIZE(valid_modes))
+			return error(_("Invalid value for --show-current-patch: %s"), arg);
+	}
+
+	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
+		return error(_("--show-current-patch=%s is incompatible with "
+			       "--show-current-patch=%s"),
+			     arg, valid_modes[resume->sub_mode]);
+
+	resume->mode = RESUME_SHOW_PATCH;
+	resume->sub_mode = new_value;
+	return 0;
+}
+
 static int git_am_config(const char *k, const char *v, void *cb)
 {
 	int status;
@@ -2233,9 +2278,11 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "quit", &resume.mode,
 			N_("abort the patching operation but keep HEAD where it is."),
 			RESUME_QUIT),
-		OPT_CMDMODE(0, "show-current-patch", &resume.mode,
-			N_("show the patch being applied."),
-			RESUME_SHOW_PATCH),
+		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
+		  "raw",
+		  N_("show the patch being applied"),
+		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2354,7 +2401,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		am_destroy(&state);
 		break;
 	case RESUME_SHOW_PATCH:
-		ret = show_patch(&state);
+		ret = show_patch(&state, resume.sub_mode);
 		break;
 	default:
 		BUG("invalid resume value");
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1aac5a56c0..247f34f1fa 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1197,6 +1197,7 @@ __git_count_arguments ()
 
 __git_whitespacelist="nowarn warn error error-all fix"
 __git_patchformat="mbox stgit stgit-series hg mboxrd"
+__git_showcurrentpatch="raw"
 __git_am_inprogress_options="--skip --continue --resolved --abort --quit --show-current-patch"
 
 _git_am ()
@@ -1215,6 +1216,10 @@ _git_am ()
 		__gitcomp "$__git_patchformat" "" "${cur##--patch-format=}"
 		return
 		;;
+	--show-current-patch=*)
+		__gitcomp "$__git_showcurrentpatch" "" "${cur##--show-current-patch=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin am "" \
 			"$__git_am_inprogress_options"
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 4f1e24ecbe..afe456e75e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -666,6 +666,16 @@ test_expect_success 'am --show-current-patch' '
 	test_cmp .git/rebase-apply/0001 actual.patch
 '
 
+test_expect_success 'am --show-current-patch=raw' '
+	git am --show-current-patch=raw >actual.patch &&
+	test_cmp .git/rebase-apply/0001 actual.patch
+'
+
+test_expect_success 'am accepts repeated --show-current-patch' '
+	git am --show-current-patch --show-current-patch=raw >actual.patch &&
+	test_cmp .git/rebase-apply/0001 actual.patch
+'
+
 test_expect_success 'am --skip works' '
 	echo goodbye >expected &&
 	git am --skip &&
-- 
2.21.1


