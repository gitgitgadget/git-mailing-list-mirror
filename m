Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8636C2D0D2
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE064206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh+VRYV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfLUV5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33577 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLUV5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so12024228edq.0
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZAzk+dyQS+fde6JUpQyd4vd2dkIGGQ6o2+2UPs2QMz4=;
        b=Nh+VRYV/FCHwNxA6Occr5mD5PZXl1/lxGxQY9FOz0Gtp2xiZzfbr4/ZFE+iGmCW6DL
         hti2ZMOxwJKx4ltjA7bh2PtyA4ssl/BRwRMo+DocIWxnUBb2c7NNXwpvQGY9QKTfTpNf
         7c1wnYu66TTZMy+GrmG4agu12KVG4dIwn5zlJytcHiW6I+R2SU9K5cLl3xHTgmX7gD1b
         xhKgtN20aNVjJSROLaTokI9covgIfvbOiQDtIFHPKiqrtenDfqq13yE/CIb5nRCLcgEt
         oJpurIpx2bcmBk3xLrciX1tVZrEKuHT8Jx2lH0wYxxEW+x+ayICMZeqqPRpZyudaVSAz
         ANGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZAzk+dyQS+fde6JUpQyd4vd2dkIGGQ6o2+2UPs2QMz4=;
        b=AXKhfmm5nIOHX1Bh/NAjNB44qVZa4HZV8KiXf+CxH57z2UtWnbyIV6KZtGVC+388DC
         NA3vJ59beHe+e3l/t8SDmo8aSMKTeL/LCPo7ktWKqz9RFxoRH3Mk7Y760NxJj6X6j90e
         8rlSjzrVoBr5Y01jT1pU7M6g/9vxMDlWwvWIfKpl8GZgjt2P2KvGxzE2sh6whKysheQM
         KS5FWKQwMVYqb2hdJjePzwQEGllXGX9/sHhyX15fUb1XveX1fJY+xi+HOWwBvXmPxszS
         LsNvO6JT9gZoxYbpDQjs1eqGeLfEyYXeLgM515EGlgS26tSu5mp1b4fihu0hWxTqyjEE
         d+yQ==
X-Gm-Message-State: APjAAAX6CkVqX/fO3sP+4uwEwN/1ail0HHFl3nffLA4Z4my1RtzZgJE3
        9Qc2Q0sC5T7H3EPx2E+MxKDhVDm2
X-Google-Smtp-Source: APXvYqyl3nDBF5diiM3WzJkGEEIyH1Alc3V/7dsOof2qhK+czSS0QaBSCKGpJY4/Q+7VX1WLzjrQgQ==
X-Received: by 2002:a05:6402:1595:: with SMTP id c21mr24441464edv.32.1576965440193;
        Sat, 21 Dec 2019 13:57:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25sm1630904ejb.53.2019.12.21.13.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:19 -0800 (PST)
Message-Id: <bf9b7f897adce9a2a8316e85b504a0721afeaa35.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:12 +0000
Subject: [PATCH v2 3/7] legacy stash -p: respect the
 add.interactive.usebuiltin setting
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
index b0d6891479..fa8bf6b10a 100644
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

