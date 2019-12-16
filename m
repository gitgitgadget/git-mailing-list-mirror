Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE69C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 11:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21990206CB
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnpu/S3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfLPLNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:13:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfLPLNS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 06:13:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so4761729wmd.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w428xQDAUGzEneuGwWn5EnShnj2G2k7ZB6AKqq12MJ4=;
        b=Bnpu/S3VuUSzl2uHGGGaxA41JmWwbiaHF+nmixJoPy/rnwU88tN6AFFSYEuESrxune
         hweufqEy563Tl+7ewJgodeXoOf0c96LdwmTp06pUT0Xyw84k/gyJAQpP0qF06625Nn83
         zcrw3fOKPg3M6QPkCAFmpT2FzknVKM1/YKM2bmYM9X3/Zfq8PKi3BLhfqCs7I+rVlbNd
         /KqxYtw8e4tM0biT31RQPr3FaZgmeBY6whJVUPDuRvvJTHQqtibygsqsxS8rSr+dv8Wi
         jY/JFHDrZvBadhpZHgdhhymotJ5xj+t30rUO10WTcN90WQ1PzphFAFAnsW0Bsq/m4mE1
         XGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w428xQDAUGzEneuGwWn5EnShnj2G2k7ZB6AKqq12MJ4=;
        b=IZXVUm+elg0KDTdCGQBg1gDWyGzypbjmh2HIglETAOKQw9JBySwhSy2B5YdN9PgOmu
         5qZM9absQXI0YsqmrDheEJM3J2tjkWqJoEIQGHP49ZAMq+AkbXxlwGJVwknsgUOcRmEQ
         YG0x92D+kYNt6lM2wQAzbSB8tfq+XLm6HyknmqSXgcgyQ0OcZyKWvNah6qYjcxEFNxfQ
         iXBYwHFSISfCW2+deR4iXnIorQNvPQQPsHry2kAI+og3fS9o4Jr/3GOq0mzuJeANyJoi
         HIEdMP0XRbIrqY4RvkhxZLl7LtEBYbVYlg5BDD3IIfRPEPdP0ys2ncml23AC5y4BmFl4
         hsJw==
X-Gm-Message-State: APjAAAUAwn3xAH8utsXH33BJIIrjR8gDpDdo9CDHBzRlxQLVpVD3TfGR
        fIN8QuyMdAlORJq2k+muaiK4/mJ+9hA=
X-Google-Smtp-Source: APXvYqzxFVnTRBnkRJuqouiJNjFsJnTr/vqOQqJavhU25hBlu46IXEuR3tHaqhLu5mq5dEaHbzL3pg==
X-Received: by 2002:a1c:7e13:: with SMTP id z19mr29520853wmc.67.1576494795544;
        Mon, 16 Dec 2019 03:13:15 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id x10sm20989397wrp.58.2019.12.16.03.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 03:13:15 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH] bisect--helper: change `retval` to `res`
Date:   Mon, 16 Dec 2019 12:12:46 +0100
Message-Id: <20191216111246.5190-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Convert of variable `retval` to `res` make `bisect--helper.c` 
more consistent.

Now, 110 ocurrences of `res` in file and zero `retval` occurrences.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
This patch is a new version of:
https://public-inbox.org/git/bb04df4bfb3b045e3496e4d05eecc729c3228217.1551003074.git.gitgitgadget@gmail.com/
sent previously by Tanushree Tumane.

 builtin/bisect--helper.c | 52 ++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1fbe156e67..8cc19b7f32 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -205,31 +205,31 @@ static int bisect_write(const char *state, const char *rev,
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
 
@@ -243,7 +243,7 @@ static int bisect_write(const char *state, const char *rev,
 	if (fp)
 		fclose(fp);
 	strbuf_release(&tag);
-	return retval;
+	return res;
 }
 
 static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
@@ -293,7 +293,7 @@ static const char *need_bisect_start_warning =
 static int bisect_next_check(const struct bisect_terms *terms,
 			     const char *current_term)
 {
-	int missing_good = 1, missing_bad = 1, retval = 0;
+	int missing_good = 1, missing_bad = 1, res = 0;
 	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	const char *good_glob = xstrfmt("%s-*", terms->term_good);
 
@@ -307,7 +307,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		goto finish;
 
 	if (!current_term) {
-		retval = -1;
+		res = -1;
 		goto finish;
 	}
 
@@ -328,21 +328,21 @@ static int bisect_next_check(const struct bisect_terms *terms,
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
@@ -396,7 +396,7 @@ static int bisect_terms(struct bisect_terms *terms, const char *option)
 
 static int bisect_append_log_quoted(const char **argv)
 {
-	int retval = 0;
+	int res = 0;
 	FILE *fp = fopen(git_path_bisect_log(), "a");
 	struct strbuf orig_args = STRBUF_INIT;
 
@@ -404,25 +404,25 @@ static int bisect_append_log_quoted(const char **argv)
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
@@ -523,7 +523,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			argv_array_pushl(&argv, "checkout", start_head.buf,
 					 "--", NULL);
 			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-				retval = error(_("checking out '%s' failed."
+				res = error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
 					       start_head.buf);
@@ -571,12 +571,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 
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
@@ -588,26 +588,26 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
2.21.0 (Apple Git-122.2)

