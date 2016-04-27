From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/29] refs: don't dereference on rename
Date: Wed, 27 Apr 2016 18:57:36 +0200
Message-ID: <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoH-00047Q-05
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbcD0Q6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:50 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58074 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438AbcD0Q6r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:47 -0400
X-AuditID: 1207440c-c3fff70000000b85-80-5720efbbe5f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D9.0A.02949.BBFE0275; Wed, 27 Apr 2016 12:58:35 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6W022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:33 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLv7vUK4werPIhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7ozJn5ayFzyXrpiw6wZjA+NrsS5GTg4JAROJjg8z
	WLsYuTiEBLYySkx+uYoZwjnOJNF7eQErSBWbgK7Eop5mJhBbRMBBYvnKX+wgRcwCTUwS35c3
	sYAkhAUsJM5sOQ1WxCKgKnHpzhZmEJtXIEri3NvNjBDr5CQuT3/ABmJzAtV/aX0LFhcSMJdY
	8mA1+wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQoKMZwfjt3Uy
	hxgFOBiVeHgLJBTChVgTy4orcw8xSnIwKYnyLjkLFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	O/0NUI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMGbCowmIcGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQFMQXA+MAJMUDtLf0Hcje4oLEXKAoROspRkUp
	cV7Xt0AJAZBERmke3FhY6njFKA70pTBvEEg7DzDtwHW/AhrMBDT48iFZkMEliQgpqQbGzOUn
	Z8yQKZi/7c/D3Is9R+1dPqx4n/6hvaPjvGLs7ZiHnNfYTFd0aM7ayNhvpXknx37jm6pXhWt6
	DRUKNk9JWr277TnHvt/6DFbMBd0WycsZbSe3Wn67HBW39GjSLwUDH6M50ZvttZgO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292763>

From: David Turner <dturner@twopensource.com>

When renaming refs, don't dereference either the origin or the destination
before renaming.

The origin does not need to be dereferenced because it is presently
forbidden to rename symbolic refs.

Not dereferencing the destination fixes a bug where renaming on top of
a broken symref would use the pointed-to ref name for the moved
reflog.

Add a test for the reflog bug.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++++-----
 t/t3200-branch.sh    |  9 +++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 91416db..e4cdd5a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2358,11 +2358,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	struct strbuf err = STRBUF_INIT;
+	const int resolve_flags = RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING, orig_sha1, &flag))
+	if (!resolve_ref_unsafe(oldrefname, resolve_flags, orig_sha1, &flag))
 		return error("refname %s not found", oldrefname);
 
 	if (flag & REF_ISSYMREF)
@@ -2380,8 +2381,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+	if (!read_ref_full(newrefname, resolve_flags, sha1, NULL) &&
+	    delete_ref(newrefname, NULL, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -2405,7 +2406,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2423,7 +2425,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e3b6c..4281160 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -79,6 +79,15 @@ test_expect_success 'git branch -m dumps usage' '
 	test_i18ngrep "branch name required" err
 '
 
+test_expect_success 'git branch -m m broken_symref should work' '
+	test_when_finished "git branch -D broken_symref" &&
+	git branch -l m &&
+	git symbolic-ref refs/heads/broken_symref refs/heads/i_am_broken &&
+	git branch -m m broken_symref &&
+	git reflog exists refs/heads/broken_symref &&
+	test_must_fail git reflog exists refs/heads/i_am_broken
+'
+
 test_expect_success 'git branch -m m m/m should work' '
 	git branch -l m &&
 	git branch -m m m/m &&
-- 
2.8.1
