From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/17] rename_tmp_log(): limit the number of remote_empty_directories() attempts
Date: Mon,  6 Jan 2014 14:45:34 +0100
Message-ID: <1389015935-21936-17-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AW2-0006PI-5q
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaAFNqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:38 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59498 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753170AbaAFNqg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:36 -0500
X-AuditID: 12074414-b7fb46d000002a4d-01-52cab3bb0e64
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.84.10829.BB3BAC25; Mon,  6 Jan 2014 08:46:35 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPH021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:34 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqLt786kgg2UHzCy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzDu9tZyv4zV6x/uwy9gbGlWxdjJwcEgImEo+P72SFsMUkLtxbDxTn4hASuMwocfZb
	BxOEc4xJoufOF3aQKjYBXYlFPc1MILaIgJrExLZDLCBFzAKLGSW6pn1jBEkICyRL9C+bxQxi
	swioSvRObAGzeQVcJXrn9QDVcACtU5BYfV0IJMwJFJ427TDYRUICLhJrDj1imcDIu4CRYRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSFCJ7GA8clLuEKMAB6MSD++HxyeD
	hFgTy4orcw8xSnIwKYnycq4+FSTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhJdrAVCONyWxsiq1
	KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCd8MmoEbBotT01Iq0zJwShDQTByeI
	4ALZwAO04QpIIW9xQWJucWY6RNEpRkUpcd7zIAkBkERGaR7cAFj8v2IUB/pHmHcLSBUPMHXA
	db8CGswENDg0DmxwSSJCSqqB0fLYE1Zh54pJ4cZO3z7Jb/wc/+Lv5yqZnmP1ivPNBI+4ro7w
	WtB02mLJxtJ7Vs+OZz7PFYxYmrAv2DqEp2+FqfKWJrYVdlv6bzWH2rwJMHy9LUCZe/WOH8li
	y7lvnqz4s9+gLCzlT0THjVZ9h5qSY6fmyP3fbm8qoeE8ZctRu79Wy9bMFTBcrsRS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240002>

This doesn't seem to be a likely error, but we've got the counter
anyway, so we might as well use it for an added bit of safety.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 8de636e..490525a 100644
--- a/refs.c
+++ b/refs.c
@@ -2530,7 +2530,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 static int rename_tmp_log(const char *newrefname)
 {
-	int attempts = 3;
+	int attempts = 4;
 
  retry:
 	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
@@ -2539,7 +2539,7 @@ static int rename_tmp_log(const char *newrefname)
 	}
 
 	if (rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
-		if (errno==EISDIR || errno==ENOTDIR) {
+		if ((errno==EISDIR || errno==ENOTDIR) && --attempts > 0) {
 			/*
 			 * rename(a, b) when b is an existing
 			 * directory ought to result in ISDIR, but
-- 
1.8.5.2
