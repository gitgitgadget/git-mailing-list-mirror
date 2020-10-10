Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E928C43457
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064912075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlwmkIQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbgJJW4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbgJJTwD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6FC05BD17
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id 3so222606wrm.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFGUeazmN8IA86N71XkqLUHEi7UNYWpGhbDRPTEdlpw=;
        b=rlwmkIQVnB5snZvK2WTJO0ba4TqOfMc6UjCoDKWA51D5XuspYz/D1zq0xXcH+IO4P2
         3TeQeXnL69x9AHnBAgVfiRmMkq54y83t29Ulfpj3QBuLQFuMGM23xoNmNDFLpp5eebzL
         5ShRuGfW0j6SQaxFld/YrZq40jCk33Wqn7b/3TSTJlTw0StU1xkISA6zOHZ9i9BoZK7E
         DTXBwCb/f1AcXsmLtc6qVy0z3Rkpjcrj+BiL3nSd4a31/TVxugs5kwkNbya59YPW/7hx
         EDj2Gwni2JtsnDXCOcHItc20LvbIcB6+C9BgFeL8ywzT6T7BGPzc2YWv/UfYDXNeKQZD
         tmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFGUeazmN8IA86N71XkqLUHEi7UNYWpGhbDRPTEdlpw=;
        b=iRBMJM+DjILefL10AeNa6RFIpd7+uM2GPZg/DhZqeS9ADgSN7FKhPcWu7BGh2x34bx
         ee4hKC4cmsssLKmNROccCaOaVsQMl6ka7OH7yiynvxHNJz3aNM9KPukqh4Cm+ZyFUK4p
         9TaO7hHfrNLbL/ar9MTyPonp+Eeq/EdNr5BY8LzGp/sxETFb4AnRAdL6mGBy6vrbJs9u
         ha3Ac/jYvxxG6HJ0X6YYDM/O4sR514SjC99H0iQxPdrs9GHsL+muqq/nBPhcYxiqSbFa
         dLKIAX4N/JOk6jfYH47vIqGADm6rwzYV4n316Bgst8FWGrg008OZftYYxcTg1vi1DqIv
         yzJg==
X-Gm-Message-State: AOAM530qoNs4zOrHa8ts25CbZBGYa+O5ZLGVwSHCwL2yKih2rBDm1siO
        7b7bq4X+dixRYOclXTyhmo4f73BAfQ8=
X-Google-Smtp-Source: ABdhPJzCag772h9q0MdT2AX5J9kzOdOvX8X6rxajQiuFNnK0WSfTw1TNNzU4nWxZdIH3ErCF4x1uTQ==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr19487991wrs.186.1602338934172;
        Sat, 10 Oct 2020 07:08:54 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:08:53 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 1/7] bisect--helper: finish porting `bisect_start()` to C
Date:   Sat, 10 Oct 2020 16:07:37 +0200
Message-Id: <20201010140743.580-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Add the subcommand to `git bisect--helper` and call it from
git-bisect.sh.

With the conversion of `bisect_auto_next()` from shell to C in a
previous commit, `bisect_start()` can now be fully ported to C.

So let's complete the `--bisect-start` subcommand of
`git bisect--helper` so that it fully implements `bisect_start()`,
and let's use this subcommand in `git-bisect.sh` instead of
`bisect_start()`.

Note that the `eval` in the changed line of `git-bisect.sh` cannot be
dropped: it is necessary because the `rev` and the `tail`
variables may contain multiple, quoted arguments that need to be
passed to `bisect--helper` (without the quotes, naturally).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 41 ++++++++++++++++++++++++++--------------
 git-bisect.sh            | 26 ++-----------------------
 2 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7512b880f0..8adad68268 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -85,6 +85,19 @@ static int one_of(const char *term, ...)
 	return res;
 }
 
+/*
+ * return code BISECT_INTERNAL_SUCCESS_MERGE_BASE
+ * and BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND are codes
+ * that indicate special success.
+ */
+
+static int is_bisect_success(enum bisect_error res)
+{
+	return !res ||
+		res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND ||
+		res == BISECT_INTERNAL_SUCCESS_MERGE_BASE;
+}
+
 static int write_in_file(const char *path, const char *mode, const char *format, va_list args)
 {
 	FILE *fp = NULL;
@@ -609,12 +622,13 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 	return bisect_next(terms, prefix);
 }
 
-static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos, res = 0;
+	int flags, pathspec_pos;
+	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
 	struct strbuf start_head = STRBUF_INIT;
@@ -753,14 +767,7 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 	 * Get rid of any old bisect state.
 	 */
 	if (bisect_clean_state())
-		return -1;
-
-	/*
-	 * In case of mistaken revs or checkout error, or signals received,
-	 * "bisect_auto_next" below may exit or misbehave.
-	 * We have to trap this to be able to clean up using
-	 * "bisect_clean_state".
-	 */
+		return BISECT_FAILED;
 
 	/*
 	 * Write new start state
@@ -777,7 +784,7 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -789,25 +796,31 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 	for (i = 0; i < states.nr; i++)
 		if (bisect_write(states.items[i].string,
 				 revs.items[i].string, terms, 1)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 
 	if (must_write_terms && write_terms(terms->term_bad,
 					    terms->term_good)) {
-		res = -1;
+		res = BISECT_FAILED;
 		goto finish;
 	}
 
 	res = bisect_append_log_quoted(argv);
 	if (res)
-		res = -1;
+		res = BISECT_FAILED;
 
 finish:
 	string_list_clear(&revs, 0);
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
 	strbuf_release(&bisect_names);
+	if (res)
+		return res;
+
+	res = bisect_auto_next(terms, NULL);
+	if (!is_bisect_success(res))
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index ea7e684ebb..dda386bc3a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -49,27 +49,6 @@ bisect_head()
 	fi
 }
 
-bisect_start() {
-	git bisect--helper --bisect-start $@ || exit
-
-	#
-	# Change state.
-	# In case of mistaken revs or checkout error, or signals received,
-	# "bisect_auto_next" below may exit or misbehave.
-	# We have to trap this to be able to clean up using
-	# "bisect_clean_state".
-	#
-	trap 'git bisect--helper --bisect-clean-state' 0
-	trap 'exit 255' 1 2 3 15
-
-	#
-	# Check if we can proceed to the next bisect state.
-	#
-	git bisect--helper --bisect-auto-next || exit
-
-	trap '-' 0
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -163,8 +142,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev $tail"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev $tail" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -264,7 +242,7 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		bisect_start "$@" ;;
+		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
-- 
2.25.0

