Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C0C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042292080C
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2eJksZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFSJXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFSJXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 05:23:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4FC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 02:23:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a6so4409241wmm.5
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aooHoACe8YLyVKCoyhjA+pzcmb+a4LaCMCJ4QnCbaT4=;
        b=B2eJksZ/S+kyjo37ov/sU/ms74m0AT77VWtplh20U7c5h7iUV7QpvN3s+U6f3RWBB/
         y0i/APifGtksPhS7za0jEzj0eldx+OoCJWhdw8gBWYxBV9bGg93JDirIrnFJgxyMJGiG
         ZYBbtw4puK5hgFPYE4OOBatr0391PbvkapOpDf040t6I020JbSwp3bGnOF6n8t5OlnHv
         gw0C5Z7drAeu++kqJiAUzXZtz1V6QmHR2ZQz3FsBxfdw/INDlEkqnuhVTUhQToJB8hQH
         modclipz9GzEePQVcs9C3CSdyCajBqRSkrNsKgQ6yFXs4V32atEDVg8q0Hxz+RGtz6e5
         Wr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aooHoACe8YLyVKCoyhjA+pzcmb+a4LaCMCJ4QnCbaT4=;
        b=q1yRy1PDQnrmQqA++xanZQbHqa9iaprJIvDoiYDFCUr/jBGht3GRruioUqqIZ6hyfe
         HUMGlf4Ni0fFMRRuRmlo2IwRckJuuT4g7gaQQmFWm7TgX6utVHWKhOdLd2pPTx7dK3Uj
         7Z4v6DGIYnpbxETrFBXWEnbOKfu1yMEakHtF2aNLUe4ynWridrR5ngev8TOV5R3bebXe
         UME8MsG18b81K8IpC71pWbHbf1F3FGSsSQhKjQaZAK5stWicepFfF/runzgEKVYQft5A
         /blgFLpqb1CLywvDmggyj+vHrKWvWTtaJR7uXd9wwkFy60QGkEClSaQXKnCowwAUKHMR
         pY0Q==
X-Gm-Message-State: AOAM531tGUtf9nwyMCkt8SRgd9zx7tqC8T+aAOia6teM/DyIALKAhw+3
        qlrWJWlRwzZRxYVTLnAP+mU=
X-Google-Smtp-Source: ABdhPJx4QukJhNbfNLJA+kkG/OKrXiVam7cGoEW3oLlppcc/iA2G82dN+142iZMOiNosvDlGs2Xx5A==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr2762535wmk.77.1592558616283;
        Fri, 19 Jun 2020 02:23:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.googlemail.com with ESMTPSA id d9sm6418296wre.28.2020.06.19.02.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:23:35 -0700 (PDT)
Subject: Re: [PATCH] tests: do not use "slave branch" nomenclature
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20200618163843.22181-1-bonzini@gnu.org>
 <20200618164554.GA616157@coredump.intra.peff.net>
 <xmqqwo44nt6m.fsf@gitster.c.googlers.com>
 <20200619092035.GQ21462@kitsune.suse.cz>
From:   Paolo Bonzini <bonzini@gnu.org>
Autocrypt: addr=bonzini@gnu.org; prefer-encrypt=mutual; keydata=
 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
 10oh++mb6s1dGf3ADAaOTRf8
Message-ID: <b4259ac0-9510-8d01-0e71-f11b4a193123@gnu.org>
Date:   Fri, 19 Jun 2020 11:23:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619092035.GQ21462@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/20 11:20, Michal Suchánek wrote:
> On Thu, Jun 18, 2020 at 11:08:01AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Thu, Jun 18, 2020 at 06:38:43PM +0200, Paolo Bonzini wrote:
>>>
>>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>>
>>>> Git does not have slave branches and has never had.  Independent
>>>> of any future change to the naming of branches, remove the sole
>>>> appearance of the term.
>>>
>>> I think this is a sensible change, though note that something simpler
>>> was proposed recently:
>>>
>>>   https://lore.kernel.org/git/20200610165441.iktvzuwz44sbytfg@chatter.i7.local/
>>>
>>> and the review suggested using a name that is even more meaningful to
>>> the test case (so we not just remove the unwanted names, but make the
>>> test easier to follow).
>>
>> Thanks for spotting that both versions share the same issue.  We'd
>> just need a single one that is fixed up ;-).
> How about s/slave/feature/
> 
> This is about simulating some development happening on the new branch so
> this name looks appropriate.

Indeed I was going to send v2 with topic or feature.  Thanks,

Paolo

