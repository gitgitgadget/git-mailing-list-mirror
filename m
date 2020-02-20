Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29A5C11D0A
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF0F208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz6wRVm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBTOPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:15:31 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35271 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgBTOPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:15:30 -0500
Received: by mail-wm1-f42.google.com with SMTP id b17so2230552wmb.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpPsizAx1REte/H4RpYeY3J30V7EBkwmGV+AmNPsm9E=;
        b=dz6wRVm5SHmsCKk/H1Ae3tdDk2Dmn0pdQdLva3aemmPElv9CrsX7YFLz9ubGK1bz9Z
         1tGHECpIq88N1vHPKyZxJgIuFtfBlXlMN2Ls52Nd0ijMBsnQBGGY8IZmhuQnqMURB6Q3
         u8hNuawD/PHlTpvcGiNnpVGXAJgE7zOlglh/g8k6dkWZAEwHNu4Img25LuXuvBqwMb0v
         cfq1IwOxu3zCMNbvg9/DPO3uY4kJy8TXAffiMv2Gxb//473axpXAUXMTJ4GRJgJnwE/t
         JCUDn4LdQ5YrDk7fWiMo5phUMpdJaf4gWV9k63eBt5rYoPrVRIQ0fqo/S5GYBIgfsW8c
         etMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jpPsizAx1REte/H4RpYeY3J30V7EBkwmGV+AmNPsm9E=;
        b=ub0cv1b6dIxhoff8Ag+ilSbsSBGkNoWideqcIEidukI2h9fQHssMKcD2igVa4VhiZ7
         QgxcdfOUMCBTf3fv0fWnuFDO97ymfnk8QMMFqrQTx6tNzFsY1vonHCLeniqMEgj8N/G+
         AF9eInD3VX4mcyKisaqE83Ge/GL4XcFTJW8XXM3+2Xok8avMEMvoQdf0Z3pZvH+NKAGx
         PlxQRPnZtwMUrmcukfsjbA8gGP1Mbf2VHTerIVCaf1qB/QjzraUmgfH0bal6YD2I0qUF
         YtEzmZ0fD4Y2OgTuB8I8/2BKEwGlKz5wiZYO6N8PXGUn5orpY/y7SmBjJwrp09bSnx3c
         lG8Q==
X-Gm-Message-State: APjAAAUTg2evxr9RKXzc5htRcBXOA/bqivAFUhKcn+P5y+8PTZQ7Bffk
        dezq/d54XR/KT+v8+RbxeA3Sa+/h
X-Google-Smtp-Source: APXvYqzNKg4Np3ncnQIcnxcZR+SPww2SsC1/0DFMFqGoXtSro7XRHfGGqf2uSsJav8lMTitt1b0kyQ==
X-Received: by 2002:a1c:610a:: with SMTP id v10mr4713482wmb.44.1582208127048;
        Thu, 20 Feb 2020 06:15:27 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id v15sm4933614wrf.7.2020.02.20.06.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:15:26 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH v2 5/5] am: support --show-current-patch=diff to retrieve .git/rebase-apply/patch
Date:   Thu, 20 Feb 2020 15:15:19 +0100
Message-Id: <20200220141519.28315-6-pbonzini@redhat.com>
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
is somewhat misguided; for example, the output of "git am --show-current-patch"
cannot be passed to "git apply" if it is encoded as quoted-printable
or base64.  Add a new mode to "git am --show-current-patch" in order to
straighten the suggestion.

Reported-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: - replace "diff|raw" with "(diff|raw)" in docs and help [Eric]
	- improve docs wording [Eric]

 Documentation/git-am.txt               | 11 ++++++-----
 builtin/am.c                           |  9 +++++++--
 contrib/completion/git-completion.bash |  2 +-
 t/t4150-am.sh                          | 10 ++++++++++
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 590b711536..ab5754e05d 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=raw])
+'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
 DESCRIPTION
 -----------
@@ -176,10 +176,11 @@ default.   You can use `--no-utf8` to override this.
 	Abort the patching operation but keep HEAD and the index
 	untouched.
 
---show-current-patch[=raw]::
-	Show the raw contents of the e-mail message at which `git am`
-	has stopped due to conflicts.  The argument must be omitted or
-	`raw`.
+--show-current-patch[=(diff|raw)]::
+	Show the message at which `git am` has stopped due to
+	conflicts.  If `raw` is specified, show the raw contents of
+	the e-mail message; if `diff`, show the diff portion only.
+	Defaults to `raw`.
 
 DISCUSSION
 ----------
diff --git a/builtin/am.c b/builtin/am.c
index 54b04da86d..e3dfd93c25 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -83,6 +83,7 @@ enum signoff_type {
 
 enum show_patch_type {
 	SHOW_PATCH_RAW = 0,
+	SHOW_PATCH_DIFF = 1,
 };
 
 struct am_state {
@@ -1767,7 +1768,7 @@ static void am_run(struct am_state *state, int resume)
 				linelen(state->msg), state->msg);
 
 			if (advice_amworkdir)
-				advise(_("Use 'git am --show-current-patch' to see the failed patch"));
+				advise(_("Use 'git am --show-current-patch=diff' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
@@ -2086,6 +2087,9 @@ static int show_patch(struct am_state *state, enum show_patch_type sub_mode)
 	case SHOW_PATCH_RAW:
 		patch_path = am_path(state, msgnum(state));
 		break;
+	case SHOW_PATCH_DIFF:
+		patch_path = am_path(state, "patch");
+		break;
 	default:
 		BUG("invalid mode for --show-current-patch");
 	}
@@ -2154,6 +2158,7 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	 * when you add new options
 	 */
 	const char *valid_modes[] = {
+		[SHOW_PATCH_DIFF] = "diff",
 		[SHOW_PATCH_RAW] = "raw"
 	};
 	int new_value = SHOW_PATCH_RAW;
@@ -2279,7 +2284,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("abort the patching operation but keep HEAD where it is."),
 			RESUME_QUIT),
 		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
-		  "raw",
+		  "(diff|raw)",
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 247f34f1fa..1151697f01 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1197,7 +1197,7 @@ __git_count_arguments ()
 
 __git_whitespacelist="nowarn warn error error-all fix"
 __git_patchformat="mbox stgit stgit-series hg mboxrd"
-__git_showcurrentpatch="raw"
+__git_showcurrentpatch="diff raw"
 __git_am_inprogress_options="--skip --continue --resolved --abort --quit --show-current-patch"
 
 _git_am ()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index afe456e75e..cb45271457 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -671,11 +671,21 @@ test_expect_success 'am --show-current-patch=raw' '
 	test_cmp .git/rebase-apply/0001 actual.patch
 '
 
+test_expect_success 'am --show-current-patch=diff' '
+	git am --show-current-patch=diff >actual.patch &&
+	test_cmp .git/rebase-apply/patch actual.patch
+'
+
 test_expect_success 'am accepts repeated --show-current-patch' '
 	git am --show-current-patch --show-current-patch=raw >actual.patch &&
 	test_cmp .git/rebase-apply/0001 actual.patch
 '
 
+test_expect_success 'am detects incompatible --show-current-patch' '
+	test_must_fail git am --show-current-patch=raw --show-current-patch=diff &&
+	test_must_fail git am --show-current-patch --show-current-patch=diff
+'
+
 test_expect_success 'am --skip works' '
 	echo goodbye >expected &&
 	git am --skip &&
-- 
2.21.1

