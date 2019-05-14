Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A446A1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfENSEI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:04:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38747 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfENSEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:04:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so33330wmj.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ssgWnfsVXAVIL9ZEdxizKDh8pM5BtMAVAj/SZnNyPlM=;
        b=ebnutD1EcWPyZn7MYzx1BjLldpwsn6uyjPDZicuLjqk/6gbxILeZO7Jpu0h0K94plz
         jDyEwCQvFdHvvggMXCiJAvDMVpz+2XU4Ni2u3cXEWDJyjNWoVQ/SRpqrdZ2ZPx9mjMCt
         IChBTmV4VlbOqOR/a5r5Ov50eraOc5jX4k4SpMcKXsfamPPkqtUVW4Fq+sdL7MRhx8mw
         acbz54FsHOOPuV0kdRjQrU99VQRYN3RVqp4jBwqSTNPde2/rk+cY7lllR5rWmDRi/lKe
         qFAixKMW+kiW4sCNSYpaDxlbtflnXr7eMoLuuVe1ScVumfuDc5IFqIXLjCkDtnW/Tih3
         Ujgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ssgWnfsVXAVIL9ZEdxizKDh8pM5BtMAVAj/SZnNyPlM=;
        b=Odv4hb39aVmzjn9IaBO0dQNZSnCqyRotuvRH3hTaP94cjWBsgty4O4fmaLr9CkvTW6
         w7mW1Oe4lQPAQ6GmPBqFnM/Vk7SrOLbLXpHZ8Tz8NMcNeaT10qRZyghOo1YmUU8Jkjc7
         tl5Ybk0jEwICSbWt1MzySdaY6TgQlRNZ9LscO9LsMkOEhhwnxMFIRH+a+L4287J//2G/
         N5vh1XQAsDcTSg+RKBOyjbhVEfGC/EGdwcyKa8Orfdo0noRwh6mQ8NENxZsqe5UDJ4vn
         R0mmcyt006z6Y0h5/7Kqrv7OylNGfiaYFPAPeG1E1sUPIUleTlgxFfYWySzikBIKD67Y
         HghQ==
X-Gm-Message-State: APjAAAWsR/EQDyQpcMi6WRrkStvGGBS1vNgX0fHxgP3oNVL+eDSJhPjD
        JPKIYc/5D3PUdquc1EVAO4XFFsy6
X-Google-Smtp-Source: APXvYqwVhYgdi9lV9mwvGr938N7w8McjVL/Ht/2Zk1zf8sFZ5RUbNhkUR2YDSlbOIrkvpoZ+Ngg4EA==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr20340050wmc.149.1557857044670;
        Tue, 14 May 2019 11:04:04 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id a4sm4528230wmf.45.2019.05.14.11.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:04:04 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/4] rebase --abort/--quit: cleanup refs/rewritten
Date:   Tue, 14 May 2019 19:03:49 +0100
Message-Id: <20190514180349.17245-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514180349.17245-1-phillip.wood123@gmail.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <20190514180349.17245-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When `rebase -r` finishes it removes any refs under refs/rewritten that
it has created. However if the user aborts or quits the rebase refs are
not removed. This can cause problems for future rebases. For example I
recently wanted to merge a updated version of a topic branch into an
integration branch so ran `rebase -ir` and removed the picks and label
for the topic branch from the todo list so that

    merge -C <old-merge> topic

would pick up the new version of topic. Unfortunately
refs/rewritten/topic already existed from a previous rebase that had
been aborted so the rebase just used the old topic, not the new one.

The logic for the non-interactive quit case is changed to ensure
`buf` is always freed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c         | 34 +++++++++++++++++++++++++---------
 t/t3430-rebase-merges.sh | 18 +++++++++++++++++-
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 199cb5b81d..7c4cd1a733 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -762,10 +762,18 @@ static int finish_rebase(struct rebase_options *opts)
 	 * user should see them.
 	 */
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
-	strbuf_addstr(&dir, opts->state_dir);
-	if (remove_dir_recursively(&dir, 0))
-		ret = error(_("could not remove '%s'"), opts->state_dir);
-	strbuf_release(&dir);
+	if (opts->type == REBASE_INTERACTIVE) {
+		struct replay_opts replay = REPLAY_OPTS_INIT;
+
+		replay.action = REPLAY_INTERACTIVE_REBASE;
+		ret = sequencer_remove_state(&replay);
+	} else {
+		strbuf_addstr(&dir, opts->state_dir);
+		if (remove_dir_recursively(&dir, 0))
+			ret = error(_("could not remove '%s'"),
+				    opts->state_dir);
+		strbuf_release(&dir);
+	}
 
 	return ret;
 }
@@ -1654,11 +1662,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, options.state_dir);
-		ret = !!remove_dir_recursively(&buf, 0);
-		if (ret)
-			die(_("could not remove '%s'"), options.state_dir);
+		if (options.type == REBASE_INTERACTIVE) {
+			struct replay_opts replay = REPLAY_OPTS_INIT;
+
+			replay.action = REPLAY_INTERACTIVE_REBASE;
+			ret = !!sequencer_remove_state(&replay);
+		} else {
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, options.state_dir);
+			ret = !!remove_dir_recursively(&buf, 0);
+			if (ret)
+				error(_("could not remove '%s'"),
+				       options.state_dir);
+		}
 		goto cleanup;
 	}
 	case ACTION_EDIT_TODO:
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 4c69255ee6..e63576d334 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -224,8 +224,24 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
 	test_cmp_rev HEAD "$(cat wt/b)"
 '
 
+test_expect_success '--abort cleans up refs/rewritten' '
+	git checkout -b abort-cleans-refs-rewritten H &&
+	GIT_SEQUENCE_EDITOR="echo break >>" git rebase -ir @^ &&
+	git rev-parse --verify refs/rewritten/onto &&
+	git rebase --abort &&
+	test_must_fail git rev-parse --verify refs/rewritten/onto
+'
+
+test_expect_success '--quit cleans up refs/rewritten' '
+	git checkout -b quit-cleans-refs-rewritten H &&
+	GIT_SEQUENCE_EDITOR="echo break >>" git rebase -ir @^ &&
+	git rev-parse --verify refs/rewritten/onto &&
+	git rebase --quit &&
+	test_must_fail git rev-parse --verify refs/rewritten/onto
+'
+
 test_expect_success 'post-rewrite hook and fixups work for merges' '
-	git checkout -b post-rewrite &&
+	git checkout -b post-rewrite H &&
 	test_commit same1 &&
 	git reset --hard HEAD^ &&
 	test_commit same2 &&
-- 
2.21.0

