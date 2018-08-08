Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15796208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 17:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeHHTVD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 15:21:03 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39086 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 15:21:03 -0400
Received: by mail-qk0-f196.google.com with SMTP id b5-v6so2001525qkg.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=up0LdkRrUAj1cEGywsOGgQlkuAEjzQaA6VSVpQN7jFo=;
        b=sIWE64LBVxxf8MqCRCzOEf47jTEfFfFfP/cVOl+S7svy7i+iGd6pNFpT8mnVyT2OF9
         qN0G7+Ttl9lt2GzOLrQOPz3tCbDEVdUqZAG3ZDdvhSNjccCwXL4pguViybR3MiYCXYZC
         qxcfcRoDQ54pPMUvoOYi7ZhOjo8LkxMubsZsVIV2xVPzOY3xf0DE6T2eTPhwMxcBp6gc
         5hHOe7mxgLPkFKEhzl/Ln02BYXRN7zVMZ2iBtrO8DJBvR+jxGh3TueauGTwPXm/8H1te
         nsh/RgcJ+8QqC07+9QxKnBc0JGxi7bVDgPz2DiW5KbIWfkntRlrC31zxZvGxPeBUBOAz
         n3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=up0LdkRrUAj1cEGywsOGgQlkuAEjzQaA6VSVpQN7jFo=;
        b=qP2VPDT4SxYAF9olmPHk82cueyVXSF56gpwVnEvkH9zfBCqqffpHWRmirGdoswfJfm
         BwCP96IwkdfG1mx36RrPNZtf1z6sG1G6my4I4vRTjvMvNEl5y/Ew+3HTIyk4doCbjzqZ
         UbpfnRdKOZReQ2pwgPYM1HIS2MlQipRqdSNyYp9x0nJJCcM02qSILiprtNIQWD9HEjPF
         53yJ1iPmb6Y6uPFuec9Jdv61M/L2k3n7002z/fSpq2QKbhV7TVkn472ktEPb8QljthzN
         j6sQ2Ym27xELVZWMxQ5FE2zjqT4+gTY2jeHqXJUnQJS+TnnWK5WwryRhGdp0HINmWrQc
         26hQ==
X-Gm-Message-State: AOUpUlFViHsuItFfpYIT0hx95pSZ5ozqpWOvkgHVjzVNBuL8hlDps4GB
        urv3z6GM6wq3cPuzqQaRLyw=
X-Google-Smtp-Source: AA+uWPw052e+MSsbdpvKjAi1ynlAkMBcWqaibzdg2rxtwt2NzS5eNif80fNe3ZJIb+spD1R/4v6Bbg==
X-Received: by 2002:a37:7a46:: with SMTP id v67-v6mr3137409qkc.188.1533747628334;
        Wed, 08 Aug 2018 10:00:28 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p5-v6sm2507583qkd.81.2018.08.08.10.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 10:00:27 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <20180729103306.16403-1-pclouds@gmail.com>
 <20180804053723.4695-1-pclouds@gmail.com>
 <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
 <xmqqr2jbnwy2.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a8be62e2-528b-72cc-56c7-55291af8dd66@gmail.com>
Date:   Wed, 8 Aug 2018 13:00:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2jbnwy2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/6/2018 2:59 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> We require the unpacked entry from all input trees to be a tree
>> objects (the dirmask thing), so if one tree has 't' as a file,
> 
> Ah, OK, this is still part of that "all the trees match cache tree
> so we walk the index instead" optimization.  I forgot about that.
> 

I ran this set of patches through the VFS For Git set of functional 
tests as well as our performance test suite (my earlier perf numbers 
were from manual testing).  All the functional tests pass and the 
performance tests are looking _very_ promising.

Checkout times are impacted most and on average drop from 20.96	seconds 
to 11.63 seconds for a 45% savings.

Merge times drop from 19.44 seconds to 12.88 for a 34% savings.

Rebase times drop from 26.78 seconds to 20.72 for a 23% savings.

Overall, I'm looking forward to a good review of the patches and seeing 
them get merged as soon as they are ready.

