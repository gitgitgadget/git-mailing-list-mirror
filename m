Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17AC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200C66023D
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhGCF4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGCF4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 01:56:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B39C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 22:54:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g21so11196775pfc.11
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 22:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2sX496unjLyx9Fpc6f42CKx59bQZb/B72/XbqJYGPiQ=;
        b=XiaDGhrJVmUqoFMCzfMeQEFX0jWFD9PEd9jp/QVXx5cO+UVS+fh/GvWHLuuEg9fnps
         wMwtWcDXgHrS2ek/ZpZIeEg7VayPd38Zpz1gY9xUDHj0tv2MXgIra7uz1AX5NjtDNQuE
         adl7AuH8CLyLHIRqpskY46u/u2sRwfIRm8TqSdIzI1bR/OGum57ufmkxdmPBKg234fyH
         JVg7vQ5Yhu7pKlFLa5uw2WllF6LzdT0NBZsCqhOw0xSv51SM6DqF2PXlS0i5RB1opwCV
         8/SLu1B2ZckenjJPlURfZybf/uJgmnCfOuXpsEmZU0Ioj+E2HYDcxsN0MRSPY/B82+yB
         eZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2sX496unjLyx9Fpc6f42CKx59bQZb/B72/XbqJYGPiQ=;
        b=Hyz3PrRuhYrmOmKH9TJtRkOiLHH2I2fkLgH34E/CbEaZtfRf0NZvJRwuvQWngTTgvn
         bevuCTueaAs0m24QbKI7OEqTTKP9RSIIOy0zgo9Xj/8c4STNC9AcQZGX0/tECb/mHI0H
         DN4+2ICbo3a3pb05XfQzowgabj8PmuFed04c74FvPoblNzkWvr6Qh/R7NGvBH6h7yVC1
         EkiWygCPB9Gra+5X/5u8zbdwlrcaqV1hGALmvmfHrztkvbkYIFsfpTjnodIImNkZ7WQf
         vIOQV+24Uu0/z40Hh/Om8GwTVxYMBxZuzzaxBUCe/Rg184PZcXPfNz+ShfHv1KBpozYr
         6KKA==
X-Gm-Message-State: AOAM532RsyVeTY/MJLCE9x0ajJCwWx74ziLxdlsn+Xfq15hw4C6lekxf
        WyWkHmJlzYPT/hm2l51st1c5JlWAK2A=
X-Google-Smtp-Source: ABdhPJxKFlEFHLLubGzhqxedYOuCbCFGSrM4b7X37OD818V4DypRgsYRLy2EtP6ACNSQbr2qF5XFTQ==
X-Received: by 2002:a63:4761:: with SMTP id w33mr3703970pgk.195.1625291659144;
        Fri, 02 Jul 2021 22:54:19 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id e18sm808965pfc.85.2021.07.02.22.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 22:54:18 -0700 (PDT)
Subject: Re: The git spring cleanup challenge completion
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <60df97ed24687_34a92088a@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <cd495a08-bbf7-35f8-e1a8-a87cdc9c3ef1@gmail.com>
Date:   Sat, 3 Jul 2021 12:53:57 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60df97ed24687_34a92088a@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07/21 05.49, Felipe Contreras wrote:
> Other than that, it's fair to say that *everyone* needs some command
> aliases to use git. This past month shell completions have saved me, but
> not completely. I can't imagine how a newcomer must feel using git
> without any alias.

I personally use git *sans* aliases. I prefer writing full commands 
(like `git checkout`) rather than shorter aliases (like `git co`) so 
that I know what my intentions are.

-- 
An old man doll... just what I always wanted! - Clara
