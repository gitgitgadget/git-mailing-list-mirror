Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD05C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7120684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c01cyQfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLCOC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:26 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41539 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLCOCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:25 -0500
Received: by mail-wr1-f46.google.com with SMTP id b18so3785859wrj.8
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/uK7BgEr7oMW5g58dt51M2VtdlmyVxFS9orGRLslvD0=;
        b=c01cyQfIfKXW7rZt3DOhl7W/ktVPJ6srSdSI78w8aGexgrtOvjDH05SZ3+njlNydL+
         KsBv6xhbsAybLB2spTlmTzJvvjqidq5y0tZTxCd8wi/L4KCPIhXuemILCyB2Ozo87G/w
         zOtE8cLyQxB6L3sWnk3ovz7B6JHrWanU05EvaB4xBgobs+rKclcZDQhQFXyRHxXKtvKE
         6b9qcXqSFl1pkPHI/0uIQVQ6qbiaMU/mSUd42rM/yF2nFGjmzlTCxvl/TZRRgh1pgf4k
         0pE/Ju51yw5j8gOc3LCwuO90li99ok9NpLIfexNEKInHFbo/RzYoCAZjRVxJebQ1aHgN
         qEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/uK7BgEr7oMW5g58dt51M2VtdlmyVxFS9orGRLslvD0=;
        b=raI4/XSBL9vK640A2hCpyVTGhFwjCmKQ0inDZWzupC7d3Ja9SZgo3NgISJkSEldZ4+
         hGeUaH4X0i1KUOKIGzoho7bQXc4g1S6/oOEG881NZQ0xfT2RDoRmoL8b3p32+OsBKgpZ
         NW7FJv8JVPnZ/6vXJWILBVdnWJXM8s3NsVTSYEP0ERIoNxaTsrlZnFtqz5wW3ECLQLxL
         LQYTtMt+0OT7//X07GQzD5RM8HgyVyAM2ABGrTSrN9/zw3pLsURxQkFfklnuEAJ4JIWA
         0uBpRCQ5n4uLbOl/FnewbV2vFyChekSa2DM2evE/EdOzJHMUFS4+VOrCD24xEA02kbwY
         caRw==
X-Gm-Message-State: APjAAAUx7N+j1wULTBcHbMTai26S90DkdvjpJIEQl5HNH+5r5DcrwYWA
        gpq4IKZxYujOINrdnOZ+SJOtR4Lp
X-Google-Smtp-Source: APXvYqxdHE5enguw57OiRaQ+oMW/LCYEnx0loK7wpm/hV7rpTW1I4Iwm3DJ8xwbW0r1eZj78tC9FKA==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr5268154wrf.174.1575381742755;
        Tue, 03 Dec 2019 06:02:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm3686178wrp.93.2019.12.03.06.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:22 -0800 (PST)
Message-Id: <1182ba39535bc7c0cc4a241bd19d4c66cf6277d7.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:08 +0000
Subject: [PATCH v4 03/13] doc: reset: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`git add` shows an example of good writing, follow it.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-reset.txt | 29 ++++++++++++++++++-----------
 builtin/reset.c             |  4 ++--
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 97e0544d9e..d517a43e73 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,8 +8,8 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [-q] [<tree-ish>] [--] <paths>...
-'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
+'git reset' [-q] [<tree-ish>] [--] <pathspec>...
+'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
@@ -19,23 +19,23 @@ In the third form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 
-'git reset' [-q] [<tree-ish>] [--] <paths>...::
-	This form resets the index entries for all `<paths>` to their
-	state at `<tree-ish>`.  (It does not affect the working tree or
-	the current branch.)
+'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
+	This form resets the index entries for all paths that match the
+	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
+	the working tree or the current branch.)
 +
-This means that `git reset <paths>` is the opposite of `git add
-<paths>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <paths>...`.
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
 +
-After running `git reset <paths>` to update the index entry, you can
+After running `git reset <pathspec>` to update the index entry, you can
 use linkgit:git-restore[1] to check the contents out of the index to
 the working tree. Alternatively, using linkgit:git-restore[1]
 and specifying a commit with `--source`, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
-'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]::
+'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]::
 	Interactively select hunks in the difference between the index
 	and `<tree-ish>` (defaults to `HEAD`).  The chosen hunks are applied
 	in reverse to the index.
@@ -101,6 +101,13 @@ OPTIONS
 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
 	override the default behavior.
 
+\--::
+	Do not interpret any more arguments as options.
+
+<pathspec>...::
+	Limits the paths affected by the operation.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 EXAMPLES
 --------
diff --git a/builtin/reset.c b/builtin/reset.c
index fdd572168b..9291c0fd72 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -30,8 +30,8 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
-	N_("git reset [-q] [<tree-ish>] [--] <paths>..."),
-	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
+	N_("git reset [-q] [<tree-ish>] [--] <pathspec>..."),
+	N_("git reset --patch [<tree-ish>] [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
gitgitgadget

