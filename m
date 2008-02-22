From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] refs.c: make close_ref() and commit_ref() non-static
Date: Fri, 22 Feb 2008 12:57:30 -0600
Message-ID: <47BF1B1A.5070907@nrlssc.navy.mil>
References: <47BF18DF.6050100@nrlssc.navy.mil> <1203706541-21719-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdCT-0002Ld-3c
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758827AbYBVTDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757319AbYBVTDj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:03:39 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52863 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758573AbYBVTDh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:03:37 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1MIvUqa027371;
	Fri, 22 Feb 2008 12:57:31 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 12:57:30 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1203706541-21719-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Feb 2008 18:57:30.0158 (UTC) FILETIME=[C63564E0:01C87584]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--13.435400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY3NS03MDE3?=
	=?us-ascii?B?MzUtMTA1MDQwLTcwNzc1MC03MDAxNjAtMTg4MDE5LTEyMTU4OC03?=
	=?us-ascii?B?MDQ3NDctNzA2MjkwLTEzNzcxNy03MDA5NzEtMTIxNjI0LTEyMTcw?=
	=?us-ascii?B?OS03MDIxNDMtMTM5NTA0LTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74748>

This is in preparation to the reflog-expire changes which will
allow updating the ref after expiring the reflog.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 refs.c |    4 ++--
 refs.h |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 67d2a50..bc65429 100644
--- a/refs.c
+++ b/refs.c
@@ -1018,7 +1018,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	return 1;
 }
 
-static int close_ref(struct ref_lock *lock)
+int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -1026,7 +1026,7 @@ static int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int commit_ref(struct ref_lock *lock)
+int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
diff --git a/refs.h b/refs.h
index 9cd16f8..06abee1 100644
--- a/refs.h
+++ b/refs.h
@@ -33,6 +33,12 @@ extern struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_
 #define REF_NODEREF	0x01
 extern struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags);
 
+/** Close the file descriptor owned by a lock and return the status */
+extern int close_ref(struct ref_lock *lock);
+
+/** Close and commit the ref locked by the lock */
+extern int commit_ref(struct ref_lock *lock);
+
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-- 
1.5.4.2.267.g38ea
