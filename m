X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 4/4] Show the branch type after the branch name for remotes
Date: Thu, 2 Nov 2006 11:11:32 +0000
Message-ID: <200611021111.32759.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:11:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
X-TUID: fe2e08d5124584c7
X-UID: 159
X-Length: 1623
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:12:39.0264 (UTC) FILETIME=[CEE5F600:01C6FE6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30723>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaTz-00042A-Br for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752844AbWKBLLg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbWKBLLg
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:11:36 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:13670 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752844AbWKBLLf
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:11:35 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:12:39 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaTu-0003wE-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:11:34 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Instead of prefixing the remote branches with "remotes/" suffix them with
"[read only]"

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index b88413a..6736882 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -105,6 +105,7 @@ static void print_ref_list(int display_m
 	int i;
 	char c;
 	char *p;
+	const char *suffix;
 
 	switch (display_mode) {
 		case 0:
@@ -122,6 +123,7 @@ static void print_ref_list(int display_m
 
 	for (i = 0; i < ref_index; i++) {
 		p = ref_list[i];
+		suffix = "";
 		if (display_mode == 2) {
 			if (!strncmp( p, "refs/", 5 ))
 				p += 5;
@@ -129,13 +131,17 @@ static void print_ref_list(int display_m
 				continue;
 			if (!strncmp( p, "heads/", 6 ))
 				p += 6;
+			if (!strncmp( p, "remotes/", 8 )) {
+				suffix = " [read only]";
+				p += 8;
+			}
 		}
 
 		c = ' ';
 		if (!strcmp(p, head))
 			c = '*';
 
-		printf("%c %s\n", c, p);
+		printf("%c %s%s\n", c, p, suffix);
 	}
 }
 
-- 
1.4.3.2
