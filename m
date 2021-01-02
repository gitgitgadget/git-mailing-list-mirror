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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F30C433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 01:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69DB2222D
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 01:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhABBhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 20:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbhABBhE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 20:37:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB8C061573
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 17:36:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l23so7178922pjg.1
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 17:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C15iR+nt4ZjuCYaStyZkhE05B1zkiiozhFSKdMlyt9U=;
        b=S2onMGhqL4HlKIubwfNOtken/vhBuTCL4txC8xWwE37I+w7FuSrAblX+H3t7zeyjH6
         X3mK7gjeaRN8QfIT+z6+bNVGFYKLwa8aFbIMtyv9p+fcQaf39ZXc5+ZEjUOhO2/TxzCX
         NQsjMjgyYl/AeOWURKpuN/mAtPaUTuYDy2af/D5BKCnxjKeQhNaCD/gMh2RQw44nS2Av
         gMwi5uc8YHOKptO6G5WiCiUsZgMqH2gT4CUq7qvTXra/ztEkdGo76U2jUB1YqfzW2NmY
         NnilKhoxbTMwSxS4OiQ/pM/JYUW4ux2h6nOn3kteetTf0BQN1bowKoAldrKeFE7lrzL7
         7jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C15iR+nt4ZjuCYaStyZkhE05B1zkiiozhFSKdMlyt9U=;
        b=XFvDrHTeDc+iwNLoidYfrUMvDme1F/SKsbaiPvenBOCO1fNTHLMKwCGVVlCz8cuLZ6
         pfXSpzRhQy/9CrdN0Si7B+BaTEzVnGNTMu5v4yC096TdVzUssLb41FZ3xcXeGEsD6HkX
         KwKKDdFaCpTsP656K/P5W9251ZAsRX5U5jBpkwn2FPNna5KNEsgwEJU/hZnrFP+vZsa/
         gIjO7U9AIsASIf+b1SV6txz5X2lQSaQSh39113kb1712KBwpuQbyPGVvNwuN+pO2WCaQ
         AjaTs+CGtPSIJwCf4SzowL9PFsJjhm1FL9RcaNeLHUYHl8vjos+WUP1DEj7Umr8rA+/w
         hi+w==
X-Gm-Message-State: AOAM530x1A8SWO+8l6j6xQJ9bMdmcGfno5u2+1YYIxjwlyts6mP1oszB
        5escpiHGNiKoSWauqolYMMTe100RCls=
X-Google-Smtp-Source: ABdhPJwxtisSFQslvLZWFMwTgElm8n+PTEDwTSmyJeJhpM7jAfTrLeISm+/Ss3hC/26698GYba+q+w==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr63627442plr.73.1609551380706;
        Fri, 01 Jan 2021 17:36:20 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id s1sm14854882pjk.1.2021.01.01.17.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 17:36:19 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] refs: allow @{n} to work with n-sized reflog
Date:   Fri,  1 Jan 2021 17:36:06 -0800
Message-Id: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
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
 refs.c                      | 48 +++++++++++++++++++++++++++----------
 t/t1503-rev-parse-verify.sh | 17 +++++++++++--
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 13dc2c3291..c35c61a009 100644
--- a/refs.c
+++ b/refs.c
@@ -887,12 +887,16 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
+	int at_indexed_ent;
 
 	cb->reccnt++;
 	cb->tz = tz;
 	cb->date = timestamp;
 
-	if (timestamp <= cb->at_time || cb->cnt == 0) {
+	if (cb->cnt > 0)
+		cb->cnt--;
+	at_indexed_ent = cb->cnt == 0 && !is_null_oid(ooid);
+	if (timestamp <= cb->at_time || at_indexed_ent) {
 		if (cb->msg)
 			*cb->msg = xstrdup(message);
 		if (cb->cutoff_time)
@@ -905,28 +909,41 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
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
-		oidcpy(&cb->ooid, ooid);
-		oidcpy(&cb->noid, noid);
 		cb->found_it = 1;
-		return 1;
 	}
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
+	if (cb->msg)
+		*cb->msg = xstrdup(message);
+	if (cb->cutoff_time)
+		*cb->cutoff_time = timestamp;
+	if (cb->cutoff_tz)
+		*cb->cutoff_tz = tz;
+	if (cb->cutoff_cnt)
+		*cb->cutoff_cnt = cb->reccnt;
+	oidcpy(cb->oid, noid);
+	/* We just want the first entry */
+	return 1;
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
@@ -967,6 +984,11 @@ int read_ref_at(struct ref_store *refs, const char *refname,
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
index dc9fe3cbf1..ed4a366e85 100755
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
 
@@ -139,6 +139,19 @@ test_expect_success 'master@{n} for various n' '
 	test_must_fail git rev-parse --verify master@{$Np1}
 '
 
+test_expect_success '@{1} works with only one reflog entry' '
+	git checkout -B newbranch &&
+	git reflog expire --expire=now refs/heads/newbranch &&
+	git commit --allow-empty -mexpired &&
+	git rev-parse --verify newbranch@{1}
+'
+
+test_expect_success '@{0} works with empty reflog' '
+	git checkout -B newbranch &&
+	git reflog expire --expire=now refs/heads/newbranch &&
+	git rev-parse --verify newbranch@{0}
+'
+
 test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
 	ln -s does-not-exist .git/refs/heads/broken &&
 	test_must_fail git rev-parse --verify broken
-- 
2.30.0

