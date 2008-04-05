Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 6306 invoked by uid 111); 5 Apr 2008 18:29:07 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 05 Apr 2008 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYDES25 (ORCPT <rfc822;peff@peff.net>);
	Sat, 5 Apr 2008 14:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYDES25
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 14:28:57 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:55097 "EHLO
	randymail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752840AbYDES24 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 14:28:56 -0400
Received: from localhost.localdomain (kballard.res.wpi.net [130.215.239.91])
	by randymail-a8.g.dreamhost.com (Postfix) with ESMTP id 5C779AF8EF;
	Sat,  5 Apr 2008 11:28:55 -0700 (PDT)
From:	Kevin Ballard <kevin@sb.org>
To:	git@vger.kernel.org
Cc:	Kevin Ballard <kevin@sb.org>
Subject: [PATCH] git-fetch: Don't trigger a bus error when given the refspec "tag"
Date:	Sat,  5 Apr 2008 14:28:53 -0400
Message-Id: <1207420133-23631-1-git-send-email-kevin@sb.org>
X-Mailer: git-send-email 1.5.5.rc3.dirty
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When git-fetch encounters the refspec "tag" it assumes that the next
argument will be a tag name. If there is no next argument, it should
die gracefully instead of erroring.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 builtin-fetch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index a11548c..5841b3e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -637,6 +637,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			if (!strcmp(argv[i], "tag")) {
 				char *ref;
 				i++;
+				if (i >= argc)
+					die("You need to specify a tag name.");
 				ref = xmalloc(strlen(argv[i]) * 2 + 22);
 				strcpy(ref, "refs/tags/");
 				strcat(ref, argv[i]);
-- 
1.5.5.rc3.dirty

