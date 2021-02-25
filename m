Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96FC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D55864F0E
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBYNjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 08:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhBYNjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 08:39:41 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17A7C061574
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:39:00 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c1so4060653qtc.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XwuOaZQs/3qxcOywgUmCM54banPDOrQ9ZqLT224+mVo=;
        b=GDaIff+JO6OCbOgI+tWGVs8VAuJneJtvZJOQ1revPnjJ/Trp5RayU0jhc1ccdZsXlN
         I13ZYYdyXQKz8vQBmDzXXp467DINK1KPZfp+kyt8Ms/NlqT61LlgRbDiZTsTgiwtFWyN
         S6r+iDEQVNoV9GoYhzinwzcWHWJamSyfguEXCwkfzlKsEfEHbVNKD1UxgbtNNSjIhlj/
         yW2tPoKmBrEd8VTJivr6AHYGb7plevVBAnpbCdjqv5FNG/4QTZyMvqYeV9GAya0Ol+pu
         +xANKlFyKdBCjujC3jPlNJFrJAhyrf+ov8XcddVNAx2ro06RH87KNcxVxX7eNfkCGJob
         MAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XwuOaZQs/3qxcOywgUmCM54banPDOrQ9ZqLT224+mVo=;
        b=lmBYSRCsaYZvASnaWAVpcKo764XiHMjjTPY1bPKtDjksffTeNxX8pS8Lf3bR+obbJi
         qddM19/TPLridTRs1e05ihVpk56zr2EjFbM+Ye6j6Sq8vLUXtrx9VYUmOqLNrME656zw
         3tQa6JzrSeMHzOnZYvGZs0QSD8XsWEguBw6Zs/Ly8lftaL5hZWW8kejifKdY0I0Jov/s
         J2HaA3UQ2noa80yOtFeaOPeCSjmoGAY+Jgn987IQpr+hkreviH48xgomoynYDL/pvPwH
         Yjd2/TwnYKNqNxkQzKQynsP2T9fnvx/SEa1q0UgbqaWOBv4/C0n6SP2aEeyVyAq7TLHg
         N5mw==
X-Gm-Message-State: AOAM5326jZNwciVzBFEfgiakWVEdVdVfiFTRHFkTDSY24bDnClZJCD27
        SR0hYYAM5ttr4UAczYay0SU=
X-Google-Smtp-Source: ABdhPJxN/LsEBEOnp/jirAkFCcjV4gLnCSChruoTA8IY+NIh1lpKfKlWmlKyegwjZhSmxLCMxsTToA==
X-Received: by 2002:ac8:518d:: with SMTP id c13mr2373803qtn.284.1614260338957;
        Thu, 25 Feb 2021 05:38:58 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id t71sm3930761qka.86.2021.02.25.05.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:38:58 -0800 (PST)
Subject: Re: [PATCH v4] clone: document partial clone section
To:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
References: <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
 <pull.745.v4.git.git.1614244436547.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <caf0fa50-6c2b-7764-1114-d933b2a06061@gmail.com>
Date:   Thu, 25 Feb 2021 08:38:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <pull.745.v4.git.git.1614244436547.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dyrone,

Le 2021-02-25 à 04:13, Teng Long via GitGitGadget a écrit :
> From: Teng Long <dyroneteng@gmail.com>
> 
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation. Add a relevant section
> to help users understand what partial clones are and how they differ
> from normal clones.
> 
> The section briefly introduces the applicable scenarios and some
> precautions of partial clone. If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>      clone: document partial clone section
>      
>      Partial clones are created using 'git clone', but there is no related
>      help information in the git-clone documentation during a period. Add a
>      relevant section to help users understand what partial clones are and
>      how they differ from normal clones.
>      
>      The section briefly introduces the applicable scenarios and some
>      precautions of partial clone. If users want to know more about its
>      technical design and other details, users can view the link of
>      git-partial-clone(7) according to the guidelines in the section.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v4
> Pull-Request: https://github.com/git/git/pull/745
> 
> Range-diff vs v3:
> 
>   1:  681c5dcb7904 ! 1:  6d543cc11378 clone: document partial clone section
>       @@
>         ## Metadata ##
>       -Author: Dyrone Teng <dyroneteng@gmail.com>
>       +Author: Teng Long <dyroneteng@gmail.com>
>        
>         ## Commit message ##
>            clone: document partial clone section
>        
>            Partial clones are created using 'git clone', but there is no related
>       -    help information in the git-clone documentation during a period. Add
>       -    a relevant section to help users understand what partial clones are
>       -    and how they differ from normal clones.
>       +    help information in the git-clone documentation. Add a relevant section
>       +    to help users understand what partial clones are and how they differ
>       +    from normal clones.
>        
>            The section briefly introduces the applicable scenarios and some
>            precautions of partial clone. If users want to know more about its

The "range-diff" above is automatically inserted by GitGitGadget and shows what has changed
since the last version you sent (i.e. it compares v3 to v4). So you adressed Junio's comment
about your commit identity and signed-off-by identity needing to match, good.
You also adressed my comment about the wording of the first paragraph of the commit message.
But then I wrote:

However, you did not address all the feedback I sent as a reply to patch 3/3 of v2 (see [1]).
So it would be good to send a v5 with these suggestions incorporated (or, if you do not
agree with a reviewer, you should still answer them and explain why).

Cheers,

Philippe.

[1] https://lore.kernel.org/git/B90939A5-5693-4EB6-8F07-5B50F63B3143@gmail.com/
