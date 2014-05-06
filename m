From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 1/2] refs.c: add new functions reflog_exists and delete_reflog
Date: Tue,  6 May 2014 15:45:52 -0700
Message-ID: <1399416353-31817-2-git-send-email-sahlberg@google.com>
References: <1399416353-31817-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 00:46:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Who7q-0001DO-FN
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbaEFWqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:46:01 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:47333 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbaEFWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:46:00 -0400
Received: by mail-vc0-f202.google.com with SMTP id if11so32103vcb.1
        for <git@vger.kernel.org>; Tue, 06 May 2014 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=of5FIZovNwFi9FgiGZFRwlW6xHbT4Wfbim2nOQB7Zds=;
        b=NE0tqaZuk3BAodbLh1+Z+zyoet5cRYF7mvPX1gPj6a1/e+NNh+yqV8xl96I3J2x+jJ
         dpvIwYKlAYmV0+Nqk9y72QHrJT4H5kKoOdnW4ANVtUo59bOfkqBDNSW6yHo2o20oYcQT
         8mXteR8B20WlT+FZ+G1fReWNmOtk6ZSUZdV4Em2KNNZMi2bd9GJsXL2ILsZyhD8OjLUA
         tNhwQXLYX595DA7bZpyffZtARvHzBctVXuNKvqqpoOUmAPHwGs43zQHKkackJG1JmQ+w
         pdcAP2rgCo8sarTF5KRtYLLkTXg4uNuQN19OvYQdlpvQXw3OrpNjm9c5cHtlaDEKhE99
         qRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=of5FIZovNwFi9FgiGZFRwlW6xHbT4Wfbim2nOQB7Zds=;
        b=kMPaSRkTnBAjEibDDF2frMTpTXVMf/3Y59zJtrkjcs1+yS4fpEKBVlmmNW19EXETmN
         qKoHH/TN8EHuRzKo148JxZr3GfkZuzWQNrCubKyaTdNq/fyjiqO3AEh/INJ8lbyEEXeT
         8fwN3AQanfeYaHhJJvswPk0+OHFRLV/QEOvABzailBAAoYPXyQP6H0qH04fA5JG+WsMt
         Bxe+pKu6mH/vCmmlASraTwLm2LlSR2rH7Mtl7k4at76Y/2OgEHBEx5bDN5qEVROqD89F
         mWZ02dVQwujzO68YaLg4EzxiHqRQZ6crlGhKS73iyo8LlOsTbHaKHIUD6YI5DYsVmlbe
         cYEQ==
X-Gm-Message-State: ALoCoQlIpcqmtzuY7Tv72SNuAlwvTOVV6KBd53aHestQueElQxxJQ34GQqpAzQRxA0UxM9lB3LXD
X-Received: by 10.58.150.194 with SMTP id uk2mr2701222veb.0.1399416359677;
        Tue, 06 May 2014 15:45:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si602290yhh.0.2014.05.06.15.45.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 15:45:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 64C8231C1BD;
	Tue,  6 May 2014 15:45:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 148AAE0ACF; Tue,  6 May 2014 15:45:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.354.g7561c2b.dirty
In-Reply-To: <1399416353-31817-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248266>

Add two new functions, reflog_exists and delete_reflog, to hide the internal
reflog implementation (that they are files under .git/logs/...) from callers.
Update checkout.c to use these functions in update_refs_for_switch instead of
building pathnames and calling out to file access functions. Update reflog.c
to use these to check if the reflog exists. Now there are still many places
in reflog.c where we are still leaking the reflog storage implementation but
this at least reduces the number of such dependencies by one. Finally
change two places in refs.c itself to use the new function to check if a ref
exists or not isntead of build-path-and-stat(). Now, this is strictly not all
that important since these are in parts of refs that are implementing the
actual file storage backend but on the other hand it will not hurt either.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c |  7 +++----
 builtin/reflog.c   |  2 +-
 refs.c             | 21 +++++++++++++++------
 refs.h             |  6 ++++++
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ff44921..929f5bd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -651,12 +651,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			}
 		}
 		if (old->path && old->name) {
-			char log_file[PATH_MAX], ref_file[PATH_MAX];
+			char ref_file[PATH_MAX];
 
-			git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
 			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
-			if (!file_exists(ref_file) && file_exists(log_file))
-				remove_path(log_file);
+			if (!file_exists(ref_file) && reflog_exists(old->path))
+				delete_reflog(old->path);
 		}
 	}
 	remove_branch_state();
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c12a9784..e8a8fb1 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -369,7 +369,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
 	log_file = git_pathdup("logs/%s", ref);
-	if (!file_exists(log_file))
+	if (!reflog_exists(ref))
 		goto finish;
 	if (!cmd->dry_run) {
 		newlog_path = git_pathdup("logs/%s.lock", ref);
diff --git a/refs.c b/refs.c
index e59bc18..302a2b3 100644
--- a/refs.c
+++ b/refs.c
@@ -2013,7 +2013,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 	*log = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
-		struct stat st;
 		unsigned char hash[20];
 		char path[PATH_MAX];
 		const char *ref, *it;
@@ -2022,12 +2021,9 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		ref = resolve_ref_unsafe(path, hash, 1, NULL);
 		if (!ref)
 			continue;
-		if (!stat(git_path("logs/%s", path), &st) &&
-		    S_ISREG(st.st_mode))
+		if (reflog_exists(path))
 			it = path;
-		else if (strcmp(ref, path) &&
-			 !stat(git_path("logs/%s", ref), &st) &&
-			 S_ISREG(st.st_mode))
+		else if (strcmp(ref, path) && reflog_exists(ref))
 			it = ref;
 		else
 			continue;
@@ -3030,6 +3026,19 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 	return 1;
 }
 
+int reflog_exists(const char *refname)
+{
+	struct stat st;
+
+	return !lstat(git_path("logs/%s", refname), &st) &&
+		S_ISREG(st.st_mode);
+}
+
+int delete_reflog(const char *refname)
+{
+	return remove_path(git_path("logs/%s", refname));
+}
+
 static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
 {
 	unsigned char osha1[20], nsha1[20];
diff --git a/refs.h b/refs.h
index c1cb4b4..8bd815d 100644
--- a/refs.h
+++ b/refs.h
@@ -159,6 +159,12 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
 		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
+/** Check if a particular reflog exists */
+extern int reflog_exists(const char *refname);
+
+/** Delete a reflog */
+extern int delete_reflog(const char *refname);
+
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
-- 
2.0.0.rc1.354.g7561c2b.dirty
