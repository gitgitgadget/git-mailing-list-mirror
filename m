From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 21/35] dump_marks(): remove a redundant call to rollback_lock_file()
Date: Tue, 16 Sep 2014 21:33:42 +0200
Message-ID: <1410896036-12750-22-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWa-0000L7-0C
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbaIPTes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:48 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43316 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755050AbaIPTes (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:48 -0400
X-AuditID: 1207440e-f79da6d0000002fc-fd-541890d7f2e6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.49.00764.7D098145; Tue, 16 Sep 2014 15:34:47 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcP001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:46 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1L0+QSLEYN1ZPYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOmHByD2PBE9aKHS19bA2MN1m6GDk5JARMJN73HGGE
	sMUkLtxbz9bFyMUhJHCZUWLX44esEM4JJonHk7eDVbEJ6Eos6mlmAkmICLQBVV3cDFbFLNDN
	KPH+xGkmkCphgXCJ1dPOg9ksAqoSl6YfAOvmFXCVmHxzKTPEPjmJDbv/A8U5ODiB4l/3FYCY
	QgIuEgfv+k1g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyTw+HYw
	tq+XOcQowMGoxMPr8Ug8RIg1say4MvcQoyQHk5Io779uiRAhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIrw/fIFyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3nn9QI2C
	RanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2jvZpB23uKCxFygKETr
	KUZjjpamt71MHOs6v/UzCbHk5eelSonz2oCUCoCUZpTmwS2CpZxXjOJAfwvzbgGp4gGmK7h5
	r4BWMQGtOtsjBrKqJBEhJdXA2JeTIcbzt5glrnc305RYpjm7VAO7VzhHKZ95feBBfX7/3H3O
	TqwBbhcST/vZFMdN8V26hvXszIO71n2XcbtooTXJZOMJdoObba1bp8ydHjDFaP3r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257153>

When commit_lock_file() fails, it now always calls
rollback_lock_file() internally, so there is no need to call that
function here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 fast-import.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c071253..742d4d7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1828,10 +1828,8 @@ static void dump_marks(void)
 	}
 
 	if (commit_lock_file(&mark_lock)) {
-		int saved_errno = errno;
-		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to commit marks file %s: %s",
-			export_marks_file, strerror(saved_errno));
+			export_marks_file, strerror(errno));
 		return;
 	}
 }
-- 
2.1.0
