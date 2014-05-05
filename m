From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] refs.c: add new functions reflog_exists and delete_reflog
Date: Mon,  5 May 2014 15:57:57 -0700
Message-ID: <1399330677-17930-2-git-send-email-sahlberg@google.com>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiCW-0007Xo-A5
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbaEEW6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 18:58:04 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:54520 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbaEEW6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 18:58:03 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so650911pab.4
        for <git@vger.kernel.org>; Mon, 05 May 2014 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYM+dHaHGNd7GSbRyE6guXm16GfPpcA8P092Pb/4eYw=;
        b=clGRWVvI8CdD2svfm6jsTRzwRJMSVVbTmox+RX7NfKFZNiywFRiYbAm/iWiZ4pSG9b
         j62rMohm5lqj9zbfAVmjfBqotMfSQpMOD4y+Uy13Jsyq+2CveBQaSu7B1o/bIf8Te9NA
         XNGlmDNS8yMkzd6kZnc/WBEJeH7bfl0abUse+cY/Tvk87l29gLZoA8lLWKskG55SVN/O
         BshaQ3vHq4hmh2hjXKc2RgOK6V7NqnG0eC1vetiIa5BJMFgcYcTnaTl1a6bhsKxNDntO
         MVraP/WDIiHAHNkbUo193A3lQa5mxZETgmXXvDHHun3ThtWC8A/uMq8ikmyvOn+Fi+fU
         VKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYM+dHaHGNd7GSbRyE6guXm16GfPpcA8P092Pb/4eYw=;
        b=jm21kb/45Vsi8Is5T8ZHuxfls451TnNQhJfYmHuSzC2D/1STCVWk5lJhFVi343Sg4l
         Ni/o5WkjZewc841lLcawWSyM9kvuM2w0aTkB6aCNb3105yYisfYfIFqfoEiAyGvMOBt4
         zhNUSiWrfid1LXB6Q2vqkxJIQRT0gcKqhnIvkIGi1eHYrLWzcXL+mWT5TZ2ETxiTb2sY
         8p/i2cHFTGr2CJBfAdxm4AYwC0rkqWFVIU9+ia8Tub4y3mbsA7jxszWOID+59V4OllIl
         Qxrc6PKAoXuaMjR9pw1jzwci1ZjvzrNTG9XN5Uul4GJLMPj4VNiOSFyFUtjtRkXAqnvr
         jPQQ==
X-Gm-Message-State: ALoCoQnN8LBJAntHAkkuUWk7UpU2AJDIBJu6PBYnWXRJLrwlQTghx8rvZka5GZdGt/nGE6WqSs9c
X-Received: by 10.66.66.196 with SMTP id h4mr18089189pat.22.1399330681866;
        Mon, 05 May 2014 15:58:01 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si437479yhk.4.2014.05.05.15.58.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 May 2014 15:58:01 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9C52D31C0AF;
	Mon,  5 May 2014 15:58:01 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4CA1BE1A8A; Mon,  5 May 2014 15:58:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.gd2b7e18.dirty
In-Reply-To: <1399330677-17930-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248170>

Add two new functions, reflog_exists and delete_reflog to hide the internal
reflog implementation (that they are files under .git/logs/...) from callers.
Update checkout.c to use these functions in update_refs_for_switch instead of
building pathnames and calling out to file access functions. Update reflog.c
to use these too check if the reflog exists. Now there are still many places
in reflog.c where we are still leaking the reflog storage implementation but
this at least reduces the number of such dependencies by one. Finally
change two places in refs.c itself to use the new function to check if a ref
exists or not isntead of build-path-and-stat(). Now, this is strictly not all
that important since these are in parts of refs that are implementing the
actual file storage backend but on the other hand it will not hurt either.

In config.c we also change to use the existing function ref_exists instead of
checking if the loose ref file exist. The previous code made the assumption
that the branch we switched from must exist as a loose ref and thus checking
the file would be sufficent. I think that assumption is always true in the
current code but it is still somewhat fragile since if git would change so that
the checkedout branch could exist as a packed ref without a corresponding
loose ref then this subtle 'does the lose ref not exist' check would suddenly
fail.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c |  8 ++------
 builtin/reflog.c   |  2 +-
 refs.c             | 20 ++++++++++++++------
 refs.h             |  6 ++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ff44921..f1dc56e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -651,12 +651,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			}
 		}
 		if (old->path && old->name) {
-			char log_file[PATH_MAX], ref_file[PATH_MAX];
-
-			git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
-			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
-			if (!file_exists(ref_file) && file_exists(log_file))
-				remove_path(log_file);
+			if (!ref_exists(old->path) && reflog_exists(old->path))
+				delete_reflog(old->path);
 		}
 	}
 	remove_branch_state();
diff --git a/builtin/reflog.c b/builtin/reflog.c
index c12a9784..0e7ea74 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -369,7 +369,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
 	log_file = git_pathdup("logs/%s", ref);
-	if (!file_exists(log_file))
+	if (!ref_exists(ref))
 		goto finish;
 	if (!cmd->dry_run) {
 		newlog_path = git_pathdup("logs/%s.lock", ref);
diff --git a/refs.c b/refs.c
index e59bc18..7d12ac7 100644
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
@@ -3030,6 +3026,18 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 	return 1;
 }
 
+int reflog_exists(const char *ref)
+{
+	struct stat st;
+
+	return !lstat(git_path("logs/%s", ref), &st) && S_ISREG(st.st_mode);
+}
+
+int delete_reflog(const char *ref)
+{
+	return remove_path(git_path("logs/%s", ref));
+}
+
 static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
 {
 	unsigned char osha1[20], nsha1[20];
diff --git a/refs.h b/refs.h
index 71e39b9..5a93f27 100644
--- a/refs.h
+++ b/refs.h
@@ -159,6 +159,12 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
 		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
+/** Check if a particular ref log exists */
+extern int reflog_exists(const char *);
+
+/** Delete a ref log */
+extern int delete_reflog(const char *);
+
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
-- 
2.0.0.rc1.351.gd2b7e18.dirty
