Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03DC43215
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C310207FC
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ1UIPoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKXRpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:45:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38199 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKXRpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:45:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so14716790wro.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2jD4uRKBSr13QcjVhqXeICyQyuEhi7TRuZICo8Fj/Q=;
        b=FJ1UIPoigd1e7pkVrn/2n+U7vU2Yw9i6pgySU/opMvBHnTOIa9Fc0VJx7j1/7iYis2
         x5ewiCNebl0/ljuRiHVY8FTuxRO1wvkrQflb7vJStIRnyYf7YcY1BPPYGCqG8NEVfsdJ
         7GUGMk6lr3/tvbEDkdTMuadBODdvLnMuZggXAhqD9JNoTnFX8Z17W0OyXnMovBwoYd/S
         NFtMS/5djZewZ00e6C4Ukvr13dLarRzQDtnJGnzMTmNYx7v2hHsYkR+/L2mFbCf+ltaG
         Sy8dTb0j+NozTIH0HvOqNfEgRQmRDqeEz2f2TSsODI2sE0iz1IX7E0xqgz/FyKGzzc+m
         2v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2jD4uRKBSr13QcjVhqXeICyQyuEhi7TRuZICo8Fj/Q=;
        b=iCkavcezykNxfqKiO6k7ryH2zfaEAqVArh2l5cRDwgFb8Is9uIo0yri8VqT43RiSZi
         ds+lP0EnGhgFyCT1gkUGkW7HhJ4qJQW1z3c+nuCpM8G0kidigoi620woMmI1dEqwKhhr
         IQkWT0I5firMMfynLzgL9LKMNomUPMspGI330KioTVf7eg8CDXhrhnKuuDkq0IMVBEQe
         oxn4ghADGHN1bIabJ0z8BHPHgeDHw7RM63xbWZnIQla1u6jZt5YhH2N6s5CExDQLQ6Up
         2gfw/QZFuRtlA23d6952h1vUbA49SciwqlYhnPiZw0i0yyMlJePxdeUtZQ8PRCYiy+SQ
         txvA==
X-Gm-Message-State: APjAAAXroTETqeK+0H3X7RMQPBkfbysao7P0hZJ2sYIpqEtPjHWJeQ7z
        3qoIaMwfJQRr29CL5tsevX0wDm0D
X-Google-Smtp-Source: APXvYqxeoQVgw2I8/mqBwqkyQCGtenLANbC0lCUyQjtTrGeeO8UEuSR3iUkCId2AlcoGlzXsxT0Qog==
X-Received: by 2002:adf:e550:: with SMTP id z16mr4236921wrm.315.1574617539317;
        Sun, 24 Nov 2019 09:45:39 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id a2sm7171315wrt.79.2019.11.24.09.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:45:38 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 2/5] sequencer: update `done_nr' when skipping commands in a todo list
Date:   Sun, 24 Nov 2019 18:43:29 +0100
Message-Id: <20191124174332.30887-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191124174332.30887-1-alban.gruin@gmail.com>
References: <20191123143705.17280-1-alban.gruin@gmail.com>
 <20191124174332.30887-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a todo list, `done_nr' is the number of commands that were executed
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

