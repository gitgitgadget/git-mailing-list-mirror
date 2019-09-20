Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5B31F463
	for <e@80x24.org>; Fri, 20 Sep 2019 14:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392496AbfITOhG (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 10:37:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44532 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfITOhF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 10:37:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so8868861qth.11
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/P4N7nRRYX6sWrPo4FvEpv1l8NVf2/NJPrTgGaY/o4=;
        b=gbj3X4bTThvwV+DSOlu01rojML45scHDFTr4JyvxhbKLAoSiB09tykdsv+LIPNntZR
         Ig7dgL6czi7TO55hPIv1Hjs9Bh8t8RKEUxP2lNte1dxHkxHyolCWGfiapJVCTI03GGB6
         PUvrxalHiTtEOqt+Y8meijGmulRldMiBTHY2Sp9YyQTi+szjrJK5q4zhbqxcqB/jWesG
         7BuPIT4YuN3Bgjy/7Kij1XwWS0OCSpA+aCrtQV8Hpz1YbBiDddrx4K8CFaqQJajA7PT6
         fTHFbAL91x/P8dnNzBk062cYtBz2tpxjY8a18sMib07ob0WztNFKQ8wBWPTyvWTOacpV
         A20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/P4N7nRRYX6sWrPo4FvEpv1l8NVf2/NJPrTgGaY/o4=;
        b=SK6uG+TJbwet0tpcM9Wv3maMNwfG/XUXk+Kg14W+IH5eBBDXRkkn73srJCjw7a50Eu
         XvodZudpc3wd9ZAy5JwFLpV9bCFodXME2XMHryPmbtS1u7RZg6dtlye1FeD0hSOZ/YL0
         gf9zTbCdeTNwZ/YOnuRYDyUxXMLRHflvauiQ2hCCtQYj+ePyohaRd/onYDMXZynfnUfC
         1N9xC+Orb54/ERrnyoiO2f0HYta1G2WSfd8JJuzWK5GWCRZ+iFZ/FgAzw0DFW3rhGN6R
         snLCo6LBalJxdTf1np9XhSev56t7iBDstHBmA2nQSL2YsPEDuFQO5ROCNW2soTfh66mI
         NhKw==
X-Gm-Message-State: APjAAAVO6LatjRxXpRnEqSf1r6JudTY/8h1co/ZkolPmrkFO8oFCqlnT
        5c08azADGDsK5KzFgOJYDws=
X-Google-Smtp-Source: APXvYqxO6RWp01/t2PBnGfn/ve0jrNw3khUc9NJAgnvuotgfbSiP4EMpbQxiHSN/VvCoImU8NVOc3Q==
X-Received: by 2002:ac8:18c2:: with SMTP id o2mr3746071qtk.276.1568990223758;
        Fri, 20 Sep 2019 07:37:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1012:89d6:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id f27sm947160qkh.42.2019.09.20.07.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 07:37:03 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] sparse-checkout: use hashmaps for cone patterns
From:   Derrick Stolee <stolee@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <95a3285bc6021daa236d98d7e1bbdc5c45fc73b0.1568904188.git.gitgitgadget@gmail.com>
 <6b461ad3-164d-46ff-4a68-99f8e6562a72@gmail.com>
Message-ID: <7d87fe4b-160c-34c2-db6d-4a56fd919755@gmail.com>
Date:   Fri, 20 Sep 2019 10:37:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <6b461ad3-164d-46ff-4a68-99f8e6562a72@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 4:59 PM, Derrick Stolee wrote:
> On 9/19/2019 10:43 AM, Derrick Stolee via GitGitGadget wrote:
>> @@ -848,6 +953,10 @@ static int add_patterns_from_buffer(char *buf, size_t size,
>>  	int i, lineno = 1;
>>  	char *entry;
>>  
>> +	pl->use_cone_patterns = core_sparse_checkout_cone;
>> +	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
>> +	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
>> +
> 
> Just a head's-up to anyone looking at this series: this is not the
> right place to set use_cone_patterns (without passing a flag or
> something). This same path is called from the .gitignore machinery,
> so if you have a non-cone pattern in your .gitignore you will start
> seeing warnings with core.sparseCheckoutCone=true.
> 
> I figured it out only via integration tests with our C# layer. In
> v2 I'll fix this and add a test to make sure it stays fixed.

Here is the code fix. I will have a test to check this in v3.

-->8--

From 73b100d11d11bf8f045c2e116390120819dcb800 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 20 Sep 2019 08:55:06 -0400
Subject: [PATCH v2] fixup! sparse-checkout: use hashmaps for cone patterns

---
 dir.c          | 1 -
 unpack-trees.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 35fd60d487..248a418379 100644
--- a/dir.c
+++ b/dir.c
@@ -953,7 +953,6 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 	int i, lineno = 1;
 	char *entry;
 
-	pl->use_cone_patterns = core_sparse_checkout_cone;
 	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 43acc0ffd6..b5cf591c38 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1487,6 +1487,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
+		pl.use_cone_patterns = core_sparse_checkout_cone;
 		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
 			o->skip_sparse_checkout = 1;
 		else
-- 
2.23.0.vfs.1.1.19.gce6e76d


