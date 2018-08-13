Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A081F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbeHMT7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:59:06 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45808 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeHMT7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:59:06 -0400
Received: by mail-qt0-f196.google.com with SMTP id y5-v6so18150030qti.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4r76pf/i78/UjkP+XBHXKLTskZjOPEczDfWOIrpx/kY=;
        b=OzeIS8Yww7ozTfC+wkzNjmWqIgfpaoE6Lcdnsnp2yBod9Dp6eMtybEEY181b2KxW/Z
         v6KL2eAD7icRDASSjLhspQOUVzVqRbbf8tT5wFld9ulcVXLN2tkEMYwaunjHzSgM/yMY
         fPskz1hce5nXWdW441DmWPK/H2t98uCkAeQYwElDfo7APCL63exY9TzUswXDAuxwzKA/
         nWwbnmN9IQJK53y9BujbgjmBSmZqJwnWZXK4Z4YJHHtiHNCZVHpAu9JG/r/Gp8psBO9B
         ZEdkys18FxZDaYCR4OVjYDQDuPDv50PPPswL1WhKt/qJqHZWNw6d5qVyGRufMFXfhZ3w
         wUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4r76pf/i78/UjkP+XBHXKLTskZjOPEczDfWOIrpx/kY=;
        b=YREMBS/OjrdWK/LeVrgbH9oXYeBT7IwO96+waNu3x61Jar/Or3SUHYNRzo3mSweGav
         nDZLsJVufEp10wBEz80hhJDox31wTQdeAQulZI46uqkvlEiaP470NADeRtLIVHp2a+9s
         rrg8JS8hxnYdVPNqrOrHkedHhXJuHHsDnR3lCYW3xG4A5Ah+iexdIcnXw0eLChg0Qajv
         TS2WmSM4VTVa8n3zIr45H+At367wzkQSkcLCk0Etvx6RNpv1jYfJl+0uKCxBs4jY0jm5
         cOHxi5Vc9czKPvLMZm316AELa2B/kwfIDzv2TO/f0C6NqXL93LbFtMvP4SnHif1R2VWb
         N9fA==
X-Gm-Message-State: AOUpUlGPISgqkLzy8tqNVs7zJMY83m5g0RvDFPvpuadHhbZrssGI+9Rj
        AuOjpE2vWCc3CJ+BQLmjfLk=
X-Google-Smtp-Source: AA+uWPz1rkNWCt4ldROT8cHKzmUnapPxY8vGvGUCY0t7G8IbKXS/c4nzF7ehlM5FVY00p865W3FXyw==
X-Received: by 2002:aed:3fd5:: with SMTP id w21-v6mr17241360qth.226.1534180559269;
        Mon, 13 Aug 2018 10:15:59 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 16-v6sm12010509qkd.93.2018.08.13.10.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 10:15:58 -0700 (PDT)
Subject: Re: [PATCH v4 5/5] unpack-trees: reuse (still valid) cache-tree from
 src_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-6-pclouds@gmail.com>
 <CABPp-BEDQfzyZjD0CuZKhvj3iUi0H6Ar0Fgm2UhehjP1pnWKgA@mail.gmail.com>
 <a8543f33-eb1a-4122-87a4-f8d888af7381@gmail.com>
 <CACsJy8A2L-WX_RLP37fF-f=YBLkCY7+iZLo+Uz=H9EFOWMVnoA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d3faf3e0-5526-8613-9c7e-796f627eaef3@gmail.com>
Date:   Mon, 13 Aug 2018 13:15:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8A2L-WX_RLP37fF-f=YBLkCY7+iZLo+Uz=H9EFOWMVnoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/13/2018 12:25 PM, Duy Nguyen wrote:
> On Mon, Aug 13, 2018 at 6:05 PM Ben Peart <peartben@gmail.com> wrote:
>> I was part way through writing a patch that would copy the valid parts
>> of the cache-tree from the source index to the dest index
> 
> Yeah sorry about that. I make bad judgements all the time, unfortunately.
> 
> If it's sort of working though, please post to the list anyway to
> archive it. Who knows, some time down the road we might actually need
> it again.
> 
>> I run some tests on a large repo and the results look very promising.
>>
>> base    new     diff    % saved
>> 0.55    0.52    0.02    4.32%   s:  read cache .git/index
>> 0.31    0.30    0.01    2.98%   s:  initialize name hash
>> 0.03    0.02    0.00    9.98%   s:  preload index
>> 0.09    0.09    0.00    4.86%   s:  refresh index
>> 5.93    1.19    4.74    79.95%  s:   traverse_trees
>> 0.12    0.13    -0.01   -4.15%  s:   check_updates
>> 2.14    0.00    2.14    100.00% s:   cache_tree_update
>> 10.63   4.29    6.33    59.59%  s:  unpack_trees
> 
> There's a big gap here, I think. unpack_trees() takes 4s but the sum
> of traverse_trees, check_updates and cache_tree_update is 1.5s top. I
> guess that's sparse checkout and stuff? It's either that or there's
> another big hidden thing we should pay attention to ;-)
> 

Yes, there are additional costs associated with the sparse-checkout and 
excludes logic.  We've sped that up significantly by converting it to a 
hashmap but it still has measurable cost as we have to compute the hash 
of the cache entry name before looking it up.

Name                                            Inc %	     Inc
+ git!unpack_trees                      	 50.9	   4,575
|+ git!clear_ce_flags_1                 	 16.5	   1,479
||+ git!is_included_in_virtualfilesystem	 15.9	   1,430
|| + git!check_includes_hashmap         	 15.8	   1,418
|+ git!traverse_trees                   	 16.3	   1,468
|+ git!cache_tree_fully_valid           	 11.7	   1,055
|+ git!check_updates                    	  1.9	     169
|+ git!discard_index                    	  1.8	     162
|+ git!apply_sparse_checkout            	  0.2	      15
|+ git!next_cache_entry                 	  0.0	       3

