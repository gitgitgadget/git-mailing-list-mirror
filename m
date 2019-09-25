Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92471F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392966AbfIYUNx (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:13:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51769 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfIYUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:13:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so117112wme.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q32P1WqcgYd8m8YbrvCFu8ke9M5+bZk/HZ8TyMKYDZo=;
        b=p/NDlu5hraZuZiuB4QQT/w+oSesznIP1qxQdsDMrhGImdNL4mE2WSLTqyqg3hS5u4B
         sGtvczv6Al5oFXPrxcPWAP/5XnzEuaoI48IML5FwVEvXxF9NtUEBHbiO748Bb3CS4ggc
         QCdAL6hjZPqvqsxmvElK0qfkKcKBh2UM7MAfk4JeJen9VW/NEml+MivANTs/13CwWR/g
         h9k1Nxw0IwZfohWCFNSznTd1HBewzFDQyYYa4Tky/egkPWhQfaF/mnnYBBlm+ob32Id3
         gpioDGkBj5iQ5kgRFGvdXTanHDK12Dwu9z7pKBWXnQ8LjesHbTM5Mjb/49mOKZdzJIzM
         bqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q32P1WqcgYd8m8YbrvCFu8ke9M5+bZk/HZ8TyMKYDZo=;
        b=A+RkZbU6kT8PjzSuGibDenhx73+hYUzdShw3CLWgBRRdvdfku06RS7YA+yHMJJBxIZ
         kTamqCObtCYoSM92WE8X+PiyJYP26XI6Hez9FFo3zUGkF8aNtVx6mhgN8nkSW4qvTSzr
         6obr5Ts9cz0prRwx75WZQ0lOA4kQed0xCOckJBzA7ymD/c2UhwUpGeQ5R4KRSlDl1NdX
         NGfjcZuvgU2qYyOqQvZvyLFM13is0eIY/p0wLUAUeQI196rUku1nibp60U7vjxJY5PWc
         Zly5uBQ8OkLkl3oPYYZqxAAUdw9t/9QsZgnbb7WN/IsTYZQclGXUF79sXplCCC79Ku1e
         Gd9Q==
X-Gm-Message-State: APjAAAWE25HdYp7Cis6Vxo45yegLyIJVqQnNyBeXUSDNmDpdMm+h4OIh
        8atYaFFdMaVu2REKoOEkaUxWT2H1
X-Google-Smtp-Source: APXvYqzgbMaCO3pYL6UuumXZMnJtW3PG6fbWLqkqvuFK6JTsxKEGr8RfM+7ARes+lI8zpgMa2vZE0Q==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr34906wmc.124.1569442430344;
        Wed, 25 Sep 2019 13:13:50 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.googlemail.com with ESMTPSA id d193sm138022wmd.0.2019.09.25.13.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:13:49 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 2/5] sequencer: update `done_nr' when skipping commands in a todo list
Date:   Wed, 25 Sep 2019 22:13:12 +0200
Message-Id: <20190925201315.19722-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a todo list, `done_nr' is the amount of commands that were executed
or skipped, but skip_unnecessary_picks() did not update it.

This variable is mostly used by command prompts (ie. git-prompt.sh and
the like).

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 575b852a5a..42313f8de6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5054,6 +5054,7 @@ static int skip_unnecessary_picks(struct repository *r,
 		MOVE_ARRAY(todo_list->items, todo_list->items + i, todo_list->nr - i);
 		todo_list->nr -= i;
 		todo_list->current = 0;
+		todo_list->done_nr += i;
 
 		if (is_fixup(peek_command(todo_list, 0)))
 			record_in_rewritten(base_oid, peek_command(todo_list, 0));
-- 
2.23.0

