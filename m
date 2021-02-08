Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E53C433E9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2D764DED
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBHNrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhBHNrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 08:47:08 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956E6C06121E
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 05:44:08 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i20so14182792otl.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 05:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PjZxk2UxyaxXbcjpIT5b/Cs/A+EjZWEy9FJR/kfZVmU=;
        b=bVN1PA9d8uEvo72RYe0xmbVqjkhev1Hj981AIp4wAvtpRNzMGadfib/pGNMDUef62K
         U5wsvFPD63WVwwvlIidsO1VTWB2SW3z9uWGhRYIS9fpkj7A1ZQa9kIWCnHhbH6d15HMG
         gQTLmkeS+LdNosj15H7yIq62z4JsBxkYFi6+3UPMRG0l+uh4SsA68D3uagfqXP5upMgF
         8oKiJLy65hBOgVAPwGevYRudjkN9a6v5SygConSMZNa96qzu7pDAAQMQ/rKnR8uSCDXK
         5uuCQ8dJ585UAQQqN3TII3xHi0EfkHGDsVoaQId9d7WRLO36x3L9qavd50+qs9Njea6Z
         ZtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PjZxk2UxyaxXbcjpIT5b/Cs/A+EjZWEy9FJR/kfZVmU=;
        b=owzDUhCEh+4e2TNp1lf2d592eIMXvXPsp6C1vUAk7LXPs9o6bK/kNLWuhOvl277Zxv
         4k/k6o8X2Jx48A01Y8crIWOEvVaM6UU2xJJjeC293M1JTs81ID4kuMyk/TSEqwKQ1mT0
         3+GZymFAXUMEbhUynK2bE+uM8blKRzX4RV4u3v5J/Xs4OwKtLxJcLuv5cet4s0ISWzR2
         FPHevq1Sbwz7uFLh//calfmCUE9wugIaTLIO3+BVrgzvs8E/cJ//LNT+Dx5UyzUyT0e2
         yWuw0RomtQfoS7hA/SRoONk4ZP/dKIwbtm93SDeXmg3UJNJ3maXNHl+eiu+JUCmDWtrm
         7nHg==
X-Gm-Message-State: AOAM5335lp48ogkLF7Sv7u1lqOTBKmJk5QBUEPevIn26Db52s83MLVtk
        vLqjq0sICqJ++YreS4tCISw=
X-Google-Smtp-Source: ABdhPJwOqP2LfMKtCD4KYCQZ2FA5I5hee9n311nOSeo5SmtyZgbefzTvTCIiL4aQhbLH6FFi6qZdaA==
X-Received: by 2002:a05:6830:233a:: with SMTP id q26mr12043135otg.151.1612791847993;
        Mon, 08 Feb 2021 05:44:07 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id s189sm3573376oif.19.2021.02.08.05.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 05:44:07 -0800 (PST)
Message-ID: <96d4f87d-eb6e-faec-1d22-5f6ae307b624@gmail.com>
Date:   Mon, 8 Feb 2021 08:44:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v3 02/17] chunk-format: create chunk format write API
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <16c37d2370cf4fd5fc309ac6dc8aa6443ffcf3d7.1612535453.git.gitgitgadget@gmail.com>
 <20210207211359.GD1015009@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210207211359.GD1015009@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2021 4:13 PM, SZEDER Gábor wrote:
>> +#define CHUNK_LOOKUP_WIDTH 12
> 
> As this macro is defined in 'chunk-format.c' it's not part of the
> chunkfile API.  However, at the end of this patch series
> 'commit-graph.c' still contains:
> 
>   #define GRAPH_CHUNKLOOKUP_WIDTH 12
> 
> and uses it in a couple of safety checks (that didn't became part of
> the common chunkfile module; why?),

Chunk-based files don't have a minimum size unless we know the header
size and a minimum number of required chunks. I suppose that we could
add this in the future to further simplify consumers of the API.

> while 'midx.c' contains:
> 
>   #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
> 
> though it's not used anymore.
> 
> I think we should have only one such constant as part of the chunkfile
> API; and preferably use the definition from 'midx.c' as it is more
> informative than yet another magic number.
> 
> Furthermore, being called 'CHUNK_LOOKUP_WIDTH', I had to look up the
> places where this constant is used to make sure that it indeed means
> what I suspect it means.  Perhaps CHUNK_TOC_ENTRY_SIZE would be a more
> descriptive name for this constant.

More descriptive, for sure.

> On a somewhat related note: 'commit-graph.c' and 'midx.c' still
> contains the constants MAX_NUM_CHUNKS and MIDX_MAX_CHUNKS,
> respecticely, but neither of them is used anymore.

Thanks. The following patch can be added on top of this series
to clean up these dangling macros.

Thanks,
-Stolee

--- >8 ---

From 839b880ccee65eac63e8b77b12fab6531acc55b0 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 8 Feb 2021 08:38:47 -0500
Subject: [PATCH] chunk-format: remove outdated macro constants
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following macros were needed by midx.c and commit-graph.c to handle
their independent implementations of the chunk-based file format, but
now the chunk-format API makes them obsolete:

* MAX_NUM_CHUNKS
* MIDX_MAX_CHUNKS
* MIX_CHUNKLOOKUP_WIDTH

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 1 -
 midx.c         | 2 --
 2 files changed, 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 32cf5091d2f..3b5a8767269 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,7 +45,6 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 9
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
diff --git a/midx.c b/midx.c
index 95648a1f368..5c7f2ed2333 100644
--- a/midx.c
+++ b/midx.c
@@ -22,14 +22,12 @@
 #define MIDX_HEADER_SIZE 12
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
-#define MIDX_MAX_CHUNKS 5
 #define MIDX_CHUNK_ALIGNMENT 4
 #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
 #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
 #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
-#define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
-- 
2.30.0.vfs.0.0.exp

