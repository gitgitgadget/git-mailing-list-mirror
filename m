Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC11C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FF123340
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbhAGLvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbhAGLvq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 06:51:46 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1DC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 03:51:06 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id j8so1508813oon.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 03:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=evSwfNI/Y7w7Qjg85+xVWQ3kgUWiRUm8u8qXYwaEoiE=;
        b=KIA9f84GhcIITyw/kXh4FdazfHJp3X0M/pYX0b1h66F+QCuns0tfbFNkxsANEz/tby
         CwagZSlbA6IwVe6GL6nbn6c5ztd0jmYdWcMsOTsOj510C7vF4xsZr6pbdO3kvIdS+UrK
         L2CIS5qFtwW/luLuP1zMVlXlksqCXZ3jxLZO4rA3hOYUUjrgwC8eZ+3+5vZ9AvUoZAeJ
         vuGuJxur12M+JAIjygMHBLjdWYFGjhhMGDuZSzpMwNNB1ZbtQIB4vS1pOhoRME0OunQq
         61oEq68PcXOQYgFUoGw3llsO3dNrjodbO+u0QvNsZ+5H7tk85O021vykmXOzcYxubQp/
         N/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=evSwfNI/Y7w7Qjg85+xVWQ3kgUWiRUm8u8qXYwaEoiE=;
        b=m5u9jjTcfBMLbakePKOG/tyUKRcLqnKh1T0lN3XorGVyBpoDs02t77MfUR2fc/NT+T
         LlYtvaRdbW47jj4Xkg1fxRRnjIEw/FgwAl6aaCoOplB2fo/kOyKe2tR66ag6sLl1nehc
         SUqadA4PLm6Nc4iC0ATvEVQD1TjVdTWPYOZ1qCF8mLcU9JxZ5DRGMz1ObKC9NdOttaUE
         BpebySQme52ex+NJ2ZGw4yrmKbwisWd5ItM3BlaVW0KvRKr4iKD/eyS1S7ftpM72PCNx
         TUlZEy92PAbZry+D60BcgpzNNBN48f4oi2X7iemvSBPhlxDOYdpJ83ZrDjlHoTmfrW63
         ADeA==
X-Gm-Message-State: AOAM532ovkuwTutQooh56WTvIHWL/wACgM4z9SDHxllyjVeE/mm3GYmU
        E9zBsa8VKfbW8O5OtxNTakw=
X-Google-Smtp-Source: ABdhPJws1HWmq9OEpDT76bTKl8Apb+pak9iyceZYrJ+gXn5zQhLH0FhYBB5VivrVOBUWE4hoo/+Bww==
X-Received: by 2002:a4a:1d82:: with SMTP id 124mr824318oog.12.1610020265374;
        Thu, 07 Jan 2021 03:51:05 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id h7sm1091795otq.21.2021.01.07.03.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 03:51:04 -0800 (PST)
Subject: Re: [PATCH v2 6/9] index-format: update preamble to cached tree
 extension
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
 <75b51483d3c7088d0cfae36544966672374c50f9.1609729758.git.gitgitgadget@gmail.com>
 <xmqqble1o5sc.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5a1a51c1-7ada-6f66-a6d0-2fc01303d334@gmail.com>
Date:   Thu, 7 Jan 2021 06:51:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqble1o5sc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 9:10 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Subject: Re: [PATCH v2 6/9] index-format: update preamble to cached tree extension
> 
> By the way, the name of the extension is "cache tree".
> 
> 	git grep -i 'cached[- ]tree' ':!po/'
>         
> reveals there are a handful of mistakes already present but their
> number is dwarfed when we check:
> 
> 	git grep -i 'cache tree' ':!po/'

I will fix my own additions and add a patch that fixes these mistakes.

>> +  Since the index does not record entries for directories, the cache
>> +  entries cannot describe tree objects that already exist in the object
>> +  database for regions of the index that are unchanged from an existing
>> +  commit. The cached tree extension stores a recursive tree structure that
>> +  describes the trees that already exist and completely match sections of
>> +  the cache entries. This speeds up tree object generation from the index
>> +  for a new commit by only computing the trees that are "new" to that
>> +  commit.
> 
> The original motivation was the above one.  A cache of tree objects
> that correspond to unmodified part of the directory structure helps
> writing out a new tree out of modified index.
> 
> We later found out that we rather often compare the index against
> the tree of HEAD (think: "git status"), and diff-lib.c::diff_cache()
> does take advantage of the fact that an entire directory can be
> skipped if the tree object taken from the HEAD side exactly matches
> the tree recorded for the subdirectory in the cache tree extension.

I need to read more about this. traverse_by_cache_tree() seems to
be a good place to start. Thanks.

>> +  The recursive tree structure uses nodes that store a number of cache
>> +  entries, a list of subnodes, and an object ID (OID). The OID references
>> +  the exising tree for that node, if it is known to exist. The subnodes
>> +  correspond to subdirectories that themselves have cached tree nodes. The
>> +  number of cache entries corresponds to the number of cache entries in
>> +  the index that describe paths within that tree's directory.

s/exising/existing/

> 
> OK.
> 
>> +  Note that the path for a given tree is part of the parent node in-memory
> 
> Sorry, I am not sure if I follow.  The top-level in-core cache_tree
> object records the number of entries, tree object name for the
> entire tree (if valid), and cache_tree_sub structures, one for each
> subdirectory.  Each of the cache_tree_sub structure describes the
> "child" directory, including the path to it.
> 
>> +  but is part of the child in the file format. The root tree has an empty
>> +  string for its name and its name does not exist in-memory.
> 
> It's more like we could have consistently used cache_tree_sub
> instances to represent each and every level (i.e. I consider that
> cache_tree_sub is what represents a directory, with cache_tree being
> a record of just one aspect of it) including the root of the
> hierarchy, but because there wasn't much point in giving a name to
> the root level, I cheated and avoided wasting a cache_tree_sub for
> it.  So from that point of view, the path belongs to the node in
> each level in both in-core and on-disk representations.

That's a good point. I'll retract my statement here.

>> +  When a path is updated in index, Git invalidates all nodes of the
>> +  recurisive cached tree corresponding to the parent directories of that
>> +  path. We store these tree nodes as being "invalid" by using "-1" as the
>> +  number of cache entries.
> 
> Correct.

Making note of my s/recurisive/recursive/ typo here.

>> +  To create trees corresponding to the current
>> +  index, Git only walks the invalid tree nodes and uses the cached OIDs
>> +  for the valid trees to construct new trees.
> 
> I wonder if the above is sufficiently clear, or "Git only has to
> walk the spans of index entries that corresponds to the invalid
> trees, while reusing the ..." is too long and detailed.

I will try to simplify.

Thanks,
-Stolee
