Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE13220985
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755541AbcIKFmv (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36741 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755489AbcIKFmo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id x24so6261030pfa.3
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ym9XhrcLDjbwom5mcyu7UePeOgizo0cVzs1xHTKMwEY=;
        b=CszZC0bnVrFxsMGPYGBQZrzl+fD5X/NVGmrF6JE3by9oaa8jgVngW4TkKj6OsktUDw
         CIB1tE2iT7XahgK5RbHYekRdO2OQJL8wBQKksgJbrUXjlz9aBchC77fq3dPS2yya+OOM
         AN1EPaFYoPaHH755NO/qyrTjeUg//aWK1CFC5sMTUtO68gkvBvrFZCOfA1PrmPq3rpOu
         leQuSc0qD97bBPJP+6nLQlskN7i+90ulYU068zu0RzeObPym/etEufdMei98/AiTFWHx
         gV8RmIEJuvfWunWq/jbz5WwpWLG2eNmL/fNalZh8Lc/0AOiDNf2LwkoZh63J6ybTA0LE
         +n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ym9XhrcLDjbwom5mcyu7UePeOgizo0cVzs1xHTKMwEY=;
        b=XWgiYNyBNKF2rWTpqonBibIw+yHYQeg4fWXcvWUU4nmnJCShseHce1vt8rR8zvhfeo
         JXQWHwu2uqKv/QXf0xd4jPCeuo4Eo7WqljM6sLbDoav1u7I2+hACDPpnv43bdhp4ptoq
         h0l8MvQTSPCkPnMCqLb8arpPmBTItCBYMKoWmU2ioBy2RuuBPza2GXFX3sd7rmHps0Mo
         lQqAOHM1z25y4r+caAWj8M4tmAn54DigrcUp/7IT/YuL8fBHIHE1wxHGXJK5e9/6tZcv
         MjanXfjZmXMyvUHTKbBKUQHP0nFtcjxz5xqp2LgX7+qqHrBuzCw7E5qHFs2eO6GLdw3d
         Y0eQ==
X-Gm-Message-State: AE9vXwOyPFGxlO23MxcD4FNTzQpTVdNfUhoBBGF+y/CoqePD8vFZq6YOym81AnuR33dp2Q==
X-Received: by 10.98.150.213 with SMTP id s82mr21721437pfk.86.1473572563991;
        Sat, 10 Sep 2016 22:42:43 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id bx9sm15517283pab.17.2016.09.10.22.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:43 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/10] diff.c: convert emit_rewrite_lines to use emit_line_0
Date:   Sat, 10 Sep 2016 22:42:09 -0700
Message-Id: <1473572530-25764-10-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 98d6655..255fbf3 100644
--- a/diff.c
+++ b/diff.c
@@ -690,7 +690,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 	if (!endp) {
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
+		emit_line_0(ecb->opt, 0, 0, 0, "\n", 1);
 		emit_line_0(ecb->opt, context, reset, '\\',
 			    nneof, strlen(nneof));
 	}
-- 
2.7.4

