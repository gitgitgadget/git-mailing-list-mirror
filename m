Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1402CC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 06:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjAJGSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjAJGRt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442E1C927
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 22:17:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vm8so25944698ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 22:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS7t+d8VH/H4jV4AnOENMqR5Xe4q8EmLEGqnwk9sdiA=;
        b=S1NHdrRNSx6K9ReI95mukeS42gK7+LT7mRNOxlT9+lfcmfjmuTEF8Ho+TjtG17n24K
         k7qjpOQYdVWoLwFI6MA1wy6L2LQLICt13gmoS7pfdn15eviD81nKL9szhbh85EpGs0+0
         cef/dVh9Sb76gZNuYTr43AuG80F44KakQspsmXMoGWVccXUS8hODklIqEsMwjoicI/0E
         CG6KR8gPQgFknKFccu6B7/wL0LOYfKsKM5b7dV13ucYMufSPZIQCIajRaWbTG8CqkWjk
         7CR6EB8KA2YvLPPPkvgdVgFAr94QpRbUJGvkTpgk6IxHRQ/xe0uEFwU8jA1WknB84PfH
         Fjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS7t+d8VH/H4jV4AnOENMqR5Xe4q8EmLEGqnwk9sdiA=;
        b=CMncHNfyVmSEwSbKuWEDMkC07W5fWmbfL8/hJz3qPLU0h8j/xW3c6R1pV0W0ngIU6e
         sh6aduTx7RxfO7Kixu8WMcB5xf/e4RiAQHR9sDxZc4yZms3ecU0EC0M2/u5BkPqGU2gV
         tUnc0Bn+LCruWP8r4Z8oYqHGVSMiPJVCnDj20Jcto6MsJqyA9qV6L929ggNxzGv+dAlC
         cT/+KfhgojUWM8KjdsWsaNdPFH+1khltIUrEgwpfmUGNaDkam74kODMOqUG2RXU6fXU9
         UqEvDpOVLooB//AC9aLYe6mAV7aRPQoCk1fCH/kJmy90IGSKpR0MfHD58iThqRxxFP9a
         rO9g==
X-Gm-Message-State: AFqh2krhQF4eETOKNorb0liNjmHZ6PdkyHbQb3tsGOTGt/okYSjYb2EY
        /ZwJRlf6uxKfi+EHOsQBbbIqUOqJA42dCg==
X-Google-Smtp-Source: AMrXdXsj5nFZH8MkMR2Z1HuBgTVzXnhhQNXOhZ8P6mlvGB+8TPjqtM0JIkQVPvCtUxhBiu7fY5xuaA==
X-Received: by 2002:a17:906:b00c:b0:7c4:fa17:7202 with SMTP id v12-20020a170906b00c00b007c4fa177202mr56201150ejy.33.1673331461572;
        Mon, 09 Jan 2023 22:17:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4555601edx.34.2023.01.09.22.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:17:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] read-cache.c: refactor set_new_index_sparsity() for subsequent commit
Date:   Tue, 10 Jan 2023 07:17:32 +0100
Message-Id: <patch-4.5-e514a881e38-20230110T060340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added to set_new_index_sparsity() in [1] to eliminate
indentation resulting from putting the body of his function within the
"if" block. Let's instead return early if we have no
istate->repo. This trivial change makes the subsequent commit's diff
smaller.

1. 491df5f679f (read-cache: set sparsity when index is new, 2022-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9fbff4bc6aa..78e38b0da28 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2300,12 +2300,12 @@ static void set_new_index_sparsity(struct index_state *istate)
 	 * If the index's repo exists, mark it sparse according to
 	 * repo settings.
 	 */
-	if (istate->repo) {
-		prepare_repo_settings(istate->repo);
-		if (!istate->repo->settings.command_requires_full_index &&
-		    is_sparse_index_allowed(istate, 0))
-			istate->sparse_index = 1;
-	}
+	if (!istate->repo)
+		return;
+	prepare_repo_settings(istate->repo);
+	if (!istate->repo->settings.command_requires_full_index &&
+	    is_sparse_index_allowed(istate, 0))
+		istate->sparse_index = 1;
 }
 
 /* remember to discard_cache() before reading a different cache! */
-- 
2.39.0.1195.gabc92c078c4

