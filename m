X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-apply: slightly clean up bitfield usage
Date: Sat, 18 Nov 2006 13:07:09 +0100
Message-ID: <455EF76D.1040206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 12:07:02 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31770>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlOyH-0002S2-N4 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 13:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754505AbWKRMGt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 07:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbWKRMGt
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 07:06:49 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:15016 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1754505AbWKRMGs (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18
 Nov 2006 07:06:48 -0500
Received: from [10.0.1.3] (p508E406F.dip.t-dialin.net [80.142.64.111]) by
 neapel230.server4you.de (Postfix) with ESMTP id 5D16623008; Sat, 18 Nov 2006
 13:06:47 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This patch fixes a sparse warning about inaccurate_eof being a
"dubious one-bit signed bitfield", makes three more binary
variables members of this (now unsigned) bitfield and adds a
short comment to indicate the nature of two ternary variables.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-apply.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index aad5526..61f047f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -140,12 +140,15 @@ struct fragment {
 struct patch {
 	char *new_name, *old_name, *def_name;
 	unsigned int old_mode, new_mode;
-	int is_rename, is_copy, is_new, is_delete, is_binary;
+	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
 	int rejected;
 	unsigned long deflate_origlen;
 	int lines_added, lines_deleted;
 	int score;
-	int inaccurate_eof:1;
+	unsigned int inaccurate_eof:1;
+	unsigned int is_binary:1;
+	unsigned int is_copy:1;
+	unsigned int is_rename:1;
 	struct fragment *fragments;
 	char *result;
 	unsigned long resultsize;
-- 
1.4.4
