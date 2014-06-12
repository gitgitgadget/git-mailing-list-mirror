From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 16/48] refs.c: add an err argument to delete_ref_loose
Date: Thu, 12 Jun 2014 10:21:07 -0700
Message-ID: <1402593699-13983-17-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hO-0006vy-P7
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbaFLRVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:50 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:36645 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so310162obb.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9HHcv+nzoYsURnszJvM8LF8tcjN8wIZdYzJvff9DCs=;
        b=aXHxqU/u9C+W45bNkPhASaaHC/TsLsgIkaUamZDmaqcUAs1DNa0YXHy/Evw3l9Rgvl
         J7SrxGjVcR6hs2z6odNfmNNfPRPLWK1pLBqdLOH//F8/wyUdalpxu0w3vyQxO58EVFsQ
         yRpAWIunzcNZaPK6cQFDIEOw/nt71Xyth1tY6rO1FaYJewpCFhwlPGt9AdqNJYrGlo62
         tWNCy6QJCTcaWhrz4MXuN4YOnOtu9XutrfbdIrBbhDjU72FJzqgDRv30AEXwWTrvQwJz
         ZlGcww3fwu9MK+p0YWwaArRQMzTzc2Q56ZSw1UUHPhkP1ExGeNcP8bx0aIDFstF9aCSe
         Tm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X9HHcv+nzoYsURnszJvM8LF8tcjN8wIZdYzJvff9DCs=;
        b=TRnUiVcFPg7UiWpJ9NrYWDkujP3YXgE2yA/AGMJrjxPJv55XBCVbnyD6rwRRjUNykH
         JfolluXTZVyJbsAHYtkMltZo9u61QfVFR1R49pM+Mp0tvFT+J6Gp14vhhS7Vf5v8f2cb
         82qsQNGhAVYTM4en0U57Fs0cLlkK328selTnMdod3gatqsfe/Mkis85QMmEYCcjIedUH
         OJ96Gyu72QTBjTX0SgjklRp1h6BQcZ+zQOXSelUFd2Fi/D5C8lgDWHf/o6PvmwFPI/nL
         Ktxv/HA+ui8nLpSIzwHlKDtJXsoqPS/tY09tdl1oJ72mfme8avXHgtT4i2zPTlDqIyZv
         K0zA==
X-Gm-Message-State: ALoCoQlCdYNKlbPzBSWril+HcL/K+Fub42ZY2rrlgd011JrcGUK2Fy6Pou38fDtjT0TiQ/+58Wkm
X-Received: by 10.50.12.106 with SMTP id x10mr1634846igb.1.1402593703402;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113144yhg.2.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 380B15A4822;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0B8A6E0D39; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251421>

Add an err argument to delete_loose_ref so that we can pass a descriptive
error string back to the caller. Pass the err argument from transaction
commit to this function so that transaction users will have a nice error
string if the transaction failed due to delete_loose_ref.

Add a new function unlink_or_err that we can call from delete_ref_loose. This
function is similar to unlink_or_warn except that we can pass it an err
argument. If err is non-NULL the function will populate err instead of
printing a warning().

Simplify warn_if_unremovable.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c    | 35 +++++++++++++++++++++++++++++------
 wrapper.c | 14 ++++++--------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 81d3605..162dc6c 100644
--- a/refs.c
+++ b/refs.c
@@ -2515,16 +2515,38 @@ static int repack_without_ref(const char *refname)
 	return repack_without_refs(&refname, 1, NULL);
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int add_err_if_unremovable(const char *op, const char *file,
+				  struct strbuf *e, int rc)
+{
+	int err = errno;
+	if (rc < 0  && errno != ENOENT) {
+		strbuf_addf(e, "unable to %s %s: %s",
+			    op, file, strerror(errno));
+		errno = err;
+		return -1;
+	}
+	return 0;
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
+		if (res)
 			return 1;
 	}
 	return 0;
@@ -2538,7 +2560,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
-	ret |= delete_ref_loose(lock, flag);
+	ret |= delete_ref_loose(lock, flag, NULL);
 
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -3547,7 +3569,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 		}
 	}
 
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..c9605cd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
-	if (rc < 0) {
-		int err = errno;
-		if (ENOENT != err) {
-			warning("unable to %s %s: %s",
-				op, file, strerror(errno));
-			errno = err;
-		}
-	}
+	int err;
+	if (!rc || errno == ENOENT)
+		return 0;
+	err = errno;
+	warning("unable to %s %s: %s", op, file, strerror(errno));
+	errno = err;
 	return rc;
 }
 
-- 
2.0.0.599.g83ced0e
