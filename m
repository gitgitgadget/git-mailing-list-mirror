From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/23] expire_reflog(): move dry_run to flags argument
Date: Fri,  5 Dec 2014 00:08:23 +0100
Message-ID: <1417734515-11812-12-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfdf-00078T-2T
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377AbaLDXQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:16:43 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52156 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933153AbaLDXQm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:16:42 -0500
X-AuditID: 12074412-f79e46d0000036b4-a3-5480e9896c94
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B0.92.14004.989E0845; Thu,  4 Dec 2014 18:08:57 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de8027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:56 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNv5siHEYPcsQYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xtaTS1gLZglX7Lu+gK2BcT9/FyMHh4SAicStGVJdjJxAppjEhXvr2UBsIYHL
	jBI3z5d1MXIB2ceYJE5NmsUEkmAT0JVY1NMMZosIqEnMXDWbDaSIWeAEo8Svyd2MIAlhATeJ
	7nedzCA2i4CqxIzr18AaeAVcJRr/HWSCWCwnsXWdN0iYEyg8dWYrI8RiF4lnmxayT2DkXcDI
	sIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJLCEdjCuPyl3iFGAg1GJh7dw
	d32IEGtiWXFl7iFGSQ4mJVHes08bQoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8BofAcrxpiRW
	VqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwcr0AahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxUV8MTAyQFI8QHvLQNp5iwsSc4GiEK2nGBWlxHnrQRICIImM
	0jy4sbB08YpRHOhLYd5SkCoeYKqB634FNJgJaPDZhlqQwSWJCCmpBkbz+K3GR1dzHZEsO63i
	fC3rwutvhYcNharvL77kY3A9nNHJTnwrGzvf2dy927nmK+U6qMr0C/1t1T0b66yjEMQucPq6
	CrvZfO6Fb+//KNBY6ld44FzaGu/bzcvutAuuqz1wdKvta5vOkxcLdLNCN/rr1jy8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260832>

The policy objects don't care about "--dry-run". So move it to
expire_reflog()'s flags parameter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 319f0d2..a490193 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -22,7 +22,6 @@ static unsigned long default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
-	int dry_run;
 	int stalefix;
 	int rewrite;
 	int updateref;
@@ -415,6 +414,10 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
 
 static struct lock_file reflog_lock;
 
+enum expire_reflog_flags {
+	EXPIRE_REFLOGS_DRY_RUN = 1 << 0
+};
+
 static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 unsigned int flags, void *cb_data)
 {
@@ -439,7 +442,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	}
 
 	log_file = git_pathdup("logs/%s", refname);
-	if (!cmd->dry_run) {
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
 			goto failure;
 		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
@@ -453,7 +456,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
 	reflog_expiry_cleanup(&cb);
 
-	if (cb.newlog) {
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("Couldn't write %s: %s", log_file,
 					strerror(errno));
@@ -644,7 +647,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			cb.dry_run = 1;
+			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (starts_with(arg, "--expire=")) {
 			if (parse_expiry_date(arg + 9, &cb.expire_total))
 				die(_("'%s' is not a valid timestamp"), arg);
@@ -738,7 +741,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
-			cb.dry_run = 1;
+			flags |= EXPIRE_REFLOGS_DRY_RUN;
 		else if (!strcmp(arg, "--rewrite"))
 			cb.rewrite = 1;
 		else if (!strcmp(arg, "--updateref"))
-- 
2.1.3
