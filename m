From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 16/48] refs.c: add an err argument to delete_ref_loose
Date: Mon, 16 Jun 2014 11:03:47 -0700
Message-ID: <1402941859-29354-17-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:09:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbL3-00089r-FE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbaFPSIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:21 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:34712 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1126946oag.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VjHl+GjRGoYnQ0mAlldnobzTola4ij7S1Y8S7cfRZOk=;
        b=NJGubR7RyicZh+JfuBku0iZHZ3pAjVP4qqyr44rdtFcemqxTO28zSLjXf5CCvKGoJM
         2d4bAl5kCIBmjtyzGVZ9H2snfd4zaSwQDpqU28mHbcsj7JHZFOea7CV7he2z0ZZ+9jHX
         OjXdpPiOl3GN9Anm4/IcSG4o6jFMfM4qa+iS0rmJXXB0hJSX8kvH7LydUzF7nDCTy3QL
         4j+vJdpv6udOlYjG4UFk+h2+bYEXH8aZhp6K1xpgTmQqtfxze5nVVC3GBzMXah1BDKKn
         EqBILlyiVEtlQ0f9jmnm9w7Li31rMlp/qS2a6cgtq1UH/57qvJqrB8gwtGClI1lpu9W3
         TYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VjHl+GjRGoYnQ0mAlldnobzTola4ij7S1Y8S7cfRZOk=;
        b=hv9yeAeBg+Zay+Km8XRtDknnIFqXS2BrQyf95hWVUgO5G1qITn89H1YUj5tCsIj46J
         hvIDh4V3NHucONPYZt0QsSMmaET8c8tTqg5EEfoqKitOAjl6haq/zrYmX9Xd28w5/OdN
         o6GQALF1xbeRa/O8Uiy8cYbcr+80XbLSJLArgUnKYP/seCpu83zxTThaCvkA0YnV1kZf
         AEiycrqSph2DEsyaaI8VH0YVMa9kJKIiIikWitoV6tsYg6wTD3dDRZ2V7WbAR/XskElu
         pqsw+Kh4J3pWQpQDRqyro2EpAaojG2dZbfsXyWv99JVd7q9m3jPWhYozK3d+IjiUtPpE
         2Akw==
X-Gm-Message-State: ALoCoQmTZJLcCeUNDox1YOvi/NSdo+6lxQwNRGvWy7etNnqGyXxv7jQdPNHz8Jfd5XowbDI8uJS2
X-Received: by 10.182.73.200 with SMTP id n8mr1614730obv.33.1402941862901;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si998234yhe.1.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BA34131C8AE;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6C798E0CFF; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251790>

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
index 81d3605..92bad90 100644
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
+	if (rc < 0 && errno != ENOENT) {
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
index bc1bfb8..740e193 100644
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
+	if (rc >= 0 || errno == ENOENT)
+		return rc;
+	err = errno;
+	warning("unable to %s %s: %s", op, file, strerror(errno));
+	errno = err;
 	return rc;
 }
 
-- 
2.0.0.282.g3799eda.dirty
