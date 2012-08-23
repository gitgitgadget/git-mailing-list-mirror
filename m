From: mhagger@alum.mit.edu
Subject: [PATCH 05/17] Do not check the same match_pos twice
Date: Thu, 23 Aug 2012 10:10:30 +0200
Message-ID: <1345709442-16046-6-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ScZ-0008SD-TL
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705Ab2HWISZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:25 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:60149 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933671Ab2HWIST (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:19 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:18 EDT
X-AuditID: 12074414-b7f846d0000008b8-90-5035e5a2e6fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F8.52.02232.2A5E5305; Thu, 23 Aug 2012 04:11:14 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV5030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:12 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLvoqWmAwb8WIYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xueHp1kK
	trBXtO/byNTA+Iy1i5GTQ0LARGLRtW52CFtM4sK99WxdjFwcQgKXGSUOv/jLBOGcZZJ49P4Q
	E0gVm4CUxMvGHrAOEQE1iYlth1hAbGaBFImO592MILawgI3Ez2krmUFsFgFVid6H79lAbF4B
	F4k9Z7dAbVaU+PF9DVgNp4CrxILvm8B6hYBqPjbeZJ7AyLuAkWEVo1xiTmmubm5iZk5xarJu
	cXJiXl5qka6FXm5miV5qSukmRkgAiexgPHJS7hCjAAejEg/vC3PTACHWxLLiytxDjJIcTEqi
	vP8eAYX4kvJTKjMSizPii0pzUosPMUpwMCuJ8IbPA8rxpiRWVqUW5cOkpDlYlMR5vy1W9xMS
	SE8sSc1OTS1ILYLJynBwKEnwhgIjRUiwKDU9tSItM6cEIc3EwQkiuEA28ABtUAQp5C0uSMwt
	zkyHKDrFqCglzmsCkhAASWSU5sENgMX6K0ZxoH+Eed1BqniAaQKu+xXQYCagwWpXjUEGlyQi
	pKQaGLN9i23crHUDZnvYnOo+rH1H4d11xZ0HeA0N/np9FdT56DVpmWXZgfoc2wQn7TKBaWIm
	OyZkXXnhvG7DiVDzCb9/P7P5yRy3ZUt91rfq6EfmGdfstsxv/ntV7Omvx18Y1pyeVD0jLmAS
	xzPxXINVxj9WnrQ4Ih97d+lk9+y3urMvxjZnqpaJT1ViKc5INNRiLipOBACO9kTX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204121>

From: Michael Haggerty <mhagger@alum.mit.edu>

Once a match has been found at match_pos, the entry is zeroed and no
future attempts will match that entry.  So increment match_pos to
avoid checking against the zeroed-out entry during the next iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f11545e..a6406e7 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -561,8 +561,8 @@ static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					heads[match_pos][0] = '\0';
 					return_refs[match_pos] = ref;
+					heads[match_pos++][0] = '\0';
 					break;
 				}
 				else /* might have it; keep looking */
-- 
1.7.11.3
