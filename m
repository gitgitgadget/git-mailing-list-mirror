From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 03/38] close_lock_file(): exit (successfully) if file is already closed
Date: Wed,  1 Oct 2014 12:28:07 +0200
Message-ID: <1412159322-2622-4-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZH9c-0002Pg-RK
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbaJAK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:28:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58224 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbaJAK25 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:28:57 -0400
X-AuditID: 1207440e-f79da6d0000002fc-97-542bd767a20e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B1.F9.00764.767DB245; Wed,  1 Oct 2014 06:28:55 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk62026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:28:53 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1E2/rh1icLyTy6LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozzS/6yFEzkqvjx4QRrA+MMji5G
	Tg4JAROJn8d/sELYYhIX7q1n62Lk4hASuMwoMffpKjaQhJDAcSaJG7f8QWw2AV2JRT3NTCC2
	iICaxMS2QywgDcwCi5kkJhzaBNYgLBAlMWvjF2YQm0VAVeLdkj6gBg4OXgFniRf3tCGWyUls
	2P2fEcTmFHCRWH65mQVil7PEjjtfmSYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGus
	l5tZopeaUrqJERKKfDsY29fLHGIU4GBU4uFVSNAOEWJNLCuuzD3EKMnBpCTKu+gSUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIb/YBoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFq
	EUxWhoNDSYKX4RpQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB
	2usM0s5bXJCYCxSFaD3FqMuxrvNbP5MQS15+XqqUOG8mSJEASFFGaR7cCljiecUoDvSxMK80
	SBUPMGnBTXoFtIQJaEnyGrAlJYkIKakGRqZmkYps350P5z+xYir83jxF0mhZ+0k5D/vortt2
	e/+HJX9bP9F5h1uUYp6EkKToMkG/P2dFfjcLyEr6szhuEant53cObrLV+ME8ZVVv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257700>

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c   | 6 +++++-
 read-cache.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f1ce154..d02c3bf 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -233,6 +233,10 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 int close_lock_file(struct lock_file *lk)
 {
 	int fd = lk->fd;
+
+	if (fd < 0)
+		return 0;
+
 	lk->fd = -1;
 	return close(fd);
 }
@@ -251,7 +255,7 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 	size_t i;
-	if (lk->fd >= 0 && close_lock_file(lk))
+	if (close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
 	i = strlen(result_file) - 5; /* .lock */
diff --git a/read-cache.c b/read-cache.c
index 2fc1182..5ffb1d7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2042,7 +2042,7 @@ void set_alternate_index_output(const char *name)
 static int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
-		if (lk->fd >= 0 && close_lock_file(lk))
+		if (close_lock_file(lk))
 			return -1;
 		if (rename(lk->filename, alternate_index_output))
 			return -1;
-- 
2.1.0
