Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95ADD1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJKC7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:59:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36312 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKC7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:59:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so6933646wmf.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHSbu69oXUOc/nCG657mMgdah4B+o2XuIVoeY9X8ALY=;
        b=JJHCePyCKRVy2WDs1BZN+qffNSQMn0ukzjAzeWuqpMyEZreIwFT6jKfPEIM0Bbj6ud
         pjfH7BM5IOrVADtCnPUg7lXhgBy8KFFSYobkHFf1YAdX6hnFsVp9Z7XI/3wPyMEqTZJ6
         x5cYBnzb8jvy8NYzghd4FN0FJTQb4M1kdauZkFRAWAvC6jaHVSyhf2L4rtpXoq5lkUUq
         S6D+44oPV/oXOlU/ORV1xPgfIhKG+tjoZ7LooFef+tgdnJxEWmlUEQI/1d/b/xOc23O9
         H+U8fR+AGPRnKNQnPcqrq/5Xz2jXkW7cT8LA47DiAd39GHMzAT/o9J6d7bX3vjO9uUC9
         AOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHSbu69oXUOc/nCG657mMgdah4B+o2XuIVoeY9X8ALY=;
        b=jbQLd5u8TawTzSj23UrgkJjDbrcdJAnrx6HJH4Fc3y9w8KYhU9+SM87lhQw/++K53J
         aVo651Z+pKjHDusOFZx2h+DZuI9OUJRqLsqqMpf3yA1LCKhVsRZpgFDwWp9jQ8QjC3zf
         0KllsP3v2rBg/H/RNk5JF9djnM70AJmsZh5/pkHTaM/rvIPDwn2VyFla8MrhJWYMJHKL
         OWC9CG4gmGASJeuUKZZ025p3JpaEQ9PYIaxZqKJQHGlFX3+T2Bgap+5JQmKQSRZzvv+1
         xBia4Ek/ijyFJB7QChZNV6rE1tHBAi0WNTKlCBx7ttgJ7RE33vjPXVGFrvu26D7zJV1v
         4kaQ==
X-Gm-Message-State: ABuFfojtIBBdDrgaYz4IVErZv9dej+9gR1hEGxYm+rmUXyrBjsT5fwMs
        R9PJVFVrOf6S9+TwzIHlGSxPxi110JE=
X-Google-Smtp-Source: ACcGV6049+e/0IDWSsNZZjtp9Y7tWbzFBdOfOgF+q4rkj985SN5zK/DFudu19DbamFd1iy9Tqpiu3g==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr1890256wml.15.1539200166128;
        Wed, 10 Oct 2018 12:36:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z8-v6sm23346688wrp.63.2018.10.10.12.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 12:36:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] revert & cherry-pick: run git gc --auto
Date:   Wed, 10 Oct 2018 19:35:57 +0000
Message-Id: <20181010193557.19052-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand on the work started in 095c741edd ("commit: run git gc --auto
just before the post-commit hook", 2018-02-28) to run "gc --auto" in
more commands where new objects can be created.

The notably missing commands are now "rebase" and "stash". Both are
being rewritten in C, so any use of "gc --auto" there can wait for
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

After reading the "Users are encouraged to run this task..." paragraph
in the git-gc manpage I was wondering if due to gc --auto all over the
place now (including recently in git-commit with a patch of mine) if
we shouldn't change that advice.

I'm meaning to send some doc changes to git-gc.txt, but in the
meantime let's address this low-hanging fruit of running gc --auto
when we revert or cherry-pick commits, which can like git-commit
create a significant amount of loose objects.

 builtin/revert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9a66720cfc..1b20902910 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -209,6 +209,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
+	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 
 	if (isatty(0))
 		opts.edit = 1;
@@ -217,6 +218,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	return res;
 }
 
@@ -224,11 +226,13 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
+	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	return res;
 }
-- 
2.19.1.390.gf3a00b506f

