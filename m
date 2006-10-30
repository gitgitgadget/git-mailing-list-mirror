X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Remove unused variable in receive-pack.
Date: Mon, 30 Oct 2006 17:34:50 -0500
Message-ID: <20061030223450.GE5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:37:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30537>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefjD-0003ku-VH for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422701AbWJ3Wez (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWJ3Wez
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:34:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52874 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422701AbWJ3Wey
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:34:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GefiN-000879-RF; Mon, 30 Oct 2006 17:34:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 EB91320FB0C; Mon, 30 Oct 2006 17:34:50 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

We aren't using this return code variable for anything so lets
just get rid of it to keep this section of code clean.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 7e4e510..f6f1729 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -219,7 +219,7 @@ static void read_head_info(void)
 	}
 }
 
-static const char *unpack(int *error_code)
+static const char *unpack()
 {
 	int code;
 
@@ -230,7 +230,6 @@ static const char *unpack(int *error_cod
 		code = run_command_v_opt(ARRAY_SIZE(unpacker) - 1,
 					 unpacker, RUN_GIT_CMD);
 
-	*error_code = 0;
 	switch (code) {
 	case 0:
 		return NULL;
@@ -247,7 +246,6 @@ static const char *unpack(int *error_cod
 	case -ERR_RUN_COMMAND_WAITPID_NOEXIT:
 		return "unpacker died strangely";
 	default:
-		*error_code = -code;
 		return "unpacker exited with error code";
 	}
 }
@@ -301,8 +299,7 @@ int main(int argc, char **argv)
 
 	read_head_info();
 	if (commands) {
-		int code;
-		const char *unpack_status = unpack(&code);
+		const char *unpack_status = unpack();
 		if (!unpack_status)
 			execute_commands();
 		if (report_status)
-- 
1.4.3.3.g7d63
