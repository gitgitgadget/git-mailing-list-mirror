Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF22C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CF761154
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 04:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhGKEk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKEk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 00:40:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA462C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:37:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q10so12849885pfj.12
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 21:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/uo0fm/y76DqwU8pL0VvasgCGi2lVjHdnIEkK1cDfg=;
        b=r4uxoTBAQJ2pJDKlm0XxsU5N/hu/JHGkLpoOykp6dij61TT3FRxoPFkNP0B6pF12QX
         j65x4Lf+5fXHEKyvlOK/NmR6bTaNWvmb8GXTi84K23Qfrp0PJBmCAz6Y3NHbmsxVucoe
         rl6ZU+eYefCYVsnsTRMjdohpM0BHwdNqZhHzTO0rZuJ+nfvEztTkC2chaOpy61F2L4fK
         v4zX5tirCKwLV2v2Q4mveuS1yhD0uGPzij2mYy6zPVxSxW9qFhSS9QfZ3z3fgBaCkUj9
         PpuyH3EgPkJVe3XHUOG2EEViK2FbMuFtoN9NKTHkzLlfrOR43jDFSSp2uYobXlqjhafu
         VS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/uo0fm/y76DqwU8pL0VvasgCGi2lVjHdnIEkK1cDfg=;
        b=FoqT8Ppmy0EmKGwGyRtWeybH75/YvY/uaOOp1yWvOZBaklr9DED5xQ4/N4EfgOG2/s
         L1s9MLR9ljPnxyofgZc2UQzRKes14mRxTaZ8ThS66uOmQlAVDW2ylNhvEZCdv91/ghIk
         BNfAYuDhBcINe3aLPktdcktDG2A99O6HxGciFX3ihJYQPZVJopD/Y9XKX5NR6JP/1ADJ
         Ia9XSSoGDRty/ioK8oZhyQb3zY26uA//9htWhjHzkRh9hjv7pXWFDoDX+ndnK1Uq+gOb
         sQUAeeboSgs8Ck3uQQ0zQ6C8EaxDNGp67FURtpW+bZcY37JwGRdt9X0loxaVm/M7SCpc
         m/2Q==
X-Gm-Message-State: AOAM531rM3YV/j1FBGUtwhXKTsKVyzci41ToriHKdUyeWCHWI9E+f+Xc
        a50IGb8GHssYUFBYvVWSMOW9htZJitY=
X-Google-Smtp-Source: ABdhPJxh7d/V1gv6Lmgj+ZAQsHP/Q7tO7XWhvuJehYlSSwYfcO2haQ7QHZzkLPEEEIxgnm7JwwOPfg==
X-Received: by 2002:a63:d709:: with SMTP id d9mr47366572pgg.337.1625978259126;
        Sat, 10 Jul 2021 21:37:39 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id j16sm12571213pgh.69.2021.07.10.21.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 21:37:38 -0700 (PDT)
Subject: Re: [PATCH 1/3] doc: clarify documentation for rename/copy limits
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <450310cd-7b01-58f5-1f74-739d61db97fa@gmail.com>
Date:   Sun, 11 Jul 2021 11:37:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/21 07.46, Elijah Newren via GitGitGadget wrote:
>   -l<num>::
> -	The `-M` and `-C` options require O(n^2) processing time where n
> -	is the number of potential rename/copy targets.  This
> -	option prevents rename/copy detection from running if
> -	the number of rename/copy targets exceeds the specified
> -	number.
> +	The `-M` and `-C` options can require O(n^2) processing time
> +	where n is the number of potential rename/copy targets.  This
> +	option prevents the quadratic portion of rename/copy detection
> +	from running if the number of rename/copy targets exceeds the
> +	specified number.  Defaults to diff.renameLimit, or if that is
> +	also unspecified, to 400.

Why not just defaults to diff.renameLimit if the default for it and -l 
are both 400?

-- 
An old man doll... just what I always wanted! - Clara
