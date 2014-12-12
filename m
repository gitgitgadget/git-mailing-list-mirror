From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/24] expire_reflog(): add a "flags" argument
Date: Fri, 12 Dec 2014 09:56:49 +0100
Message-ID: <1418374623-5566-11-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM39-00052F-6l
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbaLLI5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:30 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47533 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964947AbaLLI50 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:26 -0500
X-AuditID: 12074412-f79e46d0000036b4-32-548aadf53188
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 74.5F.14004.5FDAA845; Fri, 12 Dec 2014 03:57:25 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nK023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:24 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqPt1bVeIweEuM4uuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xvrnlxgLOoUrtk54x9TAuIy/i5GTQ0LAROLJyVmMELaYxIV769m6GLk4hAQu
	M0pM3X+CHcI5xiSx/2QPC0gVm4CuxKKeZiYQW0RATWJi2yGwOLPACUaJ2Q0hILawgKPEp7/7
	2EBsFgFVifcbdzCD2LwCLhJz+qcDbeMA2iYnsXWdN0iYEyh8seUJ2BghAWeJrSs6WScw8i5g
	ZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERJaQjsY15+UO8QowMGoxMP7
	IrUrRIg1say4MvcQoyQHk5Io7/fJQCG+pPyUyozE4oz4otKc1OJDjBIczEoivH+jgHK8KYmV
	ValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8cWuAGgWLUtNTK9Iyc0oQ0kwc
	nCDDuaREilPzUlKLEktLMuJBkRFfDIwNkBQP0N5gkHbe4oLEXKAoROspRkUpcd5WkIQASCKj
	NA9uLCxhvGIUB/pSmPcMSBUPMNnAdb8CGswENHj5lg6QwSWJCCmpBsb17+cterBP2u3IicKE
	f2c+rf2wnW9/h1/uRC9nF85S3qD7R3e2/GNjvWXMGPbPfon87neqpgtn67/5cf2JTHV3iBrb
	Fx5+ydNum+doWrm4Xcr/mReQt6vEVNg80OztrqnhXQZf3ujeuV1mXtF5e/LainPu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261335>

We want to separate the options relevant to the expiry machinery from
the options affecting the expiration policy. So add a "flags" argument
to expire_reflog() to hold the former.

The argument doesn't yet do anything.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 8db52d7..dfff5f2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -414,7 +414,7 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
 }
 
 static int expire_reflog(const char *refname, const unsigned char *sha1,
-			 struct cmd_reflog_expire_cb *cmd)
+			 unsigned int flags, struct cmd_reflog_expire_cb *cmd)
 {
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
@@ -642,6 +642,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
+	unsigned int flags = 0;
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -711,7 +712,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
-			status |= expire_reflog(e->reflog, e->sha1, &cb);
+			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
 			free(e);
 		}
 		free(collected.e);
@@ -725,7 +726,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb, explicit_expiry, ref);
-		status |= expire_reflog(ref, sha1, &cb);
+		status |= expire_reflog(ref, sha1, flags, &cb);
 	}
 	return status;
 }
@@ -744,6 +745,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cb;
 	int i, status = 0;
+	unsigned int flags = 0;
 
 	memset(&cb, 0, sizeof(cb));
 
@@ -796,7 +798,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.expire_total = 0;
 		}
 
-		status |= expire_reflog(ref, sha1, &cb);
+		status |= expire_reflog(ref, sha1, flags, &cb);
 		free(ref);
 	}
 	return status;
-- 
2.1.3
