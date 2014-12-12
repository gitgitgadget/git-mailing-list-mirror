From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/24] refs.c: let fprintf handle the formatting
Date: Fri, 12 Dec 2014 09:57:03 +0100
Message-ID: <1418374623-5566-25-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2q-0004eU-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965391AbaLLI5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:47 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43826 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934127AbaLLI5o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:44 -0500
X-AuditID: 1207440f-f792a6d000001284-37-548aae083d86
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DF.47.04740.80EAA845; Fri, 12 Dec 2014 03:57:44 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nY023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:43 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqMuxrivE4HebskXXlW4mi4beK8wW
	b28uYbS4vWI+s0Vv3ydWi82b21kc2Dz+vv/A5LFz1l12jwWbSj0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE7Y97sPuaCP+wVF58vZW9gXMbWxcjJISFgItE/8TILhC0mceHeeqA4F4eQwGVG
	ibmNH1khnGNMEmeuvwGrYhPQlVjU08wEYosIqElMbDsEFmcWOMEoMbshBMQWFnCWOLL/KFic
	RUBV4ua8x2DbeAVcJLZ9OgAU5wDaJiexdZ03SJgTKHyx5QlYuRBQ69YVnawTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJLf4djF3rZQ4xCnAwKvHwvkjtChFi
	TSwrrsw9xCjJwaQkyvt9MlCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO/fKKAcb0piZVVqUT5M
	SpqDRUmcV32Jup+QQHpiSWp2ampBahFMVoaDQ0mCN24NUKNgUWp6akVaZk4JQpqJgxNkOJeU
	SHFqXkpqUWJpSUY8KDLii4GxAZLiAdrLthZkb3FBYi5QFKL1FKOilDhvK8hcAZBERmke3FhY
	wnjFKA70pTBvHUgVDzDZwHW/AhrMBDR4+ZYOkMEliQgpqQZG9if8UULbvh26KW2i/35xto+/
	6pnNWy55abJELDzvqO1wKqUqmcMmX+TkJ6vsr4wSTNY3PYUCU8KvJJZZ3WT9MDlvoue/vNpo
	zvPnfm7/eWd9exZfxULjJIbwNUseOByPYFM58KDlGd+F7yYP1pQvjXgUHxAn9/hM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261330>

From: Stefan Beller <sbeller@google.com>

Instead of calculating whether to put a plus or minus sign, offload
the responsibilty to the fprintf function.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 582a051..9e6d21c 100644
--- a/refs.c
+++ b/refs.c
@@ -3972,12 +3972,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 			printf("prune %s", message);
 	} else {
 		if (cb->newlog) {
-			char sign = (tz < 0) ? '-' : '+';
-			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
 				sha1_to_hex(osha1), sha1_to_hex(nsha1),
-				email, timestamp, sign, zone,
-				message);
+				email, timestamp, tz, message);
 			hashcpy(cb->last_kept_sha1, nsha1);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-- 
2.1.3
