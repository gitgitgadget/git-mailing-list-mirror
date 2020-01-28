Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37370C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0C320716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQJZZOAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgA1Ol0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42274 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgA1OlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so1613858wrd.9
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tu/XeKYCFKYmJZQRo2bpb+A/ims/KDpmrlZyszF8BBc=;
        b=AQJZZOAn2CCnKCmAWZaszI/o22mgDSg5T+BvOyf2EBPx7DN/OhXdjhtc2EnsTH/7mj
         eNeHXtuXT/lrYSLLZjHdEksgsSX+Ge8pLwwaujGNs4rbh7IqyCge68jz+knRj0vkUnqv
         +kutg77jKdXTVG/DxDEEL1lFI7kZo/lX4K4CzAmyqALNI5W2h3Cw7KfXpj66hM8HLrLk
         qOCcgeozawylPkTiyRsHF2QGSP4mGf7wYcNOr/3A7NSdqcjBjcpAXC98GBznrmF482fv
         13DPZIAR2JWSHizu1Tdfu8+vvH8zoboiRUGUMkACVzdjyue6sStTQS0Q6WBK31yVGeuP
         iTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tu/XeKYCFKYmJZQRo2bpb+A/ims/KDpmrlZyszF8BBc=;
        b=uIXCwAXwH4PbZMtROZJ5DQrtFJdiZxSWpP+9nsRZdP91y1vEPZQBOgOoMEl/uTNSzL
         GmYGQcwvJe9KwjxPQbFJgwSKb1HrG4ZCEKkWttCVn9rTXnklcOdC41E0ZBw0ucHP0I8b
         Q5a8QXs4oI5wO/qdUJSLZhg9VvAbUPtGE0ALuop8I920D837LfQPRTX22NpIBcTm2BYb
         lGMcmoJh5wHZsdPdn4IxXuCxP/fdLLxw824y9GYHquimoQcjqII46C8/zMPSDX3CbkkM
         X5jRQsBrClTxrrvuzVQge841fzX6AdrVSHnrNhCP7oXlZgQW2ZZuuS/FkTWJhn7cqu9a
         fF9g==
X-Gm-Message-State: APjAAAU5DMSo+3vLCtbysIz3E6KcBW/XVS4VFTD7TUPOUDSu/FNp5Bu8
        MbxrggupfcD9uBq5HH9qsyA+AWsu394=
X-Google-Smtp-Source: APXvYqwRbmnIzJlDwGEQxf7HTFSZSN57Z6Tdb5mreZeWAQUligSjikkSOwyqajqxDVVpmNoi1i3AyA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr27654888wrp.378.1580222481031;
        Tue, 28 Jan 2020 06:41:21 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:20 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 07/11] bisect: libify `bisect_checkout`
Date:   Tue, 28 Jan 2020 15:40:22 +0100
Message-Id: <20200128144026.53128-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Turn `exit()` to `return` calls in `bisect_checkout()`.
Changes related to return values have no bad side effects on the
code that calls `bisect_checkout()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index a7a5d158e6..dee8318d9b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -713,6 +713,7 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 {
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 
+	int res = 0;
 	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), the_hash_algo->hexsz + 1);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
@@ -721,14 +722,14 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
 		if (res)
-			exit(res);
+			return res > 0 ? -res : res;
 	}
 
 	argv_show_branch[1] = bisect_rev_hex;
-	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+	return res > 0 ? -res : res;
 }
 
 static struct commit *get_commit_reference(struct repository *r,
-- 
2.21.1 (Apple Git-122.3)

