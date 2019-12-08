Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8041AC43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 17:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A872054F
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 17:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wflnakag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfLHR3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:29:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52111 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHR3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 12:29:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so12968951wme.1
        for <git@vger.kernel.org>; Sun, 08 Dec 2019 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QGn5ZJwgksvhC18izzyV/qCLIsq1L2UpgdETUlaodU=;
        b=WflnakagRX0l9x16sqG5h7EBmgUEAQOP8uUT1D+xsXOnxN1lXwOwSSBUMRvOxrqMaO
         L9wKt5BMtNCxGevA/8NPP308eWozSSlPUuriTLegclVTm9pZlqm7eBZKCDT9zLP/7o0G
         nZkCc6rOjl8oKPggwcjbaz7XuHDQctah1NzV4fZT8LPfSifO8qW0JqTLYVD/30FgpMnr
         MTO4+G9YCr/4pa/thpmOXLCPYx+BXs8Vs98jm1d/j3+DIQLe90TIBFOwXMwPwToFug0D
         OumZnZ8LFTCmhhsh8eHVJNTLbolBtDhjSkeIrlxL7A1EApCKjITAE4276w1cOScSvDss
         1+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QGn5ZJwgksvhC18izzyV/qCLIsq1L2UpgdETUlaodU=;
        b=hbI360uSe/OLGPHNRfiuS+6bU0ISYnTGgGB+Ug/8PCfy9LaQBrFYmaRmtfGKHRrE8Y
         BA2OcoRmS/0HTuzudvWpzLbUIy1LkbqYsz0dVHJWEcg4DJbbDs8o/8pr9nCcPBa8Aq0+
         mH6XSyni0QeA0J+JuI1C7hxrgx+/KNoIw0FsdBrOup+IRdiS7LWh9PFR3lM7jgxm9oA3
         E9qijCVga2ELnNMxCKTTbNYe/ndyicxrNFs6bYqzGy93edRNkul2lMZvtJXQzcydY1ds
         V/iHyc6hw0PCXIwqdqb0PLK/2TVwpg7VGT+WoyDbLlsXEjEJTmYvf7M8oTn4mgmLgkLV
         3Tag==
X-Gm-Message-State: APjAAAWCRCexJUajtiNcx73oB8EmJb65Ta+cr3WwxktSJ9a8SWNtbnng
        WBWQ2yP6vKg2soJvfEae1AjU/MCw1XE=
X-Google-Smtp-Source: APXvYqwnXYJnOfaEuxq3LgXEV7BjuKuW9DPI/DHh99cIkhfczNGKkRnT5DEGxst8dLN8IZ09jBJJqg==
X-Received: by 2002:a1c:9d4a:: with SMTP id g71mr21056137wme.50.1575826190389;
        Sun, 08 Dec 2019 09:29:50 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id m3sm23962848wrs.53.2019.12.08.09.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 09:29:49 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH] bisect--helper: refer branch.buf before strbuf_release(...)
Date:   Sun,  8 Dec 2019 18:28:13 +0100
Message-Id: <20191208172813.16518-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Move `error("...%s...", branch.buf);` before `strbuf_release(&branch);`
to release string buffer `branch` and the memory it used.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
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

