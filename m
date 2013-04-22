From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/33] repack_without_ref(): use function get_packed_ref()
Date: Mon, 22 Apr 2013 21:52:17 +0200
Message-ID: <1366660361-21831-10-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMuy-0005r1-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab3DVUAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:00:44 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63866 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754815Ab3DVUAn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:00:43 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2013 16:00:43 EDT
X-AuditID: 1207440d-b7fd06d000000905-7c-517595449b8e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AA.0E.02309.44595715; Mon, 22 Apr 2013 15:53:40 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOM008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:39 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqOsytTTQ4Os2XYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44u/UVY8Ff1oqe3RfYGhg/
	sHQxcnJICJhIPFm0iAnCFpO4cG89WxcjF4eQwGVGif+XbkM5F5gkmhYvB+tgE9CVWNTTDNYh
	IqAmMbHtEFicWcBBYvPnRkYQW1jAV+L+pF9gNSwCqhL/L2wCs3kFXCVuL22D2qYgcXz7NrB6
	TqD46Y4TYHOEBFwkVhycyjKBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3U
	lNJNjJBg4d3B+H+dzCFGAQ5GJR5eAffSQCHWxLLiytxDjJIcTEqivBxTgEJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeEXzgXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4O
	JQneb5OBGgWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CGByCFvMUFibnFmekQRacYFaXEed0mASUE
	QBIZpXlwA2Bx/YpRHOgfYV4+kON5gCkBrvsV0GAmoMGZCSUgg0sSEVJSDYwtCV8qb5oEBm7p
	fD25803K/DnCQh+4goXqxd7FXFTQ655ct7TAgaHuhyVPu6x4zYZ1/7YmBx0IuWbovd5m5or0
	N4e9GNlFvE7w5qRaNfg7Xj+ldHsF2+V8zf//1K9KFvQpTjvr5X8mXHOPoxRrmPd3obrFUQae
	6UKXX2jpqluvS5wnfrr2vBJLcUaioRZzUXEiAPnDDzjGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222071>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 09b68e4..1c8edb1 100644
--- a/refs.c
+++ b/refs.c
@@ -1820,9 +1820,11 @@ static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
 	struct ref_cache *refs = get_ref_cache(NULL);
-	struct ref_dir *packed = get_packed_refs(refs);
-	if (find_ref(packed, refname) == NULL)
-		return 0;
+	struct ref_dir *packed;
+
+	if (!get_packed_ref(refname))
+		return 0; /* refname does not exist in packed refs */
+
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
 	if (data.fd < 0) {
-- 
1.8.2.1
