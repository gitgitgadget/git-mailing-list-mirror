Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA45C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4323322A83
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 13:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgLDNpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLDNpw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 08:45:52 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91BBC061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 05:45:11 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id t18so5203388otk.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 05:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ncuWeD5g0IFZ5FQBLPY82DpJV11dvIsIHlYbTP7moE=;
        b=W6ObchYoHhmTWR6q5BEoLZFgszFQtK8xCRcOQn9TDtTkbFjke/ugWOTU4laOAQJ9LV
         ITmCcfAUPgP8KWa0u/xHxyNQIXLPCjDnvph/0mPk8rqEEvTxOeAtjrppwa196f7sOm/g
         1rAl82hrRu98AoXPtqkzzkS21f/+oUnMtN9Go78a9vXfjkJsB+YxT+G+IF79bIRQ5fC1
         om0rNtNrCGnWzSVg5663bgQv3ow6hT8eK5355V2iXrpiE7kOPSqaDkoTD6d3cokqm6S3
         vtHkIKIqJ/CR8ZrCfpnVGT27FvBVTRcAZszxKhkXdUxOnj+Fjm8yF4SvW5TTm03ps/zj
         FlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ncuWeD5g0IFZ5FQBLPY82DpJV11dvIsIHlYbTP7moE=;
        b=XSiOhEuzrGP41nJpWFMTuZ5vE+0TVy3rHOpWKyp56WoW2kl8klKyeygma6+YXw8inj
         NpgmVnT4mCMmu/nu8/6pIzezmqScRZfZldcS/AcWCXviRc/x4ohpqbxKNtB66ZdeR/UN
         Mp4tfLmJuv2IVCl5bAZVRaw/anfR+VdNTlrlaYxJhlCn4nasPsSX+Z0/QEkxWnctCfGy
         T8pMKFPFLCKDiegqVTEB335cyNncJGzUV6R8ceZxL4fbAfjYPbofmpoNtS3uzyxq3/u2
         SVZaqTQMeSVl0D/RXg92dVvdO+ePBtxyAnYB0JXdpCj3/E2oM92auXgC1VxCNwrIqsjS
         oMXQ==
X-Gm-Message-State: AOAM530toh1pzG/q89pUXYqTC/Hq2A68SVbepjFxiMBZwPcOc4VuzM9Z
        Yycb0bSnU0idPqgyEjLDGaY=
X-Google-Smtp-Source: ABdhPJymtogmZEAMxED4mGzzFLqbqB5FC0SBYsZt56ElUgHDdRrKThexYTsubz/iaeDwny7xt5Trww==
X-Received: by 2002:a05:6830:1e0b:: with SMTP id s11mr3726690otr.352.1607089511234;
        Fri, 04 Dec 2020 05:45:11 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id z19sm614835otm.58.2020.12.04.05.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 05:45:10 -0800 (PST)
Subject: Re: [PATCH 13/15] chunk-format: create chunk reading API
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <6801e231f7414444a272f2ea87dcc6f60f29e25a.1607012215.git.gitgitgadget@gmail.com>
 <xmqq1rg6h5o6.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1df7dec3-37d1-9ebf-b9c5-66d5bd4cbaa1@gmail.com>
Date:   Fri, 4 Dec 2020 08:45:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rg6h5o6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 5:43 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>> ...
>> -		case GRAPH_CHUNKID_DATA:
>> -			if (graph->chunk_commit_data)
>> -				chunk_repeated = 1;
>> -			else
>> -				graph->chunk_commit_data = data + chunk_offset;
>> -			break;
>> +	/* limit the chunk-format list if we are ignoring Bloom filters */
>> +	if (!r->settings.commit_graph_read_changed_paths)
>> +		chunks_nr = 5;
> 
> I presume that this magic number 5 is directly connected to ...
> 
>> +static struct read_chunk_info read_chunks[] = {
>> +	[0] = {
>> +		GRAPH_CHUNKID_OIDFANOUT,
>> +		graph_read_oid_fanout
>> +	},
>> +	[1] = {
>> +		GRAPH_CHUNKID_OIDLOOKUP,
>> +		graph_read_oid_lookup
>> +	},
>> +	[2] = {
>> +		GRAPH_CHUNKID_DATA,
>> +		graph_read_data
>> +	},
>> +	[3] = {
>> +		GRAPH_CHUNKID_EXTRAEDGES,
>> +		graph_read_extra_edges
>> +	},
>> +	[4] = {
>> +		GRAPH_CHUNKID_BASE,
>> +		graph_read_base_graphs
>> +	},
>> +	[5] = {
>> +		GRAPH_CHUNKID_BLOOMINDEXES,
>> +		graph_read_bloom_indices
>> +	},
>> +	[6] = {
>> +		GRAPH_CHUNKID_BLOOMDATA,
>> +		graph_read_bloom_data
>> +	}
>> +};
> 
> ... the index of these entries in the table.
> 
> I find this arrangement brittle.  For one thing, it means that new
> chunks cannot be added at an arbitrary place, and BLOOMDATA must be
> at the end for the "limit the list when ignoring" logic to work
> correctly (even when the developer who is adding a new chunk type
> realizes that new one must be inserted before [5], and the magic
> number 5 above must be updated), and it won't work at all if a
> similar "we can optionally ignore reading the data" treatment needs
> to be made for new chunk types, since two or more things cannot be
> at the end of the list at the same time X-<.
> 
> Would it be a cleaner way to implement this "when member X in the
> settings structure is not set, ignore BLOOMINDEXES and BLOOMDATA"
> feature to let these graph_read_*() functions have access to the
> settings structure, so that bloom_indices and bloom_data callback
> functions can make decisions for themselves?
> 
> Once we do that, as far as I can tell, there is no longer any reason
> to initialize read_chunks[] array with designated initializer.  The
> implementation of read_table_of_contents() does not tolerate if this
> array is sparsely populated anyway, and except for the "do we ignore
> bloom?" hack, nothing really depends on the order of entries in the
> array, right?

This is a good point, and it's my fault for not noticing this behavior.
In an earlier version, I was initializing read_chunks dynamically
inside parse_commit_graph(), where the change made more sense (the
Bloom chunks were not initialized at all based on this condition). I
think the better way to handle this is to check the config within
the reading functions graph_read_bloom_(indices|data).

The added benefit of checking in the read_chunk_fn is that the
chunk-format API can see that these chunks are "known" chunk types,
in case we were to add logging for "I don't understand this chunk
type".

Thanks,
-Stolee
