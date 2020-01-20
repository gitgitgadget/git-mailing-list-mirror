Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E6C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226C22314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G69OrLl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgATOij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38522 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgATOii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so29849578wrh.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDX/Xy/xSLCaRjH5SbpbSxWGAIWXngsvdpc/dPrz69k=;
        b=G69OrLl9rPs84RXMTtfiorOPQXVib/RGhfZeFiNCOU4QjHycifIJn9FVFcC1ZMfRF+
         i1BzSvrB+T7D71ZAVVTLZg9Yhj+H/Z3JzMsoOD4LY5UtrXXBh2Vc5Yijjv5Hr0ouVY9Y
         /thexeNo/SUnBP/YUx6wJ1mI1XYh1Nd+LDVCkC/eWyittWvQGcfLtooAg1/IUWGCwkqm
         VUHmtFi4xfGA4in3FgssCl9pn/jMb7jcZaqUhKGrwdVpC2ugK7P2tzvZSkRBRnT4rn4b
         Vc8ogJNjjilcSr9pWL85VLCPlqXuWKvSfdchT7bFDLyTMAGoJZtcwiyEAxYyLMUoJVuD
         y31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDX/Xy/xSLCaRjH5SbpbSxWGAIWXngsvdpc/dPrz69k=;
        b=I/PQOS5UeO4I1dxScDaci6sdOeGuRG6pbA1SE+PXWSVZ/BNJ8xepNDwBXtnDmrpNWR
         m4RMobTOUB1pqfJl5UQP+vZ0W05n7KBwdkcJNHYevCbWJdoGEfSBA1RtpjFjx8yfeUI1
         g5fPfoWDv5qq6TNnP3afTegV6YvsC1ZH+KemNdd2/gHIcLGvIWU6dS57YE66Gid5FJsj
         1mqzKsW6I2z9+fA3hjlXSCtUm00HJAR+IUDI/j8clRJIUGhJw6POHupwhExICp2hOWxn
         +DihPsq7IoSgwVH4s6vRVno7bQRnq+r7onY1W/U8xqi2hRVyQPjmYercoOUd6Sg1BU3y
         cnNQ==
X-Gm-Message-State: APjAAAV0JyPSvYnCqkiL3o00GiyIBT9U+Kc00gMuwTcbhZmdOWZCED/c
        9Bed8Zkl+0rVzi6S2mF8xcjgGLQ+Ai0=
X-Google-Smtp-Source: APXvYqx9o/Vw6kRoRBVhhbnhdk92+VM5F5b2eDy4M4KlP7GZYhkPbLUzdhLR5WK5CtJjHHqc3Snd0A==
X-Received: by 2002:adf:d846:: with SMTP id k6mr17741011wrl.337.1579531116743;
        Mon, 20 Jan 2020 06:38:36 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:36 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 07/29] bisect: libify `bisect_checkout`
Date:   Mon, 20 Jan 2020 15:37:38 +0100
Message-Id: <20200120143800.900-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
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
index 2ac0463327..385afaf875 100644
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

