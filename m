Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C305C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 13:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEE9246B0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5/Vm6wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKSNZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgKSNZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 08:25:53 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BEC0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 05:25:53 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id f11so6283666oij.6
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zpUmC3xTyW67/K5Jr6W31KdlthbFxg1pVAnsR2HJUGI=;
        b=O5/Vm6wDoEged1Z1BGm8DEf+0rYtjQtYNXmk9GL5+4plvXCnF6uyMUSLB7/xB68ppP
         GvRvD06/8FsaVs0OWMgqPwNdg8O5B4g+AGz/d8B7zt2YxWGh5oZiFYormCduTXinwFoS
         9EtudRasFRftyvi/ndbFM3T36w5oaTvaa2DPnu6iSD6FGpkyMIVQM4n3KiYnHLtRQINJ
         wUiBeZJ8+UnpQzx6I87ujAOtoJlcMnVDO4PtPofBkhsmqe0IQxxuQxLZTcyWtrCK0euy
         chBtUjm4mXLop6YMBNWfpC7Ity10DMhGRxhvU1+e9wzRocM9X8xV7virfmgsDOjaUwNj
         Ji8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zpUmC3xTyW67/K5Jr6W31KdlthbFxg1pVAnsR2HJUGI=;
        b=nimiNhx+yegScaYixcLsFxTxq1aRvJcVtiSW/Sawv5auObRz+VjWhwd5XpeLrACufN
         1xtvR0rOJspjSuqmopYKy7E67poSpsy2JJvbylZsVvYq5sCEsKmBHm89uFYKGLpFeIIg
         iyP0SP1sg7Ermxnlebbub7J1D4x3BY2J6AGc5IAGyIGeDznf9x1hMY0+BTakrM204YMz
         gPR7IUO6PBI/vA5XhAEdcjFY6ay78XilTf4Ertv7K70PBnCNFJuu67+K5375zWtRVfe+
         Gn6DULsJ8foqI6ieU6URgtbJVNCuh+/tZW/0arngZZMR5MPB+xyTc+rKvUe+bYF8+hhF
         48QQ==
X-Gm-Message-State: AOAM530rDyDc0biKpcBm0P40Ke/2d3TkHU2h1qavAi3Mn/b/HleVEaIG
        ySrq0LeBphdP8u2AkiYCfUpn43Pl7BJY8A==
X-Google-Smtp-Source: ABdhPJwerkhMbFagn7k6XQ4O/9/g9PyQrfFsVIJlYdLoseRPrBVdk2O2r7LNKhnHPT4li6IMKPv/NA==
X-Received: by 2002:a05:6808:14e:: with SMTP id h14mr2931490oie.126.1605792352049;
        Thu, 19 Nov 2020 05:25:52 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id b123sm9200509oii.47.2020.11.19.05.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 05:25:51 -0800 (PST)
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
 <20201116235642.GA15562@google.com> <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
 <20201117010709.GB15562@google.com>
 <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
 <xmqqlfez6alb.fsf@gitster.c.googlers.com>
 <f8b1a1cc-dcda-0e53-4c46-bb5bfff3fdd4@gmail.com>
 <xmqqd00ayttk.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com>
Date:   Thu, 19 Nov 2020 08:25:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <xmqqd00ayttk.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2020 9:16 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> I will get started on this fix as a series on top of part-3.
> 
> Thanks.  Not just part-4 but Dscho's test update also depends on
> this, so let's see it corrected soonish.

I got a decent start yesterday, but I'll put this at the top
of my pile for today.

-Stolee

