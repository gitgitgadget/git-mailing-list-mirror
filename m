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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23466C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7EC61206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbhDLRQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbhDLRQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F433C06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m9so1000623wrx.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VaSkTygTZQzhDb+fapauDYfk/rjNzzAyuvOxkXfpc+o=;
        b=rqQ73mcIlaU0Lq1mWfvH2lPzO1ETFLCvxJ5GqJCEEVEIYiJkanXLDCRJHpoLvp/kjG
         3nqVq2h8fRBfYtI5B4coj9I/KDN3GQI7GebjbIoo3eex/C2JhvRtX+0nlNHfl9aB9eul
         1uNZOL2gh2rOrRsqpZRUBOcHjx8XhpM57OdkInpyzQgLoN4o0/vDncQXxl+5To57Labe
         PoTP3luQILWZQdiocVBP/zw5RehK0izFY4IhT60jNBIRVgIN4R/rxvCpqPAyYRliTODI
         7rUhRpWCKpwwKMeY4fnH+VjXKlTdaoMySndcUs1kEgjy1DbSbt2Vju9eV5JXIeDrekA6
         rsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaSkTygTZQzhDb+fapauDYfk/rjNzzAyuvOxkXfpc+o=;
        b=djomELLgipT+CLSAUwYBqyQZxRCa4qTiA4zPDJ9HN6dv/K+yAcNu9xSIdx9bqSioh8
         vmrLTW3obhhelpGBN+56TEQgSfvu9yhUeVOFWBs0glhLmOYnNZdCdX5CXkzlLEDiCiZo
         3tdzn/nKXWE9U7EID412YifE/2tnafbuow3X5P3mYTC0lN4jgxHy5FsPDtTT/Zlv6TF/
         cSCHLkJNPXfCqIKe8gqEg+dGkOA7LTaDTbTlHVyFjo8e2VRWvqTIraRA18zLTj2b+Ylw
         c4IJbWqYYfkjS3FM6IkVOwTv+AhXw3do2/20C7HTMqzYr4EtdRPpVTpSo3SHAAE/DOXe
         TVaw==
X-Gm-Message-State: AOAM533G+s6rd89HifRhME8oHwtuXeXYz4htYhn1lSwgp0aGwth5EUuP
        drWfOC8IjxHyvwjqDjezMisn1PSS7VB0Hg==
X-Google-Smtp-Source: ABdhPJzJtHNpWLqcy+BFSTD4SkHkILB3VdQJog/bZvx5xu2b1k1JXIPTEI6sq5RjLT2m0BtzYaIV6w==
X-Received: by 2002:adf:c641:: with SMTP id u1mr32916526wrg.332.1618247744735;
        Mon, 12 Apr 2021 10:15:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/22] diff.h: move pickaxe fields together again
Date:   Mon, 12 Apr 2021 19:15:16 +0200
Message-Id: <patch-09.22-fe4e75c39d2-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the pickaxe and pickaxe_opts fields next to each other again. In
a past life they'd been on adjacent lines, but when they got moved
from a global variable to the diff_options struct in 6b5ee137e5 (Diff
clean-up., 2005-09-21) they got split apart.

That split made sense at the time, the "char*" and "int" (flags)
options were being grouped, but we've long since abandoned that
pattern in the diff_options struct, and now it makes more sense to
group these together again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.h b/diff.h
index 82254396f95..8ba85c5e605 100644
--- a/diff.h
+++ b/diff.h
@@ -265,6 +265,7 @@ struct diff_options {
 	 * postimage of the diff_queue.
 	 */
 	const char *pickaxe;
+	unsigned pickaxe_opts;
 
 	/* -I<regex> */
 	regex_t **ignore_regex;
@@ -304,8 +305,6 @@ struct diff_options {
 	/* The output format used when `diff_flush()` is run. */
 	int output_format;
 
-	unsigned pickaxe_opts;
-
 	/* Affects the way detection logic for complete rewrites, renames and
 	 * copies.
 	 */
-- 
2.31.1.639.g3d04783866f

