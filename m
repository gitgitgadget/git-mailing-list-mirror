Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D581C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C9023142
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbhAGKiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbhAGKiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 05:38:14 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83538C0612FD
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 02:37:11 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t22so3613965pfl.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 02:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mg0L325WpXh8JpTEiT9H1jmvZ2S6ZfP1FQtd/xmStvQ=;
        b=U5lkI3eWuzyOWdLhayjAGTuNsqngRenZTFemkeqYtlKzFuGX/H9bzLiPziCEgMtzmn
         WB0sYtJT2v3J5nNWiPaLRRlclhcGVoSA/7XssxMVioQW5M/kCkcBlO9Wqch9pJJXQ8be
         VJ6/8KNZS13P/RDyBy8Wuy1AbRO3hxPWau7+7lDwLuHUpBLG5LNOLIQUBzSs/a5lZ8Ob
         7tMw7hiPTqdApTdi/j6kv/CByfh1UpbAzLrZLAO+7S4QxPsOI7mG1hMtAq8qwNhwtC12
         zGaooQsoTLka7ImqI5tm87X4x5aRey7daSa/eeqigPi0wvwyg/sZonHWrOFwyNYmec3L
         zCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mg0L325WpXh8JpTEiT9H1jmvZ2S6ZfP1FQtd/xmStvQ=;
        b=mhzjv1lyZ8G0gnhPvCZ1UkgRKH+dtDKypoa1wwFpsXkb5Xtx0vKzjaPzItQrxbOUkF
         QG4KZok8yois3HEip5jYjr3hRoZRwaByd+wZahB5aCk28G4yFnajzs0hruRUbnSiqCKs
         KwFiIRHek6lR/+FP48ExSz8nNIbkxGptUlBnMVOWB9ZLLcQLZ1shtwNLqYNwWPcakG/k
         f4blL4CqAYCmV6a/4h0FdTWb0Q8yEA1HUyCQ7e4EnABlD0VwHOo6g6+vVx/e2avjN40U
         TobnNL1Rkkw4649vrLFqBY6G8FimCCELv4j/aI/XAGJYQfIHQSoxKdJWuwkykYEFcYC5
         ZC0A==
X-Gm-Message-State: AOAM531oQuxW4XRnPjQsrrSSYKWowTUj0Mr6kUpE8s9K1LR/v8kXOCuq
        5MA5Tu8JHNluQswNcvO+GpvHgtBenfE=
X-Google-Smtp-Source: ABdhPJxbZb0Z9N+OIMQVYSi5hkqKKwrxQmgL2t4gpoFZVhfVd9wNrYjEkebvSdQ/tDI/W6oEgHpdGg==
X-Received: by 2002:a63:515f:: with SMTP id r31mr1245939pgl.210.1610015830738;
        Thu, 07 Jan 2021 02:37:10 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id bg20sm1777416pjb.6.2021.01.07.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:37:10 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] refs: allow @{n} to work with n-sized reflog
Date:   Thu,  7 Jan 2021 02:36:59 -0800
Message-Id: <c88c997eab2b3405cce20f719bf07d5bba7aa18e.1610015769.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610015769.git.liu.denton@gmail.com>
References: <cover.1609923643.git.liu.denton@gmail.com> <cover.1610015769.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This sequence works

	$ git checkout -b newbranch
	$ git commit --allow-empty -m one
	$ git show -s newbranch@{1}

and shows the state that was immediately after the newbranch was
created.

But then if you do

	$ git reflog expire --expire=now refs/heads/newbranch
	$ git commit --allow=empty -m two
	$ git show -s newbranch@{1}

you'd be scolded with

	fatal: log for 'newbranch' only has 1 entries

While it is true that it has only 1 entry, we have enough
information in that single entry that records the transition between
the state in which the tip of the branch was pointing at commit
'one' to the new commit 'two' built on it, so we should be able to
answer "what object newbranch was pointing at?". But we refuse to
do so.

Make @{0} the special case where we use the new side to look up that
entry. Otherwise, look up @{n} using the old side of the (n-1)th entry
of the reflog.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 refs.c                      | 46 ++++++++++++++++++++++++++-----------
 t/t1503-rev-parse-verify.sh |  4 ++--
 t/t1508-at-combinations.sh  | 12 ++++++++++
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index bfdd04aefd..e70dcd33f7 100644
--- a/refs.c
+++ b/refs.c
@@ -900,40 +900,53 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
+	int reached_count;
 
 	cb->tz = tz;
 	cb->date = timestamp;
 
-	if (timestamp <= cb->at_time || cb->cnt == 0) {
+	/*
+	 * It is not possible for cb->cnt == 0 on the first itertion because
+	 * that special case is handled in read_ref_at().
+	 */
+	if (cb->cnt > 0)
+		cb->cnt--;
+	reached_count = cb->cnt == 0 && !is_null_oid(ooid);
+	if (timestamp <= cb->at_time || reached_count) {
 		set_read_ref_cutoffs(cb, timestamp, tz, message);
 		/*
 		 * we have not yet updated cb->[n|o]oid so they still
 		 * hold the values for the previous record.
 		 */
-		if (!is_null_oid(&cb->ooid)) {
-			oidcpy(cb->oid, noid);
-			if (!oideq(&cb->ooid, noid))
-				warning(_("log for ref %s has gap after %s"),
+		if (!is_null_oid(&cb->ooid) && !oideq(&cb->ooid, noid))
+			warning(_("log for ref %s has gap after %s"),
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
-		}
-		else if (cb->date == cb->at_time)
+		if (reached_count)
+			oidcpy(cb->oid, ooid);
+		else if (!is_null_oid(&cb->ooid) || cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
 		else if (!oideq(noid, cb->oid))
 			warning(_("log for ref %s unexpectedly ended on %s"),
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
-		cb->reccnt++;
-		oidcpy(&cb->ooid, ooid);
-		oidcpy(&cb->noid, noid);
 		cb->found_it = 1;
-		return 1;
 	}
 	cb->reccnt++;
 	oidcpy(&cb->ooid, ooid);
 	oidcpy(&cb->noid, noid);
-	if (cb->cnt > 0)
-		cb->cnt--;
-	return 0;
+	return cb->found_it;
+}
+
+static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid,
+				  const char *email, timestamp_t timestamp,
+				  int tz, const char *message, void *cb_data)
+{
+	struct read_ref_at_cb *cb = cb_data;
+
+	set_read_ref_cutoffs(cb, timestamp, tz, message);
+	oidcpy(cb->oid, noid);
+	/* We just want the first entry */
+	return 1;
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
@@ -967,6 +980,11 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
+	if (cb.cnt == 0) {
+		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
+		return 0;
+	}
+
 	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index dc9fe3cbf1..a7e9b4863d 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -86,8 +86,8 @@ test_expect_success 'fails silently when using -q' '
 test_expect_success 'fails silently when using -q with deleted reflogs' '
 	ref=$(git rev-parse HEAD) &&
 	git update-ref --create-reflog -m "message for refs/test" refs/test "$ref" &&
-	git reflog delete --updateref --rewrite refs/test@{0} &&
-	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
+	git reflog delete --updateref --rewrite refs/test@{1} &&
+	test_must_fail git rev-parse -q --verify refs/test@{1} >error 2>&1 &&
 	test_must_be_empty error
 '
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 4a9964e9dc..528a77287c 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -99,4 +99,16 @@ test_expect_success 'create path with @' '
 check "@:normal" blob content
 check "@:fun@ny" blob content
 
+test_expect_success '@{1} works with only one reflog entry' '
+	git checkout -B newbranch master &&
+	git reflog expire --expire=now refs/heads/newbranch &&
+	git commit --allow-empty -m "first after expiration" &&
+	test_cmp_rev newbranch~ newbranch@{1}
+'
+
+test_expect_success '@{0} works with empty reflog' '
+	git checkout -B newbranch master &&
+	git reflog expire --expire=now refs/heads/newbranch &&
+	test_cmp_rev newbranch newbranch@{0}
+'
 test_done
-- 
2.30.0

