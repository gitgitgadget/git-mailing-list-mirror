Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF4C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3918B2465A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnat4KXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLMIIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37599 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLMIIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so5532739wmf.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gE7TdA4S7ydhUPwwWQ9b9w+MPUTElkGqFGCAyzeiKyA=;
        b=tnat4KXdWzhA7TBFlkuPDbXLXyIFkYTmngcIO9mtv6OgPG6FtOEJpLQQO9ZbJyKtOB
         GS9mKc8IOua/QF57mlTQP1ccd7QqPd2CT155/bQH2imNU276eXfVeIEdyY20lroXsR+R
         3QapQnUmHFyEm8EgUEm9z1dRBStXmiUjQOst68ShUwdv//RjqN3kX9qnXWP8pNUTWq4e
         m1sma9y45j9e8f4KjSCNzrcKkczM/pPEOu0oHhlE2DRERrZ2XinTYJcdAYRgKnmJmhUx
         LVHAk4d46y6C0ZmKlp2izpN7zyLe/Ztpx+0pAREh60nOXH655r394bx/ak/P6sLxeA1t
         /9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gE7TdA4S7ydhUPwwWQ9b9w+MPUTElkGqFGCAyzeiKyA=;
        b=mEM0+ucfGp/xOLQJ+GH3o1qnFuKbaUnQvCUBOEIGR3FImmLsdpT6b+bM9o4ELZsvGZ
         9L6GsjR49h2N1efU2gDvc6uKqtarbwK0gLr2ykr7RmVoRzccbXWdTmY5WxZy5CLHiwKD
         tpB247JJGeAkD3FBaOu76QAhk/ZfVfHuSTO7qJzhOoyNY9azfP7C2lqml8Zn8Eo9wpgf
         vS8LYD6B15fDfwN9tB2xdwOvlKSpdfhaLVsZQKg2GjLZWfcaJBuxsBGnslcJHQyxKBux
         rdKsauhAySn+3bopVU0HsNOK5dBZhHP9yRWcgek9h1NO+c2hc3uyQQVbwPwobYNBxA8p
         w2/A==
X-Gm-Message-State: APjAAAWvnu94cK9IYJbZZtWMk7M07DW1NuzzL7llp+Gr9VlGDUuwgPGz
        QMlR+14aaQgMOQhNnloEtm7Q6M1P
X-Google-Smtp-Source: APXvYqyF5PrcROXg77lRqAitaSfDvTulXlcyx1damJX9lrEcUSgolA0cTlHTtTeMgKSKmbus85FYDQ==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr12493627wmb.43.1576224492904;
        Fri, 13 Dec 2019 00:08:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm9038363wrx.20.2019.12.13.00.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:12 -0800 (PST)
Message-Id: <9ef0db2d8826f2b5c884d9e9834eedc89cd29c39.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:53 +0000
Subject: [PATCH 06/19] built-in add -p: offer a helpful error message when
 hunk navigation failed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

... just like the Perl version currently does...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index dab2ff2381..f59471cdf2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -34,6 +34,18 @@ struct add_p_state {
 	size_t hunk_nr, hunk_alloc;
 };
 
+static void err(struct add_p_state *s, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	fputs(s->s.error_color, stderr);
+	vfprintf(stderr, fmt, args);
+	fputs(s->s.reset_color, stderr);
+	fputc('\n', stderr);
+	va_end(args);
+}
+
 static void setup_child_process(struct add_p_state *s,
 				struct child_process *cp, ...)
 {
@@ -368,17 +380,27 @@ static int patch_update_file(struct add_p_state *s)
 				if (hunk->use == UNDECIDED_HUNK)
 					hunk->use = SKIP_HUNK;
 			}
-		} else if (hunk_index && s->answer.buf[0] == 'K')
-			hunk_index--;
-		else if (hunk_index + 1 < s->hunk_nr &&
-			 s->answer.buf[0] == 'J')
-			hunk_index++;
-		else if (undecided_previous >= 0 &&
-			 s->answer.buf[0] == 'k')
-			hunk_index = undecided_previous;
-		else if (undecided_next >= 0 && s->answer.buf[0] == 'j')
-			hunk_index = undecided_next;
-		else
+		} else if (s->answer.buf[0] == 'K') {
+			if (hunk_index)
+				hunk_index--;
+			else
+				err(s, _("No previous hunk"));
+		} else if (s->answer.buf[0] == 'J') {
+			if (hunk_index + 1 < s->hunk_nr)
+				hunk_index++;
+			else
+				err(s, _("No next hunk"));
+		} else if (s->answer.buf[0] == 'k') {
+			if (undecided_previous >= 0)
+				hunk_index = undecided_previous;
+			else
+				err(s, _("No previous hunk"));
+		} else if (s->answer.buf[0] == 'j') {
+			if (undecided_next >= 0)
+				hunk_index = undecided_next;
+			else
+				err(s, _("No next hunk"));
+		} else
 			color_fprintf(stdout, s->s.help_color,
 				      _(help_patch_text));
 	}
-- 
gitgitgadget

