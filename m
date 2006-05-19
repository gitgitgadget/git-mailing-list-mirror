From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Allow pickaxe to be used via git log.
Date: Thu, 18 May 2006 21:31:24 -0400
Message-ID: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 19 03:37:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgtvU-0005o1-98
	for gcvg-git@gmane.org; Fri, 19 May 2006 03:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWESBhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 21:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWESBhI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 21:37:08 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:38036 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932215AbWESBhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 21:37:07 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 18:37:06 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 758AC644C28
	for <git@vger.kernel.org>; Thu, 18 May 2006 21:37:05 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060518213124.6e731eef.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 May 2006 01:37:06.0758 (UTC) FILETIME=[BCEF7660:01C67AE4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Handle the -S option when passed to git log such that only the appropriate
commits are displayed.  Unlike "whatchanged", by default no diff output
is produced.

---

This came out of recent comments on #git and will hopefully further reduce
the need for git-whatchanged.


ecdfaa21dbff93a6a387b02e1f1d3ebf05ee517d
 revision.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

ecdfaa21dbff93a6a387b02e1f1d3ebf05ee517d
diff --git a/revision.c b/revision.c
index 2294b16..2e18b2b 100644
--- a/revision.c
+++ b/revision.c
@@ -743,6 +743,13 @@ int setup_revisions(int argc, const char
 				continue;
 			}
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
+			if (revs->diffopt.pickaxe && revs->always_show_header) {
+				revs->always_show_header = 0;
+				revs->diff = 1;
+				revs->diffopt.recursive = 1;
+				if (revs->diffopt.output_format == DIFF_FORMAT_RAW)
+					revs->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
+			}
 			if (opts > 0) {
 				revs->diff = 1;
 				i += opts - 1;
-- 
1.3.GIT
