Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B30C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577C26113A
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348610AbhIHNnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhIHNnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:43:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B619C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:42:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n5so3335879wro.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UnO3DD46EoiaShZElnEdWYUSawmoSiqebsLgKR8SmUI=;
        b=m5rzoipi5K972HWtFELJw2e6yQYM01DZ1xBSy0udVQi4xEMpSJ3xH2m+A4BWcJN2Vz
         3CG3qK+BOxX3trXytg8J7ycW2MUIagjlPUN2MGJIMxVNJaEM0A4qnYw8a4ru3Hqsj0N0
         lnpAPAG0Sj4+eaiS3RNOheGBxR4pWFQ+QYSrH1wEn875ITR33/GcIoY25saq65lDDFUJ
         e3/NIAiEeRrr2D5YQfUpMihls8nSSqwiZsCFBWgM+h4edU19NNkSZDwHtq6EgRIXuRvO
         qGZLpC23ZdHwpjbB0PUzcijm8u+jxLcFKzYiMGk8PGt33rq1Y2oAdAexPcdGzoZxznRx
         ZxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UnO3DD46EoiaShZElnEdWYUSawmoSiqebsLgKR8SmUI=;
        b=NWVcG422JU5Tlexes36S1lktRe99krN+6DjlQk26mc1VJ3Knzjrc05PT60o3xNDyvu
         sJjjhLa8NnpKxsKhWi5+yNN2VoOEbQXilg5l54sekDNqg5M5hDxKz9x+BahxC0NPSGWW
         vRpC6u676ufMn0JoAPfLe7EhwtdIo/h2WVyXEXXYid9pxIwXF2cyb2jdgEFlii+tu1oL
         5TpX00L1CpnYICY0E4d/sZDJHlRZY94nMYIzD+GBN5e/G/HsOD6zfpQRTZGGVTayaCP3
         E1QLYR3GAVQzJOo9dhvhI5YHNmPykKtkk2qa9P5DdvA60TMEpxsQoOPJKBoDBv6ZaVIq
         wOMg==
X-Gm-Message-State: AOAM530/jUpuzapvc0zW5tQY/NtxmcefXejtHsHBPOKQFFnS5CWNEFFL
        cVGfEissjbgkufXWgGRiwNM=
X-Google-Smtp-Source: ABdhPJyLicU2swgtUCLATdibvlOmq/gJ4I5A3rHgAPEc6FQCA2tG9EyOGsaDr4aaBN9gFJyGUyTadg==
X-Received: by 2002:adf:90cc:: with SMTP id i70mr4175951wri.408.1631108530986;
        Wed, 08 Sep 2021 06:42:10 -0700 (PDT)
Received: from [192.168.1.240] (205.96.189.80.dyn.plus.net. [80.189.96.205])
        by smtp.gmail.com with ESMTPSA id n1sm2167148wrp.49.2021.09.08.06.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:42:10 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/11] t3407: use test_cmp_rev
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <dfa27d7a8e7e0a9e03e228653ebff639a449ac77.1631094563.git.gitgitgadget@gmail.com>
 <87ilzbic3l.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e347691c-9f5e-9103-8690-014aa0054717@gmail.com>
Date:   Wed, 8 Sep 2021 14:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87ilzbic3l.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2021 11:40, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Sep 08 2021, Phillip Wood via GitGitGadget wrote:
> 
>> @@ -54,9 +54,9 @@ testrebase() {
>>   		echo d >> a &&
>>   		git add a &&
>>   		test_must_fail git rebase --continue &&
>> -		test $(git rev-parse HEAD) != $(git rev-parse main) &&
>> +		! test_cmp_rev HEAD main &&
> 
> Use "test_cmp_rev !", making the shell do the negation is troublesome
> for the same reason we don't do it with git command, it potentially
> hides segfaults (and that test helper invokes "git", hence the optional
> "!" first argument).

Thanks, I didn't realize one could pass "!" to test_cmp_rev - it gives a 
better message on failure as well as avoiding hidden segfaults

Best Wishes

Phillip
