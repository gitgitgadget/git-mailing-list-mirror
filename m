Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CFC433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 06:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7AC6102A
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 06:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbhICGMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbhICGM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 02:12:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5DC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 23:11:30 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m21so4758891qkm.13
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcdNZ24Uh7jn1uirKiwwq6pZHG3hHv2Hovo07UlLW+0=;
        b=Cl5MsUgUTO0f0jxhvUXq0HQGYOpqzyzPt8mU/lJCEUmmTKZPd/X4As6Lkl8LaAYJGf
         iLdhm+/1wtl9geUySmicBrGHlLrH6vNnDyi6d43mCAH2skZHwvXQOUlFbJgxFy3cKftO
         yR5dXEw7sxzwM4gkRBff6yKCop5dY0/v7uJp4weHUGoPAqtVqN/3NkRryzYDUWk/+rKh
         WiCn6v89oF3O0TuW58LG2i+ZYK1qwAq8OO6ZL68Y3mdteMFgxLJx8EZ13J9fzx0IyYZt
         7xzG6MX+IJPDnkSIpZ9/ACifrjs5cFPaR5G4/C9UN+yIEnMXUNmN/Sk7xdTfQmxx9jHY
         aGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcdNZ24Uh7jn1uirKiwwq6pZHG3hHv2Hovo07UlLW+0=;
        b=YCZuWTo1f9ryRXSnl7QPBHlVM2u65nWkaWG2R1QEhmwwAbbnhMBH9N8wKFMDTam4eZ
         uLv97D9L9lpYKc4ak6cPp3CJISw5TKGNz0kgCBY3IQa8VALxn2fUhD069w7Jm/eCaNoO
         ZVaQlovVQ0nIJvttVUZ5jGOtLXW8qfXEN7MTVKkty2+FVUZCUryRTYqs3/GbCmmCIdi8
         463GkWvDcW/Na/hEt9meP31Bh/2okphtHaamB0Lm1bApuxHAi9tEX/2wf9hGtdMzSmFc
         H2m7tTpAjjKyUPqf5p8TJB/KNoRkgdOjXnmp5r8u8xlp1XdHzUeMwMKZEekQ3141IGky
         BFGw==
X-Gm-Message-State: AOAM532ptDY9Y36tWGHDpnhjr4Eh10GgadJLn3ug8fQUNt4o/EctprNy
        8ZB+i83kZdmqO7kkgZLUJwHFeTn6bRA=
X-Google-Smtp-Source: ABdhPJzd2WUIcnQERK5DF2imnAi8J2JqIrMuC/L1nEZb4ZLOBCxvJeqw+1LBoArXEPjW1ul3sZupGg==
X-Received: by 2002:a37:e43:: with SMTP id 64mr1890835qko.249.1630649489044;
        Thu, 02 Sep 2021 23:11:29 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r140sm3250474qke.15.2021.09.02.23.11.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 23:11:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] builtin/checkout: track the command use (checkout/switch) for advice
Date:   Thu,  2 Sep 2021 23:11:20 -0700
Message-Id: <20210903061120.31897-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using `git switch` to create a local branch to track a remote
one, and more than one remote has it, a helpful message will be
printed with instructions on how to resolve the ambiguity, but the
command used in the example will be confusingly `git checkout`.

Modify parse_remote_branch() so that a bit could be passed to it
to identify the source and print the same command used in the
advice.

Add a test for this new behaviour and while at it, modify the
old one to ensure backward compatibility and update it so no longer
uses the deprecated test_i18ngrep calls.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
The overloading of cb_option to track which command was invoked seems
fragile, but it was convenient to make this the minimal change required
for a bug fix.

I am hoping that part will be reverted (including moving it back to
where it was and that seemed more obvious for its current use), once
a better facility to differenciate is build (if there isn't one that
I obviously missed).

I originally though about sending it as an RFC because of that, but
since it is working code and with tests, assumed it was better use
of the scarse reviewer time this way; either way feedback welcomed.

 builtin/checkout.c       | 29 ++++++++++++++++++-----------
 t/t2024-checkout-dwim.sh | 20 ++++++++++++++++++--
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..607ed21c36 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -29,6 +29,11 @@
 #include "entry.h"
 #include "parallel-checkout.h"
 
+enum {
+	AMBIGUOS = (1<<0),
+	SWITCH = (1<<1),
+} checkout_resolution_flags;
+
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
@@ -1170,12 +1175,12 @@ static void setup_new_branch_info_and_source_tree(
 
 static const char *parse_remote_branch(const char *arg,
 				       struct object_id *rev,
-				       int could_be_checkout_paths)
+				       unsigned flags)
 {
 	int num_matches = 0;
 	const char *remote = unique_tracking_name(arg, rev, &num_matches);
 
-	if (remote && could_be_checkout_paths) {
+	if (remote && (flags & AMBIGUOS)) {
 		die(_("'%s' could be both a local file and a tracking branch.\n"
 			"Please use -- (and optionally --no-guess) to disambiguate"),
 		    arg);
@@ -1186,11 +1191,12 @@ static const char *parse_remote_branch(const char *arg,
 		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 			     "you can do so by fully qualifying the name with the --track option:\n"
 			     "\n"
-			     "    git checkout --track origin/<name>\n"
+			     "    git %s --track origin/<name>\n"
 			     "\n"
 			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."));
+			     "checkout.defaultRemote=origin in your config."),
+				flags & SWITCH ? "switch" : "checkout");
 	    }
 
 	    die(_("'%s' matched multiple (%d) remote tracking branches"),
@@ -1200,6 +1206,9 @@ static const char *parse_remote_branch(const char *arg,
 	return remote;
 }
 
+/* create-branch option (either b or c) */
+static char cb_option = 'b';
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1293,8 +1302,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		int could_be_checkout_paths = !has_dash_dash &&
-			check_filename(opts->prefix, arg);
+		unsigned flags = (cb_option == 'c') ? SWITCH : 0;
+
+		if (!has_dash_dash && check_filename(opts->prefix, arg))
+			flags |= AMBIGUOS;
 
 		if (!has_dash_dash && !no_wildcard(arg))
 			recover_with_dwim = 0;
@@ -1309,8 +1320,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
-			const char *remote = parse_remote_branch(arg, rev,
-								 could_be_checkout_paths);
+			const char *remote = parse_remote_branch(arg, rev, flags);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1571,9 +1581,6 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-/* create-branch option (either b or c) */
-static char cb_option = 'b';
-
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 const char * const usagestr[])
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 4a1c901456..71656d6545 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -105,12 +105,28 @@ test_expect_success 'checkout of branch from multiple remotes fails with advice'
 	test_must_fail git checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
-	test_i18ngrep "^hint: " stderr &&
+	grep "^hint: " stderr &&
+	grep "git checkout" stderr &&
 	test_must_fail git -c advice.checkoutAmbiguousRemoteBranchName=false \
 		checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
-	test_i18ngrep ! "^hint: " stderr
+	! grep "^hint: " stderr
+'
+
+test_expect_success 'switch of branch from multiple remotes fails with advice' '
+	git checkout -B main &&
+	test_might_fail git branch -D foo &&
+	test_must_fail git switch foo 2>stderr &&
+	test_branch main &&
+	status_uno_is_clean &&
+	grep "^hint: " stderr &&
+	grep "git switch" stderr &&
+	test_must_fail git -c advice.checkoutAmbiguousRemoteBranchName=false \
+		switch foo 2>stderr &&
+	test_branch main &&
+	status_uno_is_clean &&
+	! grep "^hint: " stderr
 '
 
 test_expect_success PERL 'checkout -p with multiple remotes does not print advice' '
-- 
2.33.0.481.g26d3bed244

