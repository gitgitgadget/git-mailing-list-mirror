Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B823C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3647E20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAdH8mXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgEMFRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 01:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgEMFRd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 01:17:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1EC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 22:17:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so18529354wrc.11
        for <git@vger.kernel.org>; Tue, 12 May 2020 22:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sU0KsfiuW//52TNlAv16PBAJ8XN09qwEh9fbvmAhPw0=;
        b=lAdH8mXROpl0fHON9Xl4G5J9dm1mXflRpz7yCYQr98YbiIkYKjs/DZiolVlJeXivTa
         O/pRQVY/LQNiiq02omAOo96M+E2JMJRxHYRsS64iJYBNRwM7PGDEmWtDUG1gpB1N09w8
         e0YCdmYRGSoUOiwiHC4v1mamOO0iGNexnj427N0U1mkICqQu9cJymDWKYRoI1+2dwHO0
         JPLUsjqbMYK4U7MMcANmeoKaIyknIDuVDsJL78oWY3qBRwaDiEGPktLvT1eeCUnZB313
         Bx7v4KL21XzzKY+LMEL+bBTTMniF9c9rLGQZnCfYSopEFfdvTjhI6bRHTv+hpkSgDNIB
         cBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sU0KsfiuW//52TNlAv16PBAJ8XN09qwEh9fbvmAhPw0=;
        b=FJ6WPzGqt9LhoXELpNAdhC3rc57//S735XbYvUA5BGqP5CGw+YcZQvLeiGYwr8ATJG
         EGDdMuHmrr02HyY7HvQeURik6U/U/WMbI8PzgWAw0FWKW5qCbo/3Whintr++FGmCdBHw
         8G5jdoQaHOKJashlHLXx+5P4jgXWtm9FeHAaSUp3Q1WXrufZSneYTVgeuSsYb98u5T+Z
         wDeE5Gb0TSPJTaK8BQuZUC8SodEsbfl5toP0DofFDrKQOEENEvBagnHR0E/8ICsPeoju
         K1C3mea9KPGsd5YavHBfrAqTs0nw4O2xt1pPHm2K7ou4kjayxXLtPRofweWn0QAM7UG8
         hNIQ==
X-Gm-Message-State: AGi0PubMeQr4pdgvksc4YPQV7k8NYl1gQZQr0/h0fzg6ia34T+CkJjc8
        kamsO/9DpseioOs3gk7zFiTa3vr2vqO1VQ==
X-Google-Smtp-Source: APiQypKwydLYPtnydZ6ngvDu/Elx0G/FHxHO+jd//5i6v4QzmCdfB9+m0E8pbQo0Madb6JN2i5O+Mg==
X-Received: by 2002:a5d:4102:: with SMTP id l2mr28020454wrp.51.1589347051704;
        Tue, 12 May 2020 22:17:31 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-164-191-108.adslplus.ch. [31.164.191.108])
        by smtp.gmail.com with ESMTPSA id v205sm16781144wmg.11.2020.05.12.22.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 22:17:31 -0700 (PDT)
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Junio C Hamano <gitster@pobox.com>,
        "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <cf25c55e-e0c8-6374-3adf-84f4314869e9@gmail.com>
Date:   Wed, 13 May 2020 07:17:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

> If iterating over only active ones is useful, surely it would also
> be useful to be able to iterate over only inactive ones, right?
> 
> So, before getting married too much to the use-case of "only active
> ones" and getting our eyes clouded from seeing a larger picture,
> let's see what other "traits" of submodules we can use to pick which
> ones to act on.
> 
> Are there attributes other than "is-active" that we may want to and
> can check about submodules?  There is is_submodule_populated() next
> to is_submodule_active(), which might be a candidate. IOW, what I am
> wondering is if it makes sense to extend this to
> 
> 	git submodule foreach --trait=is-active ...
> 	git submodule foreach --trait=!is-active ...
> 	git submodule foreach --trait=is-populated ...
> 
> to allow iterating only on submodules with/without given trait (I am
> not suggesting the actual option name, but merely making sure that
> 'is-active' is not anything special but one of the possibilities
> that can be used to limit the iteration using the same mechanism).

The idea that other candidate are possible seem good. But then users 
will need combination like is-active && !is-populated. We will end up 
implementing a complex code to filter based on expression which is IMHO 
overkill.

If is-populated is needed, that could be implemented this way:

         git submodule--helper --is-populated[=true|false]

this would allow combination with the is active filter and the
previous example would be

         git submodule--helper --is-active --is-populated=false <cmd>

Regards,
GG
