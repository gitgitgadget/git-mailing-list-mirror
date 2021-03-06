Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DDC43381
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0196650DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhCFT0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCFTZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:25:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3006C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:25:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso1372243wmq.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=news7jlUylhCOW6liv51WiyVhWcMnH88sJdKWL+Yiro=;
        b=uuhLMLDtLBL12b6HUbGfxLHmDmlQD37WO+r8o7hhRJOpqy4KjtV+Grz2lDg/xRlb3E
         sVtczkJJCqXTu+bjpLofchWR0A6IJ/5JvZ45yLquZ+w2wVakQBlurB0ELm+7IK2N+BQV
         XASgBPZ753WLZ3JbjRvzMKm6ZwwMATttzZpDdkwZYoICvWE2gjKxfIcFzEDcFbhRNO0Z
         /u3NPTq2F3+6+1ekNucY2t05QU5RY7vjrZ6v81Rvq9SMdI3/MvzXY4hT4hvLod87wZp1
         H75nkKGidomBewCwqb1suswHw2U/CavEM5ue52lSGzqJypSIK9vlnzbkVvwOs6i14RY0
         PcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=news7jlUylhCOW6liv51WiyVhWcMnH88sJdKWL+Yiro=;
        b=EI4bs0BZdM/622GVTML9GwRLIj3wmPERFcAfeLDKh14e3Sxe1Hab6Q8hwlv6a15c3B
         adnXDlfjPH1Y9EyTLq2cZRRfH015SNUF+ZDU7H45GkyviIuB4jGu5+rX2endgLhEIXPi
         45rNgRuk0L5ZQ+IIutot8miboBe9rTDa9oifKXrbfSpRrfz6yI2JkHjz/FWBXNePR3nT
         8lf/rTDW7aeUM3hljDLnvSU2f4nJ8JILTxFePX7orvsiMsbeVOcyaCXzwiM/pCBgxaGU
         EkMILY+a8rqfCjt+DIjQ2DAj6IGUTjQZ3RH7OBA0BnJlkQ1FkjgNR1WgsLTCT58t+/tn
         y+JA==
X-Gm-Message-State: AOAM533BZOneQNmsJKHXH9noQ/67mSaV2ELO5ZrlfyIRiPGaZlN+syIb
        ZWUtRZld/iH3DogHlEnyzCkc9OL3bwusOg==
X-Google-Smtp-Source: ABdhPJyZbuSf0ytymlsyi8+pUuRVaq5P5ASgUFI4CD7KLy0+sRuF2elYNg+40cufrgFo3khw751axg==
X-Received: by 2002:a1c:1bc7:: with SMTP id b190mr14758494wmb.115.1615058738118;
        Sat, 06 Mar 2021 11:25:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm11489714wmf.45.2021.03.06.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:25:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/4] Makefile/coccicheck: use --include-headers-for-types
Date:   Sat,  6 Mar 2021 20:25:25 +0100
Message-Id: <20210306192525.15197-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210305170724.23859-5-avarab@gmail.com>
References: <20210305170724.23859-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the recently added --no-includes out for --all-includes
--include-headers-for-types.

When I moved from --all-includes to --no-includes I missed that rules
that use "type T" such as the one added dbc540c7a58 (add QSORT,
2016-09-29) won't work as intended. See [1] for a report of that.

So let's move back to --all-includes to potentially scour our includes
for definitions, but supply --include-headers-for-types so we won't
racily emit duplicate hunks. See [2] for more discussion about that
issue.

This undoes most of the optimization we gained with --no-includes,
using a very basic benchmark script [3] I get these results:

 * ~1m50s: --all-includes (before my recent patches)
   38 files changed, 74 insertions(+), 78 deletions(-)
 * ~55s:   --no-includes
   27 files changed, 55 insertions(+), 57 deletions(-)
 * ~1m35s: --all-includes --include-headers-for-types
   38 files changed, 74 insertions(+), 78 deletions(-)
 * ~1m20s: --local-includes --include-headers-for-types
   36 files changed, 70 insertions(+), 72 deletions(-)
 * ~1m20s: --local-includes --include-headers-for-types --no-loops
   36 files changed, 70 insertions(+), 72 deletions(-)

And only the "--all-includes --include-headers-for-types" gets the
same results as the previous "--all-includes", even with
"--local-includes" we miss out on some definitions.

1. https://lore.kernel.org/git/3aac381e-2ce9-e35e-498c-9c26df235aed@web.de/
2. https://lore.kernel.org/git/YENdUMLTM+cerfqJ@coredump.intra.peff.net/
3.
   for flags in \
       '--all-includes' \
       '--no-includes' \
       '--all-includes --include-headers-for-types' \
       '--local-includes --include-headers-for-types' \
       '--local-includes --include-headers-for-types --no-loops'
   do
   	git reset --hard &&
           git clean -dxfq contrib/
   	time make -j8 coccicheck SPATCH_FLAGS="$flags --patch ." SPATCH_XARGS="xargs -P 8 -n 16" 2>&1 | grep -v SPATCH
   	cat contrib/coccinelle/*.patch | git apply
   	git --no-pager diff --shortstat
   	git --no-pager diff | git patch-id
   done

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8aca96c6921..93b1009fbb1 100644
--- a/Makefile
+++ b/Makefile
@@ -1199,7 +1199,7 @@ SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --no-includes --patch .
+SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
 
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
-- 
2.31.0.rc0.126.g04f22c5b82

