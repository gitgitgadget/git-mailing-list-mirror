Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C5CD13D8
	for <git@archiver.kernel.org>; Sun, 17 Sep 2023 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbjIQTXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Sep 2023 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbjIQTWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2023 15:22:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC3DB
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 12:22:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-412989e3b7bso26335571cf.1
        for <git@vger.kernel.org>; Sun, 17 Sep 2023 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694978560; x=1695583360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bbPJEkPXQlUrv7/WIoHvsHshDcP3W0u2pazUmQn9/s=;
        b=BSpsBJsDlC6OKUJ0BG4USQRY5KdAOtr6NXSXjQfFMiKieSs4aqESQgamyCy4Ige32T
         HpWH/uzlfTGWI11j0ob5u1S/Qe4E48/NiynHk+8g9WbRBBy2haiJeIgSNcFf/UUhUkLU
         Rkf2Q9E7WvTxwlz3MHd+2W3CnxXj0xhCHlAZ2LDRti2glnNz7NRBQ75/x46lTcB8VNNx
         nNnJE1dUPbZc/x75H3pt1823bnITVcIGiG+reE0FjoQhpKkZz/xi7QYYMfUKkPi2UFCb
         o95vspQ0cv8VJ2fNO5CHltsLkhQ3FxYXMJN9ky/Z1JW4Ud03ftmEqyxdd8ULkO7v3Njv
         4yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694978560; x=1695583360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bbPJEkPXQlUrv7/WIoHvsHshDcP3W0u2pazUmQn9/s=;
        b=t3bWV++9v7S3ZedXTjjuJ+fpPztw6UhHPysPVniJ6m2vzxgj5E3geHhSXbA/sw43hX
         raJXpWnk5aLSMelnkJfRGMTebWV94c3fYfM7GGtM0L8MHdlTw/o5dc/5g9dJ7p7wJFnd
         xPqM1K17zEZ5pbdEMVFYRXF7Ee9jvedXQVRTR7StVkz/jDVloHADKRSVnWHMwTvJIJKd
         DWnLvALtVW1WSQwI/aphVW4YACbaY8NFypOPXXx+aM1+xIoGO9kW06QGbdCdhdE2wb3x
         JMh/Sj+oZnAvj4pf631nbgjrmFUKKo8zHtyPjbzV7qfg21N+YWEbWtW+DzEgdQefYbdX
         zyTA==
X-Gm-Message-State: AOJu0YxoFrrLK+UJ2/QLZAg+HSEOk9wFh8bEQcKgpopeaDjYhtDBZRv8
        ub4UMqAflbsPLioqQhcJ7K0=
X-Google-Smtp-Source: AGHT+IEUNyphxmywsYBXC6eEuwKfd1Saxq8s6PHzNSR1NgKY+dQfMcC0xMqGS5kp9rFMFYtnRbPeQA==
X-Received: by 2002:a05:622a:8d:b0:417:8eb5:2780 with SMTP id o13-20020a05622a008d00b004178eb52780mr9692304qtw.18.1694978560316;
        Sun, 17 Sep 2023 12:22:40 -0700 (PDT)
Received: from ?IPV6:2600:4040:266f:b900::387? ([2600:4040:266f:b900::387])
        by smtp.gmail.com with ESMTPSA id fu32-20020a05622a5da000b00407906a4c6fsm2526683qtb.71.2023.09.17.12.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 12:22:40 -0700 (PDT)
Message-ID: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
Date:   Sun, 17 Sep 2023 15:22:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] git-gui - re-enable use of hook scripts
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     johannes.schindelin@gmx.de, me@yadavpratyush.com,
        git@vger.kernel.org
References: <xmqqy1h6auy7.fsf@gitster.g>
 <20230916210131.78593-1-mlevedahl@gmail.com> <xmqqy1h5aisw.fsf@gitster.g>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqqy1h5aisw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/16/23 17:51, Junio C Hamano wrote:
>
> Nice.  Now we need to find a replacement maintainer for Git-gui ;-)
> In the meantime, I can queue this patch on top of what I updated
> git-gui part the last time with and merge it in.
>
> Thanks.

Thank you for help on this too. I retired some time ago, and stopped 
using git much a decade ago. My popping up on the list was inspired by 
cleaning out an old laptop and finding some old patches I thought would 
be useful, especially as I'd helped Shawn create some of that old 
git-gui/Cygwin code. My interest is unlikely to endure so I'm definitely 
not a good candidate to maintain git-gui.

On this hook execution problem, looking further, I find using git-hook 
run will fix some other issues in git-gui's hook handling, and that 
would actually also patch around the problem we just fixed. So, another 
patch follows, the commit message presumes the one fixing relative path 
search remains. I would suggest keeping the one fixing the relative path 
search regardless.

Mark

