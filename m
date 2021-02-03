Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D8C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3AD64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhBCD34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhBCD3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40089C061794
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j11so3381192wmi.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fpIbgVB1ioLE6p5hinYpbuExDDHGymIPBD7V65ryiY=;
        b=s4kDWWoj0mosA7c5PMgexLiA6pXwpwXm/dAR0OSSHQKyLup0SxWiY9/Qc+3csOrWm5
         enmgBT2d++Ob7FFHjbRVX6ZD8Az693fvFn4k3o8RIzzFMZZ5tHrz1Qb4aHN4QASPCpCq
         UxChzz51eGbPkuhkc6e5RHYjmtK57VvobQQK2lX9kiobPqOzKC2pV96QTQOdSoAwQAQI
         ESBIQuMj5Lbz2ye1tNuSUE8xZCaTY6LsriJDNacYoQqRVujATyk38mjdgb8YX5+oT1Fz
         5ZHiyd0OScNpupYG6QjR0ynKcsjNLvcjJe4yXdMqqJ+MT2GFqs/qG1arXPKEBhsmndvc
         0qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fpIbgVB1ioLE6p5hinYpbuExDDHGymIPBD7V65ryiY=;
        b=QU3Tww8kmEUnPleIgUrvl1YjSztb3kI8x1IMXjGcn1VhUS3VijwWHlsSIGbuQKoX8D
         NHDCogav9uLMnW28yV9Elv723VFycMCASLMe07etUGihry8ThMbIowWpkaIu23IwfPYS
         VDWze4uAKZljdKYEUAOSjk0/D3xoZ4TA9SxvVHeT1M99q8AEQYtZBC2TGht3rosvF/Ke
         AV0USsL9E8tP5WIlJq7sQgXmahiYKQ8rt+cCdOVzBjApMnOIqq5PMOwd2wJhjGfgic8n
         df54Xvrwc4FiIfTGDAAt+7NDIKsGEaLslwpAnP1ugpdPr7AGJWZdt0nz7MYfVKBlS29y
         e81A==
X-Gm-Message-State: AOAM533dpItSRseBevg42k9hvhoObNAZ7bU9njFWy8RlJ0Ka4g6tgkmy
        oT0cxze8Vsm6ehqZIsgAnLnbpWNN/c3r+w==
X-Google-Smtp-Source: ABdhPJwAUoQvdbe47W3e/5bBkNzlfFGASr0688DgqyP095egZsDvA78EX1DrKMsMdXtNBiTocfWh5Q==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr37108wml.164.1612322905695;
        Tue, 02 Feb 2021 19:28:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/25] grep/pcre2: actually make pcre2 use custom allocator
Date:   Wed,  3 Feb 2021 04:27:55 +0100
Message-Id: <20210203032811.14979-10-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue work started in 513f2b0bbd4 (grep: make PCRE2 aware of custom
allocator, 2019-10-16) and make PCREv2 use our pcre2_{malloc,free}().
functions for allocation. We'll now use it for all PCREv2 allocations.

The reason 513f2b0bbd4 worked as a bugfix for the USE_NED_ALLOCATOR
issue is because it managed to target pretty much the allocation freed
via free(), as opposed to by a pcre2_*free() function. I.e. the
pcre2_maketables() and pcre2_maketables_free() pair. For most of the
rest we continued allocating with stock malloc() inside PCREv2 itself,
but didn't segfault because we'd use its corresponding free().

In a preceding commit of mine I changed the free() to
pcre2_maketables_free() on versions of PCREv2 10.34 and newer. So as
far as fixing the segfault goes we could revert 513f2b0bbd4. But then
we wouldn't use the desired allocator, let's just use it instead.

Before this patch we'd on e.g.:

    grep --threads=1 -iP æ.*var.*xyz

Only use pcre2_{malloc,free}() for 2 malloc() calls and 2
corresponding free() call. Now it's 12 calls to each. This can be
observed with the GREP_PCRE2_DEBUG_MALLOC debug mode.

Reading the history of how this bug got introduced it wasn't present
in Johannes's original patch[1] to fix the issue.

My reading of that thread is that the approach the follow-up patches
to Johannes's original pursued were based on misunderstanding of how
the PCREv2 API works. In particular this part of [2]:

    "most of the time (like when using UTF-8) the chartable (and
    therefore the global context) is not needed (even when using
    alternate allocators)"

That's simply not how PCREv2 memory allocation works. It's easy to see
how the misunderstanding came about. It's because (as noted above) the
issue was noticed because of our use of free() in our own grep.c for
freeing the memory allocated by pcre2_maketables().

Thus the misunderstanding that PCREv2's compile context is something
only needed for pcre2_maketables(), and e.g. an aborted earlier
attempt[3] to only set it up when we ourselves called
pcre2_maketables().

That's not what PCREv2's compile context is. To quote PCREv2's
documentation:

    "This context just contains pointers to (and data for) external
    memory management functions that are called from several places in
    the PCRE2 library."

Thus the failed attempts to go down the route of only creating the
general context in cases where we ourselves call pcre2_maketables(),
before finally settling on the approach 513f2b0bbd4 took of always
creating it.

Instead we should always create it, and then pass the general context
to those functions that accept it, so that they'll consistently use
our preferred memory allocation functions.

1. https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/CAPUEsphMh_ZqcH3M7PXC9jHTfEdQN3mhTAK2JDkdvKBp53YBoA@mail.gmail.com/
3. https://lore.kernel.org/git/20190806085014.47776-3-carenas@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index c63dbff4b2..0116ff5f09 100644
--- a/grep.c
+++ b/grep.c
@@ -390,7 +390,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			if (!pcre2_global_context)
 				BUG("pcre2_global_context uninitialized");
 			p->pcre2_tables = pcre2_maketables(pcre2_global_context);
-			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
+			p->pcre2_compile_context = pcre2_compile_context_create(pcre2_global_context);
 			pcre2_set_character_tables(p->pcre2_compile_context,
 							p->pcre2_tables);
 		}
@@ -411,7 +411,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 					 p->pcre2_compile_context);
 
 	if (p->pcre2_pattern) {
-		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, NULL);
+		p->pcre2_match_data = pcre2_match_data_create_from_pattern(p->pcre2_pattern, pcre2_global_context);
 		if (!p->pcre2_match_data)
 			die("Couldn't allocate PCRE2 match data");
 	} else {
-- 
2.30.0.284.gd98b1dd5eaa7

