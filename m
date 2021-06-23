Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039C6C48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDAA61003
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFWRvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhFWRvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A0C0611F9
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y7so3570332wrh.7
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5NAHhblITntJlqZtDTqhJKnqvu9EczwImQ0uFEIXL8=;
        b=RrWI/ZjqXVUcRvaq50JcKBe3HEEBkdl17xKmRrCCPfluB6bQoZdhcbQn2p2opHUtht
         9XHRxIPWfmj/dIR6VivZwafzRb6XiwfAwma0U2Z+DR3Nf+OOw+sJsVqqQw7vxYIZ7RLq
         7na8mLyGmuF9CqYxyz0XTASVtcWwqQJ/wXbXZ253SL1crMYu5zpbF7zYzCQnrGz30hHf
         Q3uylItIGo+yKq9Lixl2pFoQBFVxE+zqKwiU+u9Wq0AeGxrLZf02iaRPEFvzhK74kWTV
         usRKFI85xvDBNWiobmS2Y2scxgc5Qomii62GW1x4/CgQ8yWhvbFhoqeYKWF0u60sxOFk
         lF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5NAHhblITntJlqZtDTqhJKnqvu9EczwImQ0uFEIXL8=;
        b=MVSNB1GbuEPq5nrhaXAHSJ+EJoUKXiV/zSJz52Xw3I9bCjWMs99JwUic7JWJlUCHKr
         +1EeJ0pgCP7JJhy3ew4BydSlgjTqvjmZamrJMaZcpzwem8NzeCLY8CbTKko/NrwqapV3
         xwiL3VTXngYdiVuWbj6KlDtUT8FNRqTRhvTMPymZhqvy4aBZQGACqiARgXDGHZHBnhtx
         LIXacQICGKjwfHinKzL4QfoTUQwbX+dpjAACx+RSYpemVwh40hiNfVHeRrwtzfaI2qr5
         FQHiLPyv2x+/OJCsSj6iwtp+WTXacLqW54MECVmCXlsrtdQvPGyYlXzPopsn4i4mK1Qk
         VkYw==
X-Gm-Message-State: AOAM5308U6sQHwtKNt0Ks/Jt3PAiKMxwYadpqfNdEgRzLr6zX7gyeprN
        Gmz1zCWHQ5/+L5C6hLNSHah0IrQ1fi3eyg==
X-Google-Smtp-Source: ABdhPJz5MGlpNKtHiLuRCEbcZdgFknNo+lDxLwA7lqbolxjCH/S9GWplF99crvVaud34XSRONNWq+Q==
X-Received: by 2002:a5d:5187:: with SMTP id k7mr1418361wrv.395.1624470525788;
        Wed, 23 Jun 2021 10:48:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 23/25] entry: deal with unexpected "Filtering content" total
Date:   Wed, 23 Jun 2021 19:48:23 +0200
Message-Id: <patch-23.25-e0317d7c780-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "Filtering content" end total does not match the expected total in
cases such as the 'missing file in delayed checkout' test in
't0021-conversion.sh'.

If we encounter errors we can't accurately estimate the end state of
the progress bar. This is because the test involves a purposefully
buggy filter process that doesn't process any paths, so the progress
counter doesn't have a chance to reach the expected total.

See the preceding commit for why we'd want a stop_progress_early() in
this case, as opposed to leaking memory here, or not providing a
"total" estimate to begin with.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 entry.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index bc4b8fcc980..e79a13daa51 100644
--- a/entry.c
+++ b/entry.c
@@ -232,7 +232,10 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 		}
 		string_list_remove_empty_items(&dco->filters, 0);
 	}
-	stop_progress(&progress);
+	if (!errs && !dco->paths.nr)
+		stop_progress(&progress);
+	else
+		stop_progress_early(&progress);
 	string_list_clear(&dco->filters, 0);
 
 	/* At this point we should not have any delayed paths anymore. */
-- 
2.32.0.599.g3967b4fa4ac

