From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/24] expire_reflog(): it's not an each_ref_fn anymore
Date: Fri, 12 Dec 2014 09:56:43 +0100
Message-ID: <1418374623-5566-5-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2T-0004Db-KM
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbaLLI5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:23 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:59490 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934670AbaLLI5S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:18 -0500
X-AuditID: 1207440e-f79d26d000001b6e-31-548aadeda99e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.45.07022.DEDAA845; Fri, 12 Dec 2014 03:57:17 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nE023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:16 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqPtubVeIwVtFi64r3UwWDb1XmC3e
	3lzCaHF7xXxmi96+T6wWmze3sziwefx9/4HJY+esu+weCzaVely8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGgRMLmQuaBStetFk0MN7n7WLk5JAQMJFoXPyPBcIWk7hwbz1bFyMXh5DAZUaJ
	K1PnMkM4x5gkNjdOZAWpYhPQlVjU08wEYosIqElMbDsE1s0scIJRYnZDCIgtLOAl0XBqOjOI
	zSKgKnH2yFIwm1fAWeLV1zfsXYwcQNvkJLau8wYJcwq4SFxseQI2RgioZOuKTtYJjLwLGBlW
	Mcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoSEFd8Oxvb1MocYBTgYlXh4JyR3
	hQixJpYVV+YeYpTkYFIS5f0+GSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdvFFCONyWxsiq1
	KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBe3QNUKNgUWp6akVaZk4JQpqJgxNk
	OJeUSHFqXkpqUWJpSUY8KC7ii4GRAZLiAdrLthZkb3FBYi5QFKL1FKOilDjvaZC5AiCJjNI8
	uLGwZPGKURzoS2HeMyBVPMBEA9f9CmgwE9Dg5Vs6QAaXJCKkpBoY8x2q9Cdonfl6anH6pk6R
	dYZNV2rS01kfpDV1rjvldG2J+IIKC6F4b5XX83fbCM0W3ni7/7L26byPv8u/GiwzOH34wZmY
	JNG7fIeT9m6Pyflz7ZXisoD8Nz0luQG9EYuEp3144PU1Otr6W8OKuQ/f3l//o2xJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261321>

Prior to v1.5.4~14, expire_reflog() had to be an each_ref_fn because
it was passed to for_each_reflog(). Since then, there has been no
reason for it to implement the each_ref_fn interface. So...

* Remove the "unused" parameter (which took the place of "flags", but
  was really unused).

* Declare the last parameter to be (struct cmd_reflog_expire_cb *)
  rather than (void *).

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2d85d26..160541a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -349,9 +349,9 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
-static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+static int expire_reflog(const char *ref, const unsigned char *sha1,
+			 struct cmd_reflog_expire_cb *cmd)
 {
-	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
 	char *log_file, *newlog_path = NULL;
@@ -663,7 +663,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
-			status |= expire_reflog(e->reflog, e->sha1, 0, &cb);
+			status |= expire_reflog(e->reflog, e->sha1, &cb);
 			free(e);
 		}
 		free(collected.e);
@@ -677,7 +677,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb, explicit_expiry, ref);
-		status |= expire_reflog(ref, sha1, 0, &cb);
+		status |= expire_reflog(ref, sha1, &cb);
 	}
 	return status;
 }
@@ -748,7 +748,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.expire_total = 0;
 		}
 
-		status |= expire_reflog(ref, sha1, 0, &cb);
+		status |= expire_reflog(ref, sha1, &cb);
 		free(ref);
 	}
 	return status;
-- 
2.1.3
