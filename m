Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506BC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5114610FF
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhHTPTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhHTPTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:19:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389EC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:18:20 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w22-20020a056830411600b0048bcf4c6bd9so14411202ott.8
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=icA4brZqtgLbdGw90B+TAGrxqXxsY94rnbHy2i531Ew=;
        b=OIMmcPyxcaDYVG5ta66TUbB/QQ/j7s+m5jFYs+OzNepMfNme8QuVn7MUKsaK0RW2gN
         UBHSXmO2UDAqgZZCA7dUdFMschvqr2q5izFJJ4IEJ/vmVpk/uW18BnlnPOiZ2xXabt/h
         sfgE0K+JLgmYnWgg0SkOBOVkYjn+b3it0t8xIYbomZ2ZdRXJPpBNfASowaa9fPn892Ng
         chxqQnCD/C52xkbQwzAKpbxDbYLh9NDTcd57WIQgBog3/BEWexjPTsG1KeF/o6iDoIAN
         aN4ivlQhvnIt1Krbk+zSx1SAsdidhCkCqi6vMIDNWVNElm8B9xHkV5xwxJO9s8B3Wcir
         opNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=icA4brZqtgLbdGw90B+TAGrxqXxsY94rnbHy2i531Ew=;
        b=iuNPBaVjlcz75CSB7wAyM4GrJ9XuNyTLS2k4zvp32AieODqzgPNywPHcqNEvL0xNk2
         TdX8eXyAfcpe/WfUelUjWjdElSE7ERlGOYtBaQY0B+PcoNiUREag53PJGx1u848q4zeM
         kjq4gviNp5wgE4iOIs/DuIB91P9E6pkl4gjX3PAdiVZBoGvxzHQmBjeiBNySr+5Bu0N1
         oZL6vnFLIvPo6hDVm9M7UqKEbAPxy8I7SUqKeFL9zmQmdWl5E8mdDI7EAPMCNoT+U7aU
         pMRpCTHa/91+tZ79RrdULIPGljwhI6x96JDJX9c0+8tmZMrnK0hcEycJMS1JmpRkcUq/
         i0dw==
X-Gm-Message-State: AOAM531v/Qk5Qf/cbkKFGDmtmSU9OTLRMjgi8N2Df5YSbxGjcpsBpEbU
        GFQRs2KgOdbfNs2QzBKUR8g=
X-Google-Smtp-Source: ABdhPJyvih8HrJqTAQERU/CDQ4EHyniCH2pxpmcQFITxi0P0NuX9ySPV132wQHudscY5Oj4XhL+XOA==
X-Received: by 2002:aca:320b:: with SMTP id y11mr3432451oiy.63.1629472700019;
        Fri, 20 Aug 2021 08:18:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id o133sm1458588oia.10.2021.08.20.08.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:18:19 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] unpack-trees: fix nested sparse-dir search
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <10bcadb284e49419f9b4baf75e05f719ec395d98.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108190950540.55@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7bd8e73-de86-c563-8b7d-405310ce6c57@gmail.com>
Date:   Fri, 20 Aug 2021 11:18:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2108190950540.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:01 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The iterated search in find_cache_entry() was recently modified to
>> include a loop that searches backwards for a sparse directory entry that
>> matches the given traverse_info and name_entry. However, the string
>> comparison failed to actually concatenate those two strings, so this
>> failed to find a sparse directory when it was not a top-level directory.
>>
>> This caused some errors in rare cases where a 'git checkout' spanned a
>> diff that modified files within the sparse directory entry, but we could
>> not correctly find the entry.
> 
> Good explanation.
> 
> I wonder a bit about the performance impact. How "hot" is this function?
> I.e. how often is it called, on average?
> 
> I ask because I see opportunities to optimize in both directions: it could
> be written more concisely (if speed does not matter as much), and it could
> be made faster (if speed matters a lot). See below for more.

I would definitely optimize for speed here. This can be a very hot path,
I believe.

>> +	strbuf_addstr(&full_path, info->traverse_path);
>> +	strbuf_add(&full_path, p->path, p->pathlen);
>> +	strbuf_addch(&full_path, '/');
> 
> This could be reduced to:
> 
> 	strbuf_addf(&full_path, "%s%.*s/",
> 		    info->traverse_path, (int)p->pathlen, p->path);

We should definitely avoid formatted strings here, if possible.

> But if speed matters, we probably need something more like this:
> 
> 	size_t full_path_len;
> 	const char *full_path;
> 	char *full_path_1 = NULL;
> 
> 	if (!*info->traverse_path) {
> 		full_path = p->path;
> 		full_path_len = p->pathlen;
> 	} else {
> 		size_t len = strlen(info->traverse_path);
> 
> 		full_path_len = len + p->pathlen + 1;
> 		full_path = full_path_1 = xmalloc(full_path_len + 1);
> 		memcpy(full_path_1, info->traverse_path, len);
> 		memcpy(full_path_1 + len, p->path, p->pathlen);
> 		full_path_1[full_path_len - 1] = '/';
> 		full_path_1[full_path_len] = '\0';
> 	}

The critical benefit here is that we do not need to allocate a
buffer if the traverse_path does not exist. That might be a
worthwhile investment. That leads to justifying the use of
bare 'char *'s instead of 'struct strbuf'.

If the traverse_path is usually non-null, then we could continue using
strbufs as a helper and get the planned performance gains by using
strbuf_grow(&full_path, full_path_len + 1) followed by strbuf_add()
(instead of strbuf_addstr()). That would make this code a bit less
ugly with the only real overhead being the extra insertions of '\0'
characters as we add the strings to the strbuf().

I will need to investigate so see which one is the best.

Thanks,
-Stolee
