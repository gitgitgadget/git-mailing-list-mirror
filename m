Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E591C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E331B20719
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa1LXCo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKWOtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:49:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43847 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKWOtA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 09:49:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id l14so7687163lfh.10
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3OtT2rirIH7XHYdJ8mtcDtYT9Y4YgaC5OpznLG+v7g=;
        b=qa1LXCo5xF70E1r0xTjx4WJPsF3SZUoF+Ae8mV+pXpoB56zbdO10klvdwVYSTN93wb
         CMRopbxSvcsX+rG/k/VF6a8OVFlxufMhL+zjRTzeEjzOdq/lf0h62IzvpBFFZkdHC/Hx
         8CFnnTht7OSEp/5WCo2mSZbzMnJeY+CX11qGA7jFlKbsvHMond2NVjqNrUmANvAMZh1U
         fv2KF3ubpHiYDnHdqqv9GM16h/4UzMeChPXnIodCIF0xdMPPioPIgwAJ6FFpgiNUziar
         mpIm8T+AT2ye2s7iOfmy9eWFRxEgyegx3Cj+/OSXRoXk2ZvRziCVdZ7fwyItQsQfgTmS
         pcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3OtT2rirIH7XHYdJ8mtcDtYT9Y4YgaC5OpznLG+v7g=;
        b=RZPnHP4k9eVgBhU0oOMDtTLQ429sVlKjGV6Ebo7qvN8EWQ5mswoWd9eK2nJzhfVxIP
         UfR0FfpPqWmCXnmnfIO0IQ/IKJjYKqoNlvg5dMgRyjnOV9f9SbVhNVO67+st3K7RIXuA
         SgH3xqlJ0JqGG+qnnX6/Kh/TkjlIEHdyHhE1jSH2AR7kZv1aZrjekbjiAyN+QWM3auJi
         +ESbjgjWdXtXs22kgsaOeJNwKI1MWxQIK0g4t5WmiEu5Fq8q33vzZw6bw4JdxutIpYUK
         5sDSsQ3FTk7buV/e8loUcjWsAhlQPQ7BhKYtqZFzYa+7fiey686ndj0OG6YnEf+E97Ww
         Nr1Q==
X-Gm-Message-State: APjAAAUwRxV5AeS814NIaSCL07ldC5zjVmIMIega3zd2A17D2YTKh6/T
        vUJnG6PLLD6y3rjs/BypAiIxXpt+
X-Google-Smtp-Source: APXvYqw6RpPTw0FvBsa4aUTgwkMHPHMWZTQiiz95ta+bklq1FS7GdVQan37/1WcyTmYxwBV/My1OaQ==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr5031425wrr.361.1574520040883;
        Sat, 23 Nov 2019 06:40:40 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id b10sm2399298wrw.53.2019.11.23.06.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 06:40:40 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 2/5] sequencer: update `done_nr' when skipping commands in a todo list
Date:   Sat, 23 Nov 2019 15:37:02 +0100
Message-Id: <20191123143705.17280-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123143705.17280-1-alban.gruin@gmail.com>
References: <20191007092641.12661-1-alban.gruin@gmail.com>
 <20191123143705.17280-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a todo list, `done_nr' is the amount of commands that were executed
or skipped, but skip_unnecessary_picks() did not update it.

This variable is mostly used by command prompts (ie. git-prompt.sh and
the like).  As in the previous commit, this inconsistent behaviour is
not a problem yet, but it would start to matter at the end of this
series the same reason.

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
2.24.0

