Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45AEC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12E522522
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYUV8Gwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgAQXiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:38:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44381 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgAQXiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 18:38:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so24251670wrm.11
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O+sjKwSxUvvqchvjwN8hJxSqhvyPfx8Q4HJ4ADFdrGc=;
        b=bYUV8GwfjoZ130NnhTuHk9nB4YvTY+c8BSilbZURt+lJbhe/aPwKfXaPPaXRkPLCTq
         u/zY/+qHoKslyCApTkp6mLY1JUluJOGtzOWuAVHa2THD8MyGj3FnTdxHxTJxfBU61spA
         //ZnBxO4uAioQlS+087mEQG6ac/+qTxr1Gp+ZhJIO2kLTD3bH2iutlYnaAv4DJUJvakS
         FkFqMqF+fXmZqsxgMQgodCrYyOep4TNzQFVookfpznojOQQw1GiBq1le5yv6uhojWySO
         s8o1YmxbXC1PqpAZslCP0PEaXbT4MSnK26BwgdQ8/1XpGAZXuJHnN5nDN3deSKkBia1f
         jQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O+sjKwSxUvvqchvjwN8hJxSqhvyPfx8Q4HJ4ADFdrGc=;
        b=tCaSbiibgtvGM9Eshe0lqpsmOKP0hF/Rc0pU+Es4f1kgfM6b0FTQHxZdGQBWFA3KaQ
         A4+C81WJ/4tc/Z4EyrMw6jz7Jqv562f6zDN2KTq2lpqrLO7cJuuewHtEB6Z3QR9JlOVH
         shawgz9kkFj1H1x7ZIWJM/sVkWvpdUiCQzBCfP9Yptf1WB1WPfl3gdpx0k3jdSgG7zdP
         VIJiGXyjSY/IAAGbnsVFMYP5VACTpCtsml3xY/8mooQjoHL5o5PYMBjLOoH6/xBpaqq+
         EI8/mZ3NLE7Ierz+ki13NRpe1VOXEtj/QBEVUHPPjptIOikLuf2ZM/zs2ulNSatwEujz
         lB6g==
X-Gm-Message-State: APjAAAWeh5Oazv2OhW0U32QVjGP63l1i4ZO+j6+rDRlIFm5RcvJdNxNo
        zMiMvNDP8umo/vR9uC9xJ21+knXN
X-Google-Smtp-Source: APXvYqy7Ftl+X86ebHxfeqNTAKjmcCG31nkix2rGAq32ExAiCh7icIJhkTGxwCQn085u7ccRt15Kkg==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr5490487wrt.362.1579304286426;
        Fri, 17 Jan 2020 15:38:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm34544192wrv.39.2020.01.17.15.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:38:05 -0800 (PST)
Message-Id: <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 23:38:02 +0000
Subject: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 66ae9a57b88 (t3404: rebase -i: demonstrate short SHA-1 collision,
2013-08-23), we added a test case that demonstrated how it is possible
that a previously unambiguous short commit ID could become ambiguous
*during* a rebase.

In 75c69766554 (rebase -i: fix short SHA-1 collision, 2013-08-23), we
fixed that problem simply by writing out the todo list with expanded
commit IDs (except *right* before letting the user edit the todo list,
in which case we shorten them, but we expand them right after the file
was edited).

However, the bug resurfaced as a side effect of 393adf7a6f6 (sequencer:
directly call pick_commits() from complete_action(), 2019-11-24): as of
this commit, the sequencer no longer re-reads the todo list after
writing it out with expanded commit IDs.

The only redeeming factor is that the todo list is already parsed at
that stage, including all the commits corresponding to the commands,
therefore the sequencer can continue even if the internal todo list has
short commit IDs.

That does not prevent problems, though: the sequencer writes out the
`done` and `git-rebase-todo` files incrementally (i.e. overwriting the
todo list with a version that has _short_ commit IDs), and if a merge
conflict happens, or if an `edit` or a `break` command is encountered, a
subsequent `git rebase --continue` _will_ re-read the todo list, opening
an opportunity for the "short SHA-1 collision" bug again.

To avoid that, let's make sure that we do expand the commit IDs in the
todo list as soon as we have parsed it after letting the user edit it.

Additionally, we improve the 'short SHA-1 collide' test case in t3404 to
test specifically for the case where the rebase is resumed. We also
hard-code the expected colliding short SHA-1s, to document the
expectation (and to make it easier on future readers).

Note that we specifically test that the short commit ID is used in the
`git-rebase-todo.tmp` file: this file is created by the fake editor in
the test script and reflects the state that would have been presented to
the user to edit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                   | 11 ++++++++++-
 t/t3404-rebase-interactive.sh | 15 +++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7c30dad59c..5f69b47e32 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5076,7 +5076,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 {
 	const char *shortonto, *todo_file = rebase_path_todo();
 	struct todo_list new_todo = TODO_LIST_INIT;
-	struct strbuf *buf = &todo_list->buf;
+	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
 	struct object_id oid = onto->object.oid;
 	int res;
 
@@ -5128,6 +5128,15 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return -1;
 	}
 
+	/* Expand the commit IDs */
+	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
+	strbuf_swap(&new_todo.buf, &buf2);
+	strbuf_release(&buf2);
+	new_todo.total_nr -= new_todo.nr;
+	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)
+		BUG("invalid todo list after expanding IDs:\n%s",
+		    new_todo.buf.buf);
+
 	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ae6e55ce79..1cc9f36bc7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1264,13 +1264,24 @@ test_expect_success SHA1 'short SHA-1 setup' '
 test_expect_success SHA1 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
+	colliding_sha1=6bcda37 &&
+	test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
 	(
 		unset test_tick &&
 		test_tick &&
 		set_fake_editor &&
 		FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
-		FAKE_LINES="reword 1 2" git rebase -i HEAD~2
-	)
+		FAKE_LINES="reword 1 break 2" git rebase -i HEAD~2 &&
+		test $colliding_sha1 = "$(git rev-parse HEAD | cut -c 1-7)" &&
+		grep "^pick $colliding_sha1 " \
+			.git/rebase-merge/git-rebase-todo.tmp &&
+		grep "^pick [0-9a-f]\{40\}" \
+			.git/rebase-merge/git-rebase-todo &&
+		git rebase --continue
+	) &&
+	collide2="$(git rev-parse HEAD~1 | cut -c 1-4)" &&
+	collide3="$(git rev-parse collide3 | cut -c 1-4)" &&
+	test "$collide2" = "$collide3"
 '
 
 test_expect_success 'respect core.abbrev' '
-- 
gitgitgadget

