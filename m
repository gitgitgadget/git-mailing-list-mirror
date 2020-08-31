Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16413C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEED62068F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l20fQvjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHaKwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgHaKvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A32C061236
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z9so4875765wmk.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnQ1kkgwV25WfVmhZ97e1ZSdPFpdCpqgxABGRetOF2g=;
        b=l20fQvjo6jXdxCJAsx24l673mKGo/6+u9KK5bfpKTr3ssPaf0zmDvecvMWnXSnqppv
         zh4Koj1IrupeWAVojRQe2x6YfzhZOW4GFpzKUAR7/A1pJagbQIVV0yNHUNTABCJFJEKO
         fIdeN6zdcV5wSnVVeE+g/3PUIDYHOxKvaiy/BIZ+GFohmhST2sJv9xOoV8uHrl48f7oR
         1HGyUsFYSjdvusLYNadUxK+3g4kXC1ZEq+xCOlT8HQQbuFZLgxO+Zy93EBwuStyqejaS
         Z+FMBu+pBnQj6EpMKJaPJMAzy9k57YAdScdqTOsEaeD2JjlvoG17u/1/cUE3RhGQFbxn
         kMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnQ1kkgwV25WfVmhZ97e1ZSdPFpdCpqgxABGRetOF2g=;
        b=KD5Ta/Rw3qJ/1GUo50ULEYJQ0Shn88cmDrF93tSFejvILoNfwIOYcw5VNkRl/jS7k4
         KVFKY/VXxY3EVijqQ77qgnAhKqkoM3HPz5LH1SegeQQjzsrCjBZVBMATKzQZmTlfKKoK
         PLNO6S+92xCa2/SLII5we5ohSbHDAHFuDWIWq0FMExKJZOwG/WtZ8EPjk0f8Tugzuury
         eBjO7cn5vkUDUIar1xJehhTGIpz5oHwpoxBNbS3ssrjpsqTfH4FnJAkfAKcZknD/HdHj
         BUbmhj2Ow2E/PkzbdHQIxrslYViSE73cxyWBwLRDmrYTWmmqNeJucgdwhYWo2tOVIzHU
         XtWQ==
X-Gm-Message-State: AOAM532YDzyOFWNS/MbY+fHSvMac7nB5jbx1FYhn0m+tUK2sp2A5tnp+
        +0Oo6ZtsDbA026fUpMt/bpEKm7sqZEs=
X-Google-Smtp-Source: ABdhPJzzboxYJaFwK74qLPq7F7d52KXRIICNlj335jvyH4jmohuzPTVgwT4nyuXDwTkD1jguu1jedg==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr858817wmc.22.1598871077420;
        Mon, 31 Aug 2020 03:51:17 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:16 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 07/13] bisect--helper: finish porting `bisect_start()` to C
Date:   Mon, 31 Aug 2020 12:50:37 +0200
Message-Id: <20200831105043.97665-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 56 ++++++++++++++++++++++++++++------------
 git-bisect.sh            | 26 ++-----------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e29e86142a..b40369e8aa 100644
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
@@ -607,12 +620,13 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
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
@@ -672,9 +686,12 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 			return error(_("unrecognized option: '%s'"), arg);
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash)
-				die(_("'%s' does not appear to be a valid "
-				      "revision"), arg);
+			if (get_oid(commit_id, &oid) && has_double_dash) {
+				error(_("'%s' does not appear to be a valid "
+					"revision"), arg);
+				free(commit_id);
+				return BISECT_FAILED;
+			}
 
 			string_list_append(&revs, oid_to_hex(&oid));
 			free(commit_id);
@@ -752,14 +769,7 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
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
@@ -776,7 +786,7 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -788,25 +798,37 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
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
+	/*
+	 * In case of mistaken revs or checkout error,
+	 * "bisect_auto_next" above may exit or misbehave.
+	 * We have to handle this to be able to clean up using
+	 * "bisect_clean_state".
+	 */
+	if (!is_bisect_success(res))
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 59424f5b37..356264caf0 100755
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

