Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B86202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdKUApN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:45:13 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33690 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdKUApM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:45:12 -0500
Received: by mail-qk0-f173.google.com with SMTP id 78so9866040qkz.0
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 16:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wREg42JJW0CC7TJTycLiT7VjqGpatORtLW0k+4vgPFs=;
        b=V+/qPAolZfLmBg0WwKNhidkVfUNl2l5Kfpv/CAmoQpMHQRLj01KZ31mNEg0Ml/FsYO
         0M1KTohF5Hf4BypQFTLOtx529uIcRKt2RdDyrmrJS7EcI6pbn1pLSFzGmZ9BkkWyCmuA
         FkEVmO0fmK9QVt9U60jOi/HuNYyfyEekRjuR/ZhdIciXxiScbubq+GOWxoZPcebfEjhG
         ILBBnE5VGuEEZ+Fn5f0HdNb7IwTFxkBuF0eaW7nzZNhwfUeEZsFOVURlLUZH/vq2MlYF
         cjTPApMD9iBV4o7issECmmZ400vcTf8DHurW/K/LGTeGUmNO1kRbHBNUqTBhUFBQGJkU
         MZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wREg42JJW0CC7TJTycLiT7VjqGpatORtLW0k+4vgPFs=;
        b=YM+kZKt48pKl92essrtSxXWhsZpm5m0IdqaVI5wQcJKibedGUY9YVUjZeFcVROM7WZ
         X/g4NzNDARSmK3m7t7EU063VKLFe7UsaoxlXoL3Z/sAiMXZ9/p8JlHKDMfjmNjfB3bR1
         oybnm45sQpYmQRkeiIcfYlVt0ijkrXyqihAgnebQu4Pk7TlRLnPOnV2yCVm3xu3AjoVM
         vCZfcwoi42GjYq5ToxYfdyOeURrpf/Ri1Q+lJlOoRHmZxgSJCalou+UezkUcY6QqEtdM
         xJvbH+qwiHGA/6LvJ2MdDNId1y2uNxkveCuU9qbWJom3uqMPsHX93LzOne9v/DGF5x3Y
         wBlQ==
X-Gm-Message-State: AJaThX6HIP8WFFfOxngsqqjeZVnBUwFsj+5IO2JexuWPkPXplC3VENCW
        4aWYMiZzBj7NzYKbtQOr6B4=
X-Google-Smtp-Source: AGs4zMZ9idJmwX4bBBeBXdP4mHmxsMivq1CNlwb/+47P/NXLmu2iquAi2CGA4yfkXGvWNunRHclb3A==
X-Received: by 10.55.160.69 with SMTP id j66mr22119087qke.94.1511225111241;
        Mon, 20 Nov 2017 16:45:11 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j40sm8080929qtj.52.2017.11.20.16.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 16:45:09 -0800 (PST)
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through
 parallelization
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
References: <20171109141737.47976-1-benpeart@microsoft.com>
 <20171109141737.47976-2-benpeart@microsoft.com>
 <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
 <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
 <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
 <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
 <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
 <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
 <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
 <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com>
 <xmqq1sl017dw.fsf@gitster.mtv.corp.google.com>
 <92b0b0ff-6878-003a-b26f-3b4c2c857be3@gmail.com>
 <63053f5d-0089-4165-0470-ed0d88a87e9e@ramsayjones.plus.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2a8d9ce6-0821-4dc0-92d8-fb736119bd6b@gmail.com>
Date:   Mon, 20 Nov 2017 19:45:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <63053f5d-0089-4165-0470-ed0d88a87e9e@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2017 6:51 PM, Ramsay Jones wrote:
> 
> 
> On 20/11/17 14:01, Ben Peart wrote:
>> Further testing has revealed that switching from the regular heap to a refactored version of the mem_pool in fast-import.c produces similar gains as parallelizing do_index_load().  This appears to be a much simpler patch for similar gains so we will be pursuing that path.
>>
>> Combining the two patches resulted in a further 25% reduction of do_index_load() but with index load times getting smaller, that only resulted in a 3% improvement in total git command time.  Given the greater complexity of this patch, we've decided to put it on hold for now.  We'll keep it in our back pocket in case we need it in the future.
> 
> Since you are withdrawing the 'bp/fastindex' branch, I won't send the
> patch to fix up the sparse warnings (unless you would like to see it
> before you put it in your back pocket). ;-)
> 
> ATB,
> Ramsay Jones
> 
> 

I'm happy to take your patches as I am keeping a copy just in case we 
need to revisit it.

I'm actually interested to see how Peff's suggestion to use tcmalloc 
helps because nearly 90% of the remaining execution time was spent 
waiting for a lock in malloc due to all contention from the multi-threading.
