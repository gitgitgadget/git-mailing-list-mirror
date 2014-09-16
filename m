From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 16/35] commit_lock_file(): inline temporary variable
Date: Tue, 16 Sep 2014 21:33:37 +0200
Message-ID: <1410896036-12750-17-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydM-0003Sd-BP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbaIPTlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47043 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755044AbaIPTlr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:47 -0400
X-AuditID: 1207440c-f79036d000005e77-3b-541890cff662
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FC.8C.24183.FC098145; Tue, 16 Sep 2014 15:34:39 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcK001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:38 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1D0/QSLEoHuOpUXXlW4mi4beK8wW
	T+beZba4vWI+s8WPlh5mi38Taiw6O74yOrB7/H3/gcljwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBn/GwPKmhgq2h4sYmtgfE9SxcjJ4eEgInEzBurGSFs
	MYkL99azdTFycQgJXGaU6Nl6lAnCOcEkMe/1AbAqNgFdiUU9zWAJEYE2RoldFzezgjjMAt2M
	Eu9PnGYCqRIWcJc4372IGcRmEVCVeHimGaybV8BV4v2KXUwQ++QkNuz+DxTn4OAEin/dVwBi
	Cgm4SBy86zeBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJCw49nB
	+G2dzCFGAQ5GJR7eD/fFQ4RYE8uKK3MPMUpyMCmJ8v7rlggR4kvKT6nMSCzOiC8qzUktPsQo
	wcGsJML7wxcox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4OUDxpeQ
	YFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgy4ouBsQGS4gHa+7EfZG9xQWIuUBSi
	9RSjMUdL09teJo51nd/6mYRY8vLzUqXEeW1ASgVASjNK8+AWwRLOK0ZxoL+Fed+BVPEAkxXc
	vFdAq5iAVp3tEQNZVZKIkJJqYIyJuntymWxYsNoW1cud7u0B05S8nbLXdGrMXLbmVOXDmdyt
	ZVta8mp1LCJ+Nh2duLfucsp+0aJU359p4i5a16cHV5ol7ZtyPkeso3/PrJ9W/TH6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257166>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1c85b18..9e1cdd2 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -311,12 +311,14 @@ int reopen_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	size_t i;
+
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
+
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
-	result_file[i] = 0;
+	/* remove ".lock": */
+	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
+
 	if (rename(lk->filename, result_file))
 		return -1;
 	lk->filename[0] = 0;
-- 
2.1.0
