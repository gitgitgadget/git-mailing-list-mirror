Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB0C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C9E20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4HqDyrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgFSMwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgFSMwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 08:52:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F0C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 05:52:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so5115551qkc.6
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WEfo8+Kdq+OkZPQJVIeSk48rF3cCuHttzntLhRSXa9g=;
        b=d4HqDyrKn4/SyCmWqUYfUAHikeuypMWAf374+fAGYYYIksH9SEUAGC1w3bwFVPe6B5
         vQbdf3U4M3pgbTV5c5wW4FbPqP59hSiNimzjdvJGnLGAQpl24vwn/KKR3nZRasW16LQi
         5Fc6XodqJCY+idxkeHj0M7WggzrruWQMXatAnanqq4iFNDrwg8dFQIDvaPbhOGMigiLF
         H9d97uy+7RaRzlBxBAUw7dzryRK2sfC9CDNNPDYkH8evnhyo4LxSvvLimhodexI5z7qj
         1WMjpY7NQNWzn2RHkfpc/v7aFshpQGhDgX8ZugjVdg89KJYgZ4ex3EKJ1zu8157sIxiu
         a/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEfo8+Kdq+OkZPQJVIeSk48rF3cCuHttzntLhRSXa9g=;
        b=roJVJHYGIrk35oTm3cd/+yfO0PftYwkWAKHHbB2wxQeL++MdXVNdf1m5wbZbPKBUUE
         DVylIX69etu+6U7PL35FJ3EKjft8bGHguXFmgiLdfe7QyNhtEZKFjuXnB4JrnzliZgId
         WWcgMWKJeZrQsKW6UNl8YD01j9CZNS1TZlH6bE89+FTSwK5Jw9byLbGaHJHBpbkfkTiF
         LMHnBw52+IbzcSpEEZ33z74CP7vV02uujjbRjgy3ztDlbHA1UFCoKiLpk+VqRQ3FIkLy
         16mp3kwU/d8WqUQsy4BZZsBt3ZYIJDhfizJnzhKxW1HR2Fc5t/ibpjGyyBJ2hdPBnzEF
         SudA==
X-Gm-Message-State: AOAM53360sNlnMDSRd5ljKBf8PpaFkl1Df7Jvy24lpEP4pMHjZh98e26
        bdSVwxuFRZgP2bqQfCFGBHM=
X-Google-Smtp-Source: ABdhPJxDOGUtRifK0zXfZSDnPJJl89HXJCX2q2NqEktL1/RPkQYDOC+RS+KmkFCirDKZc5zfzc0O+w==
X-Received: by 2002:a37:a44c:: with SMTP id n73mr3270693qke.247.1592571135873;
        Fri, 19 Jun 2020 05:52:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a81sm6555077qkb.24.2020.06.19.05.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 05:52:14 -0700 (PDT)
Subject: Re: [PATCH 04/10] commit-slab: add a function to deep free entries on
 the slab
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
 <32a6f11cc475f5292075093dcdc3b2a5c6d02ed0.1591362033.git.gitgitgadget@gmail.com>
 <1c982d57-a446-b655-af95-1e4aeabf30ef@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b275791b-0875-75e2-7fe4-4366b7399ee8@gmail.com>
Date:   Fri, 19 Jun 2020 08:52:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <1c982d57-a446-b655-af95-1e4aeabf30ef@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/18/2020 4:59 PM, René Scharfe wrote:
> Am 05.06.20 um 15:00 schrieb SZEDER Gábor via GitGitGadget:
>> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>>
>> clear_##slabname() frees only the memory allocated for a commit slab
>> itself, but entries in the commit slab might own additional memory
>> outside the slab that should be freed as well.  We already have (at
>> least) one such commit slab, and this patch series is about to add one
>> more.
>>
>> To free all additional memory owned by entries on the commit slab the
>> user of such a slab could iterate over all commits it knows about,
>> peek whether there is a valid entry associated with each commit, and
>> free the additional memory, if any.  Or it could rely on intimate
>> knowledge about the internals of the commit slab implementation, and
>> could itself iterate directly through all entries in the slab, and
>> free the additional memory.  Or it could just leak the additional
>> memory...
>>
>> Introduce deep_clear_##slabname() to allow releasing memory owned by
>> commit slab entries by invoking the 'void free_fn(elemtype *ptr)'
>> function specified as parameter for each entry in the slab.
> 
> Adding a new function instead of extending the existing ones makes
> sense, as this is a rare requirement.
> 
>>
>> Use it in get_shallow_commits() in 'shallow.c' to replace an
>> open-coded iteration over a commit slab's entries.
>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  commit-slab-decl.h |  1 +
>>  commit-slab-impl.h | 13 +++++++++++++
>>  commit-slab.h      | 10 ++++++++++
>>  shallow.c          | 14 +++++---------
>>  4 files changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/commit-slab-decl.h b/commit-slab-decl.h
>> index adc7b46c83b..286164b7e27 100644
>> --- a/commit-slab-decl.h
>> +++ b/commit-slab-decl.h
>> @@ -32,6 +32,7 @@ struct slabname {							\
>>  void init_ ##slabname## _with_stride(struct slabname *s, unsigned stride); \
>>  void init_ ##slabname(struct slabname *s);				\
>>  void clear_ ##slabname(struct slabname *s);				\
>> +void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtype *ptr)); \
>>  elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
>>  elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
>>  elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
>> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
>> index 5c0eb91a5d1..557738df271 100644
>> --- a/commit-slab-impl.h
>> +++ b/commit-slab-impl.h
>> @@ -38,6 +38,19 @@ scope void clear_ ##slabname(struct slabname *s)			\
>>  	FREE_AND_NULL(s->slab);						\
>>  }									\
>>  									\
>> +scope void deep_clear_ ##slabname(struct slabname *s, void (*free_fn)(elemtype *)) \
>> +{									\
>> +	unsigned int i;							\
>> +	for (i = 0; i < s->slab_count; i++) {				\
>> +		unsigned int j;						\
>> +		if (!s->slab[i])					\
>> +			continue;					\
>> +		for (j = 0; j < s->slab_size; j++)			\
>> +			free_fn(&s->slab[i][j * s->stride]);		\
>> +	}								\
>> +	clear_ ##slabname(s);						> +}									\
> 
> 
> Why pass an elemtype pointer to the callback function instead of
> a plain elemtype?  Because it matches the return type of _at() and
> _peek().  Consistency, good.  Handing it a pointer allows the
> callback to pass it on to free(), though, which would be bad,
> since we do that in clear_() as well.  Hmm.
> 
>> +									\
>>  scope elemtype *slabname## _at_peek(struct slabname *s,			\
>>  						  const struct commit *c, \
>>  						  int add_if_missing)   \
>> diff --git a/commit-slab.h b/commit-slab.h
>> index 05b3f2804e7..8e72a305365 100644
>> --- a/commit-slab.h
>> +++ b/commit-slab.h
>> @@ -47,6 +47,16 @@
>>   *
>>   *   Call this function before the slab falls out of scope to avoid
>>   *   leaking memory.
>> + *
>> + * - void deep_clear_indegree(struct indegree *, void (*free_fn)(int*))
>> + *
>> + *   Empties the slab, similar to clear_indegree(), but in addition it
>> + *   calls the given 'free_fn' for each slab entry to release any
>> + *   additional memory that might be owned by the entry (but not the
>> + *   entry itself!).
>> + *   Note that 'free_fn' might be called even for entries for which no
>> + *   indegree_at() call has been made; in this case 'free_fn' is invoked
>> + *   with a pointer to a zero-initialized location.
>>   */
>>
>>  #define define_commit_slab(slabname, elemtype) \
>> diff --git a/shallow.c b/shallow.c
>> index 7fd04afed19..c4ac8a73273 100644
>> --- a/shallow.c
>> +++ b/shallow.c
>> @@ -84,6 +84,10 @@ int is_repository_shallow(struct repository *r)
>>   * supports a "valid" flag.
>>   */
>>  define_commit_slab(commit_depth, int *);
>> +static void free_depth_in_slab(int **ptr)
>> +{
>> +	FREE_AND_NULL(*ptr);
>> +}
> 
> Why FREE_AND_NULL?  The original loop below called free().  The slabs
> are all released by deep_clear_() immediately after the callbacks are
> done anyway, so what's the point in zeroing these pointers?

I think the point was that a later change was going to free
elements in the slab on a one-by-one basis while computing
the filters, to save memory overall. To be future-proof
against such a change, we need to NULL the pointers here.

Perhaps that viewpoint also answers your other comment about
"why pass the pointer?"

Thanks,
-Stolee

