Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B130C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDAB2078D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiH5XMk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMM0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHMM0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 08:26:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC7C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 05:26:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h21so4092165qtp.11
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rADFX8mF82JatrysYPONnSiNQ+Qffv6zsEtQERPrF7I=;
        b=jiH5XMk6CX4YXXQkcTz5UMN7Hx/ojBonnxguJf/5v+9iaaAeBNz4f+Zhl8pvtYDph7
         Zl3E200uUsasPlLEnHDBoY5nZI10IxyjU1RHf54yChwmFySDVDcMwWcCpiKUJX+00fa2
         eRuSu6OFBcVWjcJj1uL5DFuRF9b9NruJJQ9poHpW6qmij18Gt5tNb3GbMvhh/Y1hyyeq
         r2UxwbCxHouTGkm9KMjFPv8JygHdQwrW3Uw3/dcEM+4h2+6UIgKGv02TGeObQQcVNEMG
         cGDI1Qv7EnCliIw7TPcQZHNYG4DLVzNXeRv95iZfKCMkT65jLdd7pIUYxlOc+Z8LqUkA
         bJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rADFX8mF82JatrysYPONnSiNQ+Qffv6zsEtQERPrF7I=;
        b=GTejxT5XzuwYSm8Cv2wfnszCq9uixQTEPb0VfZxtKATciJ1h2ba/mtG6p8S04aInDf
         ILK9++Oe2+hG2bgqDf/+Vh9jxy6X8mh8ESdOpN1CsHG5UQBrnRu3ueitjsWKTprQMRp5
         aVTfxKxrauAv1PAZu1pQmn+pfWqfhjmz5AI4FY0ID7b9r0FGhFdHpydgap6hlMO/2NLW
         KP7Bp1AX+U6kVbv+SO8SDjMH/XmYrAMkAabXVlX6KIwW6TMzL0MWWjPSccCtoT8rujF3
         NYSqVyLrtoOI4qnBj83/3XESWpn4Zm8uB3unDPhvdcY+T5BRL4N8TGLbBFMgjhVAbU0F
         Ydbw==
X-Gm-Message-State: AOAM531t+Ih5QbmPYExldkApDmojsLBS47CUJvkxIQ2IpnPt4JyE/De5
        PCsGrglKVXGEXScJG0IeLHvW7qtrVS0=
X-Google-Smtp-Source: ABdhPJxGAmTxfQ8O8IsVjBJJy2+jIIvYND69XXFZMAM4sEBr1Fnv0HnuJxLmQW3Gun/C+Hb7TPerYw==
X-Received: by 2002:ac8:4095:: with SMTP id p21mr5051337qtl.166.1597321560463;
        Thu, 13 Aug 2020 05:26:00 -0700 (PDT)
Received: from [192.168.0.103] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id x23sm4957987qkj.4.2020.08.13.05.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 05:25:59 -0700 (PDT)
Subject: Re: [PATCH 0/3] blame: fix bug in coalescing non-adjacent "-L" chunks
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Nuthan Munaiah <nm6061@rit.edu>, git@vger.kernel.org
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
 <20200807212159.GA1871940@coredump.intra.peff.net>
 <20200807213349.GB1871940@coredump.intra.peff.net>
 <xmqq7duaf6xk.fsf@gitster.c.googlers.com>
 <20200807222630.GA3750245@coredump.intra.peff.net>
 <20200807223522.GB3750245@coredump.intra.peff.net>
 <20200813052054.GA1962792@coredump.intra.peff.net>
From:   Barret Rhoden <brho@google.com>
Message-ID: <e63239f2-f121-97c3-7229-2c48d6aefcd0@google.com>
Date:   Thu, 13 Aug 2020 08:25:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813052054.GA1962792@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/20 1:20 AM, Jeff King wrote:
> On Fri, Aug 07, 2020 at 06:35:22PM -0400, Jeff King wrote:
> 
>>>> I think the only conceivable case is that in the middle of a single
>>>> block of text in an ancient version, another block of lines gets
>>>> inserted during the evolution of the file, but in the end these
>>>> intermediate edits all go away and the same original text remains.
>>>>
>>>> In such a case, without coalescing, we would not treat the original
>>>> single block of text as a single unit.
>>>
>>> Yeah, that makes sense, and it should be possible to construct a case
>>> based on that.
> 
> I started to add a test for this, and it turns out we already had one!
> It just wasn't checking the output as carefully as it could. :)
> 
> So here's a series which actually checks that blame_coalesce() is doing
> something useful, and then fixes Nuthan's bug on top (with a test case,
> but I also confirmed it makes the original tomcat issue go away).
> 
>    [1/3]: t8003: check output of coalesced blame
>    [2/3]: t8003: factor setup out of coalesce test
>    [3/3]: blame: only coalesce lines that are adjacent in result
> 

thanks for the fixes, looks good to me.

