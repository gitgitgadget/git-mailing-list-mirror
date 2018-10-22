Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267C11F453
	for <e@80x24.org>; Mon, 22 Oct 2018 13:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeJVVhP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 17:37:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46536 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 17:37:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id a193-v6so3026202qkc.13
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wRtu7/h6Bix6Vcw4Xfx2ru4d12CEnaR6YK8Pms953p0=;
        b=YtZ6Yh+CRNtbYEwBqKzdX2oujNlVKznWgPDQ5jxB3CJ8OFl7Nx9a/+oc327uXuhskz
         JkVo310pDJLBXZaPAUAP3VkOQnfKSKO0cBwPWoxwEDDVWlkmt+qHl/9K2n+O9WjIinWf
         nKQepd46M2h901lgnQNtrpO7A2hcn1dhU6uOv9eL3WuE8HDkixdQddTQ+VdP8fxoM9ay
         HF5tB0XVWQUi9mM89w5yZ8yKIezN6u/PEHVzy+o6qBuXCHvGFKDpXCEa+4ec+dIWpl10
         er4Ntfg8la3f2cdIWTArQ4NHfunbos/QB+kUr1hCrqtWuXsHJhWh58anaQwDygXwzWXZ
         +6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wRtu7/h6Bix6Vcw4Xfx2ru4d12CEnaR6YK8Pms953p0=;
        b=nPJdGSZZFad9wEBt+RK4iLGr/R9yf+QnH6epDcST4KX/OVsS6Awy3+XIz3UC3A0Gpv
         HlL2/aL4jNC2rdVatJIDXq4flHVUXrSO8iPmwFTmrirTCi79aUgRqzhcNWlvgiKoQ9ZC
         gY7szfzvLWPCHDnE0bvzDFwddIDlvx4i5OX36inKlXSFLK6oDRr/N86VTzJAQ/q+xROJ
         4Tb0M3EPn3ayF0hVHvPbFk7Bzo1/Jec1YwcxWCyxeoScntom7YDRC2zx7SLZrtM4/CzV
         EQ5gKmtBpMCgtVhovd31Sch0zMDvYFOVEip6nCP9DJliHh6C/uwOnaBUBp9JSIhMBiQE
         kXAQ==
X-Gm-Message-State: AGRZ1gL1J8TiUqlZzLrwUOwFg911+AQ52X6bsmg4/zffiXiUN99WJmyH
        +kyp3d0Z8WLy/Bl//58WW2Mw1JgEIpM=
X-Google-Smtp-Source: AJdET5d1iUyhLLyR2z9fyTtFY/yUoImT42PRmF8dnF2wRG+m4w2BqnUU/LtTbq7yTXe0IRxIs4j8GA==
X-Received: by 2002:a37:62d8:: with SMTP id w207-v6mr4933438qkb.250.1540214320107;
        Mon, 22 Oct 2018 06:18:40 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n39-v6sm746052qtn.36.2018.10.22.06.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 06:18:39 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 1/3] reset: don't compute unstaged changes after reset when --quiet
Date:   Mon, 22 Oct 2018 09:18:26 -0400
Message-Id: <20181022131828.21348-2-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181022131828.21348-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When git reset is run with the --quiet flag, don't bother finding any
additional unstaged changes as they won't be output anyway.  This speeds up
the git reset command by avoiding having to lstat() every file looking for
changes that aren't going to be reported anyway.

The savings can be significant.  In a repo with 200K files "git reset"
drops from 7.16 seconds to 0.32 seconds for a savings of 96%.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..04f0d9b4f5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -375,7 +375,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (get_git_work_tree())
+			if (!quiet && get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
-- 
2.18.0.windows.1

