Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA4F1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeHYBqu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 21:46:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52118 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeHYBqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 21:46:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so2844039wma.1
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExBgLK2e6jqB4rgL/5xJLWTtvY3+SQtXbo1SYkz7jbE=;
        b=SoWwQy6/XlD84uS5b3wM78pZn6cDABS2bFYkLQY77RydksAABoyubciLsUeFaXOYhp
         s8bj7A1PPkDFziNq5zacOXzqjN8K7pa/Zj4AumuHnv8J8XyE7+MVm/rqIYl8bxnD52dO
         buTU2Z6AIlEcI2l+++UZyCf4whFVGCesjIlEhhgCrpxT5buahB1UAUKsl72BLyQL35ql
         uFW7WTmeFR+IObRz0DtxDlMz5LZPe1v/0nIRwWnDbJOY9+FXLWQuQbnw+qMoYA2IiRyk
         YLRQzS35hNQngaE/LNU0djINJn+1kwL/D8/XFBBziiALEirU9ntNrItlCA+41+ABNPAT
         m7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExBgLK2e6jqB4rgL/5xJLWTtvY3+SQtXbo1SYkz7jbE=;
        b=q52nN9ZdVzXzdP8hBaVPRr2AbLCnQi3l4TwTWyYzzEpCV4ELuUeA1O7q413cOcUWMp
         rEh4byK8oksMTkcadAzKQHEP+AUe97dXxFOMFgw2YffRwmkCg6wV1w9I0RYlghOxW2wn
         SGRD/PZxW70EHcAwdYQ37CjBo0BoDxnsxyB5tA9efX0wRL8RKtd8ScEA5E8gx1N4G4Du
         smLzScnIU6Zf0xZtlHPiyPSM91jwPhec+RZ5GNKutTPf9j9Cy6CGt0FN9UT9TIkjS1Bu
         4M2aqE5gkXd7bgs8LtnbjPbzuiaThnu+QhOh0Am7md8HA7XMgzAhKHpv2lxliCQalVvR
         nelA==
X-Gm-Message-State: APzg51Bk8u6e8CxaeB2typ+eIQ+UfjGyqLw1ZaMLgzbHrzyGoeKmRCOm
        lB0NQGeTIyQcDY2SYb0jVUuOy7fz
X-Google-Smtp-Source: ANB0VdbXrqBJMIpAbaeS2O9mBxKtoR8rkxaz7Woi2rn7uX0V3grYR+MHRmhvydJDWfIYWuIbKxsHQg==
X-Received: by 2002:a1c:ea17:: with SMTP id i23-v6mr2594896wmh.29.1535148618341;
        Fri, 24 Aug 2018 15:10:18 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id 34-v6sm11622441wra.20.2018.08.24.15.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 15:10:17 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/2] rerere: add not about files with existing conflict markers
Date:   Fri, 24 Aug 2018 23:10:05 +0100
Message-Id: <20180824221005.5983-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.1088.ge017bf2cd1
In-Reply-To: <20180824221005.5983-1-t.gummerer@gmail.com>
References: <20180824215619.GH13316@hank.intra.tgummerer.com>
 <20180824221005.5983-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a file contains lines that look like conflict markers, 'git
rerere' may fail not be able to record a conflict resolution.
Emphasize that in the man page.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Not sure if there may be a better place in the man page for this, but
this is the best I could come up with.

 Documentation/git-rerere.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 031f31fa47..036ea11528 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -211,6 +211,12 @@ would conflict the same way as the test merge you resolved earlier.
 'git rerere' will be run by 'git rebase' to help you resolve this
 conflict.
 
+[NOTE]
+'git rerere' relies on the conflict markers in the file to detect the
+conflict.  If the file already contains lines that look the same as
+lines with conflict markers, 'git rerere' may fail to record a
+conflict resolution.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.18.0.1088.ge017bf2cd1

