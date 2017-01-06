Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B7B1FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967520AbdAFQX7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:59 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47452 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967428AbdAFQXa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:30 -0500
X-AuditID: 1207440d-8cfff700000009ba-fb-586fc477c187
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D2.7A.02490.774CF685; Fri,  6 Jan 2017 11:23:19 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX6023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:18 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 16/23] log_ref_setup(): manage the name of the reflog file internally
Date:   Fri,  6 Jan 2017 17:22:36 +0100
Message-Id: <196b4cab62f2449a54723fb402138dd5840f3502.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqFt+JD/C4OhDG4uuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKeDxzC2PBFc2KPXcvsDcwrlfoYuTkkBAwkfhz9Q5T
        FyMXh5DAZUaJ2w17oJwTTBJ/Z01nBaliE9CVWNTTzARiiwioSUxsO8QCUsQs8IFR4lfnLPYu
        Rg4OYYEIiUP9xSA1LAKqEkf/LGYGsXkFoiRWzW5hhdgmJ3Fp2xewOKeAhUTjrm+MILaQgLnE
        p4mHmScw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJgvDsY/6+T
        OcQowMGoxMMb4ZUXIcSaWFZcmXuIUZKDSUmUN8wxP0KILyk/pTIjsTgjvqg0J7X4EKMEB7OS
        CK/dIaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9w9Io2BRanpq
        RVpmTglCmomDE2Q4D9BwwcMgw4sLEnOLM9Mh8qcYFaXEebeANAuAJDJK8+B6YQngFaM40CvC
        vD0g7TzA5AHX/QpoMBPIYE+wwSWJCCmpBkb/yxLrrT9W3nk4J8ksafomIwOOX+L9LQrz3q3Z
        +cDvTKP1xXuffX6xSGxa/cDNskSnT3kN4/Ybi888Vj06W5m53uyux+m0XPO3fTMeLVrzuozL
        dc6KR8f3TbfWnZPNmrKqPe1mRN4KtYLHV9fulA6tMF47R+X8vQK2kosn0x8e1q6b1jjneHqK
        EktxRqKhFnNRcSIAYAf6+tsCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of writing the name of the reflog file into a strbuf that is
supplied by the caller but not needed there, write it into a local
temporary buffer and remove the strbuf parameter entirely.

And while we're adjusting the function signature, reorder the arguments
to move the input parameters before the output parameters.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 69 ++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9c5e804..846380f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2719,37 +2719,36 @@ static int open_or_create_logfile(const char *path, void *cb)
 }
 
 /*
- * Create a reflog for a ref. Store its path to *logfile. If
- * force_create = 0, only create the reflog for certain refs (those
- * for which should_autocreate_reflog returns non-zero). Otherwise,
- * create it regardless of the reference name. If the logfile already
- * existed or was created, return 0 and set *logfd to the file
- * descriptor opened for appending to the file. If no logfile exists
- * and we decided not to create one, return 0 and set *logfd to -1. On
- * failure, fill in *err, set *logfd to -1, and return -1.
+ * Create a reflog for a ref. If force_create = 0, only create the
+ * reflog for certain refs (those for which should_autocreate_reflog
+ * returns non-zero). Otherwise, create it regardless of the reference
+ * name. If the logfile already existed or was created, return 0 and
+ * set *logfd to the file descriptor opened for appending to the file.
+ * If no logfile exists and we decided not to create one, return 0 and
+ * set *logfd to -1. On failure, fill in *err, set *logfd to -1, and
+ * return -1.
  */
-static int log_ref_setup(const char *refname,
-			 struct strbuf *logfile, int *logfd,
-			 struct strbuf *err, int force_create)
+static int log_ref_setup(const char *refname, int force_create,
+			 int *logfd, struct strbuf *err)
 {
-	strbuf_git_path(logfile, "logs/%s", refname);
+	char *logfile = git_pathdup("logs/%s", refname);
 
 	if (force_create || should_autocreate_reflog(refname)) {
-		if (raceproof_create_file(logfile->buf, open_or_create_logfile, logfd)) {
+		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
 			if (errno == ENOENT)
 				strbuf_addf(err, "unable to create directory for '%s': "
-					    "%s", logfile->buf, strerror(errno));
+					    "%s", logfile, strerror(errno));
 			else if (errno == EISDIR)
 				strbuf_addf(err, "there are still logs under '%s'",
-					    logfile->buf);
+					    logfile);
 			else
 				strbuf_addf(err, "unable to append to '%s': %s",
-					    logfile->buf, strerror(errno));
+					    logfile, strerror(errno));
 
-			return -1;
+			goto error;
 		}
 	} else {
-		*logfd = open(logfile->buf, O_APPEND | O_WRONLY, 0666);
+		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
 		if (*logfd < 0) {
 			if (errno == ENOENT || errno == EISDIR) {
 				/*
@@ -2761,34 +2760,39 @@ static int log_ref_setup(const char *refname,
 				;
 			} else {
 				strbuf_addf(err, "unable to append to '%s': %s",
-					    logfile->buf, strerror(errno));
-				return -1;
+					    logfile, strerror(errno));
+				goto error;
 			}
 		}
 	}
 
 	if (*logfd >= 0)
-		adjust_shared_perm(logfile->buf);
+		adjust_shared_perm(logfile);
 
+	free(logfile);
 	return 0;
+
+error:
+	free(logfile);
+	return -1;
 }
 
 static int files_create_reflog(struct ref_store *ref_store,
 			       const char *refname, int force_create,
 			       struct strbuf *err)
 {
-	int ret;
-	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "create_reflog");
 
-	ret = log_ref_setup(refname, &sb, &fd, err, force_create);
+	if (log_ref_setup(refname, force_create, &fd, err))
+		return -1;
+
 	if (fd >= 0)
 		close(fd);
-	strbuf_release(&sb);
-	return ret;
+
+	return 0;
 }
 
 static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
@@ -2819,16 +2823,15 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 
 static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 			   const unsigned char *new_sha1, const char *msg,
-			   struct strbuf *logfile, int flags,
-			   struct strbuf *err)
+			   int flags, struct strbuf *err)
 {
 	int logfd, result;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, logfile, &logfd, err,
-			       flags & REF_FORCE_CREATE_REFLOG);
+	result = log_ref_setup(refname, flags & REF_FORCE_CREATE_REFLOG,
+			       &logfd, err);
 
 	if (result)
 		return result;
@@ -2859,11 +2862,7 @@ int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err)
 {
-	struct strbuf sb = STRBUF_INIT;
-	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
-				  err);
-	strbuf_release(&sb);
-	return ret;
+	return log_ref_write_1(refname, old_sha1, new_sha1, msg, flags, err);
 }
 
 /*
-- 
2.9.3

