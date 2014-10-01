From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 10/38] lockfile.c: document the various states of lock_file objects
Date: Wed,  1 Oct 2014 12:28:14 +0200
Message-ID: <1412159322-2622-11-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBX-0003Kl-VC
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbaJAKaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:30:55 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62614 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399AbaJAK3H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:07 -0400
X-AuditID: 12074412-f792e6d000005517-63-542bd77292d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FE.1A.21783.277DB245; Wed,  1 Oct 2014 06:29:07 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk69026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:05 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1C2+rh1i8PgHk0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BlPf/5iKtgvXLFkTw97A+Nq/i5G
	Tg4JAROJbbf/skHYYhIX7q0Hsrk4hAQuM0o8fr+JHcI5ziTx5eJSFpAqNgFdiUU9zUwgtoiA
	msTEtkMsIEXMAouZJCYc2gQ2SlggTOLv30WsIDaLgKpE99sHzCA2r4CLxLwrc5kh1slJbNj9
	nxHE5gSKL7/cDLZASMBZYsedr0wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vN
	LNFLTSndxAgJR6EdjOtPyh1iFOBgVOLhVUjQDhFiTSwrrsw9xCjJwaQkyrvoElCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCG/2AaAcb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKY
	rAwHh5IEL8M1oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UHTEFwPjAyTFA7TX
	GaSdt7ggMRcoCtF6ilGXY13nt34mIZa8/LxUKXHe0KtARQIgRRmleXArYMnnFaM40MfCvOEg
	o3iAiQtu0iugJUxAS5LXgC0pSURISTUwblxsVht4I6z4pe+We2/8LUTj7qd17uras2DdoYk9
	hscmM72dW/l3pkPS8SviHZ9cNulPXKxZmHBhTYZ5+uTr/c8nWGlf4vGy+DtT2rPd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257736>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 81143e5..2680dc9 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,48 @@
 #include "cache.h"
 #include "sigchain.h"
 
+/*
+ * File write-locks as used by Git.
+ *
+ * For an overview of how to use the lockfile API, please see
+ *
+ *     Documentation/technical/api-lockfile.txt
+ *
+ * This module keeps track of all locked files in lock_file_list for
+ * use at cleanup. This list and the lock_file objects that comprise
+ * it must be kept in self-consistent states at all time, because the
+ * program can be interrupted any time by a signal, in which case the
+ * signal handler will walk through the list attempting to clean up
+ * any open lock files.
+ *
+ * A lockfile is owned by the process that created it. The lock_file
+ * object has an "owner" field that records its owner. This field is
+ * used to prevent a forked process from closing a lockfile created by
+ * its parent.
+ *
+ * A lock_file object can be in several states:
+ *
+ * - Uninitialized.  In this state the object's on_list field must be
+ *   zero but the rest of its contents need not be initialized.  As
+ *   soon as the object is used in any way, it is irrevocably
+ *   registered in the lock_file_list, and on_list is set.
+ *
+ * - Locked, lockfile open (after hold_lock_file_for_update(),
+ *   hold_lock_file_for_append(), or reopen_lock_file()). In this
+ *   state, the lockfile exists, filename holds the filename of the
+ *   lockfile, fd holds a file descriptor open for writing to the
+ *   lockfile, and owner holds the PID of the process that locked the
+ *   file.
+ *
+ * - Locked, lockfile closed (after close_lock_file()).  Same as the
+ *   previous state, except that the lockfile is closed and fd is -1.
+ *
+ * - Unlocked (after commit_lock_file(), rollback_lock_file(), or a
+ *   failed attempt to lock).  In this state, filename[0] == '\0' and
+ *   fd is -1.  The object is left registered in the lock_file_list,
+ *   and on_list is set.
+ */
+
 static struct lock_file *lock_file_list;
 
 static void remove_lock_file(void)
-- 
2.1.0
