From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 09/35] lockfile.c: document the various states of lock_file objects
Date: Tue, 16 Sep 2014 21:33:30 +0200
Message-ID: <1410896036-12750-10-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydp-0003fJ-B9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbaIPTmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:09 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60015 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755136AbaIPTmG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:06 -0400
X-AuditID: 1207440d-f797f6d000000a4a-36-541890c415da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.81.02634.4C098145; Tue, 16 Sep 2014 15:34:28 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcD001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:27 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1D0yQSLE4Ge3iUXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi38Taiw6O74yOrB7/H3/gcljwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBnPF08langl0TF0+XHmBsY9wp3MXJwSAiYSDRs0O5i
	5AQyxSQu3FvP1sXIxSEkcJlRYsv9VmYI5wSTxJmtE1hBqtgEdCUW9TQzgSREBNoYJXZd3MwK
	4jALdDNKvD9xmgmkSlggTOLe9B+MIDaLgKrE357XzCA2r4CrxMc5r9kh9slJbNj9nxHkDE6g
	+Nd9BSCmkICLxMG7fhMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3E
	CAk73h2M/9fJHGIU4GBU4uH1eCQeIsSaWFZcmXuIUZKDSUmU91+3RIgQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd4fvkA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE
	Lx8wvoQEi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQZERXwyMDZAUD9Dej/0ge4sL
	EnOBohCtpxiNOSZtfN/LxLGu81s/kxBLXn5eqpQ4rw1IqQBIaUZpHtwiWMJ5xSgO9Lcw7zuQ
	Kh5gsoKb9wpoFRPQqrM9YiCrShIRUlINjNpx5uEhJVHXrsr+imSzeCYVeePnfD3euGCmpZ2P
	hVLadnI2RQtNUY+6MudvQlLC5NxGo9lb7iUv2NAfIsrudvTkBsNwoWulohzMs3s+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257172>

Document the valid states of lock_file objects, how they get into each
state, and how the state is encoded in the object's fields.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/lockfile.c b/lockfile.c
index 00c972c..b6fe848 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -4,6 +4,63 @@
 #include "cache.h"
 #include "sigchain.h"
 
+/*
+ * File write-locks as used by Git.
+ *
+ * When a file at $FILENAME needs to be written, it is done as
+ * follows:
+ *
+ * 1. Obtain a lock on the file by creating a lockfile at path
+ *    $FILENAME.lock.  The file is opened for read/write using O_CREAT
+ *    and O_EXCL mode to ensure that it doesn't already exist.  Such a
+ *    lock file is respected by writers *but not by readers*.
+ *
+ *    Usually, if $FILENAME is a symlink, then it is resolved, and the
+ *    file ultimately pointed to is the one that is locked and later
+ *    replaced.  However, if LOCK_NODEREF is used, then $FILENAME
+ *    itself is locked and later replaced, even if it is a symlink.
+ *
+ * 2. Write the new file contents to the lockfile.
+ *
+ * 3. Move the lockfile to its final destination using rename(2).
+ *
+ * Instead of (3), the change can be rolled back by deleting lockfile.
+ *
+ * This module keeps track of all locked files in lock_file_list.
+ * When the first file is locked, it registers an atexit(3) handler;
+ * when the program exits, the handler rolls back any files that have
+ * been locked but were never committed or rolled back.
+ *
+ * A lock_file is owned by the process that created it. The lock_file
+ * object has an "owner" field that records its owner. This field is
+ * used to prevent a forked process from closing a lock_file of its
+ * parent.
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
+ *
+ * See Documentation/api-lockfile.txt for more information.
+ */
+
 static struct lock_file *lock_file_list;
 
 static void remove_lock_file(void)
-- 
2.1.0
