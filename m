Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377D7C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77402075E
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2bwSoq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgKDP3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgKDP3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 10:29:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB7C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 07:29:45 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so22538723wrq.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+SWGhVw06GqguJHa0XWqqRyCqP2weNBv2ICnnesFBiw=;
        b=t2bwSoq3H3XfyFUQrRA3xVtGVBKTRsmLS14lJ3aRD9QpxhcY8YoV4adaUvrJd/HbcU
         iAk/5GHTT1XqJx91goncPXpRpHxgAeYdG0K0EbcQGAsmHfS50z7yORxYSv53cTIdXr0Z
         F8Z24EXNItx+Irm0SWo9VDx+rewUX16Iyg+X2SJ29krUUvSeDpF9Eajmcehn1oKchpa4
         zBHSmQ+4uKG5InMLH+GzinhtgHKbFUlpmEkk+kFQUO4pth5PKC/vOGUDtNWLeh4Yl/y+
         NuZheBwVkSpHk3phaDhDZDpok1ZAM3Y4AY1uOm2dtULBqUlk73yeE9DFkP6NNrGViMJZ
         v7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+SWGhVw06GqguJHa0XWqqRyCqP2weNBv2ICnnesFBiw=;
        b=B2iUgIY62A4CTridM3L36iBTjnfmiyLGtpr1npwSfDMd9+Bu0XQJ3s9bm9OtXp0FEW
         3nMYY2d1xfD72Vxx00FRXcD3Jk+lMOkTp3pGTO+/4qcN25aNV2JM7SzuaXLimxYDYrm5
         M6alUXyxaVt0TiMVLit6dPSw/4ZYMg0bbu5vhoFN+8QPmB/4PPqXKjjrdYr9rCWcf43H
         snAODaxp0+Sqf3IgCAL82VFTFXf4/d1hKwT03RRwef3iiOaGoPWsM8/Rj2GNci6MRjd8
         Yo637LrplF3bG0ZQh+E00Klqulka13SkRZkC4Zp1bKDgT4geIo+Y+gyuD9px5vLNhaZx
         JfDQ==
X-Gm-Message-State: AOAM532pcugZAMtHQjOELyrBRnn4wW2kWITKn/ADda+2v8i75fH5uhzM
        /n3qyFKobZBOGNyaxa6jAqqQ8Wr35I8=
X-Google-Smtp-Source: ABdhPJySIuhBJ76Hh/SvO46dGcoJBGJmjFPm2/xLHelbrz/gVYVxNjybKU7+x2bEmDmYCkQLACaQkA==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr31867110wrt.137.1604503783752;
        Wed, 04 Nov 2020 07:29:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm2919368wmg.36.2020.11.04.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:29:43 -0800 (PST)
Message-Id: <da05958c58deb849def1209ac7d2b54c415c35cb.1604503780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
        <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 15:29:37 +0000
Subject: [PATCH v2 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

After rebasing, ORIG_HEAD is supposed to point to the old HEAD of the
rebased branch.  The code used find_unique_abbrev() to obtain the
object name of the old HEAD and wrote to both
.git/rebase-merge/orig-head (used by `rebase --abort` to go back to
the previous state) and to ORIG_HEAD.  The buffer find_unique_abbrev()
gives back is volatile, unfortunately, and was overwritten after the
former file is written but before ORIG_FILE is written, leaving an
incorrect object name in it.

Avoid relying on the volatile buffer of find_unique_abbrev(), and
instead supply our own buffer to keep the object name.

I think that all of the users of head_hash should actually be using
opts->orig_head instead as passing a string rather than a struct
object_id around is a hang over from the scripted implementation. This
patch just fixes the immediate bug and adds a regression test based on
Caspar's reproduction example[1]. The users will be converted to use
struct object_id and head_hash removed in the next few commits.

[1] https://lore.kernel.org/git/CAFzd1+7PDg2PZgKw7U0kdepdYuoML9wSN4kofmB_-8NHrbbrHg@mail.gmail.com

Reported-by: Caspar Duregger <herr.kaste@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c              | 10 +++++-----
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index eeca53382f..cd101b2559 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -270,15 +270,15 @@ static int edit_todo_file(unsigned flags)
 }
 
 static int get_revision_ranges(struct commit *upstream, struct commit *onto,
-			       struct object_id *orig_head, const char **head_hash,
+			       struct object_id *orig_head, char *head_hash,
 			       char **revisions, char **shortrevisions)
 {
 	struct commit *base_rev = upstream ? upstream : onto;
 	const char *shorthead;
 
-	*head_hash = find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
+	find_unique_abbrev_r(head_hash, orig_head, GIT_MAX_HEXSZ);
 	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
-						   *head_hash);
+						   head_hash);
 
 	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
 
@@ -327,7 +327,7 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
-	const char *head_hash = NULL;
+	char head_hash[GIT_MAX_HEXSZ];
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -335,7 +335,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	struct string_list commands = STRING_LIST_INIT_DUP;
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
-				&head_hash, &revisions, &shortrevisions))
+				head_hash, &revisions, &shortrevisions))
 		return -1;
 
 	if (init_basic_state(&replay,
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 07a1617351..1e56696e4f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1797,6 +1797,17 @@ test_expect_success 'todo has correct onto hash' '
 	test_i18ngrep "^# Rebase ..* onto $onto" actual
 '
 
+test_expect_success 'ORIG_HEAD is updated correctly' '
+	test_when_finished "git checkout master && git branch -D test-orig-head" &&
+	git checkout -b test-orig-head A &&
+	git commit --allow-empty -m A1 &&
+	git commit --allow-empty -m A2 &&
+	git commit --allow-empty -m A3 &&
+	git commit --allow-empty -m A4 &&
+	git rebase master &&
+	test_cmp_rev ORIG_HEAD test-orig-head@{1}
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

