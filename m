Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC32C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 13:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKGN5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiKGN5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 08:57:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C61CFF7
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 05:57:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v17so11145463plo.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+1dfx8UTfsUc7TbPw1xnjTIwxKJGjT+6amGUQB2GQw=;
        b=nzxoeWpUZKu0HMeQpf/i1BkDjcoQv83a5A9eFNymQUQ6myO6Epg6dNDY21rrb4Ly4W
         9ASpI9Cyo7kkQbNxJinjobtUUItTfxet0KomD9SQapUYi3YPkknGgWVnGOM7C11/Iayl
         5sKE6QOdqhUvXYYRktihOpb/7gbHNTlxWHXPx948pJbWt7vBuOKfnoVjaGCJhl2bi1zy
         FSRL1uQT0OWvRmt/IyWIai7WbWDpN9X/deonHvhh/WEfcCDQrMq7NHqW0xO0uAR3Vy3T
         v/snt1pq65No25KSLnGDD0VRpEbA0rInx1yU3iXY8+h8jZafB1Uumt6vMZIpWVvUeb7u
         YQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+1dfx8UTfsUc7TbPw1xnjTIwxKJGjT+6amGUQB2GQw=;
        b=rYHdnl+Q+n8ofo/xGMqN17tYI6tEYPABa6ik8ls4JROYTRU4VnkXKg2pwOGM+l7ip9
         WH16dOSQquGB8GThhJuS3VU6btkTnOc+hHLBEVLNVEzBlDMweYDzWkSBydydIYnjXejB
         xIi+uYTSZJx13AVHxLCBK8yTCZbqGGzU/mYTz6n+/tBlSKuQsDQQVwWPLYMU0/xQ/Ksh
         XYYOB07cXPSz2+Jdgr8B4FqDkLOcQzh11c5oclUkhdCIDC0c3qK/KoFiZOYhvjtGzQzH
         vYWagsb5oGWpT7rg8nfxJDrbnFlHBUOEHsDJ1QmWs5wSCWV9vpjMux4GM4jo2YlIAslr
         YCfA==
X-Gm-Message-State: ACrzQf0DMfW8rG/mzneRDlaQlvddoMLKsNTwCS1yC7jhg5NShFa6PNbY
        qdA6UtW+2H5jFQXFtLsJlrw+Br5B4DLqn1yG
X-Google-Smtp-Source: AMsMyM4LEAkJ9wRuRkUUwiXcScEpgA+Ul6/pH0b2Iz/lnFFcLDbAZblrnynXSkEnt1oYgeMxoFy/Hw==
X-Received: by 2002:a17:902:b28c:b0:186:708e:6ed7 with SMTP id u12-20020a170902b28c00b00186708e6ed7mr50197482plr.98.1667829434443;
        Mon, 07 Nov 2022 05:57:14 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.56])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00562ef28aac6sm4511383pfj.185.2022.11.07.05.57.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:57:14 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Mon,  7 Nov 2022 21:57:03 +0800
Message-Id: <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.ge7205ac0a40.dirty
In-Reply-To: <cover.1667828335.git.dyroneteng@gmail.com>
References: <cover.1667828335.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When appending to a given object which has note and if the appended
note is not empty too, we will insert a blank line at first. The
blank line serves as a split line, but sometimes we just want to
omit it then append on the heels of the target note. So, we add
a new "OPT_BOOL()" option to determain whether a new blank line
is insert at first.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt | 11 +++++++++--
 builtin/notes.c             |  5 ++++-
 t/t3301-notes.sh            | 12 ++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0f5..43770ddf84 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git notes' [list [<object>]]
 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--blank-line] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
@@ -86,7 +86,9 @@ the command can read the input given to the `post-rewrite` hook.)
 
 append::
 	Append to the notes of an existing object (defaults to HEAD).
-	Creates a new notes object if needed.
+	Creates a new notes object if needed. If the note of the given
+	object and the note to be appended are not empty, a blank line
+	will be inserted between them.
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
@@ -159,6 +161,11 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--blank-line::
+--no-blank-line::
+	Controls if a blank line to split paragraphs is inserted
+	when appending (the default is true).
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index be51f69225..f0fa337e8c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -562,6 +562,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
 	int allow_empty = 0;
+	int blankline = 1;
 	const char *object_ref;
 	struct notes_tree *t;
 	struct object_id object, new_note;
@@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_BOOL(0, "blank-line", &blankline,
+			N_("insert paragraph break before appending to an existing note")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -619,7 +622,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = read_object_file(note, &type, &size);
 
 		strbuf_grow(&d.buf, size + 1);
-		if (d.buf.len && prev_buf && size)
+		if (blankline && d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec7d..76beafdeb8 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -521,12 +521,24 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append to existing note without a beginning blank line' '
+	cat >expect <<-\EOF &&
+		Initial set of notes
+		Appended notes
+	EOF
+	git notes add -m "Initial set of notes" &&
+	git notes append --no-blank-line -m "Appended notes" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'append to existing note with "git notes append"' '
 	cat >expect <<-EOF &&
 		Initial set of notes
 
 		More notes appended with git notes append
 	EOF
+	git notes remove HEAD &&
 	git notes add -m "Initial set of notes" &&
 	git notes append -m "More notes appended with git notes append" &&
 	git notes show >actual &&
-- 
2.38.1.383.ge7205ac0a40.dirty

