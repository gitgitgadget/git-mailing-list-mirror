Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F7C433ED
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52AED206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWYOLUjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGQKyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgGQKym (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F0C08C5C0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so10452694wrw.12
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOHI/uijrXArtHoXPNf+2CT7KYSXOpthnmTBYy4hSzM=;
        b=KWYOLUjb5T3o35ZTz0NXzIXbxpqWUwLCBjd6MhKxnBRaGCxK8ToBmzC+L8U/07NH7M
         v5BgNpMoQXFQXi6oXcerLy8kW+5imOhrRTgvvpQzUN1//WSZo/unvdA5xbT3mxihuJGi
         UR+EYGs4CTEo6gt4MCIE0Mh4ypCANwMiXFVnqmRAQIVVOsH8u2eDNoRTnr/P/N+9xO4g
         kNkN24jKjQ4d5+vDGXeYp7+G6/HSOfL3fZuomc2d9tUa1BYiw+5M8Up6bLQYrnIMASsd
         5qcWWR0NeYFSwj5fBU87pSrSXNAVl7zp/olrUjBX4PicaMUK54KbHFxBbhjOUwD300UV
         vq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOHI/uijrXArtHoXPNf+2CT7KYSXOpthnmTBYy4hSzM=;
        b=tDDhf9CR6hpH0ObtROMtwwYZj4ULDFkl/nYZXKWl4I0ro2EOSb6YIdE2Wf9bW8Zaz7
         bUMKe0MHajvRg+gHZiny60a8rDb43Otdt1k+Ey5qgADUwWCOCSrnaSvPmZCPhJHNhJsD
         5O97/S8I2DB2B99xXdAAgfy/x7AekG47IEjAm4EsPnvqGW1hFeOy98VgPUVZAjDIVOAZ
         KzBGLLQ9wRoDFeJC3WGYeTIHEvtJ59wSwPRuzRm29dcarHCvuKjbE5YHeq78AktnoSvi
         qUho0fNOlGni+P3QAncdy/CoEa0PLXfqfcjAdQUTswkWDAPU84ACW16mpfUeld1kvfU4
         5lAA==
X-Gm-Message-State: AOAM530gDh/e7u7fBcVKH67DWDRSf/OmRbbiGxTWmYeVRaetij3nBj6t
        SCpP13ZF4S5xdDnpl7SzLNKEAIU8
X-Google-Smtp-Source: ABdhPJwWvHhAe8mP13gUuIhoP8GQSh4u5e60t3dkgfaDWP0k3MJXROHe+MMvzzt0YYGaAXa1r2YhZg==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr9626377wro.151.1594983280990;
        Fri, 17 Jul 2020 03:54:40 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:40 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 07/13] bisect--helper: finish porting `bisect_start()` to C
Date:   Fri, 17 Jul 2020 12:54:00 +0200
Message-Id: <20200717105406.82226-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
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
index 4223af144a..2b7bad558a 100644
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

