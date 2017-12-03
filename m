Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A5320C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbdLCWST (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:19 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40474 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbdLCWSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:01 -0500
Received: by mail-it0-f68.google.com with SMTP id f190so2267013ita.5
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/PWyyBKdDrJ3Ji6ooJojSWSsXDf+iDcUN+vVX8N9PMI=;
        b=juCp3/hmckTuXtgS7Dv0PibldiLYmDIhZ0Zf/ve6HHY0tRK4/RmS1C9+pSaG7D+eDG
         NLf/3EAwz1NpB8nRNtTXaDfcsd6HmONioDQQsFDkbUH+S7L0IZwHH1G5o6gSNyXaMpQ0
         qH6W5SWEsr2uAcLQ7GHjz/rn+qXfr+5QY2EQF56KLPsNzxll3vVEptOnQ0Pn8TAkAGcs
         z12GwpN9B/93FUOdPRLbJyO2xJoSkf3EGif1lOfZN3Vs/agna/4NIGPbcEW4w772zUtl
         I97sRwcIvCi2G19Nts7FgkNkAGjWFGYystPWHN8bRm9kv9oN1viG51v1JybYBFHGLVAl
         DNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/PWyyBKdDrJ3Ji6ooJojSWSsXDf+iDcUN+vVX8N9PMI=;
        b=KT6X52afv+HC9i3BbjU8PvN5jlnVC9NesJQ7dCWPoBiI3tCJmmQgZUt9fqEMGellqA
         /I18GkeX8W+PlOWVY+jWiudctCk1mpnYuWd8SgN4a5jGWkO9RByS+Pnx+eMzBDj1qzHM
         nPNTIqWFavsP//fBbGHx0JOx7anBHrisKUGU6ttVHQOJ6+Df6voEfTzmfwL10275MvnL
         oeCn3U2gQIp0xy2G09ZDOLyPbW+DK76xa+TT0sverfSvdXv1E1RsQjIh1SDXCrgTOGpC
         qllrDu5GDHGiAP71pW+cRG1c8rLpGz6Ok6WHz5ABT16ReU9r23wI1JeFAnc1SFy/hN7j
         Qzhg==
X-Gm-Message-State: AJaThX6owCecXD6jJfF1mbIEbHy80M9JYRgdIChH3M0YsRy3O3SSBK2X
        sioLltJgSHnfAe/6To5UbFMZAJQL
X-Google-Smtp-Source: AGs4zMasM7YqZhGTGKx03DP//Znk+53SKkoZxz6hz9/pfapFvbq1IbzA6c63IXD6VwlMoIO8cWgvww==
X-Received: by 10.107.18.168 with SMTP id 40mr22196770ios.55.1512339480361;
        Sun, 03 Dec 2017 14:18:00 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:17:59 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 3/9] rebase -i: set commit to null in exec commands
Date:   Sun,  3 Dec 2017 17:17:15 -0500
Message-Id: <20171203221721.16462-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure commit is set to NULL when parsing exec instructions
from the todo list. If not, we may try to access an uninitialized
address later while updating the todo list.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index fa94ed652d2c..5033b049d995 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1268,6 +1268,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	bol += padding;
 
 	if (item->command == TODO_EXEC) {
+		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
 		return 0;
-- 
2.15.1.280.g10402c1f5b5c

