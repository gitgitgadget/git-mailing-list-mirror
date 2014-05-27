From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 08/41] refs.c: add an err argument to delete_ref_loose
Date: Tue, 27 May 2014 13:25:27 -0700
Message-ID: <1401222360-21175-9-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyU-0004YH-FC
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbaE0U1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:44 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:44045 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so1646804vcb.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2hhh8gjAzRIWMDqbbZIUywqB2i/fIGoO5/9sI7qBnVg=;
        b=Ai/fo4QlgrXmStk21rmMMi+6swHQY5OLS3k9Xoqz4HUq6RrLBN99XpZ/VFkIv6DuYW
         RRUaLqJvYA3m4hJze3Tic4Txkbf3FmkfoLWjD17qDUEmNiWoTSdq+MzlxjMt9K/TAc8M
         fRQnjOFKHW0loAlzyd541gryr2ozujNbMDRH0iNnJ8gwli1X8mpKXY36CM3cJvip3V7H
         Zj6j3759sINlMHP4ZobdRgBUFJQekI7uP4piwfBGbFwroikxUzmOIETgYMjt5uZvSoin
         fTrNDstRO5z4KhhYLfVxkFoFIzLwKUhB+nl8TBQoM05qUcRrjTiFyLbePLZqP0x0lJYp
         2iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2hhh8gjAzRIWMDqbbZIUywqB2i/fIGoO5/9sI7qBnVg=;
        b=nHVJawiWHhEpuNVNLRkP0pH79Vgvv7aktToSDBSeNOyVdMny6R+HKQR0B2BSkzA3ye
         obrwKMrTerFbQmQ1bgacrTk/h/idCQz736WkIdsCnMmXboRc1IYkpnwAnwbnylRwFUee
         D46NlAvQu29k7klA76bDbWx5gj0c/Hg3uOk/27CHZAZojYEWdjBIkdeBbR1ftjrSVipo
         aLJlUCHD9xrtP2bodlwg/4uWKcxS8174FAXuRoqUMWWVCMPGCoIBsVaHrY0NvWa+YOOt
         9YpsPXg63nYMoiyPs3+daBxSiMOd32SbyqdeRndvq6oCwXfw6yn72eC45gLf3kCCDJFW
         OSbA==
X-Gm-Message-State: ALoCoQnpa4Xjj/0ZJ+ntPkKr3mtwgCxpgfJ7noyI8HJEnq23aIRvjeLQHt1NW//TBXWf24g15sFr
X-Received: by 10.58.30.78 with SMTP id q14mr14361849veh.10.1401222364102;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1574641yhj.5.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EC2692F4ACE;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8C79BE15EE; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250225>

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
index 4c7f4f7..891b80c 100644
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
@@ -3494,7 +3520,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
-- 
2.0.0.rc3.474.g0203784
