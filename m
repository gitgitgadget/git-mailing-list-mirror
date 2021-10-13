Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162AEC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001EC610D0
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhJMN0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhJMN0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:26:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA87C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:24:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so8404343wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frzUh3p/VrJCbMvOprYoUKOhVYbnOk6VEkxuXCAQAig=;
        b=p5fHKsLbKuxsJ/J7jwS6j4yKrXeR+uEg3S6rAIFgziCNOBfjLx/4gohhjwxLw0PoiR
         IXVxrmAMBK/wdRR0xhKGIEOrJReXWaMWSXaPqjf80cowqvQVAGjFZzB/2nsQY4cILS3g
         lbOOQM72HZaOc6aHSq8GJeQleaufhsgJ2TwHfILi95ltKvdi9rgMusyq1L3Zcs9egir9
         NVpaAkW4gRzGu7+kPFYjB0lZ1/82JM2E+m2tzPXgFUVo9Ipa8/oAi04pkwgey7YM65jf
         /4f7ia72VZgAH2X6cNExppfqbTQ8wrduvS9isvI45GI0b2vRViHT5fruXNtauRaZwHdL
         Rh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frzUh3p/VrJCbMvOprYoUKOhVYbnOk6VEkxuXCAQAig=;
        b=JAnk1jW4kKW96gv3XJMpX0+ehrvf1CcneDObkYQ4AzITSJBt8feuSiKfPoE5aj57ul
         7yjpSxDEqbnF5v9Z5N4p0U7Ulanpowspjw0sJbGxosge8Z+xTW/bRuWGnb8HaP1k1vUp
         m9JH6+Q3wGR6rEnn9Jn3Piu0WOOiENWc1VwDtJkiVW27tZcefABR4fudjT3bQ+nrrEqE
         auGSyujO3AFNhCgZdJGzyNDE41qMiZE1GUG8Td6RkQAxzFlVeLP8TSa3peELdJXrpDun
         bSGDClYN1yeb9a7lGTyguReIugPMW/5r0kpY2vG6MQDTzd4SNMS7ZYo91jFDgZTkrodE
         Zf6w==
X-Gm-Message-State: AOAM530W469si4RXWkV0MeSKL507BjXrJAvs0ETxfJ8YCQZHErxiwnCg
        ueNCFN6H2FDWQuYycQt8PsCVT4Lxjy87rA==
X-Google-Smtp-Source: ABdhPJzBOut9oux93AJTQkCmDA1xx/WlOuVtVZ0luOkp/7oLUvoAyqkLWCnL2FDHyK83MUr0rWAgkQ==
X-Received: by 2002:a5d:64e9:: with SMTP id g9mr39821759wri.99.1634131439890;
        Wed, 13 Oct 2021 06:23:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm13044205wrh.64.2021.10.13.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:23:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] sequencer: fix a memory leak in do_reset()
Date:   Wed, 13 Oct 2021 15:23:55 +0200
Message-Id: <patch-v3-3.3-00b6b469a8c-20211013T132223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1569.gd2dc77f7abf
In-Reply-To: <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in 9055e401dd6 (sequencer: introduce new
commands to reset the revision, 2018-04-25), which called
setup_unpack_trees_porcelain() without a corresponding call to
clear_unpack_trees_porcelain().

This introduces a change in behavior in that we now start calling
clear_unpack_trees_porcelain() even without having called the
setup_unpack_trees_porcelain(). That's OK, that clear function, like
most others, will accept a zero'd out struct.

This inches us closer to passing various tests in
"t34*.sh" (e.g. "t3434-rebase-i18n.sh"), but because they have so many
other memory leaks in revisions.c this doesn't make any test file or
even a single test pass.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 14c37c4e25b..98181b3186e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3646,7 +3646,7 @@ static int do_reset(struct repository *r,
 	struct lock_file lock = LOCK_INIT;
 	struct tree_desc desc = { 0 };
 	struct tree *tree;
-	struct unpack_trees_options unpack_tree_opts;
+	struct unpack_trees_options unpack_tree_opts = { 0 };
 	int ret = 0;
 
 	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0)
@@ -3683,7 +3683,6 @@ static int do_reset(struct repository *r,
 		}
 	}
 
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
@@ -3724,6 +3723,7 @@ static int do_reset(struct repository *r,
 	if (ret < 0)
 		rollback_lock_file(&lock);
 	strbuf_release(&ref_name);
+	clear_unpack_trees_porcelain(&unpack_tree_opts);
 	return ret;
 }
 
-- 
2.33.0.1569.gd2dc77f7abf

