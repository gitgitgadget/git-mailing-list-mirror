Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104DEC33CB8
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E83217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHYNVVIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATOig (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34839 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so29792328wro.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+ZezR0wGUOg+FjlOgC+pT3lOJ8VVLkCSBEvw6cqiKw=;
        b=XHYNVVIYBfKmzDdnnS/sG/QOjZknnLoE270VaT5uHLwR4DIeKyqg6wgGFwCoGX69to
         0DfnZDeg3iNrzsEwyA4HezPA3J4ao3ELXOMKYmVZJ1iP6eMS4KOd7wT8EcZFdnYZAH6E
         JFXmFKsVhUuAxZ7/hTY+4PtV1nNlh4rJlNb43mQIqDQoKpm1IPsJ6sd4p1kCWKar4wbK
         +MpxzGChBJGODNmQIiW3kOJ+NipzdhT6zT+Fv/HT6A9cSm4uOsd85fxQZK7Uen/9/j3o
         JbZ4Frx0L7unk709p4iXBmNidIu++e6y+sRJ/3VqrWevHsZ0KVN46VfQyhSwtDlgJakl
         YlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+ZezR0wGUOg+FjlOgC+pT3lOJ8VVLkCSBEvw6cqiKw=;
        b=b+boANsZsidDWEHa3RfWMNvml+WoaU39b9EWOYPgz+L9RL7HMpZMfjt+mUNxh2gNhN
         fBSZCgWBvdu1JWD6EDgzlBMYtyPLJk33IImZHDUX7kv0y5rwSfrowP2Gkf9slBPWyCIj
         PDIQhTDXXpZK9QW1CDgChIiW7/7kYJlH5ROp6ssL8M44QNiXQvirTbcxuW0B0BfDD7kY
         sPz4ekPtJ+Z/8nKtm3+pD4R2TUrCP7AU3LtvfQ83/EoIBO2Tppo5FJj2v3fh7ZJ8WDN+
         DHY/k/jTg9HtccFnQ3fhu0AefUU/healVgOEuKuaWLjAlxOe0z3ECAgGh6Vr8f5EAcO8
         YlrA==
X-Gm-Message-State: APjAAAWJ7JpiWYzeHyj9wnqsaE9RbU+h5Q2ORRqnoMC8/2JbTPY2oylk
        vcwymgia4Xm6jFZHUuyysp0bTZg9
X-Google-Smtp-Source: APXvYqwAegTTypzqs2TZKRprYhVrwjmA1syEakAPDbAC5AUeWvqnfQzoODWaChQrYt+rqW5I9Fa+KA==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr17550003wrv.291.1579531111141;
        Mon, 20 Jan 2020 06:38:31 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:30 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 02/29] bisect--helper: change `retval` to `res`
Date:   Mon, 20 Jan 2020 15:37:33 +0100
Message-Id: <20200120143800.900-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
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
2.21.1 (Apple Git-122.3)

