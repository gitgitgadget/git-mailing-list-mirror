Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E7920188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758882AbdENDQu (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35152 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758814AbdENDQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id m17so14324424oik.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=23mvhNIGmuWFl3XyrBS38SThloEx5GUoXRxsDlTkQNw=;
        b=I6fYWZTPlB9f4rIwIJy7XPzF3MwqOJ7VRCdOXJFR6zm9mierI4s6YpU19dc9xGwhmQ
         sAaUBU3uDr8faJPTxmKwx/Gw3a6Jq19C5rjLG7xcm8GL8RS6NZLaZtFgtaN7+bza4KbM
         8XLStb4THhM5LSQbyaQ4z6b5ke4S69qvM3nxs9vCBbPYxyrajmXR4Vtn1E2udE05tRH1
         y2epgttNCHsBKBZyFTFaxv+CQnk/Fazb+ix6Od/QrUblpwjNzlU0cEvtxJaThm4IBDsQ
         Hp5Kayc1cjDRZiMTGa1/QtA8ox3TdBlU9cN/6/07HftWYR24MZx66Mmvm+01d382tQiH
         vnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=23mvhNIGmuWFl3XyrBS38SThloEx5GUoXRxsDlTkQNw=;
        b=X8P0zcZ2DF/1E+gUzAU6WDa6ECU9+qXvCH5cx9ep4oVa59KaCxwgzExmaiKhJYNiYn
         msWsLagw6NEcqibuD3hmFFI1nIoeggdyb1XlHUl9LqVFl7jXZkwYuAfNBrOK/xJXKXGZ
         aFcBKWPy9qUCT4EJ7JT2arvO1dk6mC9xizYquDXXbG2ziFCbbARUsuAdD4ReTaOAvTrg
         VOY3B+ZQvU7RMewunIOXpZLXV5egFPqKHvzKIOL7rnf5BxJg0pEYRy2U4o0WfCvwcbMj
         SglV1xbOPS4npmYAHkVpUL2uDu2PqYGsby0qVkw1l0O0Gv/5flsLEUlTqKSxsSEPBU15
         yjNg==
X-Gm-Message-State: AODbwcAVMzpca7yS8p/yuvyOoXiMCjcFZj6i2bLTAB28zU02tHmwNuuM
        LQWXatNlEcVAoUAEEcQ=
X-Received: by 10.157.1.149 with SMTP id e21mr5096856ote.56.1494731792058;
        Sat, 13 May 2017 20:16:32 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:31 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 20/22] blame: create scoreboard init function in libgit
Date:   Sat, 13 May 2017 22:15:11 -0500
Message-Id: <20170514031513.9042-21-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 7 +++++++
 blame.h         | 2 ++
 builtin/blame.c | 4 +---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 798e61b..17ebf64 100644
--- a/blame.c
+++ b/blame.c
@@ -1574,3 +1574,10 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 			sanity_check_refcnt(sb);
 	}
 }
+
+void init_scoreboard(struct blame_scoreboard *sb)
+{
+	memset(sb, 0, sizeof(struct blame_scoreboard));
+	sb->move_score = BLAME_DEFAULT_MOVE_SCORE;
+	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
+}
diff --git a/blame.h b/blame.h
index a3ea677..9477b6e 100644
--- a/blame.h
+++ b/blame.h
@@ -171,4 +171,6 @@ extern unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entr
 extern void assign_blame(struct blame_scoreboard *sb, int opt);
 extern const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
 
+extern void init_scoreboard(struct blame_scoreboard *sb);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 207a74d..e01265a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1026,10 +1026,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
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

