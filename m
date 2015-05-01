From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/18] is_refname_available(): convert local variable "dirname" to strbuf
Date: Fri,  1 May 2015 14:25:44 +0200
Message-ID: <1430483158-14349-5-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:33:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA8F-0006GD-N1
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbbEAMdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:33:18 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47603 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752828AbbEAMdR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:33:17 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2015 08:33:17 EDT
X-AuditID: 12074411-f79fa6d000006b8a-56-554370e7d98b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id BD.28.27530.7E073455; Fri,  1 May 2015 08:26:15 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zh004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:14 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPu8wDnU4NgnVouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ2zdspi1YCVnxYzWSawNjOvYuxg5OSQETCRWT5/JCmGLSVy4t56ti5GLQ0jgMqPEhyP7
	2SGcE0wSi7pvMYFUsQnoSizqaQazRQTUJCa2HWIBKWIW6GCUuLB8G1AHB4ewQKTEje0aIDUs
	AqoSpxbvZwOxeQVcJGa9+8MGsU1O4vzxn8wg5ZwCrhJfpiaChIWASu5//8o2gZF3ASPDKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQgBLcwTjjpNwhRgEORiUe3g3HnEKF
	WBPLiitzDzFKcjApifLaJjiHCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhvacOlONNSaysSi3K
	h0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAm5gM1ChalpqdWpGXmlCCkmTg4QYZz
	SYkUp+alpBYllpZkxIMiI74YGBsgKR6gvctA2nmLCxJzgaIQracYFaXEeXtAEgIgiYzSPLix
	sDTxilEc6Eth3uMgVTzAFAPX/QpoMBPQ4PO3HEAGlyQipKQaGKfKK/03/7V5udOEY+uUMtPs
	Lao/arRJnO0K7s86JX2trC1x64aaB5MKQmflRHm2OekI/8hfYvsrJSx1BfPXxW6/RO9OWiZ7
	dpeWbx3785rvscm7TtzN/5d3qLAnJTo/oryYT3LOP48gqz+9k2NWSCdGePUFpX8U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268132>

This change wouldn't be worth it by itself, but in a moment we will
use the strbuf for more string juggling.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 09d753f..2ef1c5e 100644
--- a/refs.c
+++ b/refs.c
@@ -892,9 +892,8 @@ static int is_refname_available(const char *refname,
 				struct ref_dir *dir)
 {
 	const char *slash;
-	size_t len;
 	int pos;
-	char *dirname;
+	struct strbuf dirname = STRBUF_INIT;
 
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		/*
@@ -942,11 +941,10 @@ static int is_refname_available(const char *refname,
 	 * We are at the leaf of our refname; we want to
 	 * make sure there are no directories which match it.
 	 */
-	len = strlen(refname);
-	dirname = xmallocz(len + 1);
-	sprintf(dirname, "%s/", refname);
-	pos = search_ref_dir(dir, dirname, len + 1);
-	free(dirname);
+	strbuf_addstr(&dirname, refname);
+	strbuf_addch(&dirname, '/');
+	pos = search_ref_dir(dir, dirname.buf, dirname.len);
+	strbuf_release(&dirname);
 
 	if (pos >= 0) {
 		/*
-- 
2.1.4
