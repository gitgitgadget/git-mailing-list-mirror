From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/18] is_refname_available(): avoid shadowing "dir" variable
Date: Fri,  1 May 2015 14:25:43 +0200
Message-ID: <1430483158-14349-4-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1c-0000zA-9p
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbbEAM02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:28 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54454 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753738AbbEAM0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:24 -0400
X-AuditID: 12074412-f79e46d0000036b4-68-554370e59f21
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C4.9C.14004.5E073455; Fri,  1 May 2015 08:26:13 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zg004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:12 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqPu0wDnU4Mc5M4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ2x/dJupYB57xbQjh5gaGB+zdjFyckgImEgsaXwHZYtJXLi3nq2LkYtDSOAyo8T7998Y
	IZwTTBLb199mBKliE9CVWNTTzARiiwioSUxsO8QCUsQs0MEocWH5NnaQhLCAr8TbLTvAxrII
	qEq8nL2TDcTmFXCR+Le1kQlinZzE+eM/mbsYOTg4BVwlvkxNBAkLAZXc//6VbQIj7wJGhlWM
	cok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYISEltINx/Um5Q4wCHIxKPLwbjjmF
	CrEmlhVX5h5ilORgUhLltU1wDhXiS8pPqcxILM6ILyrNSS0+xCjBwawkwntPHSjHm5JYWZVa
	lA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTBm5gP1ChYlJqeWpGWmVOCkGbi4AQZ
	ziUlUpyal5JalFhakhEPio34YmB0gKR4gPa+zQPZW1yQmAsUhWg9xajLcWfK/0VMQix5+Xmp
	UuK8PSA7BECKMkrz4FbAEsgrRnGgj4V5j4NU8QCTD9ykV0BLmICWnL/lALKkJBEhJdXAmKka
	LbpgqolA8I9Hf/pXm9kfqrk3OyDg4ZxXX242z550bmnJuaLUjnMX+CoET3Np/nHZvJt1X/kW
	7UOsPPnWvaJrdB6Urf3sc+XPnAm3/py6OHViybc9/NrTVnJzXNkbpM7+pj9U67k0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268121>

The function had a "dir" parameter that was shadowed by a local "dir"
variable within a code block. Use the former in place of the latter.
(This is consistent with "dir"'s use elsewhere in the function.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ab438a5..09d753f 100644
--- a/refs.c
+++ b/refs.c
@@ -954,10 +954,10 @@ static int is_refname_available(const char *refname,
 		 * problem iff it contains any ref that is not
 		 * in "skip".
 		 */
-		struct ref_entry *entry = dir->entries[pos];
-		struct ref_dir *dir = get_ref_dir(entry);
 		struct nonmatching_ref_data data;
+		struct ref_entry *entry = dir->entries[pos];
 
+		dir = get_ref_dir(entry);
 		data.skip = skip;
 		sort_ref_dir(dir);
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
-- 
2.1.4
