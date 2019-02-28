Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89AB320248
	for <e@80x24.org>; Thu, 28 Feb 2019 20:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbfB1Ug5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 15:36:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45404 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfB1Ug4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 15:36:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id d24so18105314ljc.12
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wzevuTmzh3+6HmlOxn0sKfe9mUKsnO5VUNpEsI06mQ4=;
        b=arNnzzRLqfPo6Z2gVuqr+FK2FLK35TIrhwCiFGwMxZl2/nSk0mNziS4KluVSJL1ptk
         NzQrlZIOPHgdKtr9g76LUQdLGZsW0OoJdPhieS3mpq8u19JmeCv3zu2vhTDhQGCxT0Eg
         +9eCU5TznbV0TTaqUFLvew+EqEDIZQ2gw5MgFGih9YdERdYQ2I/PDCih3vsFi7l81oa0
         oKbbM2ZAdSrOZJtjwqhMNIxuCy4J6vYBhlKbY1xkohz4v2kZ2Bj8ntCF7XWMEcTaZO5N
         uF2+outKTMnUly/K7aNyC6C8uel/GRzy8xavj0CXRqy8enEEJXuV0+Pad9J2M5zSTrEY
         H08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wzevuTmzh3+6HmlOxn0sKfe9mUKsnO5VUNpEsI06mQ4=;
        b=BAkVkby3nxshxTkGMzh9/tVeNXhyk6EAHL9P0YfUHAMUMGjzDiLtSAJ8xmB0ro3yyA
         isAMmVZPqLJbJ0MTg9sOcp7GZRP6T329/d1ujnKju1f4dduygdZysrlyI+yeBJ2XGnn/
         WNxCYTbN+TBQ/j8uO/VUq3/sFpDpc5ukDtjbw8wq/vhnp/qx4VDDVlgOcGc2jV51zFIY
         IYNhHw8ZtSNpqfm8lMkUHFfG7TdBbOBUzNUia57IReuWx3TBrL+zxTc8Tm4iDjdra2AW
         5UvOPQcwxFeWr/6xOkzaq7WG82LHjUZvqme21w1gdzG0SoEIxc05FWPCwXmJizuir0ik
         iE1w==
X-Gm-Message-State: APjAAAULTzHApVniBllGV3QpJmy+BwudaDLpuMM707QncQI/cgGhSULw
        3OW8ZRNVQcAlSiQvaRYwIHsknpam
X-Google-Smtp-Source: APXvYqzS6DEVsuRjqYvx1aHRPt5QB8luuTtas12Vn83PBkISV/6Q+fD47tFhCTRyTO0q+0HxPq9lXQ==
X-Received: by 2002:a2e:4290:: with SMTP id h16mr516205ljf.52.1551386214482;
        Thu, 28 Feb 2019 12:36:54 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id l11sm4282415lja.38.2019.02.28.12.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:36:53 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 1/2] setup: free old value before setting `work_tree`
Date:   Thu, 28 Feb 2019 21:36:27 +0100
Message-Id: <13019979b811d26f4838d09331c7ddd8223d270d.1551385992.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551385992.git.martin.agren@gmail.com>
References: <20190226174655.GE19606@sigill.intra.peff.net> <cover.1551385992.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before assigning to `data->work_tree` in `read_worktree_config()`, free
any value we might already have picked up, so that we do not leak it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index 1be5037f12..bb633942bb 100644
--- a/setup.c
+++ b/setup.c
@@ -411,6 +411,7 @@ static int read_worktree_config(const char *var, const char *value, void *vdata)
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
+		free(data->work_tree);
 		data->work_tree = xstrdup(value);
 	}
 	return 0;
-- 
2.21.0

