Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F2C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 09:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKIJH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKIJHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 04:07:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7FC1E706
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 01:07:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h14so16131738pjv.4
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dH5LPFS7uKfiS4vxdYupE+cysYQu64IbX+nmm9uXmI=;
        b=If9FQi4tleyVe9UmmVFzjtObW2uaveTAR1u4HM8K3aXQfks9rOIlyhxJbG4u4TPUkb
         SfL+qbKqRqTvbecNaRtF39lG+Bk+N2yTPKVGRRXDYz+NuojmdcMGDxKimFIh/LElHLvf
         lqYEdPRsJR2KqXUW+KfjQWqna0u/zbcT9650BzA2coYyHXG2vQ6qJLsP3B6UUBMAIvu7
         RahrUudgc4sPj81zKlMVFZOta0kNCIY1NKX3Ssjodr2sbi8PLNPfuhocUfZtbN64p7sr
         VqtleuewUf9ext4BsmebzH/1ZVZ76vOo4sU97LPUbZgpGYNzvKXLDTVI7LLiFxhKqhyz
         W1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dH5LPFS7uKfiS4vxdYupE+cysYQu64IbX+nmm9uXmI=;
        b=mzB+AnudgWpYaqufkiws65uYGSbQ4M7qeJ9j7MxAYcVJ2PwaNzWAT9Z1Iu95wLcz0D
         CZcIdtipt7phFpeQKXZT/pQ+gcYNu9XEc4gKEZcVdRQ8gn7zR4Me5xWu0b+7wohRnyDp
         1BrTtNpLm8XYvuTuAwupVk11W1h1aoM7mhSihQTxsq43Q70ROBLWcwef95SR08FiNEZl
         g6TeSEGfu2FXThSpJ3sevtCGmdb+XAHCjQ4GDc88JDlHhw/qPq/HDO7GVFpa8O6h/AYh
         mmgm5TVDnXtP1CKkSRF4RE0Y/gzSpXM6uG/6JxNCCzKJimI6iR1lZly1jxnhMmhTcJXb
         +1Rg==
X-Gm-Message-State: ACrzQf0j4yKrxT3q/2o7vw5PLjxCHpU/+ljBFkdUO13k05Hcm3SQ66xO
        mOIiTPlp7IKx+ywVgaYfvVpxM+kxAjm4CChq
X-Google-Smtp-Source: AMsMyM42/u1idk1CaKYu3BH53gpY7yZX0TpvvG9po3IMBG4QY+WStyvjYmeYAZ6cOlsHwwojPdxijQ==
X-Received: by 2002:a17:903:18d:b0:186:9862:d15f with SMTP id z13-20020a170903018d00b001869862d15fmr59384446plg.6.1667984832098;
        Wed, 09 Nov 2022 01:07:12 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm727509pjb.22.2022.11.09.01.07.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:07:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 5/5] notes.c: introduce "--no-blank-line" option
Date:   Wed,  9 Nov 2022 17:06:56 +0800
Message-Id: <196e80358e80c8904cd21e6d8fca2223af93f842.1667980450.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
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
 Documentation/git-notes.txt | 10 ++++++++--
 builtin/notes.c             |  5 ++++-
 t/t3301-notes.sh            | 13 +++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0f5..50b198c2b2 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git notes' [list [<object>]]
 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--no-blank-line] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
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
@@ -159,6 +161,10 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--no-blank-line::
+	Do not insert a blank line before the inserted notes (insert
+	a blank line is the default).
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index a6273781fb..f38e6e8b04 100644
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
@@ -618,7 +621,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
-		if (d.buf.len && prev_buf && size)
+		if (blankline && d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index e7807e052a..dedad93a2f 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -521,12 +521,25 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append to existing note without a beginning blank line' '
+	test_when_finished git notes remove HEAD &&
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
+
 	git notes add -m "Initial set of notes" &&
 	git notes append -m "More notes appended with git notes append" &&
 	git notes show >actual &&
-- 
2.38.1.386.g196e80358e8

