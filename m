X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix git-for-each-refs broken for tags
Date: Sat, 18 Nov 2006 03:56:52 +0100
Message-ID: <20061118025652.2970.10571.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sat, 18 Nov 2006 02:57:18 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31749>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlGO3-0005iB-Ab for gcvg-git@gmane.org; Sat, 18 Nov
 2006 03:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756170AbWKRC4y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 21:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbWKRC4y
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 21:56:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58497 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1756170AbWKRC4x (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 21:56:53 -0500
Received: (qmail 2980 invoked from network); 18 Nov 2006 03:56:52 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 18 Nov 2006 03:56:52 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Unfortunately, git-for-each-refs is currently unusable for peeking into tag
comments, since it uses freed pointers, so it just prints out all sort of
garbage.

This makes it strdup() contents and body values.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 builtin-for-each-ref.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 173bf38..227aa3c 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -478,9 +478,9 @@ static void grab_sub_body_contents(struc
 		if (!strcmp(name, "subject"))
 			v->s = copy_line(subpos);
 		else if (!strcmp(name, "body"))
-			v->s = bodypos;
+			v->s = xstrdup(bodypos);
 		else if (!strcmp(name, "contents"))
-			v->s = subpos;
+			v->s = xstrdup(subpos);
 	}
 }
