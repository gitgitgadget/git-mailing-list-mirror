From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Fixed text file auto-detection: treat EOF character 032 at the end of file as printable
Date: Fri, 11 Jul 2008 18:48:16 +0200
Message-ID: <1215794896-31354-1-git-send-email-prohaska@zib.de>
References: <7vabh0d4t9.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLqk-0002Yh-9L
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYGKQvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbYGKQvB
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:51:01 -0400
Received: from mailer.zib.de ([130.73.108.11]:58763 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbYGKQvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:51:01 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BGmObG027427;
	Fri, 11 Jul 2008 18:48:29 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BGmGFR009464;
	Fri, 11 Jul 2008 18:48:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <7vabh0d4t9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88143>

From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 convert.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index 352b69d..78efed8 100644
--- a/convert.c
+++ b/convert.c
@@ -61,6 +61,10 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 		else
 			stats->printable++;
 	}
+
+	/* If file ends with EOF then don't count this EOF as non-printable. */
+	if (size >= 1 && buf[size-1] == '\032')
+		stats->nonprintable--;
 }
 
 /*
-- 
1.5.6.1.282.gd8a0d
