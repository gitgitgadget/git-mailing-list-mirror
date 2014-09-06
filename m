From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 13/32] write_packed_entry_fn(): convert cb_data into a (const int *)
Date: Sat,  6 Sep 2014 09:50:27 +0200
Message-ID: <1409989846-22401-14-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnJ-0000CU-7e
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbaIFHwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:21 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44685 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbaIFHwR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:17 -0400
X-AuditID: 12074414-f79446d000001f1d-14-540abd30113c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 55.9A.07965.03DBA045; Sat,  6 Sep 2014 03:52:16 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHC006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:15 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqGuwlyvEoPeQuEXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3xr0PT1gKrrFWrF/UzdbAeJKli5GTQ0LAROLIsxVMELaYxIV769m6
	GLk4hAQuM0qsbNrPAuEcY5J4t/YlM0gVm4CuxKKeZiaQhIhAG6PEroubWUESzAIpEh3PuxlB
	bGGBcIkJx/rAGlgEVCVm9l4Gq+EVcJXY17eQEWKdnMSG3f/BbE6g+PSmTjBbSMBFov1kP9ME
	Rt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIzS/RSU0o3MUJCTWQH45GTcocYBTgY
	lXh4Cxy4QoRYE8uKK3MPMUpyMCmJ8uYtBwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4e2YDJTj
	TUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLg7dsN1ChYlJqeWpGWmVOC
	kGbi4AQZziUlUpyal5JalFhakhEPio74YmB8gKR4gPaeBWnnLS5IzAWKQrSeYjTmaGl628vE
	sa7zWz+TEEtefl6qlDjvnV1ApQIgpRmleXCLYEnmFaM40N/CvPdBBvIAExTcvFdAq5iAVpmn
	c4KsKklESEk1MM6a1bw070S8hOK023pVv7QjjQVW8UyY3an6suVCdFlluFwXh1qSW0LOTKnv
	j+aFc+81fXjqjcOVaZ0P3axu5E2MCo8PuvfNOvvc87C8RSKnW96dj8ttOvpQd/GM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256555>

This makes it obvious that we have no plans to change the integer
pointed to, which is actually the fd field from a struct lock_file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 8a63073..21b0da3 100644
--- a/refs.c
+++ b/refs.c
@@ -2218,7 +2218,7 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
  */
 static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
+	const int *fd = cb_data;
 	enum peel_status peel_status = peel_entry(entry, 0);
 
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-- 
2.1.0
