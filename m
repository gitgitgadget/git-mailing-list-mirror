From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/33] refname_is_safe(): use skip_prefix()
Date: Fri,  6 May 2016 18:13:47 +0200
Message-ID: <39950fef8bb45e944655e48393ee04c0b33211f5.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOm-0007yb-5V
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612AbcEFQOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63349 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758533AbcEFQOc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:32 -0400
X-AuditID: 1207440c-c3fff70000000b85-c2-572cc2e80671
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id FB.64.02949.8E2CC275; Fri,  6 May 2016 12:14:32 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUm031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:30 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqPvikE64wdq7rBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oyeSdfZCt6xVdxq+cfSwLiOtYuRk0NCwERiwY5T
	LF2MXBxCAlsZJd5fv8AK4Rxnknj+chYjSBWbgK7Eop5mJhBbRCBCouFVC1Ccg4NZ4DOjxEpu
	kLCwgJ1E7/4esHIWAVWJuz8OsIHYvAJREi1TP0Atk5O4PP0BWJxTwELiUO9xsJFCAuYSHWtv
	sE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyTAeHYwflsnc4hR
	gINRiYf3wGntcCHWxLLiytxDjJIcTEqivN8LdMKF+JLyUyozEosz4otKc1KLDzFKcDArifBe
	2QeU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8AYdBGoULEpNT61I
	y8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VAfDEwBkBSPEB75UHaeYsLEnOBohCtpxiNORb8
	uL2WiePI/ntrmYRY8vLzUqXEeQ1ASgVASjNK8+AWwVLLK0ZxoL+FeSeBVPEA0xLcvFdAq5iA
	Vr2fqwmyqiQRISXVwOhuLNrRpnWydlpwrtHqxs11J/s1Yu41Lj24ruAwAz934UE1+RQH9usR
	B6eV2i1ZZVg5pffE9tfz9hwoPr/z9sxNr5nOOea+n7BwyU+vHUd2PtC73OXv6M2g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293798>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 87dc82f..5789152 100644
--- a/refs.c
+++ b/refs.c
@@ -120,17 +120,19 @@ int check_refname_format(const char *refname, int flags)
 
 int refname_is_safe(const char *refname)
 {
-	if (starts_with(refname, "refs/")) {
+	const char *rest;
+
+	if (skip_prefix(refname, "refs/", &rest)) {
 		char *buf;
 		int result;
 
-		buf = xmallocz(strlen(refname));
 		/*
 		 * Does the refname try to escape refs/?
 		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
 		 * is not.
 		 */
-		result = !normalize_path_copy(buf, refname + strlen("refs/"));
+		buf = xmallocz(strlen(rest));
+		result = !normalize_path_copy(buf, rest);
 		free(buf);
 		return result;
 	}
-- 
2.8.1
