From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/33] refs: don't dereference on rename
Date: Fri,  6 May 2016 18:14:04 +0200
Message-ID: <c474a36117cfda48aae539817ad921629533aa16.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPx-0000Vy-HH
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630AbcEFQPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:48 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63363 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758702AbcEFQPD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:03 -0400
X-AuditID: 1207440c-c53ff70000000b85-19-572cc3066792
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 64.74.02949.603CC275; Fri,  6 May 2016 12:15:02 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV5031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:00 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqMt2WCfcoOOJuMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61dmD3+Pv+A5PHzll32T2e9e5h9Lh4Sdlj/9JtbB4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO6PtxjyWgsmyFau3z2RvYHwi3sXIySEhYCLxfe13
	xi5GLg4hga2MElufXmSCcI4zSbx93M4MUsUmoCuxqKeZCcQWEYiQaHjVAtTBwcEs8JlRYiU3
	SFhYwFrixL12RhCbRUBVon/+VRYQm1cgSmLGqlPsEMvkJC5Pf8AGYnMKWEgc6j0ONlJIwFyi
	Y+0N9gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihAQYzw7Gb+tk
	DjEKcDAq8fAeOK0dLsSaWFZcmXuIUZKDSUmU93uBTrgQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed4r+4ByvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJ3qCDQI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoAiILwbGAEiKB2ivPEg7b3FBYi5QFKL1FKMu
	x5H999YyCbHk5eelSonzGoAUCYAUZZTmwa2ApZNXjOJAHwvzTgKp4gGmIrhJr4CWMAEteT9X
	E2RJSSJCSqqB0b75rVjR7Qc7or76bjEMKL5xcjPH1g6myX3r5lgVn9h8iOPQ6pDCZjttYxYN
	Nblvl3i+fuV43Hmijc+iP41pc26g+I+KtWufvLM0T8hs+To3UD2y/8Iinyv9i96F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293822>

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
 refs/files-backend.c | 21 ++++++++++++++++-----
 t/t3200-branch.sh    |  9 +++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3f546d0..ad53b6e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2333,7 +2333,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING, orig_sha1, &flag))
+	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				orig_sha1, &flag))
 		return error("refname %s not found", oldrefname);
 
 	if (flag & REF_ISSYMREF)
@@ -2351,8 +2352,16 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+	/*
+	 * Since we are doing a shallow lookup, sha1 is not the
+	 * correct value to pass to delete_ref as old_sha1. But that
+	 * doesn't matter, because an old_sha1 check wouldn't add to
+	 * the safety anyway; we want to delete the reference whatever
+	 * its current value.
+	 */
+	if (!read_ref_full(newrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			   sha1, NULL) &&
+	    delete_ref(newrefname, NULL, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -2376,7 +2385,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
+				   NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2394,7 +2404,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
