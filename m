Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CB3C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D77C206D8
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFQjwjmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgHICxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICxv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD4C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so5215838wmi.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8HfzOFn9EHvhlcJ4nPceB7zs4j6XWa23+RSfvwPSb0Y=;
        b=nFQjwjmEv4hXma8csi+ypq0SveVUtmCPw3Ep90S4aNO8JdYOcUKN1WZbymHAcY7yFm
         PNo/72mCGGkgQEUXIcbkM7XIFqC/QF02Cj+ecMupokenJaBh4QN+nsO9P8pz9iVoqx7W
         dYQOEClOaQwp5+V0vg2IgatU38m93Xojueogjts4H5867Zh31UJbJGyBeNpbc2pynl9S
         TsF4/yTOJdgV63dXoOpz80QcCxln4Buvr0t061fSR2jXdB8VYlsFMZk9avvyncbwSiFP
         Dvolxm+UpOIzn/NSlPfLp5ZMhBx2HL+5EPKHZ+R/iJEWD34PEEWVRLnhrjVa+ANyHWMJ
         UwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8HfzOFn9EHvhlcJ4nPceB7zs4j6XWa23+RSfvwPSb0Y=;
        b=Zn/ut+THJHO4StwgD9K6pJMwdTL4SIAq4fu1J1DYIPYXsBicgExuOXep8Eprdrz2aY
         sPZwZ1Yn7ZCh69PnSqj413pp+2czmpZTqqYuJwR4gcSAvQM8AngoDPz4Dakhzm/0iHMm
         OrcZN1C9flJ/VgrbS0wFm9h4G4HVcrdMds5aJjyRk6SUX/crea+sF9cqSfCPmjTRF1po
         338fP/l8C8XFB4UV+ItesQ0amO8QGHHjfyMRpFG3U0FLV3XD6D330pzZHcKYMLA1mcam
         wPZSfxqRP5iibFXTQYTiOBwDALn0FsUsu2Co6ulgZq0xOsRcYX8GJ/tH40x4m7I4Byyl
         ZJOg==
X-Gm-Message-State: AOAM533XZKLgn7RG8m+BdCzZePzTj42jOSRI0VXr0mjhgd2qQAaS51zI
        yGXGEOgw2flWHunwbOJ2v7WwIpeE
X-Google-Smtp-Source: ABdhPJxeSqNCM+IMfHpPjKbik4/x+N7gWwAFgBNfYKVCC6uyxLrB+HPyc2slfVDVFm8bHf2KLrdMrg==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr19547996wmi.34.1596941629546;
        Sat, 08 Aug 2020 19:53:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b129sm15667379wmb.29.2020.08.08.19.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:49 -0700 (PDT)
Message-Id: <a962b9ae4b7a95a8263010ba76519f2bc0a73888.1596941624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:35 +0000
Subject: [PATCH v2 01/10] commit-graph: fix regression when computing bloom
 filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
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

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e51c91dd5b..ace7400a1a 100644
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

