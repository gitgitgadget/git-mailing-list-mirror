Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026E11FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967485AbdAFQXj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:39 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:44603 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967270AbdAFQXR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:17 -0500
X-AuditID: 12074411-fa3ff700000009b7-07-586fc46f6bd0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.E6.02487.F64CF685; Fri,  6 Jan 2017 11:23:11 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX1023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:09 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 11/23] log_ref_write(): inline function
Date:   Fri,  6 Jan 2017 17:22:31 +0100
Message-Id: <cd97511ebe95a8957da6228d9a77c3f04b7430a9.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqJt/JD/CYEaXlEXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlbP/6laXgn1hF1/T9jA2Ml4W6GDk5JARMJO6efM/e
        xcjFISRwmVFiwY3HTBDOCSaJo0uWsoBUsQnoSizqaWYCsUUE1CQmth1iASliFvjAKPGrcxY7
        SEJYwEpixfQvjCA2i4CqxP/Ok8wgNq9AlMT7I9eZIdbJSVza9gXM5hSwkGjc9Q2sXkjAXOLT
        xMPMExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQICTHBHYwzTsod
        YhTgYFTi4Y3wyosQYk0sK67MPcQoycGkJMob5pgfIcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
        1+4QUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMH7B6RRsCg1PbUi
        LTOnBCHNxMEJMpwHaLjgYZDhxQWJucWZ6RD5U4yKUuK8W0CaBUASGaV5cL2wFPCKURzoFWFe
        YZB2HmD6gOt+BTSYCWSwJ9jgkkSElFQDI4vHvC2bXzmuL7D7ZTwpQIRfIuNX7NRHdastJ3bL
        W1Q+yJA6em52tu7UVaZFSz9/5O3hSsw/sy+ic/8+my3TpacmrY88wdIkHpauKRHX/z/V0p9d
        Of/RFsFrJ5JipimfmFGW68t4c5v156wkw7akz7oLfovXd++8xtvzeor1zj168+5MOaQ4QYml
        OCPRUIu5qDgRAHhLm7rcAgAA
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

