Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D3C433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0B12310E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAFJCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbhAFJCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:02:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F42C061357
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 01:02:09 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 15so1795002pgx.7
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXtlc23yRHGCb7I5sp+LPDYPc9yTT5ukOKQU2VpD4gI=;
        b=SrdZMpiyeb67xPkUyQDVp/fNYg8PHgjyLC9A/FD1Q/5v/kK18jh4lAxJ6OA37/o30Q
         iX4H09wWPw6TolSgPJ/ED1cH2BsRRXu+f+VPP9yTRmUWV1z1nvfyIrN9RzT4qGa/goWm
         UmxWrSbsdYgzhEAebUO2tbrITiFJUK1KxvEVHwMieAKNTD3h7+SqCEThsiU9ZMq+LiyF
         VDtJ33r4eQXjkAMRx2eFnGgQ0y99VloG8XXVTwVZnC/1AkqY1S5DBzBF1etjo9pb+99Z
         4gOvIxzluhnDahHK98obYPaD7A6F43+i8LUPDfvFCY/DlMpl1k4E2FDCgGWusrtOGlRS
         v7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXtlc23yRHGCb7I5sp+LPDYPc9yTT5ukOKQU2VpD4gI=;
        b=BRE7BekU0aDqafhJnzGUrOuQ/aX966Qx3mva4ZncGSHeolmiw1f7TCBXGA3K+3zpAT
         wrzpc2ePb7YmkbWOpPN8595TO0Ss99+S3doCXV/fwyOzZnMBp2nL8lNNmJbs42D+jTkH
         9uX9ItOd5WqDmb2u/zPlpRnGRGs7SZpYYCfnS/wreKJEcMLa6kgd0ITnOA1CkzCvEOv7
         pdNoSaaw1WFbXvhSGGXmMT9+M9uRNuytUczVgUEWY0wWxHiXU3p+JSkK3UJzK90POBjZ
         B0tRihw2+EVVO2rn/JQB8GPvkv1bL6jM/yIj9aLLINIIhZRGaum1CpnhBApqK2W6zz3O
         eBjg==
X-Gm-Message-State: AOAM532QrJheqm/87bBo0tVfKIDh9/jetEpK5Jscceo9U1e3rnpkN7vp
        Vfw/VjrZzqby97+NUXXM4cvX9JcVN3w=
X-Google-Smtp-Source: ABdhPJziaqE98srEsoP6JZRsggss8S4QNNGxCU82I9GaoeJCVNUxiuAm0fQu/9zJBKx5uMPnjBryyw==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr3511589pgm.295.1609923728366;
        Wed, 06 Jan 2021 01:02:08 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id m10sm1561919pjn.53.2021.01.06.01.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 01:02:07 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] refs: allow @{n} to work with n-sized reflog
Date:   Wed,  6 Jan 2021 01:01:54 -0800
Message-Id: <18a35506b87356c1ae844d2686b2be6bd04567b2.1609923643.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609923643.git.liu.denton@gmail.com>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com> <cover.1609923643.git.liu.denton@gmail.com>
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
 refs.c                      | 42 ++++++++++++++++++++++++-------------
 t/t1503-rev-parse-verify.sh |  4 ++--
 t/t1508-at-combinations.sh  | 16 ++++++++++++++
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index bfdd04aefd..9eb26d456d 100644
--- a/refs.c
+++ b/refs.c
@@ -900,40 +900,49 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
+	int at_indexed_ent;
 
 	cb->tz = tz;
 	cb->date = timestamp;
 
-	if (timestamp <= cb->at_time || cb->cnt == 0) {
+	if (cb->cnt > 0)
+		cb->cnt--;
+	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
+	if (timestamp <= cb->at_time || at_indexed_ent) {
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
+		if (at_indexed_ent)
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
@@ -967,6 +976,11 @@ int read_ref_at(struct ref_store *refs, const char *refname,
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
index 4a9964e9dc..15aac6e77a 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -99,4 +99,20 @@ test_expect_success 'create path with @' '
 check "@:normal" blob content
 check "@:fun@ny" blob content
 
+test_expect_success '@{1} works with only one reflog entry' '
+	git checkout -B newbranch master &&
+	git reflog expire --expire=now refs/heads/newbranch &&
+	git commit --allow-empty -m "first after expiration" &&
+	git rev-parse newbranch~ >expect &&
+	git rev-parse newbranch@{1} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '@{0} works with empty reflog' '
+	git checkout -B newbranch master &&
+	git reflog expire --expire=now refs/heads/newbranch &&
+	git rev-parse newbranch >expect &&
+	git rev-parse newbranch@{0} >actual &&
+	test_cmp expect actual
+'
 test_done
-- 
2.30.0

