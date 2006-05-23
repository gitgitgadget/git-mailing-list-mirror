From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] --summary output should print immediately after stats.
Date: Tue, 23 May 2006 05:34:23 -0400
Message-ID: <BAYC1-PASMTP112E80721E5343A37893B6AE9B0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 23 11:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiTNN-00053B-DU
	for gcvg-git@gmane.org; Tue, 23 May 2006 11:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWEWJkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 05:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWEWJkW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 05:40:22 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:5709 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932152AbWEWJkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 05:40:21 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 May 2006 02:45:13 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 89799644C04
	for <git@vger.kernel.org>; Tue, 23 May 2006 05:40:19 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060523053423.2aca4974.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 May 2006 09:45:13.0859 (UTC) FILETIME=[970F6D30:01C67E4D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Currently the summary is displayed after the patch.  Fix this so
that the output order is stat-summary-patch.  As a consequence of
the way this is coded, the --summary option will only actually
display summary data if combined with either the --stat or 
--patch-with-stat option.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

3060faeb9c9320e12895cb33d25edb4aa4ba072e
 diff.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

3060faeb9c9320e12895cb33d25edb4aa4ba072e
diff --git a/diff.c b/diff.c
index e16e0bf..fa36366 100644
--- a/diff.c
+++ b/diff.c
@@ -1867,6 +1867,9 @@ void diff_flush(struct diff_options *opt
 		show_stats(diffstat);
 		free(diffstat);
 		diffstat = NULL;
+		if (options->summary)
+			for (i = 0; i < q->nr; i++)
+				diff_summary(q->queue[i]);
 		putchar(options->line_termination);
 	}
 	for (i = 0; i < q->nr; i++) {
@@ -1880,7 +1883,7 @@ void diff_flush(struct diff_options *opt
 	}
 
 	for (i = 0; i < q->nr; i++) {
-		if (options->summary)
+		if (diffstat && options->summary)
 			diff_summary(q->queue[i]);
 		diff_free_filepair(q->queue[i]);
 	}
-- 
1.3.GIT
