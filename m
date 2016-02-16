From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/20] safe_create_leading_directories(): set errno on SCLD_EXISTS
Date: Tue, 16 Feb 2016 14:22:15 +0100
Message-ID: <7ddc8ac89f36b01494fbdc6f97bf1ca258b3e885.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfk0-0004gj-2S
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbcBPNc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:32:28 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60856 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932302AbcBPN35 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:29:57 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2016 08:29:56 EST
X-AuditID: 12074411-fe7ff700000071cf-b5-56c322a8353e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 9C.14.29135.8A223C65; Tue, 16 Feb 2016 08:22:49 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOO028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:47 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLtS6XCYwY4rrBbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aEzQ2sBRMEK3Zc7mdpYDzG28XIySEhYCIx5cki
	pi5GLg4hga2MEnOWroByTjBJ3Pr4mhGkik1AV2JRTzMTiC0ioCYxse0QC0gRs8AjRomu/dvB
	ioQFgiTWT7vKDmKzCKhKrOzewQxi8wpESby4upQNYp2cRMuP3awgNqeAhcTJll4WEFtIwFzi
	zpc9TBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAkywR2MM07K
	HWIU4GBU4uHl9DgUJsSaWFZcmXuIUZKDSUmUl4f7cJgQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed5/r4DKeVMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvOKKQEMFi1LT
	UyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQVEQXwyMA5AUD9BeGwWgdt7igsRcoChE6ylG
	RSlxXheQuQIgiYzSPLixsNTxilEc6Eth3m6QKh5g2oHrfgU0mAlocM4lkIeKSxIRUlINjBMK
	mk7kpftd/rXZyvkhq1HwDukpV4U4533hKrkU0z3f5K36gbCsi669yS7mFieDYiM/vZ3H+s9M
	veKpUfW6m6+dzJaFy8559vKfzalPYtbNn7eeexRxTHeWX9T273OkLpUbCk5lZY7+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286404>

The exit path for SCLD_EXISTS wasn't setting errno, as expected by at
least one caller. Fix the problem and document that the function sets
errno correctly to help avoid similar regressions in the future.

While we're at it, document the difference between
safe_create_leading_directories() and
safe_create_leading_directories_const().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 10 ++++++++--
 sha1_file.c |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 26640b4..7d3f80c 100644
--- a/cache.h
+++ b/cache.h
@@ -950,8 +950,9 @@ int adjust_shared_perm(const char *path);
 
 /*
  * Create the directory containing the named path, using care to be
- * somewhat safe against races.  Return one of the scld_error values
- * to indicate success/failure.
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
  *
  * SCLD_VANISHED indicates that one of the ancestor directories of the
  * path existed at one point during the function call and then
@@ -959,6 +960,11 @@ int adjust_shared_perm(const char *path);
  * directory while we were working.  To be robust against this kind of
  * race, callers might want to try invoking the function again when it
  * returns SCLD_VANISHED.
+ *
+ * The non _const version of this function temporarily modifies its
+ * path parameter while it is working but restores it before exiting.
+ * The _const version does not modify path (at the cost of having to
+ * make a temporary scratch copy).
  */
 enum scld_error {
 	SCLD_OK = 0,
diff --git a/sha1_file.c b/sha1_file.c
index 568120e..a1ac646 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -135,8 +135,10 @@ enum scld_error safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode))
+			if (!S_ISDIR(st.st_mode)) {
+				errno = EEXIST;
 				ret = SCLD_EXISTS;
+			}
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
-- 
2.7.0
