From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 21/32] dump_marks(): remove a redundant call to rollback_lock_file()
Date: Sat,  6 Sep 2014 09:50:35 +0200
Message-ID: <1409989846-22401-22-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuT-0005JL-3s
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbaIFH7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:45 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48064 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408AbaIFH7l (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:41 -0400
X-AuditID: 1207440d-f797f6d000000a4a-4c-540abd3ce100
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 37.62.02634.C3DBA045; Sat,  6 Sep 2014 03:52:28 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHK006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:26 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqGuzlyvEoGc5u0XXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3xpk7l9kKnrBWLJ3t3cB4k6WLkZNDQsBE4viPx8wQtpjEhXvr2boY
	uTiEBC4zSrzo/ccM4Rxjkni7ZycTSBWbgK7Eop5mJpCEiEAbo8Sui5tZQRLMAikSHc+7GUFs
	YYFwiaOtN8BsFgFViRNfF4A18wq4Skx6dpIdYp2cxIbd/8FqOIHi05s6wWwhAReJ9pP9TBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXSy80s0UtNKd3ECAk03h2M/9fJHGIU4GBU
	4uEtcOAKEWJNLCuuzD3EKMnBpCTKm7ccKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt2MyUI43
	JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMF7YzdQo2BRanpqRVpmTglC
	momDE2Q4l5RIcWpeSmpRYmlJRjwoNuKLgdEBkuIB2su6B2RvcUFiLlAUovUUozFHS9PbXiaO
	dZ3f+pmEWPLy81KlxHmZQEoFQEozSvPgFsFSzCtGcaC/hXnvg9zDA0xPcPNeAa1iAlplns4J
	sqokESEl1cAY/mOlq3b9gb389ixffjQLS4T/Sk390xL3ZJv/gk3vnMVrBPJ9GbZaB7R+USsP
	XL/nYm68hlNu+/arNsIbVy/7lxjOoNKprBdvnXXxewd3sWuE4O9VOfyuLxIClwl2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256577>

When commit_lock_file() fails, it now always calls
rollback_lock_file() internally, so there is no need to call that
function here.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 fast-import.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d73f58c..55cb47a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1803,10 +1803,8 @@ static void dump_marks(void)
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
