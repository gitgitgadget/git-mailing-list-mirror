Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9379C7619B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78482067D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzduef1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgBQIlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35464 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so18552300wrt.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rMmId46JqJEt9chXf79F4b/ZhaDCV0s6kJWTBBk17c=;
        b=Nzduef1KqvFljdEdMcCaF2B8g+4IMHV79PsDYDgdt+aJcA3Iwks9u4YbV89ivAzpI0
         zUdjbhvYba3pykcrjJ9GE5G/q7OY0i+m8uhuD0MN4SG7KdHTD0WyNb9X3hznVDBmzITH
         lv7yjyq3F0Z8SJaIS72z9B4vlLx9v0FNnNSD6HMGGUPxWGc+E5QMNgKLfmMkJxucvwV3
         wL4V7qJYLSxQBFbpj8wSVr2+ZxsLSmB/44DanSBmgSHyzcJMU2ZFAhCc8yaxeNUXhLun
         +zvh5mAgMRByFNB4y8QpFGGc6F9RNWCGOgrOf9xRHWo1Lyk8n9c9kD1Rq/qbJTlYvwiy
         9S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rMmId46JqJEt9chXf79F4b/ZhaDCV0s6kJWTBBk17c=;
        b=WPQPVU86czdHDpur6AF27qRWFguY8CxXhwzlu7oFdu9MY9xlP8sb11eSvRLgVER8wz
         8MdnAkwPT6z8mJofOBUyv/thBp+ePC5OOGl4t5oAuSRoMMR5gMoiQzPSJH/75cfHoqmw
         JN8BFMNDcNKw7Q9Ha/blr2jKrwjbMdEsOUjN04pMzT5FnbD2G4xj1Z+rQ1eJgceOTvN4
         aH7A+AD40B0cabcHZTi7buzas7pyZJG5MLdPRneTCURi6nHz94lbH5t9i4KPBuKJ0tLb
         tphf/HCC2sAhbYXB32TRVvFW/PmzCdq6bmA+qeR73i9BriRhqVb6N4wkUvsQs1+yv9VE
         4SDQ==
X-Gm-Message-State: APjAAAUwAqe44K2wGCq3fQJDQZnUra6i3/o6nHNcLUPCoCiUVtV3zZOE
        oyxOIlKo3onWt7GhuFf9A9EKpLJt
X-Google-Smtp-Source: APXvYqxQIe/XXwWC3T3UQX86WFf4gs94HzCQPLc+ydr9PqOOhQDUpG87R1k9y2BhdlPwFrRZp6PRSg==
X-Received: by 2002:adf:93c1:: with SMTP id 59mr21164028wrp.399.1581928880834;
        Mon, 17 Feb 2020 00:41:20 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:20 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 02/12] bisect--helper: change `retval` to `res`
Date:   Mon, 17 Feb 2020 09:40:29 +0100
Message-Id: <20200217084039.78215-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
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

