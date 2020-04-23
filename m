Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A873C55193
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF745208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKfOXY3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDWHJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgDWHJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AEAC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so5223410wmj.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTEo0Yt8Ey5QaDqniZ//5HvJkTw1TzA0j8wYQicD55g=;
        b=nKfOXY3q0WFHTVoOPLX8/zYPVOaGdi2on239knlUz6kMtRfXpVh171tGJhohj5ZsmE
         ZbPReYslAVkMik4VXhMfWT6s0/v2K83jGNxkrAjCGkaLOEI5d8cmP21fFr3pmVb12gl3
         qPXqRGdveIjev2cAu7Zm6a5cV4iBHfHYG7lgyIs9VXsXJ17twPKaz8ScnhcTmOC6xAXA
         JZleCRED1Xxc8lI1dA5pnP9HYQifS0Br4WfF45iImtSiUNDu2hIlxUySeuzaOiGpa7US
         MpYR/nJRn8L8bqtxTJ1SlclKQA3iqygkRpd04qctEUNfwgB0JtMOwhifUCyYa747K17E
         +Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTEo0Yt8Ey5QaDqniZ//5HvJkTw1TzA0j8wYQicD55g=;
        b=KEDj4/rZVcIwJvvPXgFlEyka/hEBWWFnV1FrHy4S51DljDAswtvA6zJT09ClrctwxP
         z7YOw1e/GATyCmGsNFoTZbDIyf3kDsgBI2C0EVHIQPudOtmIYkFt/u0pHsx79OElXBcg
         Ds6A0fzunbgLqtcU7ZVBdRg3E0IXht+tH73LeVdBU6iVof03hsu0Md+6gRBKXkGh0E6f
         PcJEy7rNPod7BBnuzefOmYWn4ipwHh/LWl1caR06Wyx2SlQ7Ot4lQZ6hDY7DTB4jrhRE
         cBP+yBmUrji/MeQnYV5Tsh0VB4X5GB2z9FgdrO7LdMXEuCGjYhJp/Q5wjKk60zXfHKVj
         e4ww==
X-Gm-Message-State: AGi0PuaX6E+QZKuuz1ahgwJ+4jjzPNPQYMlr7Zy1t84Moy//sOekFVAZ
        wIZZepPVPwEpci6/n/v3ReP+Kk6XExk=
X-Google-Smtp-Source: APiQypITTHNXBPkKS7kQPrC0laL1KLpIMyg2RkjHD4va0fcgEekQoEas2b8tHL7EPlUdDfTrfCCaCw==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr2653895wmb.26.1587625782158;
        Thu, 23 Apr 2020 00:09:42 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:41 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 06/12] bisect--helper: finish porting `bisect_start()` to C
Date:   Thu, 23 Apr 2020 09:06:58 +0200
Message-Id: <20200423070704.39872-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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

This removes the signal handling we had in `bisect_start()` as we
don't really need it. While at it, "trap" is changed to "handle".
As "trap" is a reference to the shell "trap" builtin, which isn't
used anymore.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 54 +++++++++++++++++++++++++++++++---------
 git-bisect.sh            | 26 ++-----------------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c6aaa8eb15..f2ec7f89e4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -588,11 +588,12 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
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
@@ -645,9 +646,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
@@ -725,12 +729,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	 * Get rid of any old bisect state.
 	 */
 	if (bisect_clean_state())
-		return -1;
+		return BISECT_FAILED;
 
 	/*
-	 * In case of mistaken revs or checkout error, or signals received,
+	 * In case of mistaken revs or checkout error,
 	 * "bisect_auto_next" below may exit or misbehave.
-	 * We have to trap this to be able to clean up using
+	 * We have to handle this to be able to clean up using
 	 * "bisect_clean_state".
 	 */
 
@@ -746,7 +750,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -758,25 +762,51 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
+	 * In case of mistaken revs or checkout error, or signals received,
+	 * "bisect_auto_next" below may exit or misbehave.
+	 * We have to handle this to be able to clean up using
+	 * "bisect_clean_state".
+	 * return code BISECT_INTERNAL_SUCCESS_MERGE_BASE is special code
+	 * that indicates special success.
+	 *	-> bisect_start()
+	 *	   . res = bisect_auto_next()
+	 *	    -> bisect_auto_next()
+	 *	       . return bisect_next()
+	 *	       -> bisect_next()
+	 *		  . res = bisect_next_all()
+	 *		  -> bisect_next_all()
+	 *		     . res = check_good_are_ancestors_of_bad()
+	 *		     -> check_good_are_ancestors_of_bad()
+	 *			. res = check_merge_bases()
+	 *			-> check_merge_bases()
+	 *			   . res = BISECT_INTERNAL_SUCCESS_MERGE_BASE
+	 */
+	if (res && res != BISECT_INTERNAL_SUCCESS_MERGE_BASE)
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 897825b675..049ffacdff 100755
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
@@ -162,8 +141,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -262,7 +240,7 @@ case "$#" in
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

