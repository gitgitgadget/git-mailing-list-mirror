From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/17] safe_create_leading_directories(): reduce scope of local variable
Date: Mon,  6 Jan 2014 14:45:20 +0100
Message-ID: <1389015935-21936-3-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVc-0005p1-SE
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbaAFNqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:20 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45645 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753292AbaAFNqO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:14 -0500
X-AuditID: 1207440f-b7f306d000006d99-c1-52cab3a6a76b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.D2.28057.6A3BAC25; Mon,  6 Jan 2014 08:46:14 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfP3021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:13 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqLts86kgg6fLpCy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzVrZOYC34wlKxaOlOpgbGD8xdjJwcEgImEkdOXGOBsMUkLtxbz9bFyMUhJHCZUWLd
	i7XsEM4xJonTt5oZQarYBHQlFvU0M4HYIgJqEhPbDrGAFDELLGaU6Jr2DaxIWCBa4vDtdnYQ
	m0VAVWJL/3WwOK+Ai8Tsq+eBVnAArVOQWH1dCCTMKeAqMW3aYTYQWwioZM2hRywTGHkXMDKs
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJKv4djF3rZQ4xCnAwKvHwej47
	GSTEmlhWXJl7iFGSg0lJlJdz9akgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8XAuAcrwpiZVV
	qUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCd6Xm4AaBYtS01Mr0jJzShDSTByc
	IIILZAMP0IYrIIW8xQWJucWZ6RBFpxgVpcR5BYERLCQAksgozYMbAIv/V4ziQP8I824BaecB
	pg647ldAg5mABofGgQ0uSURISTUw5mp9OJQS7b7l1g/O2weMHvPVqLuey1g5Q/ZFqsxE74gS
	ZoWLz/IaJkg0/o1fWMhtwrPs9LFtqr3s/jl+TlExzxa/cfnG9SD79uHPSy1myyUluk1m/J3T
	84z3jJLbdi/PLV2FwTLWnZxOz+6qX1wcc4c3UMD6/ve/61x+tP3eL72Q/aJKh0i7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239994>

This makes it more obvious that values of "st" don't persist across
loop iterations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index c9245a6..cc9957e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,9 +108,10 @@ int mkdir_in_gitdir(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *pos = path + offset_1st_component(path);
-	struct stat st;
 
 	while (pos) {
+		struct stat st;
+
 		pos = strchr(pos, '/');
 		if (!pos)
 			break;
-- 
1.8.5.2
