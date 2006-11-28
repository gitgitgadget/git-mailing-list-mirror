X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] shortlog: remove range check
Date: Tue, 28 Nov 2006 22:49:17 +0100
Message-ID: <456CAEDD.7030203@lsrfire.ath.cx>
References: <7v8xhv2uj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 21:49:55 +0000 (UTC)
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7v8xhv2uj1.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32585>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpApS-00072H-VR for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757072AbWK1VtY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbWK1VtY
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:49:24 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:59099 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1757069AbWK1VtX (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28
 Nov 2006 16:49:23 -0500
Received: from [10.0.1.4] (p508E44AE.dip.t-dialin.net [80.142.68.174]) by
 neapel230.server4you.de (Postfix) with ESMTP id 5244214032; Tue, 28 Nov 2006
 22:49:22 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Don't force the user to specify more than one revision parameter,
thus making git-shortlog behave more like git-log.
'git-shortlog master' will now produce the expected results; the
other end of the range simply is the (oldest) root commit.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b5b13de..f1124e2 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -298,9 +298,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	if (!access(".mailmap", R_OK))
 		read_mailmap(".mailmap");
 
-	if (rev.pending.nr == 1)
-		die ("Need a range!");
-	else if (rev.pending.nr == 0)
+	if (rev.pending.nr == 0)
 		read_from_stdin(&list);
 	else
