Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FAFC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbiCBT6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiCBT6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:58:21 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23BADF58
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:57:37 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id z7so2783476oid.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tjohNp4J5u5szdXpaF4Jh65MjHPvSROCtODiz7oiQ1U=;
        b=GyIbiSDC3YmHOImRrqciDbib0jKLmOITF1OYlGSI+uJr9CTpxWaXujh9N5635pKcQn
         f3KoXv1FOfy4s2SQlgf+vKq0wAKPj1wN4CiJDtwQ6XJLVfz3TUCcCE+mW98jNEdyMOj9
         mmwCN7kw4Q3egbGMT+52V38+iQeUgdnVcRTvq6AUGhJi0RD+YK7wMdidhIcvsNbXDAqB
         Y3JTdLXG4HfLOvPGik8rrVAs4yDOQXZsbCXML15XCYkZjSZUq4Anf8OWQIjBBS6Oi1u6
         gYinbp1VtqZM8tEln/BlF9pbW4PDnOcK3eoKW95bFcYGLptp5ghcHVsWTzK7b92SUwB9
         AvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tjohNp4J5u5szdXpaF4Jh65MjHPvSROCtODiz7oiQ1U=;
        b=dRwRig9gFqh8ciImQ9RDI9ITVXoN1GHL9LIn42krgTuFvKRQfHyfhVi8AFPJPg+SvS
         RxzcBfLPHQbqifIdFoHBagpxNqub2+VLmabGaW4eJFgFUfHM/VleXCl4Lsu65kb3+OTA
         eeEjQF+fqfSmmvBUGpztXOil3pz6e6mDLLiRiiA4si4BgsqYoENB9eaCpQAMNYEBKi+n
         HlwDjiA4d8Bw8fwayNSCKcg/U42fmSZGMeHaXNZUOgzDrACOnIA8MHas6jr9WQ7BIrqz
         nuLFesYZR8n/ADBWT+h5Tjzd+5lorc6rckIFxUI4p1qJ9I/SF1Zqcp9fkBeSjLKtM5uB
         hI8w==
X-Gm-Message-State: AOAM532y2bcnmfh9zHjRaD3T1fn+yBEu+PSYMIS4j5i9q6EiyrSD5X/E
        WXfJPjhvDDwBLN47g1ohe4ew
X-Google-Smtp-Source: ABdhPJxzE7WpgSL2qHsvTIUgEat2Sx81Bm3Zxbo0TlSOIXGv84DZ1vrahZ+CJC1A1SvaEru2+urf4A==
X-Received: by 2002:aca:5e86:0:b0:2ce:de77:5256 with SMTP id s128-20020aca5e86000000b002cede775256mr1391159oib.117.1646251057260;
        Wed, 02 Mar 2022 11:57:37 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v6-20020a056830140600b005af1486cb20sm8197030otp.10.2022.03.02.11.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:57:36 -0800 (PST)
Message-ID: <5e4d195b-5a4f-48d5-10a6-631501ca466e@github.com>
Date:   Wed, 2 Mar 2022 14:57:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 11/17] builtin/pack-objects.c: --cruft with expiration
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, larsxschneider@gmail.com
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <d68ce281324097e10e4c1921d84c577bed6943e7.1646182671.git.me@ttaylorr.com>
 <xmqqwnhcn6ke.fsf@gitster.g> <Yh+TPppXFoBU2zbN@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh+TPppXFoBU2zbN@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 10:54 AM, Taylor Blau wrote:
> On Tue, Mar 01, 2022 at 11:42:57PM -0800, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>>  builtin/pack-objects.c        |  84 +++++++++++++++++++-
>>>  t/t5328-pack-objects-cruft.sh | 143 ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 226 insertions(+), 1 deletion(-)
>>
>> I'd renumber this to 5329, as the latest iteration of generation
>> number v2 series took 5328, while queuing.
> 
> Oops. I had scanned that series, but glossed over the new test number.
> 
> Thanks for renaming (I'll do the same, in case we end up accumulating
> more reroll-able bits).

Sorry for the collision! Had I realized this was already used here,
I would have changed the number myself.

Thanks,
-Stolee
