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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9CC04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11D52080D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0RdxPpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLILxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36435 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfLILxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so14604613wma.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOj7vpzDhBq5DQ1tXOq0lbHYgZrUg4SALkvy59BjkZs=;
        b=V0RdxPpiKZQ89TDnt4mbWszGxgtHMIcdvTrH4uERTJ6qv4FREE8ptSWkelVwpNOG9R
         st+hkmzoicaqvEnxo3MHgx27TR9UYM+Rw6vrIUFMag7Ig9jOmh2Iu6nY6QnE9J5R2AD1
         Jea1wF5hxRCNsAR+NryIkJxqfsqGb1nhXNGOywFCdweHc8VF/s6aX1CsOfm7VnYKoKYM
         T8oJ4YN5VE0j8JwefA9HfcCeec/QwdUWhsMW+1/ThNbhDFg5rvkvRXinCA/Ni7xUvz6v
         44vrt5E8J+Z6PZsHnzSJbRjAr/iabUqIUtbjmSNoc8DwlTcW/QFPPXpfKNEZ7IWDovzr
         rpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOj7vpzDhBq5DQ1tXOq0lbHYgZrUg4SALkvy59BjkZs=;
        b=HwA89n/PlcQ/F8B6CpMYm2kAGfKs8MVszV3ZNUJBKpKbbsitHBNHolNfU1AAbGHava
         9GAdC4d6Ka/pgPQuPCo3EDtcz+wJitW1IONJu8tu3UCDkLorSkr8i6CJYmG8BpQ7rcWn
         y0tAOZa4OSr1KAvK/VOcIjaza8ta14LS6gZZEwcPe4KawwJj4dQzTiMndCW6BSovB16A
         s7TRuqbs7kbmTtTbIFvi+jjuR/paHVDUcvN9S1bGadPiQtO1OrQAdOup2c9gueO/1rjr
         OFsKQTTJsN62IH4k1FrjEHfCReNTXKZ6ZMZCW8N3GPOWPDv0JzWp9w7Y3KbmIml+Eovv
         edIw==
X-Gm-Message-State: APjAAAWM85Ld1k3TX3Uu3lIGsEQvAZkx2o9N/uTW2eTTe3zOuVNhL4Bx
        g996L4RsU7ox7CPoFWnC5E5iCfLz
X-Google-Smtp-Source: APXvYqyV4tuvb/f1XBbhFtY4iChZxT5x91u50hbQBAVWVYFV4wNKD8f6HpqQBQtZKjGPgIhgZ+XtMg==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr25072189wmk.68.1575892396842;
        Mon, 09 Dec 2019 03:53:16 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 12/14] name-rev: use 'name->tip_name' instead of 'tip_name'
Date:   Mon,  9 Dec 2019 12:52:56 +0100
Message-Id: <20191209115258.9281-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the previous patches in this series we can get the value of
'name_rev()'s 'tip_name' parameter from the 'struct rev_name'
associated with the commit as well.

So let's use 'name->tip_name' instead, which makes the patch
eliminating the recursion of name_rev() a bit easier to follow.

Note that at this point we could drop the 'tip_name' parameter as
well, but that parameter will be necessary later, after the recursion
is eliminated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index fc61d6fa71..6c1e6e9868 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -126,18 +126,21 @@ static void name_rev(struct commit *commit,
 		if (parent_number > 1) {
 			size_t len;
 
-			strip_suffix(tip_name, "^0", &len);
+			strip_suffix(name->tip_name, "^0", &len);
 			if (name->generation > 0)
-				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
+				new_name = xstrfmt("%.*s~%d^%d",
+						   (int)len,
+						   name->tip_name,
 						   name->generation,
 						   parent_number);
 			else
-				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
+				new_name = xstrfmt("%.*s^%d", (int)len,
+						   name->tip_name,
 						   parent_number);
 			generation = 0;
 			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
 		} else {
-			new_name = tip_name;
+			new_name = name->tip_name;
 			generation = name->generation + 1;
 			distance = name->distance + 1;
 		}
-- 
2.24.0.801.g241c134b8d

