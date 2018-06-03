Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456BA1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 14:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeFCOg4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 10:36:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33533 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCOgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 10:36:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so11016019wma.0
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7MC5xrz4xJ1at/NbJaHdbXRmplcZLnKEG9dTheufaTM=;
        b=mFaDGV8P2pGH2uczOjwVL1PmkjkyCuWkngb8vjkGhfrrDloh6sGOPEV0HMZTbk8j1T
         gnV8RPPXklylI/NaGR6vc5cAIwDcqgnu4Z7NDadjTjjMGnaC64Bi4yDAGkcUKtz4wwYg
         QLcqwmuO6Ft09pwEBlP7kyIJln9KSOaGN81x8e61lBBEciYFMhs4VESm2mEOM3G3zcah
         7srPkPoGWs3yH2+5Q0yMxOTUCiy2AgV03+1ouSqpPyq36MPv0qcklUibLM6IxDHAEOfZ
         34jPQQbiPBlSogSVqB4btj+mo0v8UI85Jl7ACgh6gIpsvvA/moi6xFAJvUaUYTU7N/xy
         zkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7MC5xrz4xJ1at/NbJaHdbXRmplcZLnKEG9dTheufaTM=;
        b=KHwzHHIiq2MAFG+px8srUjCH+ab5oaG+fOCazhy8aWAgXa5/ZTw67m6J2mDx2tElj1
         SgL6XRSCKO1QFHYVclYLSgKw790aweW9VwtFnLbJrLzBW7uC4m5ZIy0Yy8pnax3VHSvj
         Z46EVKOeKrd+A5wQFxH7zvvXJsg6JDWaSMqbI2zjVtYikE81jMH/a0kNUKLCu6NFEhAf
         O0H2/fJRM8Wi1YftriMZ2Rb+hErFkTDOBS4ayoSa8isDRpGSGDWRrkQdm4Ksz5EhpxhE
         kJZwlXxNoLp+X0Tqq6FV1h6flRg6W5td70Pg9N+tTZh+uua4jtmmJ3W0XJhlEY3YmplA
         0QDA==
X-Gm-Message-State: ALKqPwdLC/+G3O+n1X9b+hqG5ST+tRApN3eW4TwoSVVoY77PiWkr0wP9
        UWLU7XOW4fWIc2VzYwcXJUS31Q==
X-Google-Smtp-Source: ADUXVKJ7FB8s6HxCtmsJ9J16ScJLI8DT4hvaYBYNzU5CpYa7wWlspjjQBEokI3PBtQm79mEHV3zj7A==
X-Received: by 2002:a1c:2143:: with SMTP id h64-v6mr7810333wmh.114.1528036614462;
        Sun, 03 Jun 2018 07:36:54 -0700 (PDT)
Received: from localhost.localdomain (x590e56c9.dyn.telefonica.de. [89.14.86.201])
        by smtp.gmail.com with ESMTPSA id g75-v6sm9609649wmd.15.2018.06.03.07.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Jun 2018 07:36:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] update-ref --stdin: use skip_prefix()
Date:   Sun,  3 Jun 2018 16:36:51 +0200
Message-Id: <20180603143651.6844-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use skip_prefix() instead of starts_with() and strcmp() when parsing
'git update-ref's stdin to avoid a couple of magic numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/update-ref.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4b4714b3fd..4fa3c0a86f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -311,11 +311,12 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 
 static const char *parse_cmd_option(struct strbuf *input, const char *next)
 {
-	if (!strncmp(next, "no-deref", 8) && next[8] == line_termination)
+	const char *rest;
+	if (skip_prefix(next, "no-deref", &rest) && *rest == line_termination)
 		update_flags |= REF_NO_DEREF;
 	else
 		die("option unknown: %s", next);
-	return next + 8;
+	return rest;
 }
 
 static void update_refs_stdin(struct ref_transaction *transaction)
@@ -332,16 +333,16 @@ static void update_refs_stdin(struct ref_transaction *transaction)
 			die("empty command in input");
 		else if (isspace(*next))
 			die("whitespace before command: %s", next);
-		else if (starts_with(next, "update "))
-			next = parse_cmd_update(transaction, &input, next + 7);
-		else if (starts_with(next, "create "))
-			next = parse_cmd_create(transaction, &input, next + 7);
-		else if (starts_with(next, "delete "))
-			next = parse_cmd_delete(transaction, &input, next + 7);
-		else if (starts_with(next, "verify "))
-			next = parse_cmd_verify(transaction, &input, next + 7);
-		else if (starts_with(next, "option "))
-			next = parse_cmd_option(&input, next + 7);
+		else if (skip_prefix(next, "update ", &next))
+			next = parse_cmd_update(transaction, &input, next);
+		else if (skip_prefix(next, "create ", &next))
+			next = parse_cmd_create(transaction, &input, next);
+		else if (skip_prefix(next, "delete ", &next))
+			next = parse_cmd_delete(transaction, &input, next);
+		else if (skip_prefix(next, "verify ", &next))
+			next = parse_cmd_verify(transaction, &input, next);
+		else if (skip_prefix(next, "option ", &next))
+			next = parse_cmd_option(&input, next);
 		else
 			die("unknown command: %s", next);
 
-- 
2.18.0.rc0.207.ga6211da864

