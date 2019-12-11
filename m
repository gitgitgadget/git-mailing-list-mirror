Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CEC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FD52173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH92FCnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLKTYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:24:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35046 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 14:24:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so3935252wmb.0
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7X256iaCvqKEdnoICObkxo/QuY+qb4TstJFFOYk1dg=;
        b=pH92FCnz5ThkllYWXEZbZM+UnYvXPezi/xk/cLP6pMOlI+0uOuuFNu3MdQvNpuhCuY
         J5L64F1pSc/Uq4CQNNCXh4ADGj9aPZzER01ZshH0GR7wrJgiM0ECCDg3Vm9RqreAjyrK
         /pRGMrtzxWU2ZBM9D8gyf/Du/o7Py1ijyiV8fuleOli/W1PiBxqVrZqstoxLC7aKXQrp
         X9s95sHqVShwnbAWv7soM0KRZU9nkA6+vTDiNiWMBKXDNjvRNB0HTLO/g164n2ZnyZAA
         RnHpqzjtPO4D8MSMkWl/fPrMWzoAWvhoJH8+gKM2Sws8KLAgfHgq/cJlM8vwD+nuze+H
         hzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7X256iaCvqKEdnoICObkxo/QuY+qb4TstJFFOYk1dg=;
        b=k4b8EEJkxbACWVsui9SohVdpXWdjFnAi/V0x8pPUfWAoDSUVHS//6Svu+8rKScxBBS
         u21dj04hhxFXGN5JTcPMLJ9zH7OHbSEkXSl+svT73QurMw/E7LnZoE5uCW06A8dp/EHo
         0mFN5mNqlQQEpOFqD8CHaX6GGjP9g8l3xhru9ljUfDlobF/+sGWYL10YlGvKeuB+WGxR
         eRuGAPAcxbWfiniNwLKl+aa/nziTJxcQT7pa+AB9N2kfUk48HxCrWA3RN2twjvlTi4ia
         CfaTG3Gp0G/8QgLDuLhnKRRGfRf5uZtv4VCN6zMO3hWffCXkTMY5HYtr03OLuJD/+2t1
         6u+Q==
X-Gm-Message-State: APjAAAXG3nLRxbjTPL0MIERdedWfyJj7OKL/PnQWP5vuDbyfvtQwWNxW
        nGTXVsOACDf0vaguhUBu6uH0tQQkVhI=
X-Google-Smtp-Source: APXvYqzjg+ynEYsBqH6lgbqEnNtH/FAF6oObhxnKaKwX+jXPwJa5T2ROIbeKc3M3b76+eIigOKSayQ==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr1613115wmc.126.1576092293069;
        Wed, 11 Dec 2019 11:24:53 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id y20sm3163653wmi.25.2019.12.11.11.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:24:52 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [Outreachy] [PATCH v3] bisect--helper: avoid use-after-free
Date:   Wed, 11 Dec 2019 20:23:51 +0100
Message-Id: <20191211192351.7840-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
2019-01-02), the `git bisect reset` subcommand was ported to C. When the
call to `git checkout` failed, an error message was reported to the
user.

However, this error message used the `strbuf` that had just been
released already. Let's switch that around: first use it, then release
it.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
This patch is a new version of
https://public-inbox.org/git/20191209103923.21659-1-mirucam@gmail.com/
which itself has been sent previously by Tanushree
(https://public-inbox.org/git/64117cde718f0d56ebfa4c30f4d8fe2155f5cf65.1551003074.git.gitgitgadget@gmail.com/).

 builtin/bisect--helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1fbe156e67..3055b2bb50 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
 
 		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
 		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			error(_("could not check out original"
+				" HEAD '%s'. Try 'git bisect"
+				" reset <commit>'."), branch.buf);
 			strbuf_release(&branch);
 			argv_array_clear(&argv);
-			return error(_("could not check out original"
-				       " HEAD '%s'. Try 'git bisect"
-				       " reset <commit>'."), branch.buf);
+			return -1;
 		}
 		argv_array_clear(&argv);
 	}
-- 
2.21.0 (Apple Git-122.2)

