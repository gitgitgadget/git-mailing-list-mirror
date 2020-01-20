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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0408C33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6F422464
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClUFNhTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgATOir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgATOiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so29830615wre.10
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIy0Duhk99PbPXdNOWsjgIubuTGfCEk54TwIYCfF2Ic=;
        b=ClUFNhTjZ68/9Sv0q6jguCj55ynYdNM0dmLO1qZmUp/TKjppfW+hD2IwUtGuHVOvjh
         /Ih8c3uUgtziFm+XpqFvYiaplt5tbbGl2g4DmJiS4XU3pYAUlnGfNomf7lKxMMjtpfWx
         uMXoN/1whsl8xZAQxJ95YF4NYG/P0ealxhVVQ0rNuBIgzg8sbfaB+4tSx3hlNI+e4S/d
         xSZ6xaxgvHqpRdjIvDnrD5Y0TJwxJHRkeE7uog/JpyiMpJVf/Ej47d+Yol8iaAEEx6u0
         j8jleNrsPgShJ4Nj3/+bgDBmBNhD04qJmKl2fZMe01RAP5pxSj6+tK5jQBZmMae4kmZS
         8JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIy0Duhk99PbPXdNOWsjgIubuTGfCEk54TwIYCfF2Ic=;
        b=BTwZRChz9O+hveY/j0Zput+4wpNzQtIVJh1pLLtX1fCzaZDEVxyy4iJN+bc4MxKcVD
         wS53LXPoBDmK2maf4ox0YctYSJNRHk/FSiyCJ6bhjajgO535FVc3wg1PwBzunp4i5my2
         lqUsj+6kH27XFM1WIdRERla6Wfg7gc0ibFAv5WybDeoDI+sWhz1k8p6z+waL1W3pCmwb
         7CxbiqGFrdKntXB04KO3SEXksxX34lk2ZTuN0RQAhOntK9mPNs6JiHKDuYU7Z4HEqbBP
         kqxzo4WS8BL6PgdiZla46LHfSRk70AL9xnT9ZYl6qmrV0WarbLO8lfVGEqZ48FFCNrWi
         Y/FA==
X-Gm-Message-State: APjAAAU5mltVrl40VkKJY1GbrlRhjKkwE/BbocRAHTBIsihjJzRWwYxg
        4UU0n3gGMkbOcmFIK8IVFhj2oyKSHMg=
X-Google-Smtp-Source: APXvYqyXKDhDMsach+PM8va9JShphP5+WvshncigKSxL5tUNQzrZrwIwOB8Hc3apqu9ya8hWCQVnCQ==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr18742090wrn.356.1579531124277;
        Mon, 20 Jan 2020 06:38:44 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:43 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 13/29] bisect--helper: finish porting `bisect_start()` to C
Date:   Mon, 20 Jan 2020 15:37:44 +0100
Message-Id: <20200120143800.900-14-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 38 +++++++++++++++++++++++++++++++++-----
 git-bisect.sh            | 29 +++--------------------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 29bbc1573b..e604334c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -632,9 +632,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
+				return -1;
+			}
 
 			string_list_append(&revs, oid_to_hex(&oid));
 			free(commit_id);
@@ -715,9 +718,9 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		return -1;
 
 	/*
-	 * In case of mistaken revs or checkout error, or signals received,
+	 * In case of mistaken revs or checkout error,
 	 * "bisect_auto_next" below may exit or misbehave.
-	 * We have to trap this to be able to clean up using
+	 * We have to handle this to be able to clean up using
 	 * "bisect_clean_state".
 	 */
 
@@ -764,6 +767,31 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
+	 * return code -11 is special code that indicates special success.
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
+	 *			   . res = -11
+	 */
+	if (res && res != -11)
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 7531b74708..fec527e1ef 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -63,35 +63,13 @@ bisect_autostart() {
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
-	get_terms
-	git bisect--helper --bisect-auto-next || exit
-
-	trap '-' 0
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -184,8 +162,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -284,7 +261,7 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		bisect_start "$@" ;;
+		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
-- 
2.21.1 (Apple Git-122.3)

