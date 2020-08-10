Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DDC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2442073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="I0DxX38f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHJVfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE051C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:52 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so9841935qkf.10
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pr52DQdJReuczN6yQWxg7xzpDo926gZ3vA2f9FtoTwA=;
        b=I0DxX38fQwZt4epJueQ3xwLYdTnjd5i6DC+rQ4i3zvx6Mvtp/nqCIrm9jLQqJa75Ch
         6dPlkQADQ7E7NCJrclGmXOQSJ/HyilDCAYGJPPPWvQ9emXV4kmvObIQsC7u6SCuG1wCL
         FBOlrJuZKt6Z7395nerjDnUpdUDbReWE1pi2eGtDlrmncprUO6l1Ved8Dz3Cs8Afog1v
         qlrALFcHO6GIYBehVDhVoC1MNOV+DkbiVMC0HzIZN6e1Qqsi15SIJsTjVR4Rf4Er4oFr
         eu8fz7HQf+ZrXE+LtWqTshYJ8bUuxolWg4SK+HzpOu5GSbJluKApoJizkHHTSOUbRLxT
         HneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pr52DQdJReuczN6yQWxg7xzpDo926gZ3vA2f9FtoTwA=;
        b=A5gsD0D36WIeJbhXaUme5bJ0UEwOYl9dOzL5reb9u6dYjPgIH7CnNIcRVqXxtK6JQb
         CYD5nfl6hzkZ1Me1g2m/6Bpbj6Lsm7UiPiuXjw2AUD6QVrOHK+l5ik93OJ3n+RIGL8ct
         Kr5em7uclYZnHCXq7d2LdYb1+kUd8QMpHwOfrUOBcc8CZPg1IaU/0P7Jf4rhlNol5cr5
         1K2rimdn08rcLlQc0hMuclY6fmP6+GJiQe0W305jQjuIUMLdLhjC4b+mRLCbwdgiZg55
         qg0SDlPvILMrb9jA6kBIioQFaAi/geEIxRMro7dAlA6impJrbcq5NlBnpSnKcYjvU/em
         Vdeg==
X-Gm-Message-State: AOAM532YyEf4uA+iI2RdzXhp97xVry0GA+/rnNQJbbntuxqYTosc+vGv
        NljdRRxVMwgPUVD7AD/4ebbM7u5QCek=
X-Google-Smtp-Source: ABdhPJyvex9NhOUtkzLVXkrQp6IogngOYy+Xczns41EUIdGIyVoFCBhVmYvgsZ3JTocsAK+levuZYQ==
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr27956567qkf.55.1597095351743;
        Mon, 10 Aug 2020 14:35:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 21/21] parallel-checkout: skip checking the working tree on clone
Date:   Mon, 10 Aug 2020 18:33:29 -0300
Message-Id: <6356b499a4c12c86ec12ca6309c12e16662996f9.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the current checkout process is part of a clone, we can skip some
steps that check paths in the working tree, as we know it was previously
empty. More specifically, we can enqueue the entry for parallel checkout
before calling check_path() to see if the path was already present and
up-to-date. We can also skip calling remove_non_dirs().

Note: this optimization is only possible because the parallel checkout
machinery will detect path collisions, and call checkout_entry_ca()
again for them, going through the check_path() logic.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 5dfd4d150d..8c03e23811 100644
--- a/entry.c
+++ b/entry.c
@@ -513,12 +513,24 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 		return 0;
 	}
 
-	if (topath) {
+	if (topath || state->clone) {
 		if (S_ISREG(ce->ce_mode) && !ca) {
 			convert_attrs(state->istate, &ca_buf, ce->name);
 			ca = &ca_buf;
 		}
-		return write_entry(ce, topath, ca, state, 1);
+		if (topath)
+			return write_entry(ce, topath, ca, state, 1);
+		/*
+		 * Since we are cloning, there should be no previous files in
+		 * the working tree. So we can skip calling remove_non_dirs()
+		 * and check_path(). (parallel-checkout.c will take care of path
+		 * collision.)
+		 */
+		if (!enqueue_checkout(ce, ca)) {
+			if (nr_checkouts)
+				(*nr_checkouts)++;
+			return 0;
+		}
 	}
 
 	/*
-- 
2.27.0

