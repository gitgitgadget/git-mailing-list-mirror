From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a
 fd
Date: Thu, 20 Nov 2014 13:58:00 -0800
Message-ID: <20141120215800.GA22370@google.com>
References: <20141120023655.GG6527@google.com>
 <1416508657-9057-1-git-send-email-sbeller@google.com>
 <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:58:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZjt-0004Ne-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbaKTV6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 16:58:04 -0500
Received: from mail-ig0-f202.google.com ([209.85.213.202]:42416 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbaKTV6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:58:03 -0500
Received: by mail-ig0-f202.google.com with SMTP id hn18so566550igb.3
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0tFVshEE6mtE8pTlEdoYIri3ynvu9xllpN9TGDH++IA=;
        b=RhmGy7Usnp85ZVt4g5F7guSdVFGUK09dDhOVrdL5pubCU/3m0y+nAOgkND5tK0KlHI
         uqLRkeNnQ7S3Q/g/uQEsKtoKprQsm0HdhUilaySH2p059CRWHYb7tDf12wKTkqc8Mtsb
         z6YOKWsNlWhZn9mRrDp5mfrqSz0MTl0mBLt9lhs8YK4NXQ/DXSQuDDpDGORdIvvAfynM
         DKnb8p7BgWdEuC75COmB4GAJH+gxXOAfyAueNnvxn2BrQeZUpjpgpn+VxzAtE2LkReEF
         OMC/0rluRcb1cMPoX/W/7GcUe29Khp+LOzQte5abbo+s3Shv/x+aC+pOxlHQI/jNWcx8
         7Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0tFVshEE6mtE8pTlEdoYIri3ynvu9xllpN9TGDH++IA=;
        b=CIQgiyE4so21mcXu6D/tN9jSDXjDzW2J4IIap0p7H5Q4Lgmn7t7j/C8Yan74kZkRmP
         lIQeSkT17yulkydlgqn1URAtWWe34Ttgt5Fp7IActKyIRUGsa6QjIss8B/EeIPGYIWVh
         GC77J28p5vkQdDIhH7DHqxFs2QbOzhpJDsCy9mW4RHH2pGsHw9h/nzWIKz0w9HmHIszX
         ALWl4f80W5frmEjjVz/Jg6/Pt/w2pUTWQ9l6ixr52LA546WqW0C4dcTz4aoiRZgGxGYY
         xpmAhW4ym73n2uohwZig4sbG/2G7dyEEHAAdY8xo1OdNnz52K/OaKK5xDK05rJGutGjT
         l/dQ==
X-Gm-Message-State: ALoCoQmHeuYR11elKwoyN1+oeg+6Ih5+j0uGY6hc4bKpOp5Mw4lCpfIuKb2FSBUYfakGyLXMe3xh
X-Received: by 10.182.33.162 with SMTP id s2mr714439obi.17.1416520682141;
        Thu, 20 Nov 2014 13:58:02 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id b3si871289qcq.2.2014.11.20.13.58.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2014 13:58:02 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id QPKHr6iC.1; Thu, 20 Nov 2014 13:58:01 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id B6C651411F5; Thu, 20 Nov 2014 13:58:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From 4bec12b878ca02a1e80af3c265e7e7ab52ba17ce Mon Sep 17 00:00:00 2001
From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 20 Nov 2014 13:48:14 -0800
Subject: [PATCH v4] refs.c: add a function to append a reflog entry to a fd

Move code to create the string for a ref and write it to a file descriptor
from log_ref_write and add it into a new dedicated function
log_ref_write_fd.

For now the new function is only used from log_ref_write, but later
on we will call this function from reflog transactions too. That means
that we will end up with only a single place, where we write a reflog
entry to a file instead of the current two places (log_ref_write and
builtin/reflog.c).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
Changes in version 3:
 * reword the commit message to make it more understandable.
 * no changes in code
 * wait for the follow up to address any changes in the code.

Changes in version 4:
 * fix arguments of sprintf, (note to self: compile testing helps)
 * break lines of commit message again to appease the taste of Jonathan ;)
 * take the simplification for
   
   result = log_ref_write_fd(...);
   
   if (result) {
       ...
       
   and omit the result variable in there to just become
    
   if (log_ref_write_fd(...)) {
       ...
   
 refs.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..a6088e3 100644
--- a/refs.c
+++ b/refs.c
@@ -2990,15 +2990,37 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	return 0;
 }
 
+static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const char *committer, const char *msg)
+{
+	int msglen, written;
+	unsigned maxlen, len;
+	char *logrec;
+
+	msglen = msg ? strlen(msg) : 0;
+	maxlen = strlen(committer) + msglen + 100;
+	logrec = xmalloc(maxlen);
+	len = sprintf(logrec, "%s %s %s\n",
+		      sha1_to_hex(old_sha1),
+		      sha1_to_hex(new_sha1),
+		      committer);
+	if (msglen)
+		len += copy_msg(logrec + len - 1, msg) - 1;
+
+	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
+	free(logrec);
+	if (written != len)
+		return -1;
+
+	return 0;
+}
+
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, written, oflags = O_APPEND | O_WRONLY;
-	unsigned maxlen, len;
-	int msglen;
+	int logfd, result, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
-	char *logrec;
-	const char *committer;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
@@ -3010,19 +3032,9 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
-	msglen = msg ? strlen(msg) : 0;
-	committer = git_committer_info(0);
-	maxlen = strlen(committer) + msglen + 100;
-	logrec = xmalloc(maxlen);
-	len = sprintf(logrec, "%s %s %s\n",
-		      sha1_to_hex(old_sha1),
-		      sha1_to_hex(new_sha1),
-		      committer);
-	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
-	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
-	free(logrec);
-	if (written != len) {
+
+	if (log_ref_write_fd(logfd, old_sha1, new_sha1,
+			     git_committer_info(0), msg)) {
 		int save_errno = errno;
 		close(logfd);
 		error("Unable to append to %s", log_file);
-- 
2.2.0.rc2.23.gca0107e
