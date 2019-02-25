Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD3620248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfBYXRL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43312 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfBYXRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so11793782wre.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeUSnj9kZA4cPAQk5+NXKnid1oJWkE89qx//1rGw4Dw=;
        b=fzWmY7mWfM2KWpcPCMO9pQi84ErrSUTzW9jLFgsdDYVbp1ry78b6zHNoLNvCX0vXpu
         Qbx1n0muEhY1mdwTQxaK2EksJJXsb+mYpsbVbopALD8T3smwOPXvhkUa7EXhmdbgiZyK
         /J5D3+nDuHVBtjTENRNosMkVMQIL29UkE0Slul61wBhV3yJ6ueTfM0JFTDpqGWM3h7bj
         jdUtAO6WSL3YsW2x3H5ET+5hsKfaF079Z/bMk0r8FZ6FZHUA+Jd5l2wvPDt2MEZNo6/p
         uEA/CoH/5vqqpjspvr+qkT2+kABAYzxQwHN3K4Awpou0lONj1JWriRuZH4GpephcOV0w
         gIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeUSnj9kZA4cPAQk5+NXKnid1oJWkE89qx//1rGw4Dw=;
        b=BV+1zKfT9lTB/p8b+sat7mymIlY4GA0YQIwcQVIPQ60iLAzKASEUFhp/c/7O/1TANr
         whKoaFW6BL3hRGK8AAQAbyO2OMHngy7NkDSnCcQ9Cs8cMc5RQJZgOANhhEB2dRniLQHc
         0yf4FRwrSNr3YWihPP5RVk6T+Tu61snGjxSsSIawBO72HfO6GXrcW1Hydc5Rgwgg6KKf
         lfSV6aNDmyKkeUQ0gcNw10bgJGNQC+jO42Z5ncKjbTOZGaynYQKhjPzk1Tk0P0mQpSZd
         ks2K2YtpGa/sw1775ytTxdxgV2D+vV0tCjuoJaryqdB208N90KCwdHdgR6x2eb+1u88p
         OiAA==
X-Gm-Message-State: AHQUAuZY6YXWKNKqgruSnCNe6rTFa8Rwv05ERtw38udnpz694Fb3b34/
        psxRiCpo1vMj9dXdGtcJIdKLWMqR
X-Google-Smtp-Source: AHgI3IamolSqCS2S0FbL4Xd4wOeaecetohZqOhUAztdGt61GEiOrzBJ2/Po6sWnXqU5Kq/9f42i/jg==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr13824030wrw.72.1551136627875;
        Mon, 25 Feb 2019 15:17:07 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id n129sm8995224wmf.21.2019.02.25.15.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:06 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 13/27] stash: convert branch to builtin
Date:   Mon, 25 Feb 2019 23:16:17 +0000
Message-Id: <20190225231631.30507-14-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash branch to the helper and delete the apply_to_branch
function from the shell script.

Checkout does not currently provide a function for checking out
a branch as cmd_checkout does a large amount of sanity checks
first that we require here.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 46 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++-------------
 2 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index c515f0b358..c9874e2f5d 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -14,6 +14,7 @@
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
 };
@@ -28,6 +29,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_clear_usage[] = {
 	N_("git stash--helper clear"),
 	NULL
@@ -536,6 +542,44 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	const char *branch = NULL;
+	struct stash_info info;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_branch_usage, 0);
+
+	if (!argc) {
+		fprintf_ln(stderr, _("No branch name specified"));
+		return -1;
+	}
+
+	branch = argv[0];
+
+	if (get_stash_info(&info, argc - 1, argv + 1))
+		return -1;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "checkout", "-b", NULL);
+	argv_array_push(&cp.args, branch);
+	argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
+	ret = run_command(&cp);
+	if (!ret)
+		ret = do_apply_stash(prefix, &info, 1, 0);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info, 0);
+
+	free_stash_info(&info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -562,6 +606,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		return !!branch_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index b8f70230f9..67db321a4c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -615,20 +615,6 @@ drop_stash () {
 	clear_stash
 }
 
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -690,7 +676,8 @@ pop)
 	;;
 branch)
 	shift
-	apply_to_branch "$@"
+	cd "$START_DIR"
+	git stash--helper branch "$@"
 	;;
 *)
 	case $# in
-- 
2.21.0.rc2.291.g17236886c5

