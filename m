From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/33] refs: document how current_ref is used
Date: Mon, 22 Apr 2013 21:52:12 +0200
Message-ID: <1366660361-21831-5-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMo9-0004ng-Fi
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab3DVTxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:37 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46315 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755044Ab3DVTxd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:33 -0400
X-AuditID: 12074414-b7fb86d000000905-fa-5175953d3f50
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D8.4B.02309.D3595715; Mon, 22 Apr 2013 15:53:33 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOH008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:32 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqGs7tTTQ4H+LrEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGccO3WEreAQe8WRHROYGxi7
	2boYOTkkBEwkvmzeyghhi0lcuLceKM7FISRwmVHi2K57TBDOBSaJzWsfgHWwCehKLOppZgKx
	RQTUJCa2HWIBsZkFHCQ2f24EmsTBIQxk77vuBhJmEVCV2NX9DqycV8BF4t/VnSwQyxQkjm/f
	BraYU8BV4nTHCbC4EFDNioNTWSYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZ
	opeaUrqJERIqIjsYj5yUO8QowMGoxMMr6F4aKMSaWFZcmXuIUZKDSUmUl2MKUIgvKT+lMiOx
	OCO+qDQntfgQowQHs5IIr2g+UI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxW
	hoNDSYI3A2SoYFFqempFWmZOCUKaiYMTRHCBbOAB2hAJUshbXJCYW5yZDlF0ilFRSpzXbRJQ
	QgAkkVGaBzcAFtWvGMWB/hHm5QNp5wEmBLjuV0CDmYAGZyaUgAwuSURISTUwhjCG6uVHRZy/
	Jvs8TSCN/6DQBSGti1OnbI6LyfaWWnJwZ/faI/OYijPy5h1prz3/unyb/EF+VQPPMxxROzKW
	exhJePlxalyUrCt+NFNtUuhKobQTcnV2TaffbtZdqSonymZ8QLM12K/gqMy5P3yu2X+dey48
	3Ma0wW/dvE6xpNxrAZYtQU5KLMUZiYZazEXFiQC2GfarxQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222058>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/refs.c b/refs.c
index 44cc2fc..efad658 100644
--- a/refs.c
+++ b/refs.c
@@ -528,6 +528,15 @@ static void sort_ref_dir(struct ref_dir *dir)
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
+/*
+ * current_ref is a performance hack: when iterating over references
+ * using the for_each_ref*() functions, current_ref is set to the
+ * current reference's entry before calling the callback function.  If
+ * the callback function calls peel_ref(), then peel_ref() first
+ * checks whether the reference to be peeled is the current reference
+ * (it usually is) and if so, returns that reference's peeled version
+ * if it is available.  This avoids a refname lookup in a common case.
+ */
 static struct ref_entry *current_ref;
 
 /*
-- 
1.8.2.1
