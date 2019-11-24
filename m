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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93646C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73882207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp/3PY2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfKXRpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:45:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39966 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfKXRpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:45:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id 4so11393917wro.7
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6T8n9ofQ5yvpBR4OTB57nmZonnh7MyJGYi+C89M7Zs=;
        b=Gp/3PY2YYK8mbWZHHYjFdj99m8qryCBDCBDyIn2bvVijQWt4N4JK7OxfWT5QcojZPy
         uiRy1Wza1DczGPU1FE508QbUCZ8nOJgOGP71Ns4g/DgnbOMghBgplUwrk4iQFd1pfRIC
         pMBUC6eRYs7rnon1Z0+/1BWeGtgRJjpthZnhxAez82cxUXZ4oggSJcmFJYUhX83Ng1/q
         MlwqDTFjt8SY0zb7bPLfkAi67SA65WCdarXd/9uUaiyIwdF3+1hKLvnHjO1HIMoIQmj3
         +Qv7saUIhrK2/clLHpDbNDCr+v7WWIdoLsxAuFOz+EvPLsdI8o2gjLmBOuJx3MOzLkAY
         LR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6T8n9ofQ5yvpBR4OTB57nmZonnh7MyJGYi+C89M7Zs=;
        b=LjMDYa8BvAzzr5yhnHfv9i2MotfFjpsHtJInv3dQmTasm9B3ugB9q28Xlsz7NFPc3B
         Dm4YgZ25zcgmYv+9xJxL1/lzXHgTM8t5RuHimUMfHWL4qtPwlEh/Oxf2w1CMolfUhJf6
         cWzcj7LbquVqt14jqxqB44naNChEcbvTLp1NfZfe4o2OEZuHf1ACc6k2L9uBZp0MZut3
         aSFUHh80tcVF3hThKRqmK7+hbro0PHkuyKqJavJp36IIZuibk+6wkGgBvqH907z+YzPd
         gxJyAOx5LzWCpVLt8d0MpvcolCkVpwrkQHPM4L25Vmv+PBtng1I/YPBJGzVleDKcWQhF
         +fYQ==
X-Gm-Message-State: APjAAAXE1IDDt3AhkT72HRFvEczYzsTiX+udnE3ix9k/HRuzatKW6L5Q
        TIaNpQJchzIH9fAOTkhiXQPNl0/R
X-Google-Smtp-Source: APXvYqz+iDa18ChYjM7hqdpugqEt7YJMn3ljQhcJojJhcqIstbCDCqpzua0f+nM5vcusfLkTSvPFrQ==
X-Received: by 2002:adf:f489:: with SMTP id l9mr26368248wro.337.1574617538279;
        Sun, 24 Nov 2019 09:45:38 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id a2sm7171315wrt.79.2019.11.24.09.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:45:37 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 1/5] sequencer: update `total_nr' when adding an item to a todo list
Date:   Sun, 24 Nov 2019 18:43:28 +0100
Message-Id: <20191124174332.30887-2-alban.gruin@gmail.com>
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

