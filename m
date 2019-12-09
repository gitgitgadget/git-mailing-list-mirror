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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A2C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1002073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 08:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG+27DEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLIIkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:40:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39362 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLIIkj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 03:40:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so13904671wmh.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 00:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBd/hB3iLxUSSz/g3ux7IMWALX3PM7w36bgpqgWkxlo=;
        b=HG+27DEPpnL9u88o/CD0MXJU9z29a+3JlO3mYXQTzSWXNlIxX4oCttRdPl1WiS8oJ/
         thWdT9Zok5bXhX2XaGjjVHF8eCIJYgxXwj3PH1ij6k7eigSYjp1wjTnyyaUWUIS3DmTX
         t+Pgzwv+pi5X96qe0LazMkDtkwWUboAq5w444t9p+nYUDii6snVspvVC+mVMwtu0o3tt
         UwdqhX3pR77G4fiko/vsGG/E+/f5VCCodurKBR1uqro3EMbVn+wj5tjtPcG5MMkk9wfQ
         58fvYvtt94RlOSrsrmKM+Kw8C1D7YNCRIGzPWWYDDozz4iw5wW75aaLggStr6huatPkq
         +A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBd/hB3iLxUSSz/g3ux7IMWALX3PM7w36bgpqgWkxlo=;
        b=no8QXkkJtuHOjhGKmudFF6ovYW6sVSdhIXjvZyoklykGPfLvbNWIQUeKtjnlBsGQY9
         8KR3lgag+KW7G8K47LLSZQo0QGy2Ozm9uNdXlz/B7KKo2AQVG5Y4pJFuYrxIgGkOd9Wv
         EtlX0KM8XDq/ybHAgKC7lPSLkjCKzr1mvCnAqqXggYYXvo9jcnLKQRcVGXVvAhZ3x7w5
         jrRKTINIYICK1aF1BwEKs6ajEUXEjSikOkiKyD4/w9xkhaP7k2mWqQ/+6mc228oEzCOY
         JHR7SsI9KiQOqjHKcFb1pXLaYRqFeSv0HzeXQrn7k88GPJXr/MBvnF6rtJKsbjABDK9g
         4ijQ==
X-Gm-Message-State: APjAAAWfk17ikR+3HFF/hACa2s4CeiU5y3SNEf8h0sGogDpa555RdeNg
        syJ1KtOlz2nEFmd/AY8HmJRPMEBINRE=
X-Google-Smtp-Source: APXvYqyBPJaFUKQkeacQ/y2cmaxJUxBQTpElvWqtYy5q4Ypm+z/TZcYxyF5c3im8oxSZHHEYpMTatg==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr24021772wmj.58.1575880836427;
        Mon, 09 Dec 2019 00:40:36 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id g74sm12625265wme.5.2019.12.09.00.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 00:40:36 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH] bisect--helper: avoid free-after-use
Date:   Mon,  9 Dec 2019 09:40:22 +0100
Message-Id: <20191209084022.18650-1-mirucam@gmail.com>
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

