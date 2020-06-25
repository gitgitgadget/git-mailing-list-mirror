Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391E8C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16175207D8
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9MZRIzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405542AbgFYPCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405405AbgFYPCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 11:02:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB580C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 08:02:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so3064972qke.9
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J71RmCI/n1AwBVL1F/uVZN6AVaEp58NcOP8xBWOFX+w=;
        b=f9MZRIzSSUCsjiKbBdOXLZ8ozupTX38YfHZjQlKfQKwn7pymlEWFD/cxnikosf27lj
         LtNYuKXNzplkraTRXqs27D/NjJQFQcBAnKXMo4LCsHdhY0FLOz5ocjRvx7yM/FHm5JDI
         J/Ne9dpA2VORtu0VtbtlJqwi19wEDDZyzMst/VMffmIbNiutEMx2AKpqlK12iaPLLC6y
         MkQO8xYJ1FyT/Lpvcoyr6UqC1YU4whATG01OcUsZ33VG1HtomiU6NuOx+AkFM8LrJGDd
         sEivO8hjih1IoXhQ7nBH34DQWOhQn0zmQ+eHXTEJzvW4Zp36ivJ8SRguc2zq2Cy9ZKWZ
         QsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J71RmCI/n1AwBVL1F/uVZN6AVaEp58NcOP8xBWOFX+w=;
        b=KYLz7q8ckoJc/s0D0zJe9Crk6SwDLMaQ35EcCNq4+VWZbN6aZwFcgbtlZ0ecRcVCY3
         bWwedKj8zCmc82C4Xe5qEowrGMG2vdwCBMiQk/9qikPY7DeT2BzKFhVpPjDnhoyf4P4C
         tXTGEreLpZxauTIs0xaoJpq/lNkqVaHnewmG9dH0PEJesbnWF8d2eviL7eL8raaTZ85W
         vr/Ec7CZNF3tThIrhrnX/+HrolOXHH1JrOP+5j22cNeSZzP7jHeOwpo5kNYV3cBzvQI+
         reolq+pk1TW5NKFkDjjJm93ma7t0Hham7hc02GNMig3DqpPfS6XGh8XANZMJmifn7wX4
         P3Lg==
X-Gm-Message-State: AOAM531/Ux/+t/bXi1thBwLqMon5+dtyrX/IX5SGE7A+rJRoYxdqVixl
        80pZ7v+/p54Y5MSaqR0V26c=
X-Google-Smtp-Source: ABdhPJwXEujaxeiHnZw4XbFdmnmFCjPTmHdOcoaUudmUIMbdMROIyW5d710vjgQOAvS+ivgyDTZJLw==
X-Received: by 2002:a05:620a:13fb:: with SMTP id h27mr26673089qkl.466.1593097369976;
        Thu, 25 Jun 2020 08:02:49 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i10sm7380353qkn.126.2020.06.25.08.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:02:49 -0700 (PDT)
Subject: Re: [PATCH v2 07/11] commit-graph: check chunk sizes after writing
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <3eb10933dc8517ab01eff17a179e484068d29724.1592934430.git.gitgitgadget@gmail.com>
 <de5453ed-6db9-ebd5-28f9-8db4f9ed8447@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5cb45264-1788-a563-a0e1-40ec7e64644a@gmail.com>
Date:   Thu, 25 Jun 2020 11:02:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <de5453ed-6db9-ebd5-28f9-8db4f9ed8447@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2020 3:25 AM, René Scharfe wrote:
> Am 23.06.20 um 19:47 schrieb SZEDER Gábor via GitGitGadget:
>> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
>>
>> In my experience while experimenting with new commit-graph chunks,
>> early versions of the corresponding new write_commit_graph_my_chunk()
>> functions are, sadly but not surprisingly, often buggy, and write more
>> or less data than they are supposed to, especially if the chunk size
>> is not directly proportional to the number of commits.  This then
>> causes all kinds of issues when reading such a bogus commit-graph
>> file, raising the question of whether the writing or the reading part
>> happens to be buggy this time.
>>
>> Let's catch such issues early, already when writing the commit-graph
>> file, and check that each write_graph_chunk_*() function wrote the
>> amount of data that it was expected to, and what has been encoded in
>> the Chunk Lookup table.  Now that all commit-graph chunks are written
>> in a loop we can do this check in a single place for all chunks, and
>> any chunks added in the future will get checked as well.
>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  commit-graph.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 086fc2d070..1de6800d74 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -1683,12 +1683,21 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>>  			num_chunks * ctx->commits.nr);
>>  	}
>>
>> +	chunk_offset = f->total + f->offset;
>>  	for (i = 0; i < num_chunks; i++) {
>> +		uint64_t end_offset;
>> +
> 
> Hmm, the added code looks complicated because it keeps state outside the
> loop, but it could be replace by this:
> 
> 		uint64_t start_offset = f->total + f->offset;
> 
>>  		if (chunks[i].write_fn(f, ctx)) {
>>  			error(_("failed writing chunk with id %"PRIx32""),
>>  			      chunks[i].id);
>>  			return -1;
>>  		}
>> +
>> +		end_offset = f->total + f->offset;
>> +		if (end_offset - chunk_offset != chunks[i].size)
>> +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
>> +			    chunks[i].size, chunks[i].id, end_offset - chunk_offset);
>> +		chunk_offset = end_offset;
> 
> ... and that:
> 
> 		if (f->total + f->offset != start_offset + chunks[i].size)
> 			BUG(...);

Thanks! I agree this approach is simpler and less prone to
bugs since we are using the local state.

-Stolee
