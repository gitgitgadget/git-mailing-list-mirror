Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE94C433DF
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DBB207D3
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMTJ5nMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgFFOxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgFFOxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 10:53:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D9C03E96A
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 07:53:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so6628251pgk.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uO1O2Cme5hYENUGgJPcul+MMCOCisF1lHFoHskT9U+E=;
        b=KMTJ5nMNdTihOg7cLoq75Qug/NhPkP/+ECw0s8eDMBfKFQhPrGKdnhYUurbKoffwxH
         MmxJAzc3ps9PbAS+4iqYZc0U8+KSSQLVjwbCPoA01q6OXz6Vil3L6JSNAkt5oqGU7drC
         8gXLUljf4xWjao9BTfo3NaoUQiW+UphJTTYe6croXWMip/EB8xzZUdp/ZP5J+gPzZLZh
         6cY/ac14jcHW4nHsuwJWYf8N3dQ41iEzrN51k/CA3CSB64AQ3+2z/Yq/+ouCUqzE1R7e
         SQQzjcuRlJWKQQ87jciyjpoNuatRHxfHMjl0rvoWrlV8HVfIzlvJ0oA9UdyOccPSeGfy
         pMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uO1O2Cme5hYENUGgJPcul+MMCOCisF1lHFoHskT9U+E=;
        b=eEctA8KhXmuvuXgRitO/I15QMMbMtQftmt5TNkGPtRlwYXeyFLIMXFX1wbmsZqFblF
         9OSLFxCbCORK33l1Isyel/3XdzG67n/rKZAOjKvJZKtutyb/85skC0Hp5JbXEFn6vcN2
         PlqC5uwGyGo7LczOlCu9tDJa/kKldQIenyHGqUK2CEBaZmCxskKCONtF6tfjpfOrttcA
         PkGGut33AxYW9I1u1OT1ap1NH+KeiXbR5bJZMxlMljEqaz0BycL3dbJ1IAK/QKRk+GuP
         wYHvO/KMznb5NCePMbfF3bsHxi/7HiKa9yHRiP0UEJQgVMyhsswTg5zAPYbMuhgyY9Wy
         ++Qw==
X-Gm-Message-State: AOAM531+hsZyVOrxWvqjztP/sVuUPEyS3IHW45Z70DJ4ZDSDV4BSw/+n
        O2sxsTZVzAXYM1jDn0vPR7U=
X-Google-Smtp-Source: ABdhPJyjaaO3wGc+CsaUbs1FqrcqhvVa2vjyZ9JY4tDrF2JeRzcptcksgeuIAgL0oLQKFXblyid3BQ==
X-Received: by 2002:a63:c407:: with SMTP id h7mr13432934pgd.174.1591455232142;
        Sat, 06 Jun 2020 07:53:52 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.140.115])
        by smtp.gmail.com with ESMTPSA id m20sm2684677pfk.52.2020.06.06.07.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 07:53:51 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
 <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
 <CAP8UFD0V+=tq8CGFk_Mz+N=HjRtkhkMbX9Cy2-=WfHL8wrj6=Q@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <8e479e02-81c5-6329-ff1f-304b1cd4e292@gmail.com>
Date:   Sat, 6 Jun 2020 20:23:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0V+=tq8CGFk_Mz+N=HjRtkhkMbX9Cy2-=WfHL8wrj6=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-06-2020 20:02, Christian Couder wrote:
>
> Now to go back to Junio's question:
> 
>> ... people are eager
>> enough to help by reporting issues they encounter, but there are not
>> enough people who are eager enough to help by testing the tip of
>> 'master' before the release. Are there things we can do to help
>> them become early adopters so that they do not have to scramble
>> after the release?
> 
> Yeah, I agree that increasing the number of early adopters could be
> the best way to avoid regressions report just after the release.
> 
> Maybe we could just ask people to test rc releases or 'master' in Git
> Rev News?

That sounds like a good idea.

> It might work better if someone wrote a small article about
> what is coming in the next release before asking to test.

I think writing an article wouldn't need much effort thanks to
the wonderful summaries of the topics already found in the '-rc'
release e-mails. It might need curation as there would be a lot
of topics.

> Then there
> is the issue of making it easier to build Git and to understand and
> fix build issues.

Yeah, that would be nice. As a first step we could link to steps for
building Git from the hypothetical article about the '-rc'.
The "Install Dependencies" section of MyFirstContribution is
an option[1].

[1]: https://git-scm.com/docs/MyFirstContribution#dependencies

> We could also perhaps coordinate Git Rev News
> editions and Git releases, so that the editions are published for
> example between rc-1 and rc-2  releases.
>

That would be necessary. Though, I'm wondering how the eight to ten
week feature release cycle of Git and monthly frequency of Rev News
would play along. This might need some thought.

-- 
Sivaraam
