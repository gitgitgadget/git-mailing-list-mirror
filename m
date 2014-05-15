From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 06/44] refs.c: add an err argument to delete_ref_loose
Date: Thu, 15 May 2014 16:15:03 -0700
Message-ID: <1400195741-22996-7-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sv-0004pQ-Kn
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbaEOXQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:14 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:54246 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbaEOXPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:50 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so325821veb.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pt6u0fDS2Qbg90ik8NY7Pw3rPqL4n7ngdtEBw+HrFks=;
        b=BoKl0s+IfFClLoE0nom1++9vjPJP681X3YNWURwAzrFxLokQ/YW5rCnr91QCa3X5y7
         SoSc9CvUUJ9xjLFgt+8YtjstpnX/MyatNuqd45dlMbTqaRRqW+432NO4LIKmIERul8Vg
         eNjEoG2IjPru5D3MmiVVKHmSka0q33khiBWP3uEHFbrD7znmpd0BNNqG2OLL/MVolDz7
         /apPoCg0Ip7+WIzyLu5EypmCPnC94VIZ+m1kWOH6ZhYuCxg2TYmDBMCbmi419/Y3Znui
         F7XILLxZ3ASFaHmFtAkYItBF0dZkn+JYjqNZyd8WSPxrVtkVGvlGFLX6kuAHWUxrE1ze
         xVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pt6u0fDS2Qbg90ik8NY7Pw3rPqL4n7ngdtEBw+HrFks=;
        b=P3cMxgQQ6VzhHp6yl/Zxav96+1dxTshg7FgIFAXUaiirsZx9mc+JtOW68QIeuFQAZP
         IDa0ODBRMxTH2i9Dm0ZG5zoXPDGCvrmp5yoDnc7EU7IBXslDpJDTRfeo2ZZdGNm6PuO8
         W0Mavj78jNheTeXZLd5gxAO5VV3u5D+l9KzxJZhdRfBT7MHjJ7ckcv+zzNyZBqFnuPyy
         WOxWSdnQc4Kc42WIZHdnYHojnE9kgSRAnPE58fHMMmyLE9XdYWhWglttRaCY7fGv81nw
         hTXtfFq4SPVbYC2YQ57oB8+SZcBMHVKF9adSr7intxQH77ziotfAuTa1hoQNwGnIKoJH
         R6SQ==
X-Gm-Message-State: ALoCoQlS/MuFkaxCX66qcyEXlGIE3DDJeQnYsBO0fu8O8BfeTv5wLLd8brbM5kdkEfh72Th5DZjj
X-Received: by 10.236.36.33 with SMTP id v21mr5511443yha.53.1400195749770;
        Thu, 15 May 2014 16:15:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si318887yhq.3.2014.05.15.16.15.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 98BDE31C314;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4476CE103B; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249230>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Add a new function unlink_or_err that we can call from delete_ref_loose. This
function is similar to unlink_or_warn except that we can pass it an err
argument. If err is non-NULL the function will populate err instead of
printing a warning().

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 4ebf130..e4d35c9 100644
--- a/refs.c
+++ b/refs.c
@@ -2491,17 +2491,43 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0 && err != ENOENT) {
+		strbuf_addf(e, "unable to %s %s: %s",
+			    op, file, strerror(errno));
+		errno = err;
+	}
+	return rc;
+}
+
+static int unlink_or_err(const char *file, struct strbuf *err)
+{
+	if (err)
+		return add_err_if_unremovable("unlink", file, err,
+					      unlink(file));
+	else
+		return unlink_or_warn(file);
+}
+
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_err(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (res && errno != ENOENT) {
+			if (err)
+				strbuf_addf(err,
+					    "failed to delete loose ref '%s'",
+					    lock->lk->filename);
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -2514,7 +2540,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3499,7 +3525,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.rc3.477.gffe78a2
