Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DCBC4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCCE22597
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgLDGRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLDGRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:47 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9879C061A55
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:34 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id y24so4227900otk.3
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBCaGz/kPZXyIa+ai5/KJhc94Mzn+CBnk+qFYabAI6s=;
        b=ldXIi8Em2KxTzkCry6yaLCsMUKhPlwbw7HDDW35UpCCD5rmEOZgKgEanrhkljgaHPl
         rbAhzAcmOtcbKCQxMkJJQaI7Qfro8dW/DLjC2Y1B1Zpgh9MgHiGJ7e1c7xiqa/ZwWlZe
         +LgLDTPwoAj4sp0j66Ca65a5D0eqQrBBdwzLZd7/pFWRNBFaBSREKPAbzBzDXbRlAaWb
         Zrp6iqSpVrlrtR3KOXO7v8B9MxvGL2JoNRmd/q0lL87IALVuwEnuVYXuNFIuNicWA9hh
         1Dv9k3VLvxOcjFSu3q2qtru4go9i/SA/hND1JOlR2R0CMKCnnQt6VkhtHRUFYH9HqO6r
         Ht4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBCaGz/kPZXyIa+ai5/KJhc94Mzn+CBnk+qFYabAI6s=;
        b=YHK2aq2mH2McTXZemHBJ0QfKTZwtbaJ44ZFGbG99LRxevox1/AbmY8dsWHcyU2VOOj
         0YLXWmJkkZbaXOnPQJCGlmjd4JJwEN4JpNjxX1HzH6mz13Ce/LRneIv8zfW/LkdPGg1Y
         2ScNYIPiHRQ/l+q6KGzMmkUMtW/yjRMEUCGudEjzxMziz3Ccg7J0NVX2yxDKLSmN0syN
         SyRzVdpItdzWt/NnNpJ5h5pptwo1ifYWPVlugA+a5kKI9X0gigYkKd6Wn9h9M7iWqhpq
         uZEdB9+oqW0kBWRInRyc3AdhOv+uFRHus+55mGE/5tTQvpNcU7CpbUPXOhSalVq0b90A
         RnPQ==
X-Gm-Message-State: AOAM531b4lTRC2UF3TTbzDk8b1vKDoYBItf2OIKpWFXYALOJwO3SeZNI
        tS8MA0OvvQheX4yHdhyDXtghRk7U8JYPuA==
X-Google-Smtp-Source: ABdhPJxKHts5HydQh+moyt7Bot3ekoRIiJ8lT5cvtIZIlYb7A1VpZ5FJ0Lv+y8Jp+ptB4ZqKQV+yEg==
X-Received: by 2002:a05:6830:1d3:: with SMTP id r19mr2365492ota.333.1607062594039;
        Thu, 03 Dec 2020 22:16:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k5sm458615oot.30.2020.12.03.22.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:33 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/14] pull: trivial cleanup
Date:   Fri,  4 Dec 2020 00:16:14 -0600
Message-Id: <20201204061623.1170745-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index c38548dab8..8daba7539c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1024,19 +1024,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
+
 		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.29.2

