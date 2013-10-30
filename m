From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/23] fetch: improve the error messages emitted for conflicting refspecs
Date: Wed, 30 Oct 2013 06:33:12 +0100
Message-ID: <1383111192-23780-24-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXm-0007Xo-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab3J3FmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:42:10 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49620 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab3J3FmI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:42:08 -0400
X-AuditID: 12074411-b7f426d000005455-86-52709a765feb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 22.DA.21589.67A90725; Wed, 30 Oct 2013 01:34:46 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIY014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:44 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqFs2qyDI4MRWSYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y8eE0+wFO+UqHkzsYm9gfCjRxcjJISFgInF96mdmCFtM4sK99WxdjFwcQgKXGSXmrb8A
	5Vxhkjhw5zcbSBWbgK7Eop5mJhBbREBNYmLbIRaQImaBicwSx6cvYgFJCAvESGxY0w80loOD
	RUBVYub9aJAwr4CrREPHM6htChI3mqeygticQPFPu26yg9hCAi4STe2f2Scw8i5gZFjFKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERK2gjsYZ5yUO8QowMGoxMNr8CA/SIg1
	say4MvcQoyQHk5Iob9qUgiAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzTjwOV86YkVlalFuXD
	pKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeJVnAg0VLEpNT61Iy8wpQUgzcXCCCC6Q
	DTxAG3hACnmLCxJzizPTIYpOMSpKifMqgCQEQBIZpXlwA2AJ5hWjONA/whDtPMDkBNf9Cmgw
	E9DgPSx5IINLEhFSUg2M6cH8xW97Op9/XRFWHvo9N11bN8me5Z2TiXacnQKvUNXUmT7W4vff
	fJxZYrD+gZHMFqkzZTb+2Y47o7N38LPXvfbJOqJu/TPGb5vL6lgtBvYzZ+bN+rrx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236978>

If we find two refspecs that want to update the same local reference,
emit an error message that is more informative based on whether one of
the conflicting refspecs is an opportunistic update during a fetch
with explicit command-line refspecs.  And especially, do not die if an
opportunistic reference update conflicts with an express wish of the
user; rather, just emit a warning and skip the opportunistic reference
update.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c                   | 25 ++++++++++++++++++++++---
 t/t5536-fetch-conflicts.sh | 14 +++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 06a0eda..15e6e5e 100644
--- a/remote.c
+++ b/remote.c
@@ -747,9 +747,28 @@ int for_each_remote(each_remote_fn fn, void *priv)
 
 static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 {
-	if (strcmp(ref1->name, ref2->name))
-		die(_("%s tracks both %s and %s"),
-		    ref2->peer_ref->name, ref1->name, ref2->name);
+	if (strcmp(ref1->name, ref2->name)) {
+		if (ref1->fetch_head_status != FETCH_HEAD_IGNORE &&
+		    ref2->fetch_head_status != FETCH_HEAD_IGNORE) {
+			die(_("Cannot fetch both %s and %s to %s"),
+			    ref1->name, ref2->name, ref2->peer_ref->name);
+		} else if (ref1->fetch_head_status != FETCH_HEAD_IGNORE &&
+			   ref2->fetch_head_status == FETCH_HEAD_IGNORE) {
+			warning(_("%s usually tracks %s, not %s"),
+				ref2->peer_ref->name, ref2->name, ref1->name);
+		} else if (ref1->fetch_head_status == FETCH_HEAD_IGNORE &&
+			   ref2->fetch_head_status == FETCH_HEAD_IGNORE) {
+			die(_("%s tracks both %s and %s"),
+			    ref2->peer_ref->name, ref1->name, ref2->name);
+		} else {
+			/*
+			 * This last possibility doesn't occur because
+			 * FETCH_HEAD_IGNORE entries always appear at
+			 * the end of the list.
+			 */
+			die(_("Internal error"));
+		}
+	}
 	free(ref2->peer_ref);
 	free(ref2);
 }
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 679c53e..6c5d3a4 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -22,7 +22,7 @@ verify_stderr () {
 	cat >expected &&
 	# We're not interested in the error
 	# "fatal: The remote end hung up unexpectedly":
-	grep -v "hung up" <error >actual &&
+	grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
 	test_cmp expected actual
 }
 
@@ -49,7 +49,7 @@ test_expect_success 'fetch conflict: config vs. config' '
 		cd ccc &&
 		test_must_fail git fetch origin 2>error &&
 		verify_stderr <<-\EOF
-		fatal: refs/remotes/origin/branch1 tracks both refs/heads/branch1 and refs/heads/branch2
+		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
 		EOF
 	)
 '
@@ -78,18 +78,22 @@ test_expect_success 'fetch conflict: arg vs. arg' '
 			refs/heads/*:refs/remotes/origin/* \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
 		verify_stderr <<-\EOF
-		fatal: refs/remotes/origin/branch1 tracks both refs/heads/branch1 and refs/heads/branch2
+		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
 		EOF
 	)
 '
 
-test_expect_failure 'fetch conflict: criss-cross args' '
+test_expect_success 'fetch conflict: criss-cross args' '
 	setup_repository xaa \
 		"+refs/heads/*:refs/remotes/origin/*" && (
 		cd xaa &&
 		git fetch origin \
 			refs/heads/branch1:refs/remotes/origin/branch2 \
-			refs/heads/branch2:refs/remotes/origin/branch1
+			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
+		verify_stderr <<-\EOF
+		warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2
+		warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1
+		EOF
 	)
 '
 
-- 
1.8.4.1
