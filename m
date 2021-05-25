Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACDDC47086
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DB56101E
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEYHdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhEYHdC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 03:33:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D659C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 00:31:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 29so10938700pgu.11
        for <git@vger.kernel.org>; Tue, 25 May 2021 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIiR6pU65hWelLdLntU1bVOPwELBhmJiBGL9OsNkrh0=;
        b=BrSzPn40r8Bng+sLe6LanFz9TaA9w7CEAgV2rs/Rfnk4m3nIvc95SlReWqTzApZcwW
         NfT7oM7ycRSru/I5UTMtzzxwB51MIozvt0TGN7WNecrs5Fnsm+MmUEBNWwAwjTkVgXsq
         MfyxU0kWDvyjbiKNKoTWJc96DAD90YDs21PqWEkXlcV+4UkCjp0Pf7vQOYM0zQ+uoJ74
         aiBz3WSragCvpI4v98yMY7k/VxEHS8L2f81ZTLsDoVoHy+vBWtRu/t23jQvDRR67pIyM
         eRxXRHW+r8G8xMyvzLG1cTkTIb/ZXKRjwl+qZwZeOA0m2EZlTvtuxhOtB2CxN4jy/xBV
         Wp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIiR6pU65hWelLdLntU1bVOPwELBhmJiBGL9OsNkrh0=;
        b=a0Vj6VIHJpzJIAwEbmSmvya5AgNMSKBPU1zzU7tOPhHtlyzSFIx1o/jXbGEFagUypQ
         aFC1sUziFMzi73On/fttu6RmcexqR53T+C5fnT3KiqRkdEb7lhk3rEnk4gHe8R2ecceE
         O9n7Fts1YkciThpMxtarOGDyhw27hcQGW8549917QJoIO8YWzPVWbeZJsr6gsmUGSG2x
         svlHf13tN/HwS/O4BVltVErtl0X9yVYVE3Gwd6Cca4YgiXKriMMPUromgmLZqek3GmhK
         MKXXpAXpip1t6A04+V48EU5ji3eLeAxyzviseMsuVl+0qZUTLSLwRhs+4T4BU89bl5Lq
         riVA==
X-Gm-Message-State: AOAM532uxeC1fJlyFWMIVVjcXSFvWF/3Vm8g9BNCJ1/hT7PGeCYSDmdf
        nLjKAfdJPiUGak4LZkq84aOzLFPfivTWgQ==
X-Google-Smtp-Source: ABdhPJzDmzIyiZqLu38+vzGhmBDs6B/TlM9ihTXBMMcE7e45/EZkVEJc9d03UXDFHRCcg+2sGuvTWQ==
X-Received: by 2002:a63:3c56:: with SMTP id i22mr17642555pgn.25.1621927891431;
        Tue, 25 May 2021 00:31:31 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-75.three.co.id. [180.214.233.75])
        by smtp.gmail.com with ESMTPSA id e29sm12701563pfm.110.2021.05.25.00.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:31:30 -0700 (PDT)
Subject: Re: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch> <87o8d0o2or.fsf@evledraar.gmail.com>
 <xmqqtumrfgqx.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8c08ee45-d7e4-b816-e883-a18dfa69fbc1@gmail.com>
Date:   Tue, 25 May 2021 14:31:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqtumrfgqx.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/05/21 13.51, Junio C Hamano wrote:
> I think dispelling the conception by distro people must begin with
> an update to contrib/README where it clearly says these are
> "contributed software" that are not part of "Git".  They are not
> something we stand behind like what we have in the rest of the
> source tree.
> 
Archlinux packagers did remove contrib/ because they don't interest
on it [1]:

> Right now the Arch Linux's git package does this:
> 
>   find contrib/ -name '.gitignore' -delete
>   cp -a ./contrib/* "$pkgdir"/usr/share/git/

> Also, the description there is rather stale.  For example, the last
> paragraph must go as its entirety.  The ecosystem has expanded
> thousand-fold since the document was written, and we no longer
> encourage people to add new things to contrib/ directory at all.  We
> instead encourage them to write and sell their ware on their own
> merit alone, without planning to "borrow" authority and gain undue
> advantage over its competitors by being in the contrib/ area in our
> tree.
> .
> 

So basically we should deprecate contrib/, and then after next few
releases we proceed to remove it, right?

[1]: https://lore.kernel.org/git/60ac51a7ecf74_1f8f720843@natae.notmuch/

-- 
An old man doll... just what I always wanted! - Clara
