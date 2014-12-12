From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/24] expire_reflog(): move updateref to flags argument
Date: Fri, 12 Dec 2014 09:56:51 +0100
Message-ID: <1418374623-5566-13-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2b-0004NQ-V1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbaLLI5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:30 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59926 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964914AbaLLI53 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:29 -0500
X-AuditID: 12074414-f797f6d000004084-ba-548aadf82a37
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 32.13.16516.8FDAA845; Fri, 12 Dec 2014 03:57:28 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nM023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:27 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqPtjbVeIwac10hZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujPOXL7IUnBCuWPp3GXsD4z3+LkZODgkBE4k9Gw+zQdhiEhfurQeyuTiEBC4z
	Sqz/+48RwjnGJPFu/kNmkCo2AV2JRT3NTCC2iICaxMS2QywgNrPACUaJ2Q0hXYwcHMIC3hJH
	toeAhFkEVCXWnegDK+cVcJE4u6qBEaREQkBOYus6b5AwJ1D4YssTsClCAs4SW1d0sk5g5F3A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIySwRHYwHjkpd4hRgINRiYf3
	RWpXiBBrYllxZe4hRkkOJiVR3u+TgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeP9GAeV4UxIr
	q1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4j64BahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxUV8MTAyQFI8QHvZ1oLsLS5IzAWKQrSeYlSUEuc9DTJXACSR
	UZoHNxaWLl4xigN9KczrCFLFA0w1cN2vgAYzAQ1evqUDZHBJIkJKqoFxMu/kT/P8RXR4XPw9
	5ywt27Jikfj+HoYlt/UZJ+04EnNdJN22XjlK+8r2TgNxzV+MNXpnzyWsT9Ey0WHLU711Kr5s
	6cZncSf6etQf7djeuqTEMIZt6sajVpFVW+v0xbrEzCXPOSWbqMYveWD5K/nSPb15 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261326>

The policy objects don't care about "--updateref". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 2f21735..e238fe0 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -21,14 +21,14 @@ static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
 
 enum expire_reflog_flags {
-	EXPIRE_REFLOGS_DRY_RUN = 1 << 0
+	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
+	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1
 };
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
 	int rewrite;
-	int updateref;
 	int verbose;
 	unsigned long expire_total;
 	unsigned long expire_unreachable;
@@ -474,7 +474,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
-		} else if (cmd->updateref &&
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lock_fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
@@ -485,7 +485,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to commit reflog '%s' (%s)",
 					log_file, strerror(errno));
-		} else if (cmd->updateref && commit_ref(lock)) {
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
 			status |= error("couldn't set %s", lock->ref_name);
 		}
 	}
@@ -677,7 +677,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
 		else if (!strcmp(arg, "--updateref"))
-			cb.updateref = 1;
+			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
 		else if (!strcmp(arg, "--verbose"))
@@ -759,7 +759,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
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
