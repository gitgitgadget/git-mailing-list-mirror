From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] buffer_fdinit(): use fdopen_with_retry()
Date: Thu,  5 Mar 2015 17:07:49 +0100
Message-ID: <1425571669-22800-6-git-send-email-mhagger@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYJu-0001YC-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbbCEQIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:08:11 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60308 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932997AbbCEQIJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 11:08:09 -0500
X-AuditID: 1207440e-f79bc6d000000c43-c3-54f87f62bc61
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.A8.03139.26F78F45; Thu,  5 Mar 2015 11:08:02 -0500 (EST)
Received: from michael.fritz.box (p5DDB3EC9.dip0.t-ipconnect.de [93.219.62.201])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t25G7s7j031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 5 Mar 2015 11:08:01 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqJtU/yPE4NU0cYuuK91MFg29V5gt
	3t5cwmhxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M67PvchW
	sJ+l4uKCn4wNjLeZuxg5OCQETCT6nlt2MXICmWISF+6tZ+ti5OIQErjMKLF3wSYmkISQwHEm
	ie4z8iA2m4CuxKKeZrC4iICaxMS2QywgNrNAvsT33SfA4sICthLHXt0Ei7MIqEq8ebOeGcTm
	FXCReLvhKTvEMjmJ88d/gsU5BVwlpl25xQ6xy0Vi3r+lrBMYeRcwMqxilEvMKc3VzU3MzClO
	TdYtTk7My0st0jXWy80s0UtNKd3ECAkevh2M7etlDjEKcDAq8fB+2Pw9RIg1say4MvcQoyQH
	k5Io74+qHyFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHivRALleFMSK6tSi/JhUtIcLErivGpL
	1P2EBNITS1KzU1MLUotgsjIcHEoSvGZ1QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYml
	JRnxoLiILwZGBkiKB2gvD0g7b3FBYi5QFKL1FKMux4L2/TOZhFjy8vNSpcR5FUGKBECKMkrz
	4FbAUsUrRnGgj4V5LUCqeIBpBm7SK6AlTEBLtMTAlpQkIqSkGhhXNN5xuvQ7Zsf6OTcU3N5c
	e/f93oGHOl1B9ms/2L16uSon8kez19yU2OXurdN3+SY5BMr87jFez/hyRtqV/QuKbqttu3vB
	hcmlJLp9xXSZeKHNr4r/Je/akrBt5WPD1VxTGlxvXb1cOOWCrO2/i0bak1bN36mv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264847>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 vcs-svn/line_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 57cc1ce..10791cf 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -19,7 +19,7 @@ int buffer_init(struct line_buffer *buf, const char *filename)
 
 int buffer_fdinit(struct line_buffer *buf, int fd)
 {
-	buf->infile = fdopen(fd, "r");
+	buf->infile = fdopen_with_retry(fd, "r");
 	if (!buf->infile)
 		return -1;
 	return 0;
-- 
2.1.4
