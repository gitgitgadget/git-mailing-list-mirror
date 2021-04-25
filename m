Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B81AC433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51955601FF
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhDYNSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 09:18:24 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:52162 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhDYNSX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 09:18:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 855A440814;
        Sun, 25 Apr 2021 15:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1619356662; x=1621171063; bh=fQ/eoil8Vd3EMjfQKGN
        BJbR8VabpeHn3tvsA+GpURsY=; b=EDqPXMuEeeFW6f6V//rKRD+WipZTsn7Z3UR
        6C1J7MNU+bFqa/twzCXAZzNyPee+fWNfaXVwL6KoO79Z44kQ1d1Ejp+6FpJkcoz3
        +beEC3RoaO0Uk0IHmBEpK53SV5MCNnXxBmbIABytI2HwW34PrvpN0V8Ze7YdukDt
        GMC25ATFj8u4xW6t3MU4iD1xXg9ibc+pxeCrE8ddO/QbhIYEHJYWs+Ammh+zTF7s
        jm4R4WwIAuR9ih+ifKk4G/fet5bPID0EyRcFkfn5yT1rvEznU3negsr6DL6PAsVN
        Ub02Q7J126zOeaGNqzrfs3DvElnaGpqAW8uDC20vt7fzggKctIWUbjDIr8LLe5P7
        Gj40IIiqYPaq7WnCgkrnNmmSPfdi8/Gj2ZycRZP8t0m7O1R4/0vl4MVQ8+krxuGd
        oXxNC5h5z05evc2d6QaCUNovzy/kdD1uwUZ56McYWHcKQsV5jfSIve2YObD1BvB6
        AomaRtzMsqDQAm3pxTCFwNGULyyk7esamJM3eubv5ndZNEvIiDRqPZZQCzfEZ6J/
        oFiaCwSDTX7MSiqyELr1s33n64n6M5FINi55KfaNhogqUqn0cA2pCPUEIZOtCVNs
        06I60hw8yeWW/zeZfivLTXyDSE8TktcZs7NXzg4hs4OS8gf9PWbKKDFhl3/NbeMf
        m4cgGAk4=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fkh80N90fgNu; Sun, 25 Apr 2021 15:17:42 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 6F74D404C5;
        Sun, 25 Apr 2021 15:17:41 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 1998F25E9;
        Sun, 25 Apr 2021 15:17:39 +0200 (CEST)
Subject: Re: [PATCH 04/12] bloom: clear each bloom_key after use
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
 <9ae15b94881369fa1cbd09fc2de9cc94c30edb2d.1617994052.git.gitgitgadget@gmail.com>
 <20210411072651.GF2947267@szeder.dev>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <a641ca69-05c8-a2c0-59a8-93711eb3d349@ahunt.org>
Date:   Sun, 25 Apr 2021 15:17:38 +0200
MIME-Version: 1.0
In-Reply-To: <20210411072651.GF2947267@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/04/2021 09:26, SZEDER Gábor wrote:
> On Fri, Apr 09, 2021 at 06:47:23PM +0000, Andrzej Hunt via GitGitGadget wrote:
>> From: Andrzej Hunt <ajrhunt@google.com>
>>
>> fill_bloom_key() allocates memory into bloom_key, we need to clean that
>> up once the key is no longer needed.
>>
>> This fixes the following leak which was found while running t0002-t0099.
>> Although this leak is happening in code being called from a test-helper,
>> the same code is also used in various locations around git, and could
>> presumably happen during normal usage too.
> 
> It does indeed happen: 'git commit-graph write --reachable
> --changed-paths' generates Bloom filters for every commit, with each
> filter containing all paths modified by its associated commit, so it
> leaks a lot of 7 * 4byte hashes.  This patch reduces the memory usage
> of that command:
> 
>                           Max RSS
>                      before      after
>    ---------------------------------------------
>    android-base     1275028k   1006576k   -21.1%
>    chromium         3245144k   3127764k    -3.6%
>    cmssw             793996k    699156k   -12.0%
>    cpython           371584k    343480k    -7.6%
>    elasticsearch     748104k    637936k   -14.7%
>    freebsd-src       819020k    741272k    -9.5%
>    gcc               867412k    730332k   -15.8%
>    gecko-dev        2619112k   2457280k    -6.2%
>    git               252684k    216900k   -14.2%
>    glibc             239000k    222228k    -7.0%
>    go                264132k    251344k    -4.9%
>    homebrew-cask     542188k    480588k   -11.4%
>    homebrew-core     805332k    715848k   -11.1%
>    jdk               417832k    342928k   -17.9%
>    libreoff-core    1257296k   1089980k   -13.3%
>    linux            2033296k   1759712k   -13.5%
>    llvm-project     1067216k    956704k   -10.4%
>    mariadb-srv       695172k    559508k   -19.5%
>    postgres          340132k    317416k    -6.7%
>    rails             325432k    294332k    -9.6%
>    rust              655244k    584904k   -10.7%
>    tensorflow        507308k    480848k    -5.2%
>    webkit           2466812k   2237332k    -9.3%
> 
> Just out of curiosity, I disabled the questionable hardcoded 512 paths
> limit on the size of modified path Bloom filters, and the memory usage
> in the jdk repository sunk by over 55%, from 849520k to 379760k.
> 
> Please feel free to include any of the above data points in the commit
> message.

Thank you for the detailed analysis - these kinds of results are very 
motivating! I will include a brief summary (something like "10% typical 
improvement for 'commit-graph write' for large repos") along with a link 
to your posting for those who want the full picture.
