Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E1E2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbcLaDOH (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:14:07 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53310 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754628AbcLaDNY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:24 -0500
X-AuditID: 12074411-fbbff700000009b7-53-58672252fc69
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 54.63.02487.25227685; Fri, 30 Dec 2016 22:13:22 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u4010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:21 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/23] log_ref_write(): inline function
Date:   Sat, 31 Dec 2016 04:12:50 +0100
Message-Id: <dba3d081c32854593d8113f9cd604a9891748bcd.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsUixO6iqBuklB5hcKdTz6LrSjeTRUPvFWaL
        2yvmM1ssefia2eJHSw+zA6vH3/cfmDy62o+weTzr3cPocfGSssfnTXIBrFFcNimpOZllqUX6
        dglcGdu/fmUp+CdW0TV9P2MD42WhLkZODgkBE4n/71+wdDFycQgJXGaUeHBgLxuEc5xJ4tjn
        rSwgVWwCuhKLepqZQGwRATWJiW2HwDqYBSYySkzbcgksISxgJbHswGxWEJtFQFXi87wXzCA2
        r0CUxJdfB1kg1slJXNr2BSzOKWAhsfhTH1ivkIC5xLqdl5gnMPIsYGRYxSiXmFOaq5ubmJlT
        nJqsW5ycmJeXWqRrqpebWaKXmlK6iRESPII7GGeclDvEKMDBqMTD++BGWoQQa2JZcWXuIUZJ
        DiYlUV5Ly9QIIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8C+XSI4R4UxIrq1KL8mFS0hwsSuK8
        fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8CopAjYJFqempFWmZOSUIaSYOTpDhPEDD/UFqeIsL
        EnOLM9Mh8qcYFaXEedcqACUEQBIZpXlwvbDofsUoDvSKMO8ukHYeYGKA634FNJgJaLBaTjLI
        4JJEhJRUA2P+udwUB6Mzf1fo+i92/F97pDDjWJTk0dYFUSJ/Hh+6dbhtg+Llr1x/GmZ7Hu18
        Y2TAujBG/Jld9NGz190Pm/NEGsy4Oj1p6u4VptP3zeYoUXixNGaKzZeYbwmG1q/zFnHsrwxZ
        HLrVz2/PG8OMUAXryiv5nf1/VipGlT5bx1kYNrHiKHP50+9KLMUZiYZazEXFiQDwwmwCyQIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function doesn't do anything beyond call files_log_ref_write(), so
replace it with the latter at its call sites.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 49a119c..fd8a751 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2832,14 +2832,6 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg,
-			 int flags, struct strbuf *err)
-{
-	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
-				   err);
-}
-
 int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err)
@@ -2903,7 +2895,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 	assert_main_repository(&refs->base, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
+	if (files_log_ref_write(lock->ref_name, lock->old_oid.hash, sha1,
+				logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -2934,7 +2927,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-			if (log_ref_write("HEAD", lock->old_oid.hash, sha1,
+			if (files_log_ref_write("HEAD", lock->old_oid.hash, sha1,
 					  logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
@@ -2973,7 +2966,8 @@ static void update_symref_reflog(struct ref_lock *lock, const char *refname,
 	struct strbuf err = STRBUF_INIT;
 	unsigned char new_sha1[20];
 	if (logmsg && !read_ref(target, new_sha1) &&
-	    log_ref_write(refname, lock->old_oid.hash, new_sha1, logmsg, 0, &err)) {
+	    files_log_ref_write(refname, lock->old_oid.hash, new_sha1,
+				logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
@@ -3748,9 +3742,11 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (log_ref_write(lock->ref_name, lock->old_oid.hash,
-					  update->new_sha1,
-					  update->msg, update->flags, err)) {
+			if (files_log_ref_write(lock->ref_name,
+						lock->old_oid.hash,
+						update->new_sha1,
+						update->msg, update->flags,
+						err)) {
 				char *old_msg = strbuf_detach(err, NULL);
 
 				strbuf_addf(err, "cannot update the ref '%s': %s",
-- 
2.9.3

