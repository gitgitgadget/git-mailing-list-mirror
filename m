Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD88C47095
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E07208C7
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+omOjWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgJGOJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgJGOJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE2C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so2348925wrt.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M/QthR91i79H7bu4fIAyrnvQ5WFBNKCoEToyeargL68=;
        b=G+omOjWUlX/AwZl/PFFyB1hp+nGTpT8Ehvgmd+1WEadTpNXKWDKBxkTOUYKRPtgaXz
         6wNdfdpvlVBdzCacAuZkMxY7k543XHDeYlEKCGvM+Xqh0qjlUwoiEOIDYCy0iBvLWgCg
         +QOrY2nNNLJP0UbYQiimrI2KGo2vti4w5M7qIB1ajHZ4UE9r4gS9KjcJ4QP9L0WrAJFE
         dr3IMYkO96FQzEBFvaM14B8KnxINJNy/uYhDMb7sRVOrhCvFp+kquCfIGjYmMs1PmmjJ
         ++C2GRRXG9LB5aztf3MOZc5K3ZFhbnaPVbiK7rkVx/NtN/N4dCs51Fyb9AXjJN+11qWM
         f0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M/QthR91i79H7bu4fIAyrnvQ5WFBNKCoEToyeargL68=;
        b=hhagb8gd59MH8LhK9e/nhJfgA9LQtw+tA9UhVnJ+iKo9oplxS50EsdxU8jkyEbIAkF
         fHKpq3w9Iivt85gGhcYEbFXzPm5WiI5oq3uLwqQIJx+WrPRPVrzrzt2yuFqCadAYLa3l
         rp6AV/W58kX+aiUM6MM4dpnTg1BfD/Ka9ORGpwQBhV3iDvA1WpkgOh8uI1hUDdIUD8nf
         DF6LHjrIqfrmAnKAfQkGr/YsPAOq127gVhKL3VeQ1BqRldpp3r9WfBgOcqW1SpdiyKr4
         WzSwXLcQQpD5kVxKXsyev4YRJ39AeKKsnUCzk/szF6F8kgK1TMaED4qTm/jUx0hMb8Pz
         WbYw==
X-Gm-Message-State: AOAM533j3nWWDcYtRSJ7Wfjsw0iSzygcOIcuOrFitBA9gmwBn5+rG4kW
        AwW3683k5NmaIJZpSigJvPxaxwvrh18=
X-Google-Smtp-Source: ABdhPJy1J+YwmgdHvite0A6rjblnBnADlyho6+Zl5L4jWIHsPduGwYfPIZRKCVPPPwDQMg9yp/YmrQ==
X-Received: by 2002:adf:e952:: with SMTP id m18mr3679162wrn.171.1602079788572;
        Wed, 07 Oct 2020 07:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm1734646wrq.72.2020.10.07.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:48 -0700 (PDT)
Message-Id: <fae81b534b14c8227454ff94e385fb16faee0e99.1602079785.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:36 +0000
Subject: [PATCH v4 01/10] commit-graph: fix regression when computing Bloom
 filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

commit_gen_cmp is used when writing a commit-graph to sort commits in
generation order before computing Bloom filters. Since c49c82aa (commit:
move members graph_pos, generation to a slab, 2020-06-17) made it so
that 'commit_graph_generation()' returns 'GENERATION_NUMBER_INFINITY'
during writing, we cannot call it within this function. Instead, access
the generation number directly through the slab (i.e., by calling
'commit_graph_data_at(c)->generation') in order to access it while
writing.

While measuring performance with `git commit-graph write --reachable
--changed-paths` on the linux repository led to around 1m40s for both
HEAD and master (and could be due to fault in my measurements), it is
still the "right" thing to do.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cb042bdba8..94503e584b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_generation(a);
-	uint32_t generation_b = commit_graph_generation(b);
+	uint32_t generation_a = commit_graph_data_at(a)->generation;
+	uint32_t generation_b = commit_graph_data_at(b)->generation;
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
-- 
gitgitgadget

