Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF5C2D0D2
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620B32072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2m0AJwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfLQKlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35887 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfLQKlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2543719wma.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1nfSYCSnOPOFBUrxA7NbIL9qkJn0oXSIHR7HmoYxjt8=;
        b=V2m0AJwZI2P0HmKZpixDQek6hEMHSuaFAUy73qx7CmNNBTVfelAA89JPQsW1uvPOBy
         0ZFZiazsKvc6Is/lpLmqJbxPA/9vI9s+TU8iDHP+R2cvfa6OK8mHZeJTWi/2E0qxhnFh
         xZo+XbfvR3OQF9tMOlmaPW6VDL7mW/EcqqbjOY5zTkSNLdng1DCj/WNyNZwt0lrYjCHQ
         MOxvfOpvtzVDxanh6ZTdbtb6iXRH0smtwvRJYfJVRG5cNMv+YSfuCsj+5JUulup7JSQe
         ToVWT95KRICzy1aljpqpgSJsaZOz23RNkC+T1XFpdokP59zwSw9ui1ijQV6pvN+/7U3k
         MOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1nfSYCSnOPOFBUrxA7NbIL9qkJn0oXSIHR7HmoYxjt8=;
        b=j6V/3PW5lKjH0k8DIxnkXzOKWoWnpiYleXetshnEouxvO4MXBtM/gcs9+vIGHpVKQC
         LgDoiEoBz2+y9v98KVsfbwl4hpdZ3oLO+2VYGk4up6hZZOcpp24RXWKKCHOYbouXyqh+
         OA85CScZtRC2tjmSn/llwOg1TkfBAb3mHTnq4Iy0FgwfRY7D8/kgHoNKAQk1VuAvycac
         XczdPppF/PiSPauLcL9LPIgpUGnGKBRyI1LV7Vv+Gq80uYJcwmUR6K5N6IWWHtYLsV5A
         GKw2MO48zBkPD+gv006bpBClZHlWRZxBUtVpYEIFgIh+z9S6ys/ee8Yllsf1MZVBQ4J0
         yWRw==
X-Gm-Message-State: APjAAAXu9vj5m48VFe6lv+MvZBqxxBKYS3kTrnXO4/tv3R4P58xnAsmf
        Lu3GhB4vhlNTWNhmQrLVLwZ7Wp4r
X-Google-Smtp-Source: APXvYqwLgjoUmeTD2xeS4xeasKZxSxv3n/OyH/C9b5Dgl8NQVWXn5/n4acVteWKMLsDV39JU/ieDzg==
X-Received: by 2002:a1c:9a44:: with SMTP id c65mr4952544wme.30.1576579271443;
        Tue, 17 Dec 2019 02:41:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n189sm2605332wme.33.2019.12.17.02.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:10 -0800 (PST)
Message-Id: <b63fca6dabd6f5dbbc8280647146153e82aca77c.1576579264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:41:03 +0000
Subject: [PATCH 6/7] built-in add -p: implement the "worktree" patch modes
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

This is a straight-forward port of 2f0896ec3ad4 (restore: support
--patch, 2019-04-25) which added support for `git restore -p`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.h |  1 +
 add-patch.c       | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 builtin/add.c     |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/add-interactive.h b/add-interactive.h
index f865f1e8ca..4895ed1df5 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -28,6 +28,7 @@ enum add_p_mode {
 	ADD_P_STASH,
 	ADD_P_RESET,
 	ADD_P_CHECKOUT,
+	ADD_P_WORKTREE,
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
diff --git a/add-patch.c b/add-patch.c
index dea99a79a4..2ad18dc3cb 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -174,6 +174,50 @@ static struct patch_mode patch_mode_checkout_nothead = {
 			"the file\n"),
 };
 
+static struct patch_mode patch_mode_worktree_head = {
+	.diff = { "diff-index", NULL },
+	.apply = { "-R", NULL },
+	.apply_check = { "-R", NULL },
+	.is_reverse = 1,
+	.prompt_mode = {
+		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for discarding."),
+	.help_patch_text =
+		N_("y - discard this hunk from worktree\n"
+		   "n - do not discard this hunk from worktree\n"
+		   "q - quit; do not discard this hunk or any of the remaining "
+			"ones\n"
+		   "a - discard this hunk and all later hunks in the file\n"
+		   "d - do not discard this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
+static struct patch_mode patch_mode_worktree_nothead = {
+	.diff = { "diff-index", "-R", NULL },
+	.apply = { NULL },
+	.apply_check = { NULL },
+	.is_reverse = 0,
+	.prompt_mode = {
+		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+	},
+	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
+			     "will immediately be marked for applying."),
+	.help_patch_text =
+		N_("y - apply this hunk to worktree\n"
+		   "n - do not apply this hunk to worktree\n"
+		   "q - quit; do not apply this hunk or any of the remaining "
+			"ones\n"
+		   "a - apply this hunk and all later hunks in the file\n"
+		   "d - do not apply this hunk or any of the later hunks in "
+			"the file\n"),
+};
+
 struct hunk_header {
 	unsigned long old_offset, old_count, new_offset, new_count;
 	/*
@@ -1549,6 +1593,13 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			s.mode = &patch_mode_checkout_head;
 		else
 			s.mode = &patch_mode_checkout_nothead;
+	} else if (mode == ADD_P_WORKTREE) {
+		if (!revision)
+			s.mode = &patch_mode_checkout_index;
+		else if (!strcmp(revision, "HEAD"))
+			s.mode = &patch_mode_worktree_head;
+		else
+			s.mode = &patch_mode_worktree_nothead;
 	} else
 		s.mode = &patch_mode_stage;
 	s.revision = revision;
diff --git a/builtin/add.c b/builtin/add.c
index f4d6eb9e06..6fa2b2dd17 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -208,6 +208,8 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 			mode = ADD_P_RESET;
 		else if (!strcmp(patch_mode, "--patch=checkout"))
 			mode = ADD_P_CHECKOUT;
+		else if (!strcmp(patch_mode, "--patch=worktree"))
+			mode = ADD_P_WORKTREE;
 		else
 			die("'%s' not supported", patch_mode);
 
-- 
gitgitgadget

