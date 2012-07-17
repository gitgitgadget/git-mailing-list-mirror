From: "Jakub Vrana" <jakub@vrana.cz>
Subject: [PATCH] diff: respect --no-ext-diff with typechange
Date: Mon, 16 Jul 2012 17:27:00 -0700
Message-ID: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 02:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqw6P-0008Bq-SL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 02:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab2GQA5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 20:57:21 -0400
Received: from maxipes.logix.cz ([93.89.80.122]:35907 "EHLO maxipes.logix.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab2GQA5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 20:57:20 -0400
X-Greylist: delayed 1816 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 20:57:20 EDT
Received: from JAKUBVT420S (unknown [IPv6:2620:0:1cfe:28:9c40:6f50:d34b:ae59])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by maxipes.logix.cz (Postfix) with ESMTP id 6D9A35D3C55;
	Tue, 17 Jul 2012 12:33:32 +1200 (NZST)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac1jsuHMiOPiqfzOQVqPrd2M62kLkw==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201582>

If external diff is specified through diff.external then it is used even if
`git diff --no-ext-diff` is used when there is a typechange.

Signed-off-by: Jakub Vrana <jakub@vrana.cz>
---
 diff.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index 208096f..898d610 100644
--- a/diff.c
+++ b/diff.c
@@ -3074,6 +3074,9 @@ static void run_diff(struct diff_filepair *p, struct
diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
+	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
+		pgm = NULL;
+
 	if (DIFF_PAIR_UNMERGED(p)) {
 		run_diff_cmd(pgm, name, NULL, attr_path,
 			     NULL, NULL, NULL, o, p);
-- 
1.7.10.msysgit.1
