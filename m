Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBBB1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJHDIe (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55450 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJHDId (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so6177612wmb.5
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ueQh8l6flc0d1rx8nbhvfEB2UyugOrf5hpX173h/J1A=;
        b=H1q/ZFIjv0E5KiDY6UOtpZU3uxaTDl0U5CntRLSmBVqVf/hHw4LhcIH81ffbQx8FG8
         286XK1duOHgyfn5ADXj/FuGpapsgUpQnspGSGwWp2VpulrKIDvGkQ+4smFws63Yxnlhh
         WUDklvECakYbEcNW5haBtILBMqb7flwzuS7zlurXCXphQGP2eRXreelg561PK+N1Fry1
         T5C964BtCqjD+uR+nVCcin7tOlI4II9ssLfaPxqiYYpbNz3uySeO9ZMFm84h9gMXDUWK
         PMPSA3hXh9kHL7+NJ5U6VA3vwReEdeMOci8HUyW+8qUt7LlC+FRkmwj4+K7lvnaDqosH
         r3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ueQh8l6flc0d1rx8nbhvfEB2UyugOrf5hpX173h/J1A=;
        b=FZm8AmE3WG+Pgbp0t7gp30sbRNlH5O8CE+bhR/ooNrVEcnCugiUmCqFo7VH5uqX/b2
         nSXFUFcuDr0sl2FeqoP/WAzWWH6arp10JVEfYhEne9mtnb41FZcWjQUbiSSJ7FwU2qFc
         ac9g/aytj2MQ8VrBfTxtZBcDr/3hMDItrEt+QYic+anDsVOyeMB7j3QvHwZwruqEuOFe
         lTcMn1ADm3761vxs2l7DS7rJFeHfUOqsVO5Y3ceYH7DujJUTELAGVfkbcCzZe7fArySJ
         KNdOGWIVc8fhL36oGSkNKniaoUl+J0uc9qluUqXovNHoDhFGSgIWvTrRrNTC7NIYybEm
         BpOg==
X-Gm-Message-State: ABuFfoglCWwdj4R+qpqyOuWoMTtJnjjPazSGK1H9HkLGT6o1rR4IEiWS
        wZZFXE0lHfllSPK2UHOFFqqjJAAv
X-Google-Smtp-Source: ACcGV62MYGlDtYRJ1tTZjl/yq/drwVSg2dY3jhLqFMlcEsjDpdx+gJMDKUPjrvtTibdD3/rfRpCimQ==
X-Received: by 2002:a1c:8601:: with SMTP id i1-v6mr12865496wmd.148.1538942408290;
        Sun, 07 Oct 2018 13:00:08 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:07 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 01/15] sequencer: clear the number of items of a todo_list before parsing
Date:   Sun,  7 Oct 2018 21:54:04 +0200
Message-Id: <20181007195418.25752-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clears the number of items of a todo_list before parsing it to
allow to parse the same list multiple times without issues.

As its items are not dynamically allocated, or don’t need to allocate
memory, no additionnal memory management is required here.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 0a3292d5c4..ed798b95d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2063,6 +2063,8 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
-- 
2.19.1

