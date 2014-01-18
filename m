From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/17] safe_create_leading_directories(): fix format of "if" chaining
Date: Sat, 18 Jan 2014 23:48:45 +0100
Message-ID: <1390085341-2553-2-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:49:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ei0-00054S-MQ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbaARWtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:32 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52574 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696AbaARWta (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:30 -0500
X-AuditID: 12074412-b7fc96d0000023d5-61-52db04fa4128
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 15.87.09173.AF40BD25; Sat, 18 Jan 2014 17:49:30 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8s030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:29 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqPuL5XaQwamfzBZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ2xffUK1oKtbBVHuu8yNTA+
	Y+li5OSQEDCReLz0GBuELSZx4d56IJuLQ0jgMqPEkeuTWSCcE0wSRx9dYwKpYhPQlVjU0wxm
	iwioSUxsOwQ2iVnAQWLz50ZGEFtYIEJi1pzJrCA2i4CqxMq242AbeAWcJd59fszexcgBtE1B
	YvV1IZAwp4CLxJH5F8BGCgGV3Hz9hH0CI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpm
	ermZJXqpKaWbGCGhIrSDcf1JuUOMAhyMSjy8B5huBwmxJpYVV+YeYpTkYFIS5VUGCfEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhDd5wK0iINyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampB
	ahFMVoaDQ0mCVwAYE0KCRanpqRVpmTklCGkmDk4QwQWygQdogyRIIW9xQWJucWY6RNEpRkUp
	cV55kIQASCKjNA9uACyqXzGKA/0jzHufGaiKB5gQ4LpfAQ1mAhosEnsTZHBJIkJKqoHx4LN7
	AvKsbXY7dWJrvn6sUc4pXi+1OfvJsZxdLlY5Zvvm/Lsl1uum8Nuruyx4d6rw66n7c3k/e4lN
	XlTzqPWfVvnVXwG+sw+YvnFpkugIPLCuc1nUfNs999SzfV8/CLe0q46pE2Hb66y6JcpKZsLc
	jRc+RuuLKNe9qc4MMVPedsWqgPe57FMlluKMREMt5qLiRACJXrJcxQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240653>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e13bd2c..8031d51 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -125,8 +125,7 @@ int safe_create_leading_directories(char *path)
 				*pos = '/';
 				return -3;
 			}
-		}
-		else if (mkdir(path, 0777)) {
+		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
@@ -134,8 +133,7 @@ int safe_create_leading_directories(char *path)
 				*pos = '/';
 				return -1;
 			}
-		}
-		else if (adjust_shared_perm(path)) {
+		} else if (adjust_shared_perm(path)) {
 			*pos = '/';
 			return -2;
 		}
-- 
1.8.5.2
