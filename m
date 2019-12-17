Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1087BC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D92072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2EUKra8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLQKlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfLQKlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so10759934wrq.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+8SAi5y6uerHKVlb8p6GgTe/XE4+PO6Wi58s9vVSi/o=;
        b=f2EUKra8g50I6SLquvLpBk2hwb4TJAwjbFPpkeAyX0egwBilxOzIN/DHnio33z8uYi
         P/4D/5N9UqfBCwH7QIYNL5KPjEx4XJWw83Pus5r18AwUjsN8oW14IVWHWyiK2dlVYsQn
         rUOnyd8uNSCXzdWTdo1tNVCbOfbBvgPQYVQcuV/x+KUNoaDX46kdNHi6N5q3t/XTl7GJ
         8nmnKt6uJUFViCczaS32GdbSERik5u6ybiiBhOk1CI1cMR1v+R84bjroQdqHTisPYOFq
         Ea68+CYQ1IIN/2AXVCMJPxwqS39nWbNDxmVR1c2RbOMfK+rZbwVFGyGNMg4L0viNlURF
         GvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+8SAi5y6uerHKVlb8p6GgTe/XE4+PO6Wi58s9vVSi/o=;
        b=ATrtOPec3bV+sr/ijKPTwLSjicjRPbEzvwASrANlcynkGMKbBL95vl2kEwevjuYctW
         JbuWDgxM6cqzEMobgO6c2+EjsJlMSS0mDc0aKDUf7qozqv9T1zr4/IamM3hNWEPpVA3Y
         qdaVI4WnTg3PhGo1741w5qPdVAX9PTktfNES96hBgUhQoqN2a7b7/GzK/UweqiPqjWHB
         kGJo+knfmzNldKciu+wPJXbAHIUMFbuydCt8SzQYGYGWdat5Lk37L+S/+y4mDlofQSSw
         /OkQVjAGkzJm0QA9AxqRFZ80+hVKcmmyiut3UjnSYDutbGkkke8JimO7xzW1Y6tyBkgU
         Y6bw==
X-Gm-Message-State: APjAAAWLc4Ca7lJ5AA6LvEBOM4hMbYU/+o+U5MP/sXQbvkwND25FnFAy
        mZ3IZFCHJCB08D6mJHNYmHcKlJQz
X-Google-Smtp-Source: APXvYqzoI/teBcXUa6fv/DjqRdqp9ZFHeT/tEots4Q2Bh2dMxvK6ObeS4YbPO7jccY9ZsPmjOx1YXg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr34549730wrl.97.1576579268990;
        Tue, 17 Dec 2019 02:41:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n67sm2527642wmf.46.2019.12.17.02.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:08 -0800 (PST)
Message-Id: <cddc2cb9de645ecc49a74e94a73bcdf843035024.1576579264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:41:00 +0000
Subject: [PATCH 3/7] legacy stash -p: respect the add.interactive.usebuiltin
 setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As `git add` traditionally did not expose the `--patch=<mode>` modes via
command-line options, the scripted version of `git stash` had to call
`git add--interactive` directly.

But this prevents the built-in `add -p` from kicking in, as
`add--interactive` is the scripted version (which does not have a
"fall-back" to the built-in version).

So let's introduce support for internal switch for `git add` that the
scripted `git stash` can use to call the appropriate backend (scripted
or built-in, depending on `add.interactive.useBuiltin`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/add.c       | 14 ++++++++++++++
 git-legacy-stash.sh |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 583d8aab0d..f238e8b623 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -29,6 +29,7 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 static int add_renormalize;
+static int legacy_stash_p; /* support for the scripted `git stash` */
 
 struct update_callback_data {
 	int flags;
@@ -335,6 +336,8 @@ static struct option builtin_add_options[] = {
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
+	OPT_HIDDEN_BOOL(0, "legacy-stash-p", &legacy_stash_p,
+			N_("backend for `git stash -p`")),
 	OPT_END(),
 };
 
@@ -431,6 +434,17 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		add_interactive = 1;
 	if (add_interactive)
 		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
+	if (legacy_stash_p) {
+		struct pathspec pathspec;
+
+		parse_pathspec(&pathspec, 0,
+			PATHSPEC_PREFER_FULL |
+			PATHSPEC_SYMLINK_LEADING_PATH |
+			PATHSPEC_PREFIX_ORIGIN,
+			prefix, argv);
+
+		return run_add_interactive(NULL, "--patch=stash", &pathspec);
+	}
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index 07ad4a5459..ed039dfcbb 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -206,7 +206,7 @@ create_stash () {
 
 		# find out what the user wants
 		GIT_INDEX_FILE="$TMP-index" \
-			git add--interactive --patch=stash -- "$@" &&
+			git add --legacy-stash-p -- "$@" &&
 
 		# state of the working tree
 		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
-- 
gitgitgadget

