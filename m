Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4085B20209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdF3Jtn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:49:43 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64695 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdF3Jtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:49:40 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id QsYKdOu0hQ527QsYUdIMsp; Fri, 30 Jun 2017 10:49:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498816179; bh=2ml5sNpe0aHbvUS65O9qjUXDFMspjLoll348Bppx2dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=QamFUxg2IwZh0wMJYJlqPkckh/F7pFVxMUEl8OkudO9vgY524k342nNjFZpZooXws
         hT5aq+/0hdSTsrQcI12F+J01EdL1nfQHvx1be3KkGtJ5nUZIX2AVMrnde8hmRJSY6X
         ieWJ8+H+Sp/Kz3CvKLWMHyoHPgCH4RwG5vptuh3s=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=HhPA1Zu1Id1Cj8__UdYA:9
 a=KKTkV0KD7i35_Iva:21 a=hzujNpbn1nv4IUPm:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/4] Git::unquote_path() throw an exception on bad path
Date:   Fri, 30 Jun 2017 10:49:11 +0100
Message-Id: <20170630094912.8653-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170630094912.8653-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
 <20170630094912.8653-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfAYMroW4qle9gm7MsA6l2HRO2wuqJao0k0PRNLh/sivn3cSa7GuZlGPvqo4wldNHDheRr0/0xBUP9fOs3CjgHqLMRD2DqHCmJFmabs0pzqqPweZc9hCI
 alnFLr5/+JGrXiPCfkIW5Yha6g6jpY/pjapbirRHy7yoeRffAaMhzRCsnVc8dYftidBww1dqc62Q1Zda114eaJAwJkcPXw3thVb1JlV/yaoN/ejOxZVpv7jB
 YhNCjlYuGavaj7Rk1jRxj4SnLUZoR7xrDKnvlKfXtDw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is what the other routines in Git.pm do if there's an error.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 perl/Git.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index f075b500c510d183074c0358fb24fefc72248125..baf80d1ab038590c85bc5971483517cba606881f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1493,8 +1493,8 @@ when not using -z or when parsing the output of diff -u.
 					$_ = $2;
 					last;
 				}
-				# This is malformed -- just return it as-is for now.
-				return $_[0];
+				# This is malformed
+				throw Error::Simple("invalid quoted path $_[0]");
 			}
 			$_ = $remainder;
 		}
-- 
2.13.1

