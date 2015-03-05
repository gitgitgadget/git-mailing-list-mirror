From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] copy_to_log(): use fdopen_with_retry()
Date: Thu,  5 Mar 2015 17:07:47 +0100
Message-ID: <1425571669-22800-4-git-send-email-mhagger@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYQy-0000e4-0h
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbbCEQPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:15:31 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:65450 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932552AbbCEQPa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:15:30 -0500
X-AuditID: 1207440c-f79376d00000680a-7d-54f87f5f207e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.51.26634.F5F78F45; Thu,  5 Mar 2015 11:08:00 -0500 (EST)
Received: from michael.fritz.box (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25G7s7h031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 11:07:59 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqJtQ/yPE4E0rs0XXlW4mi4beK8wW
	b28uYbS4vWI+swOLx9/3H5g8ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGas/nWct
	6GSpaFq3la2BcTpzFyMnh4SAicS7u71MELaYxIV769m6GLk4hAQuM0qcvDqTGcI5ziTx91gz
	G0gVm4CuxKKeZrAOEQE1iYlth1hAbGaBfInvu0+AxYUFrCVOz/nJDmKzCKhK/FlwD8jm4OAV
	cJH4/dYFYpmcxPnjP8GO4BRwlZh25RZYuRBQybx/S1knMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRrqJebWaKXmlK6iRESPjw7GL+tkznEKMDBqMTDO2Pj9xAh1sSy4srcQ4ySHExK
	orw/qn6ECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhvRIJlONNSaysSi3Kh0lJc7AoifOqLlH3
	ExJITyxJzU5NLUgtgsnKcHAoSfCa1QE1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZk
	xIMiI74YGBsgKR6gva4g7bzFBYm5QFGI1lOMuhwL2vfPZBJiycvPS5US51UEKRIAKcoozYNb
	AUsWrxjFgT4W5i0EqeIBJhq4Sa+AljABLdESA1tSkoiQkmpglN70eo7D8SZ3GZV5O2ZfnK6d
	c2967uzTG5Im/Gf82OStlc11lemPxj2b7o4V5UWnt4a/6THhavO7cHjftUlJsslsG89LGx5j
	45nvk7P1O9c1v+0HfdbGXT8wITDKxVvvYsrf0OrZHw89u/vYft+PTcmu6b1729Mt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264849>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index c3edd96..1d76ccf 100644
--- a/daemon.c
+++ b/daemon.c
@@ -421,8 +421,8 @@ static void copy_to_log(int fd)
 	struct strbuf line = STRBUF_INIT;
 	FILE *fp;
 
-	fp = fdopen(fd, "r");
-	if (fp == NULL) {
+	fp = fdopen_with_retry(fd, "r");
+	if (!fp) {
 		logerror("fdopen of error channel failed");
 		close(fd);
 		return;
-- 
2.1.4
