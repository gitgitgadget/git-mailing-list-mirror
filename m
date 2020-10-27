Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A30C61DD8
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F15206E5
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rifWtMuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827162AbgJ0SVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:21:47 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37855 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753810AbgJ0OCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:02:22 -0400
Received: by mail-wr1-f50.google.com with SMTP id w1so2059915wrm.4
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CqgeSwdqhwOSvCNIRh1cheA6qPmFRC6+n289G0EFRpo=;
        b=rifWtMuHs1PcxhQFY4EBH9mgXmuQy0Pn/LQ4QNb5Rd1/zgyVVip67x89unviMDboC1
         C70BwSOL3BiMtbdUhI/u/9JG71ivHXD3wMmC8bqDqgGMBEaXOKYc3B6Ey/b1EWTXIuQ0
         NjUD1yy9Uq4+wD50+mtVicsXb1zyasL3hyEAni2n5oqMNWqVqw+MN3PJmY74y6gc/WGe
         XuhHoWXafRIcyD5LmYhCVBwEa+Vggkcz5nyrRFWk5SgyLz6NFozoERRV1ge8GUYQqyku
         XDp8wovkX69DZFwIes0CheH070k9qkmF+oB/6kKs2KgxxhOFPhUsbGguDYoJ4I2OHzcj
         88dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CqgeSwdqhwOSvCNIRh1cheA6qPmFRC6+n289G0EFRpo=;
        b=h8Kdtgf83Nj3VH3CHCQmNf6F4L56/nvDNs8XV5NDamFxwBZe/JsUF9nwJ8UaVYMPW4
         BipAgRFxel0DIS0K5/1NSW3AdP7DiGPdAntRS2H6wGPWdRu9krum2zhU27YqCWf9wkXA
         2Npd8Z3/kEcp9SnntzeGoq2fnRi4kBVxz0WHugRCYbtiUpuPvrl9Epol55dNDL9SCOnQ
         QIpOmt/EK89d6Yj4zz68T01S2P1WupfPnsKEuzaMAvf9jVHMpSB7SRH9/Aqf/K68zZSZ
         NjNP1DU2mS9kyLSCidzJLvGfCVwqQFrnsBjfBvT22i8Tz26OP2H0EO+BPLP+vXJIIJ41
         wzsQ==
X-Gm-Message-State: AOAM5310mLemhtg8iqTma6Fr9gfNcymJpig1ZvEH6o2W/s2Ojq0wq3jq
        NFVSVTMJuNBTq/x/BM956asJMnobJ3E=
X-Google-Smtp-Source: ABdhPJxYFIztrL8zRQOUvUQOdhJ68S/LbVgzc1D+8oQo1cxk7nfEJ+fwsG5NHbklydRroTSkkjrnWw==
X-Received: by 2002:adf:e849:: with SMTP id d9mr3317980wrn.25.1603807340184;
        Tue, 27 Oct 2020 07:02:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u195sm2340823wmu.18.2020.10.27.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:02:19 -0700 (PDT)
Message-Id: <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.git.1603807337.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 14:02:14 +0000
Subject: [PATCH 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

After rebasing ORIG_HEAD is supposed to point to the old HEAD of the
rebased branch. Unfortunately the buffer storing the oid was
overwritten with a new oid before ORIG_HEAD was created. The buffer is
also used when writing .git/rebase-merge/orig-head which is used by
`rebase --abort` to restore the previous head. Luckily that file is
written before the buffer is overwritten.  As we want the full oid
find_unique_abbrev() is replaced with oid_to_hex_r() rather than
find_unique_abbrev_r().

I think that all of the users of head_hash should actually be using
opts->orig_head instead as passing a string rather than a struct
object_id around is a hang over from the scripted implementation. This
patch just fixes the immediate bug and adds a regression test based on
Caspar's reproduction example. The users will be converted to use
struct object_id and head_hash removed in the next few commits.

Reported-by: Caspar Duregger <herr.kaste@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c              | 10 +++++-----
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index eeca53382f..6def28a533 100644
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
+	oid_to_hex_r(head_hash, orig_head);
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

