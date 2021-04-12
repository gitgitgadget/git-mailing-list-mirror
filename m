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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B32C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB3261222
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhDLRQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbhDLRQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3993C06134C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y124-20020a1c32820000b029010c93864955so9125571wmy.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5UbnyFc5WlzbDDA8ccMleXKcXsWIOQT18qrf+zwzguo=;
        b=KuwQE5InV3Yh9KtCA/Wdx0SL+FvaL6FQwD12yB8xiIEIQfLG55FelMUHHUKzhreCEb
         Ezyc3TrLLCMkrc2GLDnYSFzX7lLjBsPfBu198LlILb1VbdmbJ4xNoGftw6Nst8k4fWfE
         S7PqPFHTREUIYzoUZMAli56IxbjzebynOIvIrd3SwJLQj4CqXE2mqLwxWx3p3WbU05NB
         o5u7MEY1XyFr1cF1EVzT3TBHEeMwXlIt+OYJPHyifqngljR6xrySf4uyKDUMPcBtomzZ
         vMgjAPVGmTxc3c1ZcBwy6+TdEUDvawkAoz9SB+oLZGxUlfHiI34Gz3hxrBvRyV1L2LRw
         DSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5UbnyFc5WlzbDDA8ccMleXKcXsWIOQT18qrf+zwzguo=;
        b=uN8emOuH8N5P0qV5zf4XYiwIsaLHVKTvxgjv3SjrRws7cCXM25esjB8eD7n6JqoLQe
         esZwIu/yTWT2xdkWjtKtwRGzg4uj/yfa5jNx4z0yGmAVal2bvK8xy2wqd4Wy7ueM3kdm
         65ZxccjG1b3pAaLeIjGEAw8+2xBTzgzXnrGTfgIlfiEiBJ6dT7fnsTsv1aOLGE7SNhPq
         GTPgRYOLgTAagLOqaFiTRPyVs/SQ++T+PT4JsBbLZRSRFS8frjvVyYLMkY5ukhxmB+Bg
         iicFt5eCYEgAKnncVqF4O69g7UEyc+Q5B+xmo/8beVkallvpzxOqBvKvKzGvn6CNGVO6
         kLzQ==
X-Gm-Message-State: AOAM5304p6qlmQWtCQEbnLaHA9vs1O/jDR4RKiyGdlzZ5gjZ8THpobXs
        FVM4MOkrYsNzf5XeYjjbVEQ0MaG2FfntmQ==
X-Google-Smtp-Source: ABdhPJz/dbe8PdDYcFN8/XXwUOrm0llgdF1eFyDiFHEMfUOfudv8Y5hCp3Z+ttsI7WHIKzuCok0vdg==
X-Received: by 2002:a1c:f701:: with SMTP id v1mr139210wmh.69.1618247750386;
        Mon, 12 Apr 2021 10:15:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/22] pickaxe -S: slightly optimize contains()
Date:   Mon, 12 Apr 2021 19:15:23 +0200
Message-Id: <patch-16.22-ed83c3add89-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "log -S<pat>" switch counts occurrences of <pat> on the
pre-image and post-image of a change. As soon as we know we had e.g. 1
before and 2 now we can stop, we don't need to keep counting past 2.

With this change a diff between A and B may have different performance
characteristics than between B and A. That's OK in this case, since
we'll emit the same output, and the effect is to make one of them
better.

I'm picking a check of "one" first on the assumption that it's a more
common case to have files grow over time than not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 23362a23597..b7494fdf89c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -68,7 +68,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	return ecbdata.hit;
 }
 
-static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
+static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
+			     unsigned int limit)
 {
 	unsigned int cnt = 0;
 	unsigned long sz = mf->size;
@@ -88,6 +89,9 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 				sz--;
 			}
 			cnt++;
+
+			if (limit && cnt == limit)
+				return cnt;
 		}
 
 	} else { /* Classic exact string match */
@@ -99,6 +103,9 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 			sz -= offset + kwsm.size[0];
 			data += offset + kwsm.size[0];
 			cnt++;
+
+			if (limit && cnt == limit)
+				return cnt;
 		}
 	}
 	return cnt;
@@ -108,8 +115,8 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	unsigned int c1 = one ? contains(one, regexp, kws) : 0;
-	unsigned int c2 = two ? contains(two, regexp, kws) : 0;
+	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
+	unsigned int c2 = two ? contains(two, regexp, kws, c1 + 1) : 0;
 	return c1 != c2;
 }
 
-- 
2.31.1.639.g3d04783866f

