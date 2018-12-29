Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55351F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeL2QFD (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45359 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeL2QFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so19652860edb.12
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhF+XoCAoPrGXDEYfk4Alym/AVeTqO8MeQXZMa4W2lA=;
        b=NSVDEGjYq25h0C29MYeG3F+iOqoSDrh6HFihGsio6xyTHwJu7H6hwbeYwxKLLz+UwH
         geDSkN4dGJJ2tMReH0h/GahLxoXd+FQrjohFR7hAlPy6y/3q1y/GR/UnS5UABMd7udfv
         UhX9NjLOMkm+SCCN6Yn654ACXk4w4uL6DK64MqL9SjGa/cmjveFDx573Ubqy/Ok+/LXP
         P7NOBJ/pxPLc6i7mvlsc0IY2+NXTl5BF4GXo7IVsqoYoCXPLtFjb9jfHSjSxeysFLbQK
         LjkCgeEC0Nd0rE49FGZg6QIZs7Ri3wTqQXJkMGjHSFKC8NqotD7OzpJfJuJNBecRvTJM
         AhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhF+XoCAoPrGXDEYfk4Alym/AVeTqO8MeQXZMa4W2lA=;
        b=n145/29cegaEcJYmr+uK4+LBHDtdIIzNjVzMVMQiPW66qjmPRcefV14O0QF1J8s1mc
         gTB76zY+jBKWyL7Z12Bel/ur5a8MJSSe/peP4YJ2olEbR1D4DF81mDSRP0H2fvzx+WuW
         wLpOYao/C6E3CdKEkdTVoWXt6FNxLVfniLMKtB9C2rWWQ0rm2ZXMn2OymSgNUk7Gd8VL
         hXUArwSecj/EkVcruIizfiowXa6Q48JNCFkZ0rRFpMOHuQfkkiwE8YOOLFG45wbOaQ0h
         4arIIHSpR/H4MWk/eIQh4UMQzDv21fsEGTnUD1GIO28YJ2/Ql2nu8dEAcvSor1LnGb19
         JHzQ==
X-Gm-Message-State: AA+aEWZILORLrLnO8yzICqYoSgFfk95If8oFm+mDuv+nvqJi7SK0s4on
        JdY+ETx2hH1SCSSJblxK7MREq779
X-Google-Smtp-Source: AFSGD/Wz2qKxW4gVaW0P8dzLG4m81NLOlI3ht0KJeH7vyNKLPUC1k/ePP8jSpkdQyVoBKCX5Ti62Fw==
X-Received: by 2002:a50:8bb5:: with SMTP id m50mr25487002edm.211.1546099500696;
        Sat, 29 Dec 2018 08:05:00 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:04:59 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 01/16] sequencer: changes in parse_insn_buffer()
Date:   Sat, 29 Dec 2018 17:03:58 +0100
Message-Id: <20181229160413.19333-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clears the number of items of a todo_list before parsing it to
allow to parse the same list multiple times without issues.  As its
items are not dynamically allocated, or don’t need to allocate memory,
no additionnal memory management is required here.

Furthermore, if a line is invalid, the type of the corresponding
command is set to a garbage value, and its argument is defined properly.
This will allow to recreate the text of a todo list from its commands,
even if one of them is incorrect.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
The full diff changed due to the conflict resolution with nd/the-index,
but the "core change" is the same as in the v3.

 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d726f77e11..a7afaf6882 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2091,6 +2091,8 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2104,7 +2106,10 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 		if (parse_insn_line(r, item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
-			item->command = TODO_NOOP;
+			item->command = TODO_COMMENT + 1;
+			item->arg = p;
+			item->arg_len = (int)(eol - p);
+			item->commit = NULL;
 		}
 
 		if (fixup_okay)
-- 
2.20.1

