Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F575C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 04:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF2560C51
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 04:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbhIXEiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 00:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhIXEiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 00:38:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F13C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 21:36:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g2so3741186pfc.6
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 21:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dNgbNrpKjpb6cAplpHULbfcJ69zsSgRGwCz3miBk8pA=;
        b=NbZy2wSaLGja6CMnfxe2TwYbYimu6ljsuG3aEGV9RLe5Oh0/s2LVbZ+ZDVFwg0L/Ex
         BrY9xr4smavmpIVLrHLHJDf7e5iZYGO7sKPK6Ep7wFGSvY2WH0mCe63pUEFKAz9XdTjN
         ngzP7kXJh0MeOoYRyul9ChEVYIdtUP+mPjXqsHYnw+g3bmzJkojUheWOPgUKlAPw1r4f
         4NGll+DAj3aH/zO1iG1ICUM7KYLtxScXtEVLSX8cWWV4wVEyk3RSmOFBK8i03uzJZuT/
         fW6qs5CRpWJPa7zNbEuioOr9LNdSST2TXCLUlSADMcfRXy8KQdK/I20KojGYlEnGJsza
         mI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dNgbNrpKjpb6cAplpHULbfcJ69zsSgRGwCz3miBk8pA=;
        b=E6i0DrvtbWat+idSaK285uYzqXw0E5/phWMuoHUl8y997/+2dRLq1Q6rTe+SxyB9Lz
         F19fMk3x21IKZh4XZqsCNUNUlP1o3X/GS1biDMxa6Pos7/Ey4cW5jT5PRH2kxGZm7vFE
         HDlAhShzyfWJbtYCurHdYFjCXdcAM8u5GiJXIZ67tbuEEoggi6UGx62D+xv9x5td2J1O
         gruCYE0+Xeo7Mzf9CJkHN2EtlGB5CvD4M0Jlofnl3+BfRk92rPgJAJ7uTXT8AH/msWlg
         wsZDJhOIdqM2JGuGkJgKpwo1u9G3k3hSpmhVAUPFsVcQzDJwSi1xEEpPfxo2QwnoKb4J
         bgJA==
X-Gm-Message-State: AOAM533Cu3AiWd1pzdbVopoLsM1jnITZ8BFbk3KerMVQWAiF63wxvna6
        hH2sGrYA6ALFWCuyyqJYTyQZCbSrmQdXZQ==
X-Google-Smtp-Source: ABdhPJxR3YNJR4gCH39ZdiabiaQr+DBZYhJjB/FFweULDhlaw0KuGte6o503yC6WjuvG2w72JdUURA==
X-Received: by 2002:a63:480d:: with SMTP id v13mr2073582pga.455.1632458195903;
        Thu, 23 Sep 2021 21:36:35 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-6.three.co.id. [180.214.233.6])
        by smtp.gmail.com with ESMTPSA id 26sm9413431pgx.72.2021.09.23.21.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 21:36:35 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
To:     Thiago Perrotta <tbperrotta@gmail.com>, carenas@gmail.com,
        gitster@pobox.com, avarab@gmail.com
Cc:     git@vger.kernel.org
References: <87zgs34ccx.fsf@evledraar.gmail.com>
 <20210924024606.20542-4-tbperrotta@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
Date:   Fri, 24 Sep 2021 11:36:32 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210924024606.20542-4-tbperrotta@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/21 09.46, Thiago Perrotta wrote:
>   SYNOPSIS
>   --------
>   [verse]
> -'git send-email' [<options>] <file|directory|rev-list options>...
> +'git send-email' [<options>] <file|directory>...
> +'git send-email' [<options>] <format-patch options>
>   'git send-email' --dump-aliases

Is <format-patch options> optional? If so, we can say [<format-patch 
options>].

-- 
An old man doll... just what I always wanted! - Clara
