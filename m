Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A4C35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7420D217BA
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH8+iUFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBHJI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36308 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgBHJI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so1626650wru.3
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rMmId46JqJEt9chXf79F4b/ZhaDCV0s6kJWTBBk17c=;
        b=hH8+iUFGPx6oaY5DZ5ilkumNHvQoyuJK0cUpuA+RtBATJL7ojDxylDxZ2XLeZdlRv5
         79M6cNHE307cWYTnC12dXXvwOfLB9U7WVKfou2PDX2WQNh453MlxYkvBvLQ2xMqxZ2SG
         b2MS7tCkcbqwBZK+HxSy4VsLBPCl3J7QvzXgZCUeXvvuNt+dOXdWXJ8dhW1o705ZL8Kp
         iGsYxt9ek63kBcGcQ9ym00y5cA9OfzUcISwGBbKtIHm36G9/LkpRRDStl5GDLVhzoJyq
         4ESnx0Us6J6Ylle4JIarnLsOaoCB6Q5ulbOBFGJorVEMorx/E2fm0vl+29XW+wFyGhSj
         cS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rMmId46JqJEt9chXf79F4b/ZhaDCV0s6kJWTBBk17c=;
        b=RvL/JZwsBSrb8JGhudjTjbcXlWHV8R6W+2tvfTuraJgKnEWNOmfPNLJxaYaVJFKIWr
         P6WdVknwc8eNJiqAw2avhJEh3MAbPmL/8s+wkkmu18Q55tKh4zVIVnyIgQJVrqkVbC/J
         d78cAuwrBFuK1Qk/QLoCIA8LURBIuQlSqGy4JKLENkg26gN5Uk7P99CWxbuN8q9KIa3m
         86XSWGwmiQz58PypqdBX2g63qjNW70fo+FsMHx/SVsuxNPqbPeENtBIWof5cIr+enGqY
         G4anIU4uGLXZF1p8gjSJGDEacWV/Xmq02aB/T5ONXDCOKb/1zvRtD5WGvI8k/USotEcB
         0YMQ==
X-Gm-Message-State: APjAAAVINpI9SRfmu1MwsSRSCPveMMg+leT6jvBzar5nahc+s++ZWkfz
        RszkAW/WB6zuMKUIzuKcMTkXcm5C
X-Google-Smtp-Source: APXvYqx/BPRnV5NxeDF1hbaOW0abnbTk9RlfQ004cqzFlyPXjj/+bHGVz/WiU69jGscXYJ53xocoQw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr4674980wrm.81.1581152906238;
        Sat, 08 Feb 2020 01:08:26 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:25 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 02/13] bisect--helper: change `retval` to `res`
Date:   Sat,  8 Feb 2020 10:06:53 +0100
Message-Id: <20200208090704.26506-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Let's rename variable retval to res, so that variable names
in bisect--helper.c are more consistent.

After this change, there are 110 occurrences of res in the file
and zero of retval, while there were 26 instances of retval before.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 52 ++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 36c09b7238..21de5c096c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -206,31 +206,31 @@ static int bisect_write(const char *state, const char *rev,
 	struct object_id oid;
 	struct commit *commit;
 	FILE *fp = NULL;
-	int retval = 0;
+	int res = 0;
 
 	if (!strcmp(state, terms->term_bad)) {
 		strbuf_addf(&tag, "refs/bisect/%s", state);
 	} else if (one_of(state, terms->term_good, "skip", NULL)) {
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	} else {
-		retval = error(_("Bad bisect_write argument: %s"), state);
+		res = error(_("Bad bisect_write argument: %s"), state);
 		goto finish;
 	}
 
 	if (get_oid(rev, &oid)) {
-		retval = error(_("couldn't get the oid of the rev '%s'"), rev);
+		res = error(_("couldn't get the oid of the rev '%s'"), rev);
 		goto finish;
 	}
 
 	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
 		       UPDATE_REFS_MSG_ON_ERR)) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
 	fp = fopen(git_path_bisect_log(), "a");
 	if (!fp) {
-		retval = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+		res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
 		goto finish;
 	}
 
@@ -244,7 +244,7 @@ static int bisect_write(const char *state, const char *rev,
 	if (fp)
 		fclose(fp);
 	strbuf_release(&tag);
-	return retval;
+	return res;
 }
 
 static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
@@ -294,7 +294,7 @@ static const char need_bisect_start_warning[] =
 static int bisect_next_check(const struct bisect_terms *terms,
 			     const char *current_term)
 {
-	int missing_good = 1, missing_bad = 1, retval = 0;
+	int missing_good = 1, missing_bad = 1, res = 0;
 	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	const char *good_glob = xstrfmt("%s-*", terms->term_good);
 
@@ -308,7 +308,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		goto finish;
 
 	if (!current_term) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
@@ -329,21 +329,21 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
-			retval = -1;
+			res = -1;
 		goto finish;
 	}
 	if (!is_empty_or_missing_file(git_path_bisect_start())) {
-		retval = error(_(need_bad_and_good_revision_warning),
+		res = error(_(need_bad_and_good_revision_warning),
 			       vocab_bad, vocab_good, vocab_bad, vocab_good);
 	} else {
-		retval = error(_(need_bisect_start_warning),
+		res = error(_(need_bisect_start_warning),
 			       vocab_good, vocab_bad, vocab_good, vocab_bad);
 	}
 
 finish:
 	free((void *) good_glob);
 	free((void *) bad_ref);
-	return retval;
+	return res;
 }
 
 static int get_terms(struct bisect_terms *terms)
@@ -397,7 +397,7 @@ static int bisect_terms(struct bisect_terms *terms, const char *option)
 
 static int bisect_append_log_quoted(const char **argv)
 {
-	int retval = 0;
+	int res = 0;
 	FILE *fp = fopen(git_path_bisect_log(), "a");
 	struct strbuf orig_args = STRBUF_INIT;
 
@@ -405,25 +405,25 @@ static int bisect_append_log_quoted(const char **argv)
 		return -1;
 
 	if (fprintf(fp, "git bisect start") < 1) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
 	sq_quote_argv(&orig_args, argv);
 	if (fprintf(fp, "%s\n", orig_args.buf) < 1)
-		retval = -1;
+		res = -1;
 
 finish:
 	fclose(fp);
 	strbuf_release(&orig_args);
-	return retval;
+	return res;
 }
 
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos, retval = 0;
+	int flags, pathspec_pos, res = 0;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
 	struct strbuf start_head = STRBUF_INIT;
@@ -524,7 +524,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			argv_array_pushl(&argv, "checkout", start_head.buf,
 					 "--", NULL);
 			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-				retval = error(_("checking out '%s' failed."
+				res = error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
 					       start_head.buf);
@@ -572,12 +572,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 
 	if (no_checkout) {
 		if (get_oid(start_head.buf, &oid) < 0) {
-			retval = error(_("invalid ref: '%s'"), start_head.buf);
+			res = error(_("invalid ref: '%s'"), start_head.buf);
 			goto finish;
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			retval = -1;
+			res = -1;
 			goto finish;
 		}
 	}
@@ -589,26 +589,26 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	for (i = 0; i < states.nr; i++)
 		if (bisect_write(states.items[i].string,
 				 revs.items[i].string, terms, 1)) {
-			retval = -1;
+			res = -1;
 			goto finish;
 		}
 
 	if (must_write_terms && write_terms(terms->term_bad,
 					    terms->term_good)) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
-	retval = bisect_append_log_quoted(argv);
-	if (retval)
-		retval = -1;
+	res = bisect_append_log_quoted(argv);
+	if (res)
+		res = -1;
 
 finish:
 	string_list_clear(&revs, 0);
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
 	strbuf_release(&bisect_names);
-	return retval;
+	return res;
 }
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
-- 
2.25.0

