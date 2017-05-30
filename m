Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799A42027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdE3Rbb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:31 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36295 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdE3Rb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so78253054pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHgSLF+Mz56JOJwU4okZssnLFbQA411t1s5kR1AnNYk=;
        b=XWF2Gqr5DQ+jI/6QtPdyLctL3bIsAAa2aLdvuUflCDiYS+ERkYuk/z/E878qag6Ro3
         HqfTnjOcFYfQAFCpm7GD8CL4bb0C+97K11etfrQrpJ2ra2L0H48JUhsIgR1ECExgwi5t
         HJMEvrG+LTvLLZR1fuU49Ih4hXy+qFxFJ10AQnS8iXMrKAmaMblZVRL1y9cYQGXPamHX
         /BKnt8QDLoZFu6/UDAZPqolZ+avJsP9PsEcWb4Ud5V1hDZvUkH/nqhxH1E31ewiNQJvC
         WFUoOL5i4Ocw74COR2ampuZI/h/3NWX4+yTe/cmOLW/WHrdowRIlBaMxmvkpT/0axACf
         Nb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHgSLF+Mz56JOJwU4okZssnLFbQA411t1s5kR1AnNYk=;
        b=Fc7wvKAhVPlXuWIMuyw5sgEHlYJ8dYyfWpAzwtycuTCt42IX8kAAEfihUMd0ieTi4Q
         h68bUZaXF40k+xW3vmV8wNAwpzw9snM5NOe5JwBCWGoEgXjflbs+UCFYGLmHvQl3+lxc
         KHDfGKYiQnCAA/NrZMEN6M6jYSnNkCAwEMWvuR2424H09lEXcDSTGHTCARVXco6EAa6u
         W9JfkXEH1J5sY9SSKQWoAK60rZRljJUCFnYKFHijLvTLVOeavTsecHmkreo9j/Q/yOKJ
         nzrV2TQxBSkR8SQJwUgRwdjKnGgNEaD7kSaf96VkfINjN2BxKPJurUrfnFuQyfRAZKSV
         LFhQ==
X-Gm-Message-State: AODbwcAZJIaViMKlC+esP7MAW4jVOA3Y4ebjrBGuAP+u1zpbCW9APqd5
        2c7vZ+Z93B2WGXN/
X-Received: by 10.84.224.206 with SMTP id k14mr84304645pln.162.1496165488665;
        Tue, 30 May 2017 10:31:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/33] diff: convert get_stat_data to struct object_id
Date:   Tue, 30 May 2017 10:30:45 -0700
Message-Id: <20170530173109.54904-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 2982bf055..a3bc78162 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -264,12 +264,12 @@ static void diff_index_show_file(struct rev_info *revs,
 }
 
 static int get_stat_data(const struct cache_entry *ce,
-			 const unsigned char **sha1p,
+			 const struct object_id **oidp,
 			 unsigned int *modep,
 			 int cached, int match_missing,
 			 unsigned *dirty_submodule, struct diff_options *diffopt)
 {
-	const unsigned char *sha1 = ce->oid.hash;
+	const struct object_id *oid = &ce->oid;
 	unsigned int mode = ce->ce_mode;
 
 	if (!cached && !ce_uptodate(ce)) {
@@ -280,7 +280,7 @@ static int get_stat_data(const struct cache_entry *ce,
 			return -1;
 		else if (changed) {
 			if (match_missing) {
-				*sha1p = sha1;
+				*oidp = oid;
 				*modep = mode;
 				return 0;
 			}
@@ -290,11 +290,11 @@ static int get_stat_data(const struct cache_entry *ce,
 						    0, dirty_submodule);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
-			sha1 = null_sha1;
+			oid = &null_oid;
 		}
 	}
 
-	*sha1p = sha1;
+	*oidp = oid;
 	*modep = mode;
 	return 0;
 }
@@ -303,7 +303,7 @@ static void show_new_file(struct rev_info *revs,
 			  const struct cache_entry *new,
 			  int cached, int match_missing)
 {
-	const unsigned char *sha1;
+	const struct object_id *oid;
 	unsigned int mode;
 	unsigned dirty_submodule = 0;
 
@@ -311,11 +311,11 @@ static void show_new_file(struct rev_info *revs,
 	 * New file in the index: it might actually be different in
 	 * the working tree.
 	 */
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+	if (get_stat_data(new, &oid, &mode, cached, match_missing,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
-	diff_index_show_file(revs, "+", new, sha1, !is_null_sha1(sha1), mode, dirty_submodule);
+	diff_index_show_file(revs, "+", new, oid->hash, !is_null_oid(oid), mode, dirty_submodule);
 }
 
 static int show_modified(struct rev_info *revs,
@@ -325,10 +325,10 @@ static int show_modified(struct rev_info *revs,
 			 int cached, int match_missing)
 {
 	unsigned int mode, oldmode;
-	const unsigned char *sha1;
+	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
 
-	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
+	if (get_stat_data(new, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
@@ -338,7 +338,7 @@ static int show_modified(struct rev_info *revs,
 	}
 
 	if (revs->combine_merges && !cached &&
-	    (hashcmp(sha1, old->oid.hash) || oidcmp(&old->oid, &new->oid))) {
+	    (oidcmp(oid, &old->oid) || oidcmp(&old->oid, &new->oid))) {
 		struct combine_diff_path *p;
 		int pathlen = ce_namelen(new);
 
@@ -362,12 +362,12 @@ static int show_modified(struct rev_info *revs,
 	}
 
 	oldmode = old->ce_mode;
-	if (mode == oldmode && !hashcmp(sha1, old->oid.hash) && !dirty_submodule &&
+	if (mode == oldmode && !oidcmp(oid, &old->oid) && !dirty_submodule &&
 	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->oid.hash, sha1, 1, !is_null_sha1(sha1),
+		    old->oid.hash, oid->hash, 1, !is_null_oid(oid),
 		    old->name, 0, dirty_submodule);
 	return 0;
 }
-- 
2.13.0.219.gdb65acc882-goog

