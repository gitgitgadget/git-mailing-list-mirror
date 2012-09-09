From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/14] fetch-pack: report missing refs even if no existing refs were received
Date: Sun,  9 Sep 2012 08:19:47 +0200
Message-ID: <1347171589-13327-13-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatq-00032a-G7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab2IIGVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:25 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:43233 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514Ab2IIGUv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:51 -0400
X-AuditID: 12074412-b7f216d0000008e3-e2-504c3543260b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D1.9B.02275.3453C405; Sun,  9 Sep 2012 02:20:51 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlp029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:49 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqOts6hNgcHI/i0XXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M55c8Cx4y1Hx4lUHUwPjFPYuRg4OCQETicuvfLoYOYFMMYkL99azdTFycQgJXGaUmPj1
	LSuEc4ZJYsL7P2wgVWwCuhKLepqZQGwRATWJiW2HWECKmAW6GCWWr/sFViQskCBxuX8xI4jN
	IqAq8fTNTrAGXgFXiRdP3rFDrFOU+PF9DTOIzQkUfzVzN1i9kICLxKad11gnMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESUEI7GNeflDvEKMDBqMTDy3LHO0CI
	NbGsuDL3EKMkB5OSKK+GiU+AEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeq+xAOd6UxMqq1KJ8
	mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCV5jkKGCRanpqRVpmTklCGkmDk4QwQWy
	gQdoQzBIIW9xQWJucWY6RNEpRkUpcd4ykIQASCKjNA9uACz2XzGKA/0jzOsMUsUDTBtw3a+A
	BjMBDRZ55gEyuCQRISXVwHhYWnGutpSSC4sV63u3Lg3OOd7PM0wXHbp0RefqUbWXLjFW8w8l
	XA1OsWw7sdph/swX0xfef/iPP+WW88TSY3OdhW+bvFipp/FHa8YVC6Z+3hdrVPYzSHsUrO1k
	uKh+3uXT8tsXJrru+ZQVkPTtxhql2wxPp2mbaDzOXOlse1182uydvg/Ewm8psRRn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205057>

This fixes a test in t5500.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c  | 2 +-
 t/t5500-fetch-pack.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fb2a423..3d388b5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1021,7 +1021,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	ret = !ref;
-	if (ref && sought.nr) {
+	if (sought.nr) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index acd41e8..894d945 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -403,7 +403,7 @@ test_expect_success 'set up tests of missing reference' '
 	EOF
 '
 
-test_expect_failure 'test lonely missing ref' '
+test_expect_success 'test lonely missing ref' '
 	(
 		cd client &&
 		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
-- 
1.7.11.3
