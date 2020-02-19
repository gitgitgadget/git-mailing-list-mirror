Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE1C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775B520675
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1lglpoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSQOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:14:11 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40714 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:14:11 -0500
Received: by mail-wr1-f49.google.com with SMTP id t3so1199053wru.7
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZc997ckn6kp4dK/Hk+8BpdGIfSdwgWpn9n/ahI8q+w=;
        b=m1lglpoBZiGscOL0xfWe7Nrj0+je5JTdXTtYydV2DQt4sFO92id7Iz3dtpElrXJJIc
         0NnSRCdo3CQVxpnnykhfdkiMMR7ltt+tKXGHgKWYCfAZObUrnNUSbjimBPCuP0yTmIgV
         7TXOjtIvXTjqtKgr/id/ktDXxwymeLo7yToH4wAt9ICZxw9Gvjj5Nkp/mLDnnQJWq3J0
         WdkPygtb9JFMKg3yVgie7hf04KHwKL2kK4iZ8pWjwKSoD4qxey1hJPs1P2dUcesTNNHh
         9H+uD+AlSQsdz7uzlblese5sWvZRFcR8nr1gTuIShwyjAuUV7WwFGk7R7ClvQk5fqViS
         FGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eZc997ckn6kp4dK/Hk+8BpdGIfSdwgWpn9n/ahI8q+w=;
        b=SwisVlLCG8TEPD5+jlsM8QC9yrBtOSladUa1Ts30OLF6ymUJ0YMpp3AlUBgPrwXkNF
         MU/eYDYR75Y7F9iL/9zL95TsY+jvtJcZvuLby9bhZpGdTQaE6I5BRKpsO74iiNpH/+ty
         HKuDG/P4QAM++JHR+xNDLujD0vxaRDfQqieE1CT7wq6uCnYQIHh10nMyNLlxwHPGjY7c
         fnO6ZXJ1UTZk4BbMOwyH3tmOpiR5uT29ldtHt7VsxCmMMwiPQvO8GEUfE+2H0xWuKx9s
         dGIzJVVcjJ69v0HNKrm5rbogMp94qv5c847TJcBsJvStKPKopWhovUS7o94h1Tzbcg90
         N5fw==
X-Gm-Message-State: APjAAAVvq8QSzwm01HN/TgBqifxqB+MBa2Sb5CJnjnO9Hd3r4wNJs8bp
        D9GcyYg4btFYxIplZlqes8r9VlKo
X-Google-Smtp-Source: APXvYqzxf0xysAK+kE7nl/z48ZzU+tOthC5wFP6oGRT6n2XlVWamMOz1VvjQgdMed29XBq5L+nU9tA==
X-Received: by 2002:adf:db48:: with SMTP id f8mr34751262wrj.146.1582128848317;
        Wed, 19 Feb 2020 08:14:08 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id w7sm376771wmi.9.2020.02.19.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:14:07 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     bfields@redhat.com
Subject: [PATCH 3/4] am: support --show-current-patch=raw as a synonym for--show-current-patch
Date:   Wed, 19 Feb 2020 17:13:51 +0100
Message-Id: <20200219161352.13562-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219161352.13562-1-pbonzini@redhat.com>
References: <20200219161352.13562-1-pbonzini@redhat.com>
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
is misguided, for example the output "git am --show-current-patch" cannot
be passed to "git apply" if it is encoded as quoted-printable or base64.

We would like therefore to add a new mode to "git am" that copies
.git/rebase-merge/patch to stdout.  In order to preserve backwards
compatibility, "git am --show-current-patch"'s behavior as to stay as
is, and the new functionality will be added as an optional
argument to --show-current-patch.  As a start, add the code to parse
submodes.  For now "raw" is the only valid submode, and it prints
the full e-mail message just like "git am --show-current-patch".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-am.txt               |  4 +-
 builtin/am.c                           | 59 +++++++++++++++++++++++---
 contrib/completion/git-completion.bash |  5 +++
 t/t4150-am.sh                          | 10 +++++
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 11ca61b00b..bafb491ede 100644
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
@@ -176,7 +176,7 @@ default.   You can use `--no-utf8` to override this.
 	Abort the patching operation but keep HEAD and the index
 	untouched.
 
---show-current-patch::
+--show-current-patch[=raw]::
 	Show the entire e-mail message "git am" has stopped at, because
 	of conflicts.
 
diff --git a/builtin/am.c b/builtin/am.c
index a89e1a96ed..ec4c743556 100644
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
+		abort();
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


