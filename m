From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] update_info_file(): use fdopen_with_retry()
Date: Thu,  5 Mar 2015 17:07:48 +0100
Message-ID: <1425571669-22800-5-git-send-email-mhagger@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYJm-0001QX-PI
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933016AbbCEQIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:08:05 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59978 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933000AbbCEQIC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:08:02 -0500
X-AuditID: 1207440d-f79976d000005643-c5-54f87f61538d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 70.8E.22083.16F78F45; Thu,  5 Mar 2015 11:08:01 -0500 (EST)
Received: from michael.fritz.box (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25G7s7i031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 11:08:00 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqJtY/yPEYNNjPouuK91MFg29V5gt
	3t5cwmhxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M7b0Khb0
	slQs//OVtYFxEXMXIyeHhICJxOapS9ggbDGJC/fWA9lcHEIClxklbm1cBuUcZ5J4NnEpWAeb
	gK7Eop5mJhBbREBNYmLbIRYQm1kgX+L77hNgcWEBB4kZPyYwgtgsAqoSW6acZAexeQVcJA5d
	3cQKsU1O4vzxn2AzOQVcJaZduQVWIwRUM+/fUtYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn
	5uWlFuka6eVmluilppRuYoSED+8Oxv/rZA4xCnAwKvHwftj8PUSINbGsuDL3EKMkB5OSKO+P
	qh8hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4r0QC5XhTEiurUovyYVLSHCxK4rxqS9T9hATS
	E0tSs1NTC1KLYLIyHBxKErx7aoEaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGR
	EV8MjA2QFA/Q3kN1IHuLCxJzgaIQracYdTkWtO+fySTEkpeflyolzqsIUiQAUpRRmge3ApYs
	XjGKA30szLsepIoHmGjgJr0CWsIEtERLDGxJSSJCSqqBsaWW74amc5nWpxTD7j/ea+x43wrG
	8yotzfvi/HDK7X+5+wzsVYq3bp88Ub75+8sZ+Z6ZjpmuvvOreKOePhJ6nLmre+H3viezDDYn
	/12R1sx2YepdpuNMt5JOezb0NH0zf2DXJ9yt8CRT7rHJN9GDXQflQr+cT63Yba99 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264845>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 server-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server-info.c b/server-info.c
index 34b0253..8c6f662 100644
--- a/server-info.c
+++ b/server-info.c
@@ -20,7 +20,7 @@ static int update_info_file(char *path, int (*generate)(FILE *))
 	fd = git_mkstemp_mode(tmp, 0666);
 	if (fd < 0)
 		goto out;
-	fp = fdopen(fd, "w");
+	fp = fdopen_with_retry(fd, "w");
 	if (!fp)
 		goto out;
 	ret = generate(fp);
-- 
2.1.4
