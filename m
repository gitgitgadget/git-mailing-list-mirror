From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/21] fsck_head_link(): remove unneeded flag variable
Date: Wed, 23 Mar 2016 11:04:33 +0100
Message-ID: <f569b2b9aa9a2ce2a4422ba55b0ac06753d42915.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:16:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmp-0001Ah-GC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbcCWKNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:06 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49321 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754721AbcCWKMr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:47 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:12:47 EDT
X-AuditID: 12074411-fd3ff700000071cf-0f-56f26a58d094
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A1.27.29135.85A62F65; Wed, 23 Mar 2016 06:05:12 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1L018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:11 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqBuR9SnMYMMFBYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZnbtnMRbMZquY8kW6gbGDtYuRk0NCwETi2pEfTF2MXBxCAlsZJZZP
	+w/lnGSSuLr7MwtIFZuArsSinmYmEFtEQE1iYtshFpAiZoEFjBIbFy9mBkkIC7hJTJkwAayB
	RUBVYubERYwgNq9AlMTnf0eZINYpSWx4cAHM5hSwkDh5cilYjZCAucT2B2uZJjDyLGBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokREk6COxhnnJQ7xCjAwajEw1t47mOY
	EGtiWXFl7iFGSQ4mJVHe80GfwoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8IZkAOV4UxIrq1KL
	8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK819KBGgWLUtNTK9Iyc0oQ0kwcnCDD
	uaREilPzUlKLEktLMuJBMRBfDIwCkBQP0N5IsL3FBYm5QFGI1lOMuhwLftxeyyTEkpeflyol
	zqsBUiQAUpRRmge3ApY8XjGKA30szFsPUsUDTDxwk14BLWECWrLQB2xJSSJCSqqB0XeN2KcZ
	XzVyA12vWhsmH1L3nhj4aWpwcoYhH7vaomfZ98TzFNjyPZTvqKsU9DGIdgqpW3ktLyxKevC8
	t2+peBezQ6GWhtzFSTIrC3h4vyl7TnoxwVht4u7+FgnzHXMjv0Qevp7ZL31/0489 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289629>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 55eac75..3f27456 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -493,13 +493,12 @@ static void fsck_object_dir(const char *path)
 
 static int fsck_head_link(void)
 {
-	int flag;
 	int null_is_error = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, &flag);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid.hash, NULL);
 	if (!head_points_at) {
 		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
-- 
2.8.0.rc3
