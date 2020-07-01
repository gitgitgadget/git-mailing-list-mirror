Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C7C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84924206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ6BmbYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgGANfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbgGANfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC5C08C5DB
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z13so23868833wrw.5
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6B82yBHN3PPRK+wuQVBl1RqNKJtxlXluuF0TDsVsNg=;
        b=aZ6BmbYP44kcjLg4u1cQyH6CGl3pLA/sgRxJXU6w3XTGiugckV+24jcVc0ahvuNSlI
         iZqSnWpeU1D+g6PV8t//u/KbSV1RKJMnDrs8dmEnbx1O40D/RO8DJLB7B5Wr4qlyimhP
         Q+J3sVjO5fGbzUe2aKutErwDDDkv6urd0ywsmfbaeLXRmz5UNZDPwKL3HaaZ4mu4jHMk
         lgDc54+EVihGSLb6ArtYY6lwJk63fwHXE+darA3GTzw45khKoB4I58807enNVKtWjLbZ
         j7wcfzvs4K2aM0P6Zh70Ru6RD8qBX8qC6qI/jJS0XoBgBCF/7Hr5NDiVjrRmt9x3jzHk
         dHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6B82yBHN3PPRK+wuQVBl1RqNKJtxlXluuF0TDsVsNg=;
        b=C1v4DdKQ/uz7MMAlyaOIS+NOv2gSnjka+EZtPRKP3rbsdo1srbCQQTKO0ZJAHWhvJX
         0fczEHkfMVieFHqAIdPBi/yOIiAypAHfc3cES4kgQNpPuRuTuMGNcWa2zbyXUC3kr3Vf
         UPXEftyObWQ3rByltHfbEUEDFWis7IFPYSKyf4y8VpLJcMakiihlj832VkhEoY7N+N48
         eGYZh6AxWf/fleAhWuwecH9j1oeJVJ+DaTPZ9Ylb7c6tZl82qH16Tylv3vtRaLxsjAwg
         IIvqLpi32H/fAMblxdsNX4qquKrEzyv5rvrfLCmWZparY9MyEHiyhEXrZYeZ6KTIGLTw
         P/mA==
X-Gm-Message-State: AOAM533b6m7Insz0eVkHb3qeV+Gnst9a4lE1AVYWheX8WL78ZvdWU4U0
        7or8+kPcXAsnNd+3cYEhw6iKDhBDBhk=
X-Google-Smtp-Source: ABdhPJxi9JDODQtmvrUeyqs1x5utIToRQsXkXlehcKLkN12AXNCqXyPTA9y0DI1J5G/8vryXE8lvEw==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr28597453wro.116.1593610537836;
        Wed, 01 Jul 2020 06:35:37 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:37 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 07/13] bisect--helper: finish porting `bisect_start()` to C
Date:   Wed,  1 Jul 2020 15:34:58 +0200
Message-Id: <20200701133504.18360-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
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
index 9a9705c9e3..b52a925dc6 100644
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
@@ -608,11 +621,12 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 	return bisect_next(terms, prefix);
 }
 
-static int bisect_start(struct bisect_terms *terms, int no_checkout,
+static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
-	int flags, pathspec_pos, res = 0;
+	int flags, pathspec_pos;
+	enum bisect_error res = BISECT_OK;
 	struct string_list revs = STRING_LIST_INIT_DUP;
 	struct string_list states = STRING_LIST_INIT_DUP;
 	struct strbuf start_head = STRBUF_INIT;
@@ -670,9 +684,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
@@ -750,14 +767,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
@@ -771,7 +781,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -783,25 +793,37 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
index 809be25424..cfb05c0511 100755
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

