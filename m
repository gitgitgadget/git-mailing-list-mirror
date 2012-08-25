From: mhagger@alum.mit.edu
Subject: [PATCH v2 05/17] Do not check the same head_pos twice
Date: Sat, 25 Aug 2012 08:44:15 +0200
Message-ID: <1345877067-11841-6-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5AEH-0001gP-QO
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab2HYGwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:52:14 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:59079 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586Ab2HYGwM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:52:12 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2012 02:52:11 EDT
X-AuditID: 12074413-b7f786d0000008bb-67-50387474e755
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.6A.02235.47478305; Sat, 25 Aug 2012 02:45:08 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSg011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:07 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqFtSYhFgsPKpqUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M741TmEvWM9esaX1A0sD40PWLkYODgkBE4nj82q6GDmBTDGJC/fWs3UxcnEICVxmlPg/
	eROUc5ZJYsmrAywgVWwCUhIvG3vYQWwRATWJiW2HWECKmAW6GCWWr/vFBjJVWMBO4tpMH5Aa
	FgFViZ8r7jGB2LwCLhKznjWwQ2xTlPjxfQ0ziM0p4Cox4ddFsLgQUE3TsSssExh5FzAyrGKU
	S8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICSjhHYy7TsodYhTgYFTi4b1xxjxA
	iDWxrLgy9xCjJAeTkiivWKFFgBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3u8MQDnelMTKqtSi
	fJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvbTFQo2BRanpqRVpmTglCmomDE0Rw
	gWzgAdqQDFLIW1yQmFucmQ5RdIpRUUqc1wAkIQCSyCjNgxsAi/1XjOJA/wjzziwCquIBpg24
	7ldAg5mABpe7moMMLklESEk1MMrZyccc3tXVdFxK9Ow+26UOdnKPiiozu24UBFguFjZf3Fs6
	V2T97A8FEwpnzLLPal7HcOaHRfQeHT2z/zxuLIVtk/Q713xV+STL8sP+7lmNPyFOrintf1xY
	Fm2d3/fq8vKr7O/07nnOFhAUiw305l4a9+1WyoJwF0vZlfL/nkXqP1/+r/KyvRJL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204263>

From: Michael Haggerty <mhagger@alum.mit.edu>

Once a match has been found at head_pos, the entry is zeroed and no
future attempts will match that entry.  So increment head_pos to avoid
checking against the zeroed-out entry during the next iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 76288a2..bda3c0c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -561,8 +561,8 @@ static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					heads[head_pos][0] = '\0';
 					return_refs[head_pos] = ref;
+					heads[head_pos++][0] = '\0';
 					break;
 				}
 				else /* might have it; keep looking */
-- 
1.7.11.3
