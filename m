Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC571F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeHHVUe (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:34 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39875 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbeHHVUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:34 -0400
Received: by mail-wm0-f41.google.com with SMTP id q8-v6so3839041wmq.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fdrp9J1jeM/WCfG8cEcsIfaFaO5nHWggwJ5AWvkNma0=;
        b=smfry7iPxMJXDBnbQkNCTtSRX+GKLSmxEFOV6HkrL+perpExUd37i37oVdQ8+fjFVA
         pp+McmsJHwGfwdVUTINv0lYJxqlCILM78gCwicwFuVWrqaisY+r8M7vt3NvvIHeZj2m2
         YbR5ZbN1fNuDh1Q+dL860oc2vKEQlpZQx6ahhwZW4/4pv4scXQLXcQzp/NUqOixhj5Gq
         KaFLxhn+k5CaBFM3G0wDQAa+XpyxdKNJ6OKZoX814PC8FYC2Nk5OMODJ4QscLKMA8tw/
         lXmfl8JuY44/m6KyIXK2UvKSEPMIsffFd0wl70B+/stEIGKcE50c+dcebjL+EkJDeHFP
         ex9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdrp9J1jeM/WCfG8cEcsIfaFaO5nHWggwJ5AWvkNma0=;
        b=FwBGSSVbLLExn+d14+iCi91E1HXmdATkYXiDTzJabv2fn3YPkMZC6CrtJl6/aTQDyP
         EsT5FrGsbYT22zlR1BORtOiNx9gVlU2J6sx8aPVFCAV9QCQWmNgDby4H6UkoCXqpzG2A
         3GNj+BEOW6BwNnBBkOpeTfuyIk2woNk4GfzEyeSw9u85bi3RdMl7hFSQwPMr3JPtT+6Z
         ASF1Dqvt1pdXMq6aZEd2EuGfEfPYKgWTxOF3yjzcFxCzRk/Ro5NtwSaqOrnWNh3CkKnD
         Q0IEFNh3faYMkEB4EuBX+OXdpubCmBYToLss9B3rDY76ivj3MTDEvwjtSyoLpbp/iZ2P
         4hfw==
X-Gm-Message-State: AOUpUlEmD+jKch7Yam8m52Tds5xQyHBLq3kgdp3hB6ZtMz1jcXk5U8q7
        o8cylzD+m1LjplBTWpLWNhqQpBwU
X-Google-Smtp-Source: AA+uWPyy7fTqTVOs4BM2pQ387RP5+5aC0peylrjuZQ4OTK0hJs5GRTqHas3IJOdA9VtM4w5Lpb3DFg==
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr2684057wmf.10.1533754772107;
        Wed, 08 Aug 2018 11:59:32 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:31 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 17/26] stash: avoid spawning a "diff-index" process
Date:   Wed,  8 Aug 2018 21:58:56 +0300
Message-Id: <ec5b2c9ac9e0e58710bdc385e03a01e2a7fd10bd.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commits replaces spawning `diff-index` child process by using
the already existing `diff` API
---
 builtin/stash--helper.c | 56 ++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 887b78d05..f905d3908 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 #include "rerere.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "diffcore.h"
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
@@ -297,6 +298,18 @@ static int reset_head(const char *prefix)
 	return run_command(&cp);
 }
 
+static void add_diff_to_buf(struct diff_queue_struct *q,
+			    struct diff_options *options,
+			    void *data)
+{
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		strbuf_addstr(data, p->one->path);
+		strbuf_addch(data, '\n');
+	}
+}
+
 static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -981,14 +994,16 @@ static int stash_patch(struct stash_info *info, const char **argv)
 	return ret;
 }
 
-static int stash_working_tree(struct stash_info *info, const char **argv)
+static int stash_working_tree(struct stash_info *info,
+			      const char **argv, const char *prefix)
 {
 	int ret = 0;
-	struct child_process cp1 = CHILD_PROCESS_INIT;
 	struct child_process cp2 = CHILD_PROCESS_INIT;
 	struct child_process cp3 = CHILD_PROCESS_INIT;
-	struct strbuf out1 = STRBUF_INIT;
 	struct strbuf out3 = STRBUF_INIT;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct strbuf diff_output = STRBUF_INIT;
+	struct rev_info rev;
 
 	set_alternate_index_output(stash_index_path.buf);
 	if (reset_tree(&info->i_tree, 0, 0)) {
@@ -997,26 +1012,36 @@ static int stash_working_tree(struct stash_info *info, const char **argv)
 	}
 	set_alternate_index_output(".git/index");
 
-	cp1.git_cmd = 1;
-	argv_array_pushl(&cp1.args, "diff-index", "--name-only", "-z",
-			"HEAD", "--", NULL);
+	argv_array_push(&args, "dummy");
 	if (argv)
-		argv_array_pushv(&cp1.args, argv);
-	argv_array_pushf(&cp1.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
+		argv_array_pushv(&args, argv);
+	git_config(git_diff_basic_config, NULL);
+	init_revisions(&rev, prefix);
+	args.argc = setup_revisions(args.argc, args.argv, &rev, NULL);
+
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = add_diff_to_buf;
+	rev.diffopt.format_callback_data = &diff_output;
+
+	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+		ret = -1;
+		goto done;
+	}
 
-	if (pipe_command(&cp1, NULL, 0, &out1, 0, NULL, 0)) {
+	add_pending_object(&rev, parse_object(the_repository, &info->b_commit), "");
+	if (run_diff_index(&rev, 0)) {
 		ret = -1;
 		goto done;
 	}
 
 	cp2.git_cmd = 1;
-	argv_array_pushl(&cp2.args, "update-index", "-z", "--add",
+	argv_array_pushl(&cp2.args, "update-index", "--add",
 			 "--remove", "--stdin", NULL);
 	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
-	if (pipe_command(&cp2, out1.buf, out1.len, NULL, 0, NULL, 0)) {
+	if (pipe_command(&cp2, diff_output.buf, diff_output.len,
+			 NULL, 0, NULL, 0)) {
 		ret = -1;
 		goto done;
 	}
@@ -1033,8 +1058,11 @@ static int stash_working_tree(struct stash_info *info, const char **argv)
 	get_oid_hex(out3.buf, &info->w_tree);
 
 done:
-	strbuf_release(&out1);
+	UNLEAK(rev);
 	strbuf_release(&out3);
+	argv_array_clear(&args);
+	object_array_clear(&rev.pending);
+	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1112,7 +1140,7 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
 			goto done;
 		}
 	} else {
-		if (stash_working_tree(info, argv)) {
+		if (stash_working_tree(info, argv, prefix)) {
 			printf_ln("Cannot save the current worktree state");
 			ret = -1;
 			goto done;
-- 
2.18.0.573.g56500d98f

