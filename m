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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D852C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3022073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYglOzun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLIKjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:39:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfLIKjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 05:39:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so15510768wrl.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 02:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBmT2y5FlZ/1ndfuePBW6QOP3veQTqg4gA6WSvgEqvs=;
        b=OYglOzunDOlnG4HhiUrLpHKmb1G8fkjzfdxsgqJgMrOoH6VrLcN5WVpcaeCA+HgXoH
         BEhCWE5vuMN0PgZS/J3reKdh0z25iR4BGosL30sWsndwmlhc5QVmJ0eDcGIGxyKsthmH
         K8LdBBytXg7b2rEtmnH/gKZN7rfw4b5h7kXxO78Gm8tMsl84caC+lo/vgET37hiYX1R6
         tcYceXHZ/OKZUXEv3dfCha5ANBDN50Js+fEcykmb4ceFLmTguDhuIRATnVgjvqjdec7z
         BtRTh2WvIj9vy/y06PpLg6/J08AXnJaOeYaLJda0Z67i3vDi2ukINKNxbmzZnwuOhUia
         XYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBmT2y5FlZ/1ndfuePBW6QOP3veQTqg4gA6WSvgEqvs=;
        b=JlyL7nxKcJLmEKmcAHWAi9Bq2wfyfhXHxGXs/Kk9jkLwHWEsnvy8B57ZYcE8ndqAT9
         5mV44QDiGiU8yAbEP7XS72fvIkOSMvJKfhjPkim7ilFJJds3bL/EI3JnG66Sl3xRkXwi
         /MGEW1dL0F/blbPm438frwbUW/KTLuFlvqybEcqvlLdasGtzg+tCB9k8cPKVNJJLoV+P
         EwS4TV6oXJekbAChFqZPjts/bWT9jc4gJ9FomEZ5JGjYdBOsrpSHuv4ijEQI6ggdeMdS
         r8kqROoGmuqPdEMT3qUhgUcKlbg4jVkei1fJJDIQYrsTwwbSJMlNHWtBXzl8bTA6JGgY
         4EtQ==
X-Gm-Message-State: APjAAAWFccI+yk1l4xFwQIcT3Lqz/PDEr4u9iDw6zvvZlRfwXkDxXfwV
        suSoA8wkToEtgY8++Q4rLgLxBZ8ucP8=
X-Google-Smtp-Source: APXvYqyvj0SMn4/F2uT+orGqt/oTJCP2g5cVuOX5zXhiJYUHw0a7Qk66VfhHa+Lb25cVB6k1BfOCxQ==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr1245069wrx.87.1575887978820;
        Mon, 09 Dec 2019 02:39:38 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id s82sm13138789wms.28.2019.12.09.02.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 02:39:38 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-use
Date:   Mon,  9 Dec 2019 11:39:23 +0100
Message-Id: <20191209103923.21659-1-mirucam@gmail.com>
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

