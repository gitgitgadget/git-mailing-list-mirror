Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9913D1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 09:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJGJ1A (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 05:27:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGJ07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 05:26:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so11844534wme.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xCkbnmCs8Z5d9BHZzxNK2J/yY5q0ioErhjJ3M1BQ5U=;
        b=q2rIcFEuq5W7prTjhsHNKmXUC4/EHVyDn3n/zLaISN/e+jiUGhkPk2l27eggGZRS7S
         sa+AQ0wBJVe20iJJXhbhcP06J24ZTa+j1oqAz4CcsT93o4WKBo/oPjMxSAPeUadlRS8V
         N3p/R+4P13pdjaZM9isRaxhjd0UKoufU5AER4dYAmSal2K0YbCit/7HdCMVZUsRJvHN+
         EJdzL9h5uW1gpkRVcMn9jT62jXXj8K8wxh5kGAV224u+v0nfqclAHB4hu+fJobdmHMKN
         c+NGZ/0gfwu2cidPJYMxvV0PcfOTmxfm8vA50fRmlcqlHbwc30go96tsM1sAsVrAWbqU
         h5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xCkbnmCs8Z5d9BHZzxNK2J/yY5q0ioErhjJ3M1BQ5U=;
        b=sH6UyN44udToUapJ5SR8f7SKqnLi+fgHEg0cDC6NGa1dkGq7ap8ilHCzaRSg+PjxVf
         VgjNyJE7bIj+E+S0pcD4iYMCZT4ZcipruqfKUP5pMqkrMT7VSVQPNBUuSg86EiE8aPkg
         GbEiARpbtHeP2QzGrpEHI7j+5pMmjfQ56RRWvCCV9xF0Pt9vdDnNN440hKgKzhI8Imgu
         53t+fW38Rq81SPxH6eThIOqn04zhAkqUisLSmp/JLPkl9OFyu2aCWbErtFun14nEPJZI
         7Qhk0/CNo1/f+rzGfC32w2R4ePOyccGxiLymRbT8HuECwPQeN3USJ9Pr3KfuiLkVaVYr
         mDRQ==
X-Gm-Message-State: APjAAAVTBpVDch+j2oX2x3Xj8j2XBe57Xa4RFLHMV0nP0oY9d/RPG8r/
        6QhoorlGxL3ZiAVUjXhQ8MeE8rur
X-Google-Smtp-Source: APXvYqxNpQKVfY8kFVM9tgimCOvXyf+k9Vm0me6ZgBrj+BbJxDtD49jaNlQg92vP168Q6zvkVPYMmQ==
X-Received: by 2002:a1c:dd0a:: with SMTP id u10mr19465730wmg.100.1570440417960;
        Mon, 07 Oct 2019 02:26:57 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.googlemail.com with ESMTPSA id w125sm25250914wmg.32.2019.10.07.02.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 02:26:57 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 1/5] sequencer: update `total_nr' when adding an item to a todo list
Date:   Mon,  7 Oct 2019 11:26:37 +0200
Message-Id: <20191007092641.12661-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007092641.12661-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20191007092641.12661-1-alban.gruin@gmail.com>
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
unnecessarily read_todo_list() again to update the variable to its
correct value.  At the end of this series, the unnecessary call will be
removed, and the inconsistency addressed by this patch would start to
matter.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
Reworded commit.

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
2.23.0

