X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] xdiff: Do not consider lines starting by # hunkworthy
Date: Wed, 25 Oct 2006 02:07:08 +0200
Message-ID: <20061025000708.2753.74523.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Wed, 25 Oct 2006 00:07:25 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30016>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWIj-0004uA-Lb for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422765AbWJYAHL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 20:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWJYAHL
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:07:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51644 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1422765AbWJYAHJ (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:07:09 -0400
Received: (qmail 2763 invoked from network); 25 Oct 2006 02:07:08 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 25 Oct 2006 02:07:08 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This will be probably controversial but in my personal experience, the
amount of time this is the right thing to do because of #defines is negligible
compared to amount of time it is wrong, especially because of #ifs and #endifs
in the middle of functions and also because of comments at the line start when
it concerns non-C files.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 xdiff/xemit.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 714c563..4f20075 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -86,8 +86,7 @@ static void xdl_find_func(xdfile_t *xf, 
 		if (len > 0 &&
 		    (isalpha((unsigned char)*rec) || /* identifier? */
 		     *rec == '_' ||	/* also identifier? */
-		     *rec == '(' ||	/* lisp defun? */
-		     *rec == '#')) {	/* #define? */
+		     *rec == '(')) {	/* #define? */
 			if (len > sz)
 				len = sz;
