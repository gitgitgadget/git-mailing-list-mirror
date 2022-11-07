Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722CC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiKGN50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 08:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiKGN5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 08:57:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC91CFFA
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 05:57:16 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so11119570plc.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 05:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI+08zrLivwyVjiibRhNpnzzGyr8uvoueyFSqg9/Xfs=;
        b=fY/VQO5Y6u6sHsXO6x8/tR1Mqe47L7SPMEnrYih4xwkaKwKmOch+oZrw8Q7UoYhxo3
         D7z8wohtxCasZX5YY5oQcLPUEz3hzWgckvULinZOf0qu9JBNsz9EKTd/WmiRQ6KKkPea
         NqsdWvEOU3+V0tCAKrA14AfzAmAaZqnSPFaLPcLhDxEY7HSGgPpacNK76Z8UBk+k+s0x
         E+cNNkIQXtgpd45YKnZYa0fxiUajGw8FP0W0UFDMs0JcXG380WD495ybHzFYxTNaee0x
         6pWfF9cI5uzbUmmegCk4HSVrtKsZBkm0xsv4DiCrZ04gUk4k+L2iwBxLFcNsQx0Tffgi
         N1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aI+08zrLivwyVjiibRhNpnzzGyr8uvoueyFSqg9/Xfs=;
        b=D8ax0Amxtr284NfwvbRYYebVyg9ob2+gOg5A/hnjGhWE1Yc8hX45o27cu+/54AyzcZ
         tDFdeQgNMWeBTJxYyFfO4v4EVn1Wqo/IsJ87EiD8N2ijPN1Z6yqhW7BCax2TULQiNXTo
         qfYFKis+bwSF5Tpfdcx9W4N1l6AOf0TQDFs5SptJ25N9Qwb0zI40l6uYziqhtZIyF6j/
         7YgWmq9IkbnacPLWtX4yBK4+Ea1gmhq5+BOmF8BzVQmUL8c3TkWpANI9/kh7OmP9zCvi
         OgARRX77TLPGuWAy7AvT1ziAlgvsY0XcSwZCuU7SbKKG4xoTwiEY+1DI+gxIG7sZUJjY
         vAaQ==
X-Gm-Message-State: ANoB5pnwshOf6RB+33eLgsPoE+kiAaY5fB+w0Trs2hpAO8vnlM5DAUgs
        IZDMhlLafgxo3wRpcOaJCvLst+dJssA81own
X-Google-Smtp-Source: AA0mqf7rRB/T4Lv1dyCias1KpHk2KOSBHjquTNKQ6q5+G1OQ9SEhKQ+mLfJSoCAwaNgfGX68+rc9Cg==
X-Received: by 2002:a17:902:a40a:b0:188:71b1:8f0f with SMTP id p10-20020a170902a40a00b0018871b18f0fmr13725134plq.112.1667829436240;
        Mon, 07 Nov 2022 05:57:16 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.56])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00562ef28aac6sm4511383pfj.185.2022.11.07.05.57.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:57:15 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 2/3] notes.c: fixed tip when target and append note are both empty
Date:   Mon,  7 Nov 2022 21:57:04 +0800
Message-Id: <5dbe014a09cca6ffa01dc9f61d0ddc095d31d518.1667828335.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.ge7205ac0a40.dirty
In-Reply-To: <cover.1667828335.git.dyroneteng@gmail.com>
References: <cover.1667828335.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When "git notes append <object>" is executed, if there is no note in
the given object and the appended note is empty, the command line
prompt will be as follows:

     "Removing note for object <object>"

Actually, this tip is not that accurate, because there is no note in
the original <object>, and it also does no remove work on the notes
reference, so let's fix this and give the correct tip.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c  | 17 ++++++++++++++---
 t/t3301-notes.sh |  3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f0fa337e8c..02b88e54d8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -567,9 +567,15 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	char *logmsg;
+	char *logmsg = NULL;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = {
+		.given = 0,
+		.use_editor = 0,
+		.edit_path = NULL,
+		.buf = STRBUF_INIT
+	};
+
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -634,13 +640,18 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			BUG("combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
+		commit_notes(the_repository, t, logmsg);
+	} else if (!d.buf.len && !note) {
+		fprintf(stderr,
+			_("Both original and appended notes are empty in %s, do nothing\n"),
+			oid_to_hex(&object));
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			oid_to_hex(&object));
 		remove_note(t, object.hash);
 		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
+		commit_notes(the_repository, t, logmsg);
 	}
-	commit_notes(the_repository, t, logmsg);
 
 	free(logmsg);
 	free_note_data(&d);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 76beafdeb8..1a0fd157a5 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -574,7 +574,8 @@ test_expect_success 'git notes append == add when there is no existing note' '
 test_expect_success 'appending empty string to non-existing note does not create note' '
 	git notes remove HEAD &&
 	test_must_fail git notes list HEAD &&
-	git notes append -m "" &&
+	git notes append -m "" >output 2>&1 &&
+	grep "Both original and appended notes are empty" output &&
 	test_must_fail git notes list HEAD
 '
 
-- 
2.38.1.383.ge7205ac0a40.dirty

