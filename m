From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/5] refs.c: add an err argument to commit_packed_refs
Date: Thu, 31 Jul 2014 14:25:09 -0700
Message-ID: <1406841910-3278-5-git-send-email-sahlberg@google.com>
References: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:25:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCxqz-0000bc-Gv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbaGaVZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:25:25 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:53956 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbaGaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:25:17 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so961173oif.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cUsjdCAJI3ZREI9a36WUHjtO9OV66uo8MP6Vakht47w=;
        b=kgzXLnrQqQ+Tp7Z9aSEt6RhEJnQx3E6vGFT8uT3PfHmhttSu+RGXK0gAyR5KilpeaQ
         RY+2jeFhrmgn/dr6Len1cJea3k4BSas9WP+WUuU/AVnHz9WILQj9GaOityvsQCJCFnq7
         oROYqY4GsMoSc4uBfOprmWmu+5OQo9YHOs68qKluMDiHMDE3W2W1o7umt0flI6/S+7iA
         Fnq0urLtIBn4u+U9s+QPY89u3jPwoouU/1wJu7klm8viudKiCSZcHW42S3EjSyeurL/I
         7mslx/d6c+zOlicfi8ykrU4cs56kFjENw0Sqm/BxjuVCWZQ2EtS9XgVJcFkk89s3Miic
         Vhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cUsjdCAJI3ZREI9a36WUHjtO9OV66uo8MP6Vakht47w=;
        b=OqcWskAIyatkDkgrz/qeQjlnEGD7hkuZmwgvS8nILLdceEDuwM6tIQGfDbl+VyFjhd
         4VHtUh1H5T/qLW7XCjh47W+mNf+QvhjmVhtv6EfTybyPnuhICefbMR7+MX7ihYNSRu0C
         124jRyeTyrqgh7avDy0cfkFl7VqW5o66jE41quxU+u1g5Tp3yv9d1QfNRXQIXS1uwA/u
         FMFU9BFzrZNM4qbRjN/ziJYraJdhiJY+kH0CrVzsrmn3601xx84SC8uVhYMXy4FBCyF+
         gMadMfoVxKhCIiHmKQzqV9KRFNTkSUW9nyXY2tN4PLd1ThA9zLqka0ME5vNYPDMB4CNr
         rYNg==
X-Gm-Message-State: ALoCoQkIDu1Y0l/oke635lwgGjNcgtenyiorsdelbmxhNiyLH/60HJYNUv6H1APS9QPAya2HbTWg
X-Received: by 10.42.10.66 with SMTP id p2mr990156icp.28.1406841916520;
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k15si55161igt.1.2014.07.31.14.25.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:25:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E343431C60D;
	Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7CF8CE055F; Thu, 31 Jul 2014 14:25:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g70700c9
In-Reply-To: <1406841910-3278-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254604>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 85 +++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index cfe1292..19e73f3 100644
--- a/refs.c
+++ b/refs.c
@@ -2232,8 +2232,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
  */
-static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
-			       unsigned char *peeled)
+static int write_packed_entry(int fd, char *refname, unsigned char *sha1,
+			      unsigned char *peeled, struct strbuf *err)
 {
 	char line[PATH_MAX + 100];
 	int len;
@@ -2241,33 +2241,50 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
 	len = snprintf(line, sizeof(line), "%s %s\n",
 		       sha1_to_hex(sha1), refname);
 	/* this should not happen but just being defensive */
-	if (len > sizeof(line))
-		die("too long a refname '%s'", refname);
-	write_or_die(fd, line, len);
-
+	if (len > sizeof(line)) {
+		strbuf_addf(err, "too long a refname '%s'", refname);
+		return -1;
+	}
+	if (write_in_full(fd, line, len) != len) {
+		strbuf_addf(err, "error writing to packed-refs. %s",
+			    strerror(errno));
+		return -1;
+	}
 	if (peeled) {
 		if (snprintf(line, sizeof(line), "^%s\n",
 			     sha1_to_hex(peeled)) != PEELED_LINE_LENGTH)
 			die("internal error");
-		write_or_die(fd, line, PEELED_LINE_LENGTH);
+		len = PEELED_LINE_LENGTH;
+		if (write_in_full(fd, line, len) != len) {
+			strbuf_addf(err, "error writing to packed-refs. %s",
+				    strerror(errno));
+			return -1;
+		}
 	}
+	return 0;
 }
 
+struct write_packed_data {
+	int fd;
+	struct strbuf *err;
+};
+
 /*
  * An each_ref_entry_fn that writes the entry to a packed-refs file.
  */
 static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
+	struct write_packed_data *data = cb_data;
 	enum peel_status peel_status = peel_entry(entry, 0);
 
-	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-		error("internal error: %s is not a valid packed reference!",
-		      entry->name);
-	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
-			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled : NULL);
-	return 0;
+	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG) {
+		strbuf_addf(data->err, "internal error: %s is not a "
+			    "valid packed reference!", entry->name);
+		return -1;
+	}
+	return write_packed_entry(data->fd, entry->name, entry->u.value.sha1,
+				  peel_status == PEEL_PEELED ?
+				  entry->u.value.peeled : NULL, data->err);
 }
 
 static int lock_packed_refs(struct strbuf *err)
@@ -2296,30 +2313,34 @@ static int lock_packed_refs(struct strbuf *err)
 
 /*
  * Commit the packed refs changes.
- * On error we must make sure that errno contains a meaningful value.
  */
-static int commit_packed_refs(void)
+static int commit_packed_refs(struct strbuf *err)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
-	int save_errno = 0;
+	struct write_packed_data data;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
-	write_or_die(packed_ref_cache->lock->fd,
-		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
+	if (write_in_full(packed_ref_cache->lock->fd,
+			  PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER)) < 0) {
+		strbuf_addf(err, "error writing packed-refs. %s",
+			    strerror(errno));
+		return -1;
+       }
 
+	data.fd = packed_ref_cache->lock->fd;
+	data.err = err;
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 0, write_packed_entry_fn,
-				 &packed_ref_cache->lock->fd);
+				 0, write_packed_entry_fn, &data);
 	if (commit_lock_file(packed_ref_cache->lock)) {
-		save_errno = errno;
+		strbuf_addf(err, "unable to overwrite old ref-pack "
+			    "file. %s", strerror(errno));
 		error = -1;
 	}
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
-	errno = save_errno;
 	return error;
 }
 
@@ -2477,8 +2498,8 @@ int pack_refs(unsigned int flags)
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
 				 pack_if_possible_fn, &cbdata);
 
-	if (commit_packed_refs())
-		die_errno("unable to overwrite old ref-pack file");
+	if (commit_packed_refs(&err))
+		die("%s", err.buf);
 
 	prune_refs(cbdata.ref_to_prune);
 	return 0;
@@ -2549,7 +2570,7 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, ret;
+	int i;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2572,11 +2593,7 @@ static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs();
-	if (ret && err)
-		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
-			    strerror(errno));
-	return ret;
+	return commit_packed_refs(err);
 }
 
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
@@ -3681,9 +3698,7 @@ int transaction_commit(struct ref_transaction *transaction,
 	if (need_repack) {
 		packed = get_packed_refs(&ref_cache);
 		sort_ref_dir(packed);
-		if (commit_packed_refs()){
-			strbuf_addf(err, "unable to overwrite old ref-pack "
-				    "file");
+		if (commit_packed_refs(err)){
 			ret = -1;
 			goto cleanup;
 		}
-- 
2.0.1.523.g70700c9
