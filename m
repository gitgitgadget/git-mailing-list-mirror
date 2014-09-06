From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 25/32] try_merge_strategy(): remove redundant lock_file allocation
Date: Sat,  6 Sep 2014 09:50:39 +0200
Message-ID: <1409989846-22401-26-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 10:00:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuu-0005bp-DK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 10:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbaIFIAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 04:00:12 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49039 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560AbaIFIAG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 04:00:06 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 04:00:06 EDT
X-AuditID: 12074411-f79d86d000006a97-8a-540abd41f5d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DA.7D.27287.14DBA045; Sat,  6 Sep 2014 03:52:33 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHO006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:32 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOu4lyvE4Ee/nkXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi86Or4wObB5/339g8nj4qovd41nvHkaPi5eUPT5vkvO4/WwbSwBb
	FLdNUmJJWXBmep6+XQJ3RsfRLawF59grLrb8ZWtgnMHWxcjJISFgIrHr6TZmCFtM4sK99UBx
	Lg4hgcuMEmefd7OCJIQEjjFJtO2VBrHZBHQlFvU0M4EUiQi0MUrsurgZrIhZIEWi43k3I4gt
	LBAqsXjfaxYQm0VAVeLDpytANRwcvAKuEs92W0Isk5PYsPs/WDknUHh6UycjxC4XifaT/UwT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJM8EdjDNOyh1iFOBg
	VOLhLXDgChFiTSwrrsw9xCjJwaQkypu3HCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLdjMlCO
	NyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTB67IHqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFBnxxcDYAEnxAO1lBWnnLS5IzAWKQrSeYjTmaGl628vE
	sa7zWz+TEEtefl6qlDgvE0ipAEhpRmke3CJYgnnFKA70tzCvGEgVDzA5wc17BbSKCWiVeTon
	yKqSRISUVAOjQV58g3zRxMr3mzQ2s/5ze/RW21DgV+Km6vAM6ecxM7INvL5pPdj6yPN41xzb
	ptDtLcZmWZHun/89/5v5snADj//SBZmrhCRV2lpnbL1xaIL983/GuexpU9qrsnhu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256583>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block shadowed the "lock"
variable at function scope, so the only change needed is to remove the
inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ce82eb2..0f5c185 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -669,7 +669,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
 		struct commit_list *j;
-- 
2.1.0
