Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9601F461
	for <e@80x24.org>; Sun, 19 May 2019 17:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfESRvI (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:51:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40826 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESRvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:51:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so12017662wre.7
        for <git@vger.kernel.org>; Sun, 19 May 2019 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/9TLUQwVvo63x2uenDevNmrLi4IBS/Pimy/1vY27d0=;
        b=boTinGGUFnatB92Whdq9Dgd99o+sFyrgbLVUOeEaM5m7uAtH2jRE1dKd/TgQDOvnXc
         59Ip5dyseFlCtcZy+A2+Wrvell5a2aBLzIV8B6EzLp6/5d50T/UWukOzgz2twjge6X/8
         wDaIctuXbhxSKfyMhmQlAw9d1ttuAUGBLjXWNm9L/eG6SDJ9vA9liAWy5zOdQiRhAIyk
         WugsZjxtOlS4yi931J5qnLAhlN7e4UldyJ2L5RoR03FoXa264D1rUMCcnILovF9OrQAm
         vOElfqpPwgSWwJu2MPYWsS7f6/kvVuIB1CYL8Oma9Hh4779oiRP0quC5m6yTBOuU5gHe
         Lr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/9TLUQwVvo63x2uenDevNmrLi4IBS/Pimy/1vY27d0=;
        b=B0E0Ci6tbfLy0WgZeRpoovpdub6kc2Po7W8RGWkyytA2yZ+dUyKrGYjm8a+ShF4YF2
         ejKaycEDu6POGkY7GLhNbUYqlkNXd/KU/30EpmctjrpwceoWn1RF9Gb2ezK9le58T0lN
         H41myfvxhRZiJFRoNfgBLDDikIsKXDy/F1Wh4Q8LPkbDO04JE2W1OIGlfq2Nmpx8w7Nc
         79dP0hoKZgssBGBepmjPnoSeJGBi4Dz+ZkRjTFPzkb8n2n/BGO+5bXrS2yigMo8kR6nu
         fFpUqJA3F4vzk6rA4csxWKqRJ+0J27P1zjOI2WiafayN++MWqZjLhUCaMoInfvqHYJYq
         SUlw==
X-Gm-Message-State: APjAAAXSio7WFnvTuS/g35LOmfOVf++dgAWscXSh8d4wRVllQ81863vB
        f4a/MuHZePXr1lty19iTCjOuwvos
X-Google-Smtp-Source: APXvYqy6ncm19aNcwpFSjIGYUT11xNzuXneFXBaZzGLGcxTLURH4FN9D73eDvEebbleyyIM79YVr+Q==
X-Received: by 2002:adf:e301:: with SMTP id b1mr11237229wrj.304.1558277150348;
        Sun, 19 May 2019 07:45:50 -0700 (PDT)
Received: from localhost.localdomain (x4db573a6.dyn.telefonica.de. [77.181.115.166])
        by smtp.gmail.com with ESMTPSA id b5sm12608891wrp.92.2019.05.19.07.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 07:45:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] progress: avoid empty line when breaking the progress line
Date:   Sun, 19 May 2019 16:45:46 +0200
Message-Id: <20190519144546.9978-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.424.g15834b9bb1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 545dc345eb (progress: break too long progress bar lines,
2019-04-12) when splitting a too long progress line, sometimes it
looks as if a superfluous empty line were added between the title
line and the counters.

To make sure that the previously displayed progress line is completely
covered up when writing the new, shorter title line, we calculate how
many characters need to be overwritten with spaces.  Alas, this
calculation doesn't account for the newline character at the end of
the new title line, and resulted in printing one more space than
strictly necessary.  This extra space character doesn't matter, if the
length of the previous progress line was shorter than the width of the
terminal.  However, if the previous line matched the terminal width,
then this extra space made the new line longer, effectively adding
that empty line after the title line.

Fix this off-by-one to avoid that spurious empty line.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 2d8022a622..a4da26c2aa 100644
--- a/progress.c
+++ b/progress.c
@@ -127,7 +127,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 					(int) clear_len, eol);
 			} else if (!done && cols < progress_line_len) {
 				clear_len = progress->title_len + 1 < cols ?
-					    cols - progress->title_len : 0;
+					    cols - progress->title_len - 1 : 0;
 				fprintf(stderr, "%s:%*s\n  %s%s",
 					progress->title, (int) clear_len, "",
 					counters_sb->buf, eol);
-- 
2.22.0.rc1.424.g15834b9bb1

