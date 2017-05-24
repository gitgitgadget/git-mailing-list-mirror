Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEB220281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969176AbdEXFRF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33665 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966000AbdEXFQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so31067164oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncbNWwgiTkwrebY/K8JXMyjCyi7YnUtuafNDhHgl7GE=;
        b=itE2nQqGPznUbojRR/qMv6uUkeyHuJoBVGU1xTradYutsT4RIp/JFleLoesXtivYds
         ezcQJcPpkUB8wn00BmH0de0s0FQiBTsvz0HsbnSNaxbOVDHjNnTGkBAoymKtjvN+anTm
         1/anUgrrGkgRllO8HACshveyytJsEGzmx1eJsMiV1phVUBkvLirRKBCVLXw8h/J6RRNE
         IZdUOQQhQ71mgMWpw2IpNxrReFvCuQ0eenOUyk8up0zqMlCR3rvec6QeN/GRsrCux0Nq
         q0LhJaJZGz+vjym/wPWVYAUWLqwnt8ho/kgCNWU3RJ08H61hMvh/HEQb6Yy0pqnAS5tD
         CX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncbNWwgiTkwrebY/K8JXMyjCyi7YnUtuafNDhHgl7GE=;
        b=JcgwHRltN23SZ+jS4hqCnIAHwmOTKTPcTAaW5WS/iYqqJb+aRWJZK6V/Ug3BAmrfjc
         iGdOemgfrna1L3HfqIMycPWKM9CNBo0gip8EH6chcEDYyl8Ur+FkgHAmry40ZcC4ahJm
         jSF4TfkhOBHx8cBtlWrFlwhQ4FtGKH80zefGoNI2rWY+67F3inM0NKx2Bo7xBC9eJDZj
         WCVmNsjYLdcKUht/K/yRvfLt9WF9g1skdaHXMaVD1sszwhHYjbgiUZT8ZsVIJRxfVHLu
         jPznHe6QkZVt4/CyaqaxPoi6mNKmHumoqekC+Id9S4uU9nlP3HUn1uWVnSZcG+8/Gdq8
         oDMw==
X-Gm-Message-State: AODbwcAop5D/vqN6If0iluPjnp46hv2ekOLXqtYsNNkHEF2PVY8YbCwn
        X4omrWu8los1gQ==
X-Received: by 10.202.253.208 with SMTP id b199mr16919209oii.54.1495603007069;
        Tue, 23 May 2017 22:16:47 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:46 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 21/29] blame: create scoreboard init function
Date:   Wed, 24 May 2017 00:15:29 -0500
Message-Id: <20170524051537.29978-22-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create function that initializes blame_scoreboard to default values.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e343520..f839571 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2537,6 +2537,13 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
+void init_scoreboard(struct blame_scoreboard *sb)
+{
+	memset(sb, 0, sizeof(struct blame_scoreboard));
+	sb->move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2747,10 +2754,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
-	memset(&sb, 0, sizeof(sb));
-	sb.move_score = BLAME_DEFAULT_MOVE_SCORE;
-	sb.copy_score = BLAME_DEFAULT_COPY_SCORE;
 
+	init_scoreboard(&sb);
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
-- 
2.9.3

