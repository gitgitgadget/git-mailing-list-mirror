From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 37/38] Move read_index() definition to read-cache.c
Date: Wed,  1 Oct 2014 12:28:41 +0200
Message-ID: <1412159322-2622-38-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAZ-0002tu-6w
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbaJAK3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:55 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62062 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771AbaJAK3x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:53 -0400
X-AuditID: 1207440f-f79156d000006a5c-d5-542bd7a1b179
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D7.EF.27228.1A7DB245; Wed,  1 Oct 2014 06:29:53 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6a026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:51 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1F14XTvEYMp7TouuK91MFg29V5gt
	nsy9y2zx9uYSRovbK+YzW/xo6WG2+DehxqKz4yujA4fH3/cfmDx2zrrL7rFgU6nHw1dd7B7P
	evcwely8pOzxeZOcx+1n21gCOKK4bZISS8qCM9Pz9O0SuDMeXvzPXtDIVfHtzlLmBsYOji5G
	Tg4JAROJU/Pus0DYYhIX7q1n62Lk4hASuMwoseXJVSYI5ziTxOLFf5hBqtgEdCUW9TQzgdgi
	AmoSE9sOsYAUMQssZpKYcGgTG0hCWMBN4nFPK1gRi4CqxKEJy9hBbF4BF4n2i53MEOvkJDbs
	/s8IYnMCxZdfbgY7Q0jAWWLHna9MExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHL
	zSzRS00p3cQICUf+HYxd62UOMQpwMCrx8CokaIcIsSaWFVfmHmKU5GBSEuVddAkoxJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYQ3+wBQjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUI
	JivDwaEkwTvlGlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg64ouB8QGS4gHa
	uxOknbe4IDEXKArReopRl2Nd57d+JiGWvPy8VClx3v0gRQIgRRmleXArYMnnFaM40MfCvBdA
	qniAiQtu0iugJUxAS5LXgC0pSURISTUwTt/Ku1z1u6D1D7tnSa/aJGUrHv39s6h8U4uMerhz
	brKq54HYEu3W24fV7s2P5pIRLu1+IHVSwLY7JZhv7a/cJXLLLHZ+upCeKnjUn9cx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257721>

lockfile.c contains the general API for locking any file. Code
specifically about the index file doesn't belong here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c   | 8 --------
 read-cache.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index b2f5d36..63f4e94 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -340,14 +340,6 @@ int commit_lock_file(struct lock_file *lk)
 	return err;
 }
 
-int hold_locked_index(struct lock_file *lk, int die_on_error)
-{
-	return hold_lock_file_for_update(lk, get_index_file(),
-					 die_on_error
-					 ? LOCK_DIE_ON_ERROR
-					 : 0);
-}
-
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (!lk->active)
diff --git a/read-cache.c b/read-cache.c
index e887e23..9f137e7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1367,6 +1367,14 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
+int hold_locked_index(struct lock_file *lk, int die_on_error)
+{
+	return hold_lock_file_for_update(lk, get_index_file(),
+					 die_on_error
+					 ? LOCK_DIE_ON_ERROR
+					 : 0);
+}
+
 int read_index(struct index_state *istate)
 {
 	return read_index_from(istate, get_index_file());
-- 
2.1.0
