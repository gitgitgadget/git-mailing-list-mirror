From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/23] expire_reflog(): move updateref to flags argument
Date: Fri,  5 Dec 2014 00:08:24 +0100
Message-ID: <1417734515-11812-13-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWF-0002vY-JY
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbaLDXJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:01 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44999 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847AbaLDXI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:59 -0500
X-AuditID: 1207440f-f792a6d000001284-de-5480e98a52ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id AD.89.04740.A89E0845; Thu,  4 Dec 2014 18:08:58 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de9027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:57 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqNv1siHE4MlhJYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xuWL05kLnglX7P1+g7mB8TN/FyMnh4SAicTfRQfYIGwxiQv31gPZXBxCApcZ
	JZo3PmGGcI4xScxt7WYBqWIT0JVY1NPMBGKLCKhJzFw1G6yDWeAEo8Svyd2MIAlhAQ+JOzee
	go1lEVCVaN+3EKiBg4NXwFVi6nVpEFNCQE5i6zpvkApOkOjMVrBOIQEXiWebFrJPYORdwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMktPh3MHatlznEKMDBqMTDW7C7
	PkSINbGsuDL3EKMkB5OSKO/Zpw0hQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4jY8A5XhTEiur
	UovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErylL4AaBYtS01Mr0jJzShDSTByc
	IMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3jKQdt7igsRcoChE6ylGRSlxXmuQhABIIqM0
	D24sLGG8YhQH+lKY1xKkigeYbOC6XwENZgIafLahFmRwSSJCSqqBcfrhZf7yX/R5Nym9rF9y
	M9J+yZI9+99vzjhhGWyXI/9rpdGLhR/L614u7FkVWftpyqKQCZcPJ9+Xil62WW7XrfutfD3L
	Td4E3ZSa75aXfNLrsAdTkLXSwrr+/MCJK7ddbjRIPK/gt2OjX9SbuLtVgRaXa1Se 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260816>

The policy objects don't care about "--updateref". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index a490193..597c547 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -24,7 +24,6 @@ struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
 	int rewrite;
-	int updateref;
 	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
@@ -415,7 +414,8 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
 static struct lock_file reflog_lock;
 
 enum expire_reflog_flags {
-	EXPIRE_REFLOGS_DRY_RUN = 1 << 0
+	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
+	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1
 };
 
 static int expire_reflog(const char *refname, const unsigned char *sha1,
@@ -460,7 +460,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("Couldn't write %s: %s", log_file,
 					strerror(errno));
-		} else if (cmd->updateref &&
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
@@ -471,7 +471,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("cannot rename %s.lock to %s",
 					log_file, log_file);
-		} else if (cmd->updateref && commit_ref(lock)) {
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
 			status |= error("Couldn't set %s", lock->ref_name);
 		}
 	}
@@ -663,7 +663,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
 		else if (!strcmp(arg, "--updateref"))
-			cb.updateref = 1;
+			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
 		else if (!strcmp(arg, "--verbose"))
@@ -745,7 +745,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
 		else if (!strcmp(arg, "--updateref"))
-			cb.updateref = 1;
+			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--verbose"))
 			cb.verbose = 1;
 		else if (!strcmp(arg, "--")) {
-- 
2.1.3
