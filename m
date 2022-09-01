Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83520ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 17:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiIARDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiIARDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 13:03:14 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151698D30
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 10:03:13 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 10so15130324iou.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v1WfGrIXBeTOCXivPJ5rqc48o63ybrKkYJeO97lJseA=;
        b=BDxHCZpwqbMa1zfAf1qqqLekVzW7GSktShGW19DoRl+ibu6B3kw80G0g0fMTCauWBN
         eiQNCr3yrYXX90xghj7zK97iQSv86fIIOoHGUvHK9mI/LMdPR3NZ0dydXkHeJLcRRL9X
         yHLioADjTA4VYBuusMu8AnQUOTlpUMWgK3HxW3Fn/lhlOHD1slwE4DURw3RqNfOTgjn4
         ou+smUmO8P+7S+VUEOyZwb+/ONWPVx+aKBRXctyQUlAfURRdYlt1ZikcjLc5Ex3TibwV
         f1oXavITdMkCdDOni5CR/0JsbpbdhbFjr0n3eVSfPyoBoT5rBdkNfw9Vy6rtkYWhV96Z
         vMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v1WfGrIXBeTOCXivPJ5rqc48o63ybrKkYJeO97lJseA=;
        b=XHjjFYApXNs2jmzU9Ys28gdN4xmnEKEB8io2vzmo9drILeM04ip95wF2VjT3T7yUzQ
         +A2z88uztA43FLc65MF+/J8isqBvyWVBL+SJI4q6vFjRY6sW94G9G0cc6QzPynXS1i0f
         lnlIXeDQnyxvEHv+EEdAFrkqBOVCr23MPczBQmUWrtgpiNE+wTIZgwgu/t7nITgRKEwD
         rmJEokY5zeyTWgIaMmZ0bebqZQmhBL5c2amrw79oHFSG+XHI1FeUBtxocZWrJRZhjJO/
         MMsjbGBcet1QI7qTvaWDJflRtHTbWpgtt1nTYhcvgpHrTT3coPyfNOz78NH1e7LvibJv
         Iy1A==
X-Gm-Message-State: ACgBeo32RBx3Vk6MvayUcPES7GyAp3MbWcBx1Tw8B2IQM/tauIMXu4fu
        UWYi4MhUl7oma4A70BlYE0jDD8QdpQWQ
X-Google-Smtp-Source: AA6agR44GSktzcrt7B1AbitAQTA2knmXRkFtDsXUz/Z3KhzrFNSc0HTbPTEvOpfOoKazsdQuzyoIeQ==
X-Received: by 2002:a05:6638:4117:b0:346:b5e1:383a with SMTP id ay23-20020a056638411700b00346b5e1383amr18663845jab.264.1662051793234;
        Thu, 01 Sep 2022 10:03:13 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o20-20020a02a1d4000000b0034c114c1de6sm1928725jah.74.2022.09.01.10.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:03:13 -0700 (PDT)
Message-ID: <e74b326d-ce4a-31c3-5424-e35858cdb569@github.com>
Date:   Thu, 1 Sep 2022 13:03:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 12:57 AM, Shaoxuan Yuan wrote: 
> Test                                                                          HEAD~   HEAD
> ---------------------------------------------------------------------------------------------------
> 2000.78: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v3)     0.11    0.09 (≈)
> 2000.79: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (full-v4)     0.08    0.09 (≈)
> 2000.80: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v3)   0.44    0.04 (-90.9%)
> 2000.81: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* (sparse-v4)   0.46    0.04 (-91.3%)
> 
> - Command used for testing:
> 
> 	git grep --cached --sparse bogus -- f2/f1/f1/builtin/*

It's good to list this command after the table. It allows you to shrink
the table by using "...":

Test                                HEAD~   HEAD
---------------------------------------------------------
2000.78: git grep ... (full-v3)     0.11    0.09 (≈)
2000.79: git grep ... (full-v4)     0.08    0.09 (≈)
2000.80: git grep ... (sparse-v3)   0.44    0.04 (-90.9%)
2000.81: git grep ... (sparse-v4)   0.46    0.04 (-91.3%)

This saves horizontal space without losing clarity. The test numbers help,
too.

>  		strbuf_setlen(&name, name_base_len);
>  		strbuf_addstr(&name, ce->name);
> +		if (S_ISSPARSEDIR(ce->ce_mode)) {
> +			enum object_type type;
> +			struct tree_desc tree;
> +			void *data;
> +			unsigned long size;
> +			struct strbuf base = STRBUF_INIT;
> +
> +			strbuf_addstr(&base, ce->name);
> +
> +			data = read_object_file(&ce->oid, &type, &size);
> +			init_tree_desc(&tree, data, size);
>  
> -		if (S_ISREG(ce->ce_mode) &&
> +			/*
> +			 * sneak in the ce_mode using check_attr parameter
> +			 */
> +			hit |= grep_tree(opt, pathspec, &tree, &base,
> +					 base.len, ce->ce_mode);
> +			strbuf_release(&base);
> +			free(data);
> +		} else if (S_ISREG(ce->ce_mode) &&

I think this is a good setup for transitioning from the index scan
to the tree-walking grep_tree() method. Below, I recommend calling
the method slightly differently, though.

>  		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
>  				   S_ISDIR(ce->ce_mode) ||
>  				   S_ISGITLINK(ce->ce_mode))) {
> @@ -598,7 +613,14 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  		int te_len = tree_entry_len(&entry);
>  
>  		if (match != all_entries_interesting) {
> -			strbuf_addstr(&name, base->buf + tn_len);
> +			if (S_ISSPARSEDIR(check_attr)) {
> +				// object is a sparse directory entry
> +				strbuf_addbuf(&name, base);
> +			} else {
> +				// object is a commit or a root tree
> +				strbuf_addstr(&name, base->buf + tn_len);
> +			}
> +

I think this is abusing the check_attr too much, since this will also
trigger a different if branch further down the method.

These lines are the same if tn_len is zero, so will it suffice to pass
0 for that length? You are passing base.len when you call it, so maybe
that should be zero?

When I apply this change, all tests pass, so if there _is_ something
different between the two implementations, then it isn't covered by
tests:

diff --git a/builtin/grep.c b/builtin/grep.c
index 8c0edccd8e..fc4adf876a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -549,8 +549,7 @@ static int grep_cache(struct grep_opt *opt,
 			/*
 			 * sneak in the ce_mode using check_attr parameter
 			 */
-			hit |= grep_tree(opt, pathspec, &tree, &base,
-					 base.len, ce->ce_mode);
+			hit |= grep_tree(opt, pathspec, &tree, &base, 0, 0);
 			strbuf_release(&base);
 			free(data);
 		} else if (S_ISREG(ce->ce_mode) &&
@@ -613,13 +612,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		int te_len = tree_entry_len(&entry);
 
 		if (match != all_entries_interesting) {
-			if (S_ISSPARSEDIR(check_attr)) {
-				// object is a sparse directory entry
-				strbuf_addbuf(&name, base);
-			} else {
-				// object is a commit or a root tree
-				strbuf_addstr(&name, base->buf + tn_len);
-			}
+			strbuf_addstr(&name, base->buf + tn_len);
 
 			match = tree_entry_interesting(repo->index,
 						       &entry, &name,

> +test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/builtin/*"

We can't use this path in general, because we don't always run the test
using the Git repository as the test repo (see GIT_PERF_[LARGE_]REPO
variables in t/perf/README).

We _can_ however use the structure that we have implied in our construction,
which is to use a path that we know exists and is still outside of the
sparse-checkout cone. Truncating to "f2/f1/f1/*" is sufficient for this.

Modifying the test and running them on my machine, I get:

Test                               HEAD~1            HEAD
----------------------------------------------------------------------------
2000.78: git grep ... (full-v3)    0.19(0.72+0.18)   0.18(0.84+0.13) -5.3%  
2000.79: git grep ... (full-v4)    0.17(0.83+0.16)   0.19(0.84+0.14) +11.8% 
2000.80: git grep ... (sparse-v3)  0.35(1.02+0.13)   0.15(0.85+0.15) -57.1% 
2000.81: git grep ... (sparse-v4)  0.37(1.06+0.12)   0.15(0.89+0.15) -59.5%

So, it's still expensive to do the blob search over a wider pathspec than
the test as you designed it, but this will work for other repo, such as the
Linux kernel:

Test                                HEAD~1             HEAD
------------------------------------------------------------------------------
2000.78: git grep ... (full-v3)     3.16(19.37+2.55)   2.56(15.24+1.76) -19.0%
2000.79: git grep ... (full-v4)     2.97(17.84+2.00)   2.59(15.51+1.89) -12.8%
2000.80: git grep ... (sparse-v3)   8.39(24.74+2.34)   2.13(16.03+1.72) -74.6%
2000.81: git grep ... (sparse-v4)   8.39(24.73+2.40)   2.16(16.14+1.90) -74.3%

Thanks,
-Stolee
