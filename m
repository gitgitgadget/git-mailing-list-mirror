Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C69C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 06:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjAJGRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjAJGRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691731C420
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 22:17:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i9so16000686edj.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 22:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF+Npn4IYn8MYiiFLZZMS4lxEToW/kMgWRWF9wQijx4=;
        b=RxaXnHquRBs65fvCFgg2PHpN1qIX/MzYNGq6Cw2xz2lN1EBTWALrt9k9fleiaSP3CI
         Dh3zpxgCIxucGSVDsHqb373uv/8nYEugtrdC3QiIFl2RJmDigFTt52UwFJev/4rkqXxd
         lyGAGl5CvCjzLpPxvUVw2NalRT9ovLnqYSNVR3VtR0Hw1OFzd1qI06K+cmEVjydhdxDq
         OnEHw/V51TfukNio07ZqPYY6KsdeRiza5fxgffPZZsdPxm7vppg3KjyqF8SvRyfvmPdf
         5kDLJgWxWV4x6H2rxs7Q9noOpSU6k1DZV8ZsY4AH/zlqMoFltQzbEMxWxvD8ETMkVIru
         nuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF+Npn4IYn8MYiiFLZZMS4lxEToW/kMgWRWF9wQijx4=;
        b=ywKBgYP4HsOTXR79g6bgZ+taA0HwHmCCcdR/H1UQUQEjiF6IdPoNlsPj6gFPQgqZoh
         m24XKWqzcqrrzfUUHpVamODNM2RfDdSESMBhvPoai0SJzjyI/dJvOXGZTfzI0ohtrQvw
         AHcdokeBB0A015sL+WPKr8SVJKhQ93ixepuqEFCNFD1whQAXsyVfZggLy/a0tWqdZ7T9
         PxNf3y+OAo8nS18GMioD99gB+EOxDHIGdu7opQZsvE3mfi2bmQO7LMRHGQ3NZOjrB4ic
         aK0DG3PsraZ5BUA4dNtGIZzdI5lnUbZiS1GUtqFz/D59oxE4bgSq9aqnk+0MZTAhlVIo
         ITdw==
X-Gm-Message-State: AFqh2kr82MeXNoIzTTpe63TKo1EefXzDeygicQEk61J7y5IsDlAAyZ3y
        hBTa21rCWiWQdstPnxYq9RgREy7pHfvrOA==
X-Google-Smtp-Source: AMrXdXvfO06FDVyeUmQ7qz8w+/zj9XSvJn5EI+/TrEWXT2H951e3OcWxWNuyq/wNpS7pPGXTwBAetQ==
X-Received: by 2002:a05:6402:3985:b0:467:9976:2e38 with SMTP id fk5-20020a056402398500b0046799762e38mr62767870edb.18.1673331459671;
        Mon, 09 Jan 2023 22:17:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4555601edx.34.2023.01.09.22.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:17:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] sparse-index.c: expand_to_path() can assume non-NULL "istate"
Date:   Tue, 10 Jan 2023 07:17:30 +0100
Message-Id: <patch-2.5-6db74fe958f-20230110T060340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function added in [1] was subsequently used in [2]. All of the
calls to it are in name-hash.c, and come after calls to
lazy_init_name_hash(istate). The first thing that function does is:

	if (istate->name_hash_initialized)
		return;

So we can already assume that we have a non-NULL "istate" here, or
we'd be segfaulting. Let's not confuse matters by making it appear
that's not the case.

1. 71f82d032f3 (sparse-index: expand_to_path(), 2021-04-12)
2. 4589bca829a (name-hash: use expand_to_path(), 2021-04-12)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sparse-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8c269dab803..65a08d33c73 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -547,7 +547,7 @@ void expand_to_path(struct index_state *istate,
 	if (in_expand_to_path)
 		return;
 
-	if (!istate || !istate->sparse_index)
+	if (!istate->sparse_index)
 		return;
 
 	if (!istate->repo)
-- 
2.39.0.1195.gabc92c078c4

