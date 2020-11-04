Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C10C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E2520782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jhzlYodB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgKDUd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732077AbgKDUd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:58 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864BC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:57 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id o205so13856858qke.10
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DV2DhDO8wquOylpaL4qGrTWwlE3NaLC/vl0Sp9b+4hw=;
        b=jhzlYodBEeNOZlCbFRaCK7ACsyjtq1C0e0N7JhQGUXyY3n1KUEUHHH72qP9lmJj9Z+
         ahIg4Ko3BGF6yJhSoV3k+/2x3NEQzeeu9Hxi80BtKUQcMJLNG4RvnI688Sc/JvpZ7DFC
         Pf4necjErPtAz7R+CDw7r4dqfLPEy7NpVOwhFfdB2eYqLumeqdaumWmeIFHmfVWWY9z9
         YhKlFmn/PjCWS/FcAX+Rwod2JnJphKYg7v0DS8bq9VROs4PkhKNNR+EaeocoWepjpKUN
         srhWKSbVfKGIhNZVeO3z1s+fWWhuJSIKGc9cSkOUMDjf/ludh/zU/YEhhPBhdIJcbF32
         rsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DV2DhDO8wquOylpaL4qGrTWwlE3NaLC/vl0Sp9b+4hw=;
        b=sSNIC1IhEDJdik5A2Q4AnphHPv+nv70oneQ1r9+IJf77C7c5N4xqQ85KrexOHm1KSh
         5INOGFtY9zBA5Hj5vlNLsO515dKeIZ6cdogWENeJbU3pmAmodyl8MuFRded1Znry0FdG
         oIh7s8YzNV3YdlpwQlq280v/2lKvhqqWlS5tDl01r4y6blSlD9OUpA0oHYtfmwDQJn42
         kt3Lvp4kHvPqFrwT57527dh0tnbzVatycFLZ5Jz5BKh59PnC3aEzAlNzl9s+6AB/abLb
         IVJHJ6CeF9/oIZRVl4HRyv/8sa3M8E0o9BmiSFcZYhioNi1Qm9RpxrtRb1GP+j63esob
         exvw==
X-Gm-Message-State: AOAM533zoiJZo1Hc/DIXJ9M0IWaJLi2PiH8zGmEv5GdFrxYhBpDy2zQW
        IVWYYaqRP461MeAb4GT9kiCaPk/ZWQCMNA==
X-Google-Smtp-Source: ABdhPJwre/vP1QdbbNgp0qU1Lms3Ybs+eMHR54pEIbLIhMYA1lxpqegy6QA1SrCn6kRJkSyXPenp7Q==
X-Received: by 2002:a05:620a:131c:: with SMTP id o28mr18662460qkj.388.1604522036318;
        Wed, 04 Nov 2020 12:33:56 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:55 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 07/19] entry: extract cache_entry update from write_entry()
Date:   Wed,  4 Nov 2020 17:33:06 -0300
Message-Id: <a0479d02ffedccb65a167463228445a6d62c9f96.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code will be used by the parallel checkout functions, outside
entry.c, so extract it to a public function.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 25 ++++++++++++++++---------
 entry.h |  2 ++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index b36071a610..1d2df188e5 100644
--- a/entry.c
+++ b/entry.c
@@ -251,6 +251,18 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 	return errs;
 }
 
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st)
+{
+	if (state->refresh_cache) {
+		assert(state->istate);
+		fill_stat_cache_info(state->istate, ce, st);
+		ce->ce_flags |= CE_UPDATE_IN_BASE;
+		mark_fsmonitor_invalid(state->istate, ce);
+		state->istate->cache_changed |= CE_ENTRY_CHANGED;
+	}
+}
+
 static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
@@ -371,15 +383,10 @@ static int write_entry(struct cache_entry *ce,
 
 finish:
 	if (state->refresh_cache) {
-		assert(state->istate);
-		if (!fstat_done)
-			if (lstat(ce->name, &st) < 0)
-				return error_errno("unable to stat just-written file %s",
-						   ce->name);
-		fill_stat_cache_info(state->istate, ce, &st);
-		ce->ce_flags |= CE_UPDATE_IN_BASE;
-		mark_fsmonitor_invalid(state->istate, ce);
-		state->istate->cache_changed |= CE_ENTRY_CHANGED;
+		if (!fstat_done && lstat(ce->name, &st) < 0)
+			return error_errno("unable to stat just-written file %s",
+					   ce->name);
+		update_ce_after_write(state, ce , &st);
 	}
 delayed:
 	return 0;
diff --git a/entry.h b/entry.h
index 60df93ca78..ea7290bcd5 100644
--- a/entry.h
+++ b/entry.h
@@ -41,5 +41,7 @@ void unlink_entry(const struct cache_entry *ce);
 
 void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st);
 
 #endif /* ENTRY_H */
-- 
2.28.0

