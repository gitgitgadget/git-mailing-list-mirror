From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/33] do_for_each_ref_in_dirs(): remove dead code
Date: Mon, 22 Apr 2013 21:52:14 +0200
Message-ID: <1366660361-21831-7-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoq-0005rg-36
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab3DVTyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:23 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53458 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755086Ab3DVTxh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:37 -0400
X-AuditID: 1207440f-b7f0e6d000000957-87-517595408e1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A7.0D.02391.04595715; Mon, 22 Apr 2013 15:53:36 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOJ008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:35 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqOswtTTQYPFCYYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y2+1QsJq14sr+XqYGxjaW
	LkYODgkBE4lnS0W6GDmBTDGJC/fWs3UxcnEICVxmlHh6vZcRwrnAJHHl9Ac2kCo2AV2JRT3N
	TCC2iICaxMS2QywgNrOAg8Tmz42MILawgKvEgT1LWEFsFgFViZdrzoPZvAIuEn0v7zBBbFOQ
	OL59G1g9J1D96Y4TYHOEgGpWHJzKMoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO9
	3MwSvdSU0k2MkEDh38HYtV7mEKMAB6MSD2+GZ2mgEGtiWXFl7iFGSQ4mJVFejilAIb6k/JTK
	jMTijPii0pzU4kOMEhzMSiK8ovlAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQi
	mKwMB4eSBG8GyFDBotT01Iq0zJwShDQTByeI4ALZwAO0IRKkkLe4IDG3ODMdougUo6KUOK/b
	JKCEAEgiozQPbgAspl8xigP9I8zrAdLOA0wHcN2vgAYzAQ3OTCgBGVySiJCSamAs4pvty3Ca
	6aDoRBkR0fhOVZlpjJ7TP3k+edDttXbp8d2v/y1/WiY7fYGb28Kipb5p0XNsWUS/sh6V4vx3
	QZaVPfSauNna60rLZmnt17PvsmpeNqWO4c29Ffcr7suq8R28dqV1ZsuSk6sW+cq4NNWJrnNm
	iXlRVtWwhP9m8/Rv9vaeTd93eDcqsRRnJBpqMRcVJwIAAIhwTcQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222068>

There is no way to drop out of the while loop.  This code has been
dead since 432ad41e.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/refs.c b/refs.c
index e1e9ddd..7260768 100644
--- a/refs.c
+++ b/refs.c
@@ -666,13 +666,6 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 		if (retval)
 			return retval;
 	}
-	if (i1 < dir1->nr)
-		return do_for_each_ref_in_dir(dir1, i1,
-					      base, fn, trim, flags, cb_data);
-	if (i2 < dir2->nr)
-		return do_for_each_ref_in_dir(dir2, i2,
-					      base, fn, trim, flags, cb_data);
-	return 0;
 }
 
 /*
-- 
1.8.2.1
