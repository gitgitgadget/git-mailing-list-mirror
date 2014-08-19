From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 4/5] refs.c: add an err argument to commit_packed_refs
Date: Tue, 19 Aug 2014 09:17:03 -0700
Message-ID: <1408465024-23162-5-git-send-email-sahlberg@google.com>
References: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJm6R-0003Fk-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbaHSQRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:17:19 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:34309 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbaHSQRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:17:08 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so212268ieb.4
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xb/FksQhMLDgjWXtpUgMhH0DUQBKGPzUwJh5TWQybpQ=;
        b=CXv3hGslbCRD5++N1tSYuvU+zJhQT4V8WfAbIlP9ZorvtRfdRCBuffzTtnImDRhTWw
         Vdiuk7wg52NduvOJW9TCgq4FyJZCJkdE8kmYDjO0vLrfNw09uxSOnYT5pegMVKOxBgaO
         EC12o//Qv2WGG0CqLuN0Ez+JXvt+QtNRxWV6BI7P0iJUceugk6cijloO0zZ8C2uIYiKD
         kfDG4+aaFnE9RlaCwzsijmOthGd554Q5uJcm8ujoyDd+APuklR1INhx4orsIR8TcgeQm
         z3Xa5T2FBX2YDmzITHT+dJQakuyDSQbPOuX+a4UCq1egxvtU4MkaoA00VRn0y42iV6q8
         /pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xb/FksQhMLDgjWXtpUgMhH0DUQBKGPzUwJh5TWQybpQ=;
        b=DhJ0pfA8Z/sKYQTudJIfsz/mQtJ8tEa24cuGrgPIPJi5dKcdd//bIgs0hnEpichPIw
         H9MoxWvBHK7mEcAaGM2mpg4aIwLs4i6FfsYZoAYHA1jPqSQNmuSrjL4XrqcYQ1IXYEF7
         ijkYGK9vq1p9j1fHWRzp08WkjQ1MxhIxg7pHWcwR1Jpw2wLpPFgbvsp2YHZcyJ6Xx2fy
         kcFE9Fbk0lPi6NoFtP1zE3fqaihwcYXiR/ysZb7p5xtVmnsFtt61tWvun6pF0ZjM1DIG
         dhAhLXRHBmDqyfALL4nPbHXsgtEJNAIovOf7cFaJxl6UDZYLtl5EQOTJRznUsLUG7Q5s
         +Evg==
X-Gm-Message-State: ALoCoQmMTBdhWlQIHkAsjH78aD6eZfTVIkzgCDllLbOovtMp9nWoPomibR6jv2u52rKIilL4GaUP
X-Received: by 10.50.33.18 with SMTP id n18mr3599689igi.8.1408465027542;
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v20si326077yhe.2.2014.08.19.09.17.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 508E15A441E;
	Tue, 19 Aug 2014 09:17:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BE225E11B0; Tue, 19 Aug 2014 09:17:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
In-Reply-To: <1408465024-23162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255467>

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
2.0.1.556.ge8f7cba.dirty
