Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0582C433E9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A44207B7
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhA0NwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhA0Nvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 08:51:40 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EBC061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:50:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d15so1349654qtw.12
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F7rlv61SDFKSTcr4o3TCzyMlxpoQvTBkJXGWWKNFLqM=;
        b=UDq1OvLzoaAX7/cUIBkBkUfhGxpEnxp2zbCcmsS8wJpabxg/Y2xrETCaBU0fWPyswq
         jOA3I4acwIr/1gOpdkV//bCkc+0Fg6lp8tJ5SoMon4L47cocrHlKInAg7GAFRdXeiwG9
         kosEqvovI3jTdD1IGLYvptqL+4X8Jozls5H+CJN7gHLaG5/ggATay0bk4l6IjARM5iMP
         IJZHW30GX9Qzv2c6xyv5BZ9m/h5zXTaxew7JuG0P06jzk3x/QVBFCXq64nuELWxsrYwn
         wLXTVcoQKuYbOHXQEs1DM2TXmsa0HYicZluCkfY6C/x9LHBX3EQSRqXQ0X5lSGiazpA5
         WfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7rlv61SDFKSTcr4o3TCzyMlxpoQvTBkJXGWWKNFLqM=;
        b=NQ9Jj0Fh4mkbC+c3L0d0A8ui8VuzoeWMbUMcb3COZ6hJrOP0niI1JwdgxfzLsU8fGw
         whvtcZZAQt7kKfKD6z27hDVwi8l4QiVQDG6Y5YXNXejTijmFJClyAggG9owRYlpzGkyp
         nc4mgeWF2Ir22OBL4k8zlYIavVvgfQzdkHUEkrH8GgJMS5Abyqiub4TeuX2Mc/G6ij60
         8QZy+2jE5ajLWidzoifJ8K9ThWegQtT4Z7qKEg5ZLAxIKTmZxtTLagGdV+vTzSDGSo2X
         wkOR8uCEJEu1NmnzaD7l+UVU3pLF53hRWBStDA5WxGG/ktrgi46npFG9W2zN7+dhum3r
         AOiw==
X-Gm-Message-State: AOAM531Wb2LJ9u1tyuZnWKJPsxqfX31QYdXTPYKWXNyAgtghZ/dWZ6VM
        wqDoGZgAchJ2w8I50IBDdDg=
X-Google-Smtp-Source: ABdhPJyCgLxXCgh2eq4Oxrg0mXj0EF1sNtW6NGOwv4lQVXCSJOO4/rI+Rg/W111g8lgigKxMICxJUg==
X-Received: by 2002:ac8:5bd1:: with SMTP id b17mr9469596qtb.53.1611755456068;
        Wed, 27 Jan 2021 05:50:56 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa? ([2600:1700:e72:80a0:2d7b:5e80:11e5:d0fa])
        by smtp.gmail.com with UTF8SMTPSA id h22sm1218454qth.55.2021.01.27.05.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 05:50:55 -0800 (PST)
Subject: Re: [PATCH 14/17] midx: use chunk-format read API
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <cb145e0e32afed99b9bfa822c76f48bee18885ba.1611676886.git.gitgitgadget@gmail.com>
 <YBDY0Me2QMcUMD2e@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0fd9f692-ff8c-f4b9-33ac-975da93e9591@gmail.com>
Date:   Wed, 27 Jan 2021 08:50:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YBDY0Me2QMcUMD2e@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2021 10:06 PM, Taylor Blau wrote:
> On Tue, Jan 26, 2021 at 04:01:23PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Instead of parsing the table of contents directly, use the chunk-format
>> API methods read_table_of_contents() and pair_chunk(). In particular, we
>> can use the return value of pair_chunk() to generate an error when a
>> required chunk is missing.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  midx.c                      | 103 ++++++++++++++++++++----------------
>>  t/t5319-multi-pack-index.sh |   6 +--
>>  2 files changed, 60 insertions(+), 49 deletions(-)
>>
>> diff --git a/midx.c b/midx.c
>> index 0bfd2d802b6..dd019c00795 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -54,6 +54,51 @@ static char *get_midx_filename(const char *object_dir)
>>  	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>>  }
>>
>> +static int midx_read_pack_names(const unsigned char *chunk_start,
>> +				size_t chunk_size, void *data)
>> +{
>> +	struct multi_pack_index *m = (struct multi_pack_index *)data;
>> +	m->chunk_pack_names = chunk_start;
>> +	return 0;
>> +}
> 
> There are a lot of these callbacks that just assign some 'void **' to
> point at chunk_start.
> 
> Maybe a good use of the "pair_chunk" name would be something like:
> 
>     int pair_chunk(struct chunkfile *cf, uint32_t id, const unsigned char **p);
> 
> which does the same as what you wrote here. So instead of what you
> wrote, you could instead:
> 
>     pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names);
> 
> This would be in addition to the richer callback-style function which
> allows the caller greater flexibility (e.g., for the Bloom filter
> related readers in the commit-graph code).

You're right that _most_ callers just want to assign a pointer,
so this mechanism would be better. I'll make a different function,
read_chunk() perhaps, that relies on a callback for advanced users.

Thanks,
-Stolee
