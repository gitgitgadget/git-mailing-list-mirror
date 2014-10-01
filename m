From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 15/38] remove_lock_file(): call rollback_lock_file()
Date: Wed,  1 Oct 2014 12:28:19 +0200
Message-ID: <1412159322-2622-16-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBB-0003AW-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbaJAK32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:28 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62061 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644AbaJAK30 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:26 -0400
X-AuditID: 1207440f-f79156d000006a5c-b0-542bd77ba75c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 46.EF.27228.B77DB245; Wed,  1 Oct 2014 06:29:15 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6E026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:14 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1K2+rh1i0HVP3qLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyOk7fZCjrZKnqeRTYwfmbpYuTk
	kBAwkZj36DkbhC0mceHeeiCbi0NI4DKjxIqm71DOcSaJ/e1NjCBVbAK6Eot6mplAbBEBNYmJ
	bYdYQIqYBRYzSUw4tAlslLCAu0Tr7AYwm0VAVeL57UYwm1fAReJJ9y1WiHVyEht2/wcbygkU
	X365GewkIQFniR13vjJNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0
	EyMkGPl3MHatlznEKMDBqMTDq5CgHSLEmlhWXJl7iFGSg0lJlHfRJaAQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd7sA0A53pTEyqrUonyYlDQHi5I4r/oSdT8hgfTEktTs1NSC1CKYrAwHh5IE
	75RrQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2jvTpB23uKC
	xFygKETrKUZjjpamt71MHOs6v/UzCbHk5eelSonz7gcpFQApzSjNg1sES0OvGMWB/hbmvQBS
	xQNMYXDzXgGtYgJalbwGbFVJIkJKqoExtSk05XqH5KFQ1uzG5Z7qdqfa03/v4J5WuVr/XbeW
	Zv6hqiYN46OJeluF/CtermusnmwpfWlylN+lfq5Fqwv+3l3/92vitmfzXi2cseLj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257727>

It does just what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a8f32e5..f8205f6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -53,12 +53,8 @@ static void remove_lock_file(void)
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
-		}
+		if (lock_file_list->owner == me)
+			rollback_lock_file(lock_file_list);
 		lock_file_list = lock_file_list->next;
 	}
 }
-- 
2.1.0
