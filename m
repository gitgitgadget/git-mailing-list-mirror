Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA50C4BA11
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5320838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzP2HidS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgBZKQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37605 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBZKQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so2250179wrx.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gnnykk1BeT9/Xn/4TALX6BuNNkhGtAFpMtlkyiqz9X0=;
        b=lzP2HidSZzZKxnptM5B7rhArkCKs+11tnOJgl9fbcvRIzWNp6uaa5CpGKmerUhlu6N
         70JX+hq7/ERnXhNyBw9XhjGVFx0r2mGBqKSGRkxcav1Wc5es2wLcCzHe9+UfQQtuE+PW
         cRsDRs7th/SPdT/TgisfEN2eZoNWPhlLsG5a3xDoQqN66sG2mU5pMWq1bYk2cBa6Wmf/
         3dZJh6Oi+ekzY+v67SudGKn31oy79TQ2ZpUCsSYOVmUDZAacKTB89YEtlAzUAiyHLOBd
         QvA+4UPL+dcS3MaC2rBRAZ1mz8PvvofbmXNRXkcnSJQ4oAJHWOn7nUKVYQX8FyNoa7cs
         ZZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gnnykk1BeT9/Xn/4TALX6BuNNkhGtAFpMtlkyiqz9X0=;
        b=sPkIz+4oj6vsxWLvJXe3q4pYzF6aSGphhrfzQkOQBDUqCmeJ4qi32CTFql9Gr8FxvL
         sofN4LXXQ0U2loVQeLnskB/9rxaXUb12Wuqm+1AKqRw0yxFLM0/WXIyZOBczlb1UKT84
         D1dJpkRmKRAVvaqhoHz2hb5kkZcACMHBMhsord5IQfwSA3QkbiLVmzVWgDQbu8M8BZf5
         8tngBcT6BrTBH+vZwk1RNA+okkzhJioVc/RB0EYznEPLHvVIXjXL37AeyKfn8zvdgaj/
         lxJ3MOxVBT7kDvKOpwZ3mKttjC8bcffiLf57I1Ndm0XSf1dz5qloOuZGB7Mei/8dF1id
         S0Pg==
X-Gm-Message-State: APjAAAU9eb0KxmSf9e4w5F50+3nESBnwrUsjCpEeMJi92LGS+bxbax2r
        OhwlQ//Uk4InYH6yfPC16g6DCW71
X-Google-Smtp-Source: APXvYqwReUq8rjT6ZK7YSM5+U/6E6oiqIMUEiKlTkxcaSCUNh24NKYB9PFqwlkWjrKM5xxvYdKttPg==
X-Received: by 2002:adf:e550:: with SMTP id z16mr4739088wrm.5.1582712169576;
        Wed, 26 Feb 2020 02:16:09 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:09 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 03/10] bisect--helper: finish porting `bisect_start()` to C
Date:   Wed, 26 Feb 2020 11:14:22 +0100
Message-Id: <20200226101429.81327-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
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
 git-bisect.sh            | 28 +++------------------
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c82ffe9c1c..e75e7a0837 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -583,11 +583,12 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
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
@@ -640,9 +641,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
@@ -720,12 +724,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
 
@@ -741,7 +745,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		}
 		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
 			       UPDATE_REFS_MSG_ON_ERR)) {
-			res = -1;
+			res = BISECT_FAILED;
 			goto finish;
 		}
 	}
@@ -753,25 +757,51 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
index e03f210d55..166f6a64dd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -63,34 +63,13 @@ bisect_autostart() {
 			[Nn]*)
 				exit ;;
 			esac
-			bisect_start
+			git bisect--helper --bisect-start
 		else
 			exit 1
 		fi
 	}
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
@@ -183,8 +162,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -283,7 +261,7 @@ case "$#" in
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

