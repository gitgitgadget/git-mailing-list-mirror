Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA6DC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23A120726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxu3SEd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfLIK70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:59:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIK7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 05:59:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so15705636wro.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBmT2y5FlZ/1ndfuePBW6QOP3veQTqg4gA6WSvgEqvs=;
        b=Cxu3SEd0/AzsKgL1a4bpBTKbZrc9FvM7djBd7z307lV5y4CAWIT/BVfLGHc+3LF4d6
         n6l47sk5JZY976ue0pohMvPvp2t+7Lv+7lWwJVk1aSEmEG/jLVdrCnt2evcDxqTdFxz4
         UEek01cnHakW3yKY2R2+OuF/ICbTPtAbvdrUS7LCF7Gvz5n4uQUAWi50ZXuZN8QVGTdn
         hZIXap7ogDCRDJAhytSIQocshPUpSgJZtrmQU9tAvG/SAc/susglqmlbkTXOqlpVjD9U
         CiDL9Ffec7+5CMCiszGioN4JFB+zouzG6JfkPo1yjcuCx8Pq4uCNX3tqAOPlpp5cr47R
         CQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBmT2y5FlZ/1ndfuePBW6QOP3veQTqg4gA6WSvgEqvs=;
        b=IWI7FHlWetomB5GuMQgqSRv1Fn7fEYQ+TcqoOyIUrvPqaIHCo1wRGxaZpw9q6GSmmj
         i/PihjtpylUBdMq6FKKuCt9wvbq2E8I1wYsxQxE5hh17BtFxyLecftBzggbUEXX5HHAE
         qd/o/8NLWLBRwfMiqxZc860mFGizVsoBnxLm00xDkBvc5KpQOsEvYCyL9nOakKBHENGo
         td7BC1cjoFJg2Ack+0UK0VbPNnFZmoywntefG/dmhyL1JEaTFqhFa6Gr7OkCPo0ySU+n
         27kxNMinRp4dgeocQ5epAQQfq9gR9ovmTHi7KFulnqj2yfC/dU6ZCKc9JUnlgL6gmX4d
         czng==
X-Gm-Message-State: APjAAAWFyA4VVpfIzupjvxyIm/Uv3u9+8E+axoP2fBi20ud3l6StG/eL
        NJN3dxjpo0swzoPlP7VkYHvQ5Go53PI=
X-Google-Smtp-Source: APXvYqwxN6dyVeL90T9DbnSq0pFEw8ZZdbBSeZdco4Tqg7g6mG99WpQRvuOGvYrU1mB5/OVnsF40Kg==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr1440568wrp.322.1575889163455;
        Mon, 09 Dec 2019 02:59:23 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id 2sm27995658wrq.31.2019.12.09.02.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 02:59:22 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-use
Date:   Mon,  9 Dec 2019 11:56:47 +0100
Message-Id: <20191209105647.21855-1-mirucam@gmail.com>
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
---
This patch is a new version of
https://public-inbox.org/git/20191208172813.16518-1-mirucam@gmail.com/
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

