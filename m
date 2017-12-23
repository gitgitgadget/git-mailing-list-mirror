Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787381F404
	for <e@80x24.org>; Sat, 23 Dec 2017 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdLWUMR (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 15:12:17 -0500
Received: from forward103j.mail.yandex.net ([5.45.198.246]:60213 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdLWUMQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Dec 2017 15:12:16 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2017 15:12:16 EST
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 765C134C3516
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 23:03:00 +0300 (MSK)
Received: from web42g.yandex.ru (web42g.yandex.ru [2a02:6b8:0:1402::8c])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 6IxfQZIdWX-2xBaJ4X2;
        Sat, 23 Dec 2017 23:02:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1514059379;
        bh=VvhnmDkC6MDNBLPLO1rhcfXpTIL5vl4u0oA0wRh4v5c=;
        h=From:To:Subject:Message-Id:Date;
        b=BMqHf1NhFmrNybaK4MTssaGyK7GKa1LBlNchjFgm2JOKZHJwDJVTAt08JbuphyaHe
         UhH5wDP8QAcNrZ6OS0QRApWKMBg6XNvyQq/ExGX+CYC3TkJVHoOe9RXZtf/7WbwkG2
         B1TJct8Pe/i3iCS2XFElbljqkGxhP8pYvIa/DVog=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web42g.yandex.ru with HTTP;
        Sat, 23 Dec 2017 23:02:59 +0300
From:   Vadim Petrov <tridronet@yandex.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] setup.c: move statement under condition
MIME-Version: 1.0
Message-Id: <3853941514059379@web42g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 24 Dec 2017 00:02:59 +0400
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suppose that if the condition is fulfilled then the previously
obtained value will not be necessary.

Signed-off-by: Vadim Petrov <tridronet@protonmail.com>
---
 setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 8cc34186c..1ce0189fa 100644
--- a/setup.c
+++ b/setup.c
@@ -35,7 +35,6 @@ static int abspath_part_inside_repo(char *path)
 		return -1;
 	wtlen = strlen(work_tree);
 	len = strlen(path);
-	off = offset_1st_component(path);
 
 	/* check if work tree is already the prefix */
 	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
@@ -49,6 +48,8 @@ static int abspath_part_inside_repo(char *path)
 		}
 		/* work tree might match beginning of a symlink to work tree */
 		off = wtlen;
+	} else {
+		off = offset_1st_component(path);
 	}
 	path0 = path;
 	path += off;
-- 
2.15.1.433.g936d1b989

