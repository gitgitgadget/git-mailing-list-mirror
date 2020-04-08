Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91DC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B82206F7
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 20:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv2+uuJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgDHUW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:22:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37441 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgDHUW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 16:22:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id n17so1020002qtv.4
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eub2z1nSWHmHlf9NpsGu7CY00iQBbJiG3YL9IGFpuVA=;
        b=Tv2+uuJVDDq2MyiKsN6DHT1Kx1mqIL0AzaBokz10heWUcvNDxCTfFy3SJ9vAozBJC5
         brOeGyfcBHYTHr6U5sVNCUJDT/oh/qAkQbhpFBePZ9fI6qoxZAUIlSc2CGZVgX5MCuUu
         ZSukCIQalxTG2a/gtnmFJIAzjHlbIOcowiQvrIpYC4fFwje57mf/SSl8eLnuPIruLiOt
         4Oh4njTAmjdVSRRtitrWbv+4GWKaQVWJCKAG361Qd3V/40JBcHWLFykw6ePTAh2TTquB
         fHYsNQQATtO4h2SoMGdmN4xz8MglTJzYtPNbfBtpumUgTDRg+1xyMjwvE8WnltUUHz+b
         vcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eub2z1nSWHmHlf9NpsGu7CY00iQBbJiG3YL9IGFpuVA=;
        b=LyRqJYsMXcui3UZs8l13cUIUKV83k6AtN4cKQwSFhMXUraChoV5l4EVinYWuN3XsT0
         UIj16RXJZIApxERyKSHvJBg05lLe4oXVV//FoLdVM3UX//U+awZeXqmOSWyAld8yapxp
         Jekda8ff2DW+2YS4gRrVHrjvc/KqriLf1NnVam998Akk0FK2px//8CYOOYiPIh2khkAE
         un7egIuHNakfwKd+O2yMfCGXUjL9EXVsHo6ISobJP22Wu7J+OM+wvmsRJ2yVTJSDWfxC
         BEXVAYembliL/weVkPtbCzi8tu9IDSv7zG0jZqP5aiyQSrtFonMY2itUBmUGckWs94Sk
         ojHQ==
X-Gm-Message-State: AGi0PuaB2uAfMZ3y8efMRTXudagO1yG/+E+O6svo5TW+ASWB+WVR5vk+
        MtzpDJRqhIxdNPwhOUYqOXY=
X-Google-Smtp-Source: APiQypJ4aYz0XBLjej3187ZXc3n5iKPGOrLuKUmXBgAlYW098+nPCsLOo5wX3f95oi93BwrEMyCZ2A==
X-Received: by 2002:ac8:8b9:: with SMTP id v54mr8871933qth.229.1586377343376;
        Wed, 08 Apr 2020 13:22:23 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y9sm12250812qtc.12.2020.04.08.13.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 13:22:22 -0700 (PDT)
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
 <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
 <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
 <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
 <20200408200526.GA2270445@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
Date:   Wed, 8 Apr 2020 16:22:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200408200526.GA2270445@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/8/2020 4:05 PM, Jeff King wrote:
> On Wed, Apr 08, 2020 at 12:46:41PM -0700, Junio C Hamano wrote:
> 
>> Our features written with the intent to be useful for one purpose
>> often end up being used for purposes other than what the feature was
>> originally written for (the "--pickaxe" has always been a bitter
>> example of this for me).
>>
>> For that reason, I am a bit hesitant to endorse "audit" exactly
>> because of the implication of "intent".
> 
> Yeah, I agree with this.
> 
>> I wonder if there is a simple-enough phrase to convey what the
>> latter half of above sentence says.  "include" and "keep" are both
>> good verbs---normally we discard these merges, because they do not
>> contribute at the level of individual changes, but with the option,
>> we "include" or "keep" these merges in the output.  It's not like
>> we keep _all_ the merges, but selected merges only.  How do we
>> decide which merges to keep?
>>
>> I guess your "--first-merges" came from such a line of thought, and
>> is the closest among the five to what I have in mind, but it drops
>> too many words and loses too much meaning.  
>>
>> "--keep-first-parent-merges", perhaps?
> 
> FWIW, this name left me more confused, because "first-parent merges"
> isn't an already-defined term I knew. And it seems like all merges have
> a first parent. Having read the patch description, I guess it's "a merge
> which isn't TREESAME to its first-parent".
> 
> I can't think of a more succinct way to name that, though. And possibly
> if we gave that definition in the documentation, that would be enough.
> The name doesn't have to be a complete description; it only has to make
> sense once you know what you're trying to do (and be memorable enough).

Then I suppose we should focus on naming merge commits with this property:

  A merge commit that is not TREESAME to its first parent (but is TREESAME
  to a later parent).

The part in parentheses may be optional, because a merge commit that is
not TREESAME to any parent will be included by every history mode.

In my latest attempt at documentation, I called these merges "diverters"
yet still used "--include-diversions". Here are a few other words that we
could use:

 * diverters or diversions
 * redirects
 * switches (think railroad switch). Synonym: exchange
 * detours

The "switch" or "exchange" words are probably bad because they have
noun _and_ verb forms.

Or we could look again at the history results as a whole to find
inspiration for the command-line option:

 * --merge-trail

Thanks,
-Stolee
