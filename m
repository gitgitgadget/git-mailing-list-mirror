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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0C4C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAF220719
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ36Arvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKWOpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:45:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36100 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWOpy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 09:45:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so8994523wme.1
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6T8n9ofQ5yvpBR4OTB57nmZonnh7MyJGYi+C89M7Zs=;
        b=BQ36ArvgCPW0tHw2AqNzZaRX+KFj4Yz/e9v/DFRgHlmfR717mLWNr9gbYzE0nq+3kr
         E2sKeUrGraM38d1uUzPYYNaOBgPwhfDzMQxMhIwtiCmVc0SSMs0n1ekCTfm+6KQKNNdC
         8bdcHTypZlvETx90quvgTofKOeeNhh2HC8IyYs8/u4UXFW08yglnYytXR5CD2GfUXPXC
         gpYGoVf/1UOV0NRxMlKPcXGNuW5A41G4NnxSkPSr0eLay7s6379En93c5wvBmgcjE7Tf
         WXSibkGzGJYd4q7g/KYHsF3Pm/UIWQTopCKSyPIHI5DMVWXRbJbg9Xi6qRxv0311rV7e
         gRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6T8n9ofQ5yvpBR4OTB57nmZonnh7MyJGYi+C89M7Zs=;
        b=P5GmVpcawaoKK9/fupdUCRDD59Sh1vDuMMZ7He8755qhCfv19cCQNea33lY/2hYrMC
         z0YUW2cfzC0Fv0s6MqdGcsJbZm6nsqa6KGZh5NFrA1ViAX8K2FHnt7wuCC7PTFrwf34L
         syUumuQ+OaUUbiZC3hhMS5Pn46AmxE81SUrYrQowuaCnuJtxxM4jb2l8G+chbAtLnwnf
         FsEoMsLiJKBG5aUjObnIPgKrZmcstQr7N+g1QMr4VJIdsI0YNIMPbe3d3RBCW+zHZjoU
         zej6OiAaXow8HWxdvG+Mjs3Bwfe5qmaoTq35XruGKxMhzt0dYl0W7jqBOQiUYM4RylYR
         05UA==
X-Gm-Message-State: APjAAAUQ411io1NjPzZCbZpdmIn0X5xVzLJGKHAhvXTsAV6cPuEWUNa2
        Yn/iRpZGSMmQboS++gqODVUj57ua
X-Google-Smtp-Source: APXvYqytFmJUQOm8MK8eg7pqx+vJ1KvISDemqG8k0h6fv5wQJWIdoJuM9oqlkugA2/lgQtdDb76ing==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr20547783wmj.32.1574520039766;
        Sat, 23 Nov 2019 06:40:39 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id b10sm2399298wrw.53.2019.11.23.06.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 06:40:39 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 1/5] sequencer: update `total_nr' when adding an item to a todo list
Date:   Sat, 23 Nov 2019 15:37:01 +0100
Message-Id: <20191123143705.17280-2-alban.gruin@gmail.com>
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

`total_nr' is the total number of items, counting both done and todo,
that are in a todo list.  But unlike `nr', it was not updated when an
item was appended to the list.

This variable is mostly used by command prompts (ie. git-prompt.sh and
the like).  By forgetting to update it, the original code made it not
reflect the reality, but this flaw was masked by the code calling
unnecessarily read_populate_todo() again to update the variable to its
correct value.  At the end of this series, the unnecessary call will be
removed, and the inconsistency addressed by this patch would start to
matter.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index d648aaf416..575b852a5a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
 static struct todo_item *append_new_todo(struct todo_list *todo_list)
 {
 	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
+	todo_list->total_nr++;
 	return todo_list->items + todo_list->nr++;
 }
 
-- 
2.24.0

