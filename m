From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/5] refs.c: have a write_sha1_to_lock_file wrapper
Date: Wed, 21 Jan 2015 18:32:08 -0800
Message-ID: <1421893929-7447-5-git-send-email-sbeller@google.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 03:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE7Zo-0008C2-G0
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 03:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbbAVCcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 21:32:51 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:49314 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbbAVCcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 21:32:22 -0500
Received: by mail-ig0-f179.google.com with SMTP id l13so304836iga.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 18:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9hnp5vht9/h8DCe0fJ5m2M+i9GwV2iCiCWFfwv95bs=;
        b=nedPSpCVNcJSDXoSlHcJQA/3xE/vcvIyIWeer4wvOzr1i5g/8J5JtibG1bAKcTE5d3
         bg/BA14a/R8wuBQek2XfnkZI8zrp9ZtjZPap5R/zE4sfVwWrGaEBW8grFhg21pTwgiZs
         nNTSCLEnjzioqU1i6moo8UqL+kG+yASoQDyxfc4YmZHj6WKAMtw0uJAs+m3fO2c53s1T
         v4t0vtUpKpG1cgFaU1VvbxuLneC5f5KUpgreS9AsQS2aqs9rmLLG4xi4g1pCanKTpz+V
         kjb3qWWsLPvLkmrY/GTcIVP6tdwhxnqZONX0oJhUlbzj6k8H8Yi1axQOjPt+7dwHakz5
         NpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9hnp5vht9/h8DCe0fJ5m2M+i9GwV2iCiCWFfwv95bs=;
        b=Q3lfIL4i2JgmPuQ18x2I3aVNUjeRlanM08LYLzBW1ZWJP99ZRyQKTmRFSgYWaZJCcn
         t9jFy9fM1dYts8uyDhqxaEgfyrNSzJ9FXM3W7XwbLS/vqV5iyXlRtDhyDqimQ0lomqir
         7JFKKh1QNLRoyl2PGToYxL/qJXWUCwvxFV2UXZ+4SJseMcUPEpWibPICnrOQaQmO/pDi
         c0j+Kue1/r3pytIXhbGCEV36jRJNxCq8pCksNLgi4uMXcZMtOnxWVqMhVbB5KuNfgQMR
         CxOx0IupYCrxnF2g3SUWnPk1VEUErdexwsUlqqKthqmWnJ7cyAya8XFeACnPU0sc+qMZ
         1A6w==
X-Gm-Message-State: ALoCoQlz+2106paE15hpD+EiIFhvHl5sV/AnRV3iXr2+QsYbisUJFhUItC/rLIvhtTUcQiMYosgN
X-Received: by 10.50.61.176 with SMTP id q16mr8863276igr.29.1421893937564;
        Wed, 21 Jan 2015 18:32:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id t8sm1142367igs.21.2015.01.21.18.32.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 18:32:17 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421893929-7447-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262795>

Now we only have one place where we need to touch the internals of
the lock_file struct.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 2472e61..2013d37 100644
--- a/refs.c
+++ b/refs.c
@@ -3052,6 +3052,16 @@ int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
+static int write_sha1_to_lock_file(struct ref_lock *lock,
+				   const unsigned char *sha1)
+{
+	if (fdopen_lock_file(lock->lk, "w") < 0
+	    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
+		return -1;
+	else
+		return 0;
+}
+
 /*
  * Write sha1 into the ref specified by the lock. Make sure that errno
  * is sane on error.
@@ -3059,7 +3069,6 @@ int is_branch(const char *refname)
 static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
-	static char term = '\n';
 	struct object *o;
 
 	if (!lock) {
@@ -3085,8 +3094,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
+	if (write_sha1_to_lock_file(lock, sha1) ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
@@ -4042,9 +4050,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full(lock->lk->fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
+			(write_sha1_to_lock_file(lock, cb.last_kept_sha1) ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
-- 
2.2.1.62.g3f15098
