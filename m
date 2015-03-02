From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/7] lock_ref_sha1_basic(): do not set force_write for missing references
Date: Mon,  2 Mar 2015 10:29:53 +0100
Message-ID: <1425288597-20547-4-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgY-0007Nu-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbbCBJaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:30:39 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53341 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbbCBJac (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:32 -0500
X-AuditID: 1207440f-f792a6d000001284-8e-54f42da84c77
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.19.04740.8AD24F45; Mon,  2 Mar 2015 04:30:16 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HW008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:14 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLtC90uIwdvv5hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bl/Dp5hLmjgr9jw5yZrA+Nv7i5G
	Tg4JAROJ5V+fsEDYYhIX7q1n62Lk4hASuMwo8XbZJ1aQhJDAMSaJe3s5QWw2AV2JRT3NTCC2
	iICaxMS2Q2DNzAI/mCQOragFsYUFYiQO/fzE2MXIwcEioCrxYIUPSJhXwEXi4Jt9jBC75CTO
	H//JDGJzCrhK/PzVyA6xykVi1vXVzBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXR
	y80s0UtNKd3ECAlE/h2MXetlDjEKcDAq8fAumPc5RIg1say4MvcQoyQHk5Io73GdLyFCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHhfywPleFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1ML
	UotgsjIcHEoSvMEgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP
	0N5UkHbe4oLEXKAoROspRkUpcd5ukIQASCKjNA9uLCy9vGIUB/pSmNcKpIoHmJrgul8BDWYC
	GnxLEWxwSSJCSqqBcQXX98BOnwXBP9jbixLv9mXnTdh8IMo7Yp/qxK1P94X2e3apGB5bGbVN
	fNlevat8FhsMDYoO+c1cJ1dz0PHv+1dRTMqOMwsqw+bfCll/dMr/FW/W8SpMLtq7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264583>

If a reference is missing, its SHA-1 will be null_sha1, which can't
possibly match a new value that ref_transaction_commit() is trying to
update it to. So there is no need to set force_write in this scenario.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index dd30bfa..3ed9ea6 100644
--- a/refs.c
+++ b/refs.c
@@ -2258,7 +2258,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
-	int missing = 0;
 	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2297,13 +2296,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			orig_refname, strerror(errno));
 		goto error_return;
 	}
-	missing = is_null_sha1(lock->old_sha1);
-	/* When the ref did not exist and we are creating it,
-	 * make sure there is no existing ref that is packed
-	 * whose name begins with our refname, nor a ref whose
-	 * name is a proper prefix of our refname.
+	/*
+	 * If the ref did not exist and we are creating it, make sure
+	 * there is no existing packed ref whose name begins with our
+	 * refname, nor a packed ref whose name is a proper prefix of
+	 * our refname.
 	 */
-	if (missing &&
+	if (is_null_sha1(lock->old_sha1) &&
 	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
@@ -2319,8 +2318,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
 	ref_file = git_path("%s", refname);
-	if (missing)
-		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
 
-- 
2.1.4
