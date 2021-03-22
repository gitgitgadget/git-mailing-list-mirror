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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C7C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9806198E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCVMMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCVMMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 08:12:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0192EC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so11287882wml.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWIXzARB7FLWYSbrwyfHNwRq7fv2JGmNDPMC5kFoy8c=;
        b=q9xb/1TZL+uIw1DKyzcdZ5g6fzPstf4sVTYsz87812JRuKFpfKi0ALyUj3sEEiybV6
         gYfnSfxVXyKWc6eT0rEVHeXzgJxhlCYyIMIuuiUSe4yRM79RJYx4fdF5I9Djs8v+UjOf
         JITOOMvfY0K4ms0+PpMWYRAqEBku+sXLlv6nK0YJLgnQHW3mEkaPUTyDgg9xWj01iYus
         tfB2D0gWbOR+5vjIAX6mmqBhFji4XvBmJP578o97+lJhKayBkGrx8X7mVLvCw5ziczBt
         E62QuV1Mct9UdHjtBcDkhFf9WIjFttruNFDOKHcdK2H3jl76+SIuPg+tC+Az/FV9kpqP
         FQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWIXzARB7FLWYSbrwyfHNwRq7fv2JGmNDPMC5kFoy8c=;
        b=mqZCR9HdBYlHCnjMEj7Si4XukCc59Puzo6uU1P3HNpJfsafpU+brCq/itJjKP540wi
         3FC0F0kh+00Md1XutPpsu5Ag9sLyQvtWDLZJpGcYq/mOgfIdIN/SS554ENJLFtsSJJpk
         f4H1KkqVKuUHXkl0czHhJpNTCqWFHizUfYMCDgVENKbMhQcM93bmK/nuDdH24Km+rQXR
         KwTbli39MYb4QXK5BjS8sA3bggpAUqHzwfq7k7FTllR/v3WUWCHJHG7tvIgxadJA/icy
         kmhXbRSgZ362q/UyENr4LJlJelteJl4aeF+EPRtT/dsGK3hxEUIWPMmaUzA/P5pycawR
         LtwA==
X-Gm-Message-State: AOAM530hYmEfY7pRjUagr6L+H+Rq/zYbuz0/nsaXzO90EecW9ovRJ6gR
        FqkGx/t8X8IL747J7CAf/D2TTScWkg6jlg==
X-Google-Smtp-Source: ABdhPJzXlCKsWKjieb4g+ryUDwTR0eOErnhghyQKQM3ai/uOb9237jyBBMgRj7wIv6p/1GuC2u9tLw==
X-Received: by 2002:a05:600c:1405:: with SMTP id g5mr15412978wmi.140.1616415128466;
        Mon, 22 Mar 2021 05:12:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm15621142wmp.30.2021.03.22.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:12:07 -0700 (PDT)
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
Subject: [PATCH v4 2/4] Makefile/coccicheck: speed up and fix bug with duplicate hunks
Date:   Mon, 22 Mar 2021 13:11:48 +0100
Message-Id: <3bca3239cb84488a1638f2bb269392f47f78c6da.1616414951.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616414951.git.avarab@gmail.com>
References: <20210306192525.15197-1-avarab@gmail.com> <cover.1616414951.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the coccicheck target to run on all of our *.c and *.h files
with --include-headers-for-types, instead of trusting it to find *.h
files and other includes to modify from its recursive walking of
includes as it has been doing with only --all-includes.

The --all-includes option introduced in a9a884aea57 (coccicheck: use
--all-includes by default, 2016-09-30) is needed because we have rules
that e.g. use the "type T" construct that wouldn't match unless we
scoured our headers for the definition of the relevant type.

But combining --all-includes it with processing N files at a time with
xargs as we've done since 960154b9c17 (coccicheck: optionally batch
spatch invocations, 2019-05-06) introduced a subtle bug with duplicate
hunks being written to the generated *.patch files. I did not dig down
to the root cause of that, but I think it's due to spatch doing (and
failing to do) some magical locking/racy mtime checking to decide if
it emits a hunk. See [1] for a way to reproduce the issue, and a
discussion of it.

This change speeds up the runtime of "make -j8 coccicheck" from ~1m50s
to ~1m20s for me. See [2] for more timings.

We could also use --no-includes for a runtime of ~55s, but that would
produce broken patches (we miss some hunks) in cases where we need the
type or other definitions from included files.

If anyone cares there's probably an optimization opportunity here to
e.g. detect that the whole file doesn't need to consider includes,
since the rules would be unambiguous without considering them.

Note on portability: The --include-headers-for-types option is not in
my "man spatch", but it's been part of spatch since 2014. See its
fe3a327a (include headers for types option, 2014-07-27), it was first
released with version 1.0.0 of spatch, released in April 2015. The
spatch developers are just inconsistent about updating their TeX docs
and manpages at the same time.

1. https://lore.kernel.org/git/20210305170724.23859-3-avarab@gmail.com/
2. https://lore.kernel.org/git/20210306192525.15197-1-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index eef99b4705d..e43a9618df5 100644
--- a/Makefile
+++ b/Makefile
@@ -1199,7 +1199,8 @@ SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --all-includes --patch .
+SPATCH_FLAGS = --all-includes --include-headers-for-types --patch .
+
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -2860,7 +2861,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-- 
2.31.0.285.gb40d23e604f

