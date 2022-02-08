Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CAAC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 14:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358577AbiBHOdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 09:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiBHOdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 09:33:12 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634DBC03FECE
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 06:33:12 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s24so13051918oic.6
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FG5OCOBU1/lNu7N1PgOkhP7LybVC6puOTUpsiBgaY4w=;
        b=WRQSEMvBWp/VLpbASILMDMYLyF9N0cV+gm5/d0XCcWCCGBz/kDBNQTjUxQG9zEUQot
         I9Qq9rHUM1zoW+jU5kpj9sDzZhSvfDhaAq/7UDDre3Sv70ukLqnw+Ihbq12PsBUtaPcs
         i0sUJ39dnk9Vs0biG9h8XwqZnL5k6xni6VGn8jRvGvwK1IGyV6zd58dk3P3NMBQpIDpB
         gctnTuHAYaBKlN5bphvQBaKdWwdEEBeWAveDnxUf7KbT0pFpdw1k/Qf+cbaQLpAF9Mvv
         iYib/2B5I0OLH0e5g24UC+UfM6+MTi/8ROuKmHvDE3oimH1FweNSu++dZGLGd+Vp5U4t
         9SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FG5OCOBU1/lNu7N1PgOkhP7LybVC6puOTUpsiBgaY4w=;
        b=afEMRGu0mmj9hwRmMdvI55/tTkOwjrS024DHKTB4GHqdCLYNIVQbA9kwFuWl5w6jmo
         N9Sdq0U8U8WOAX3Q5IS2WekhPgpvDA0EVKcubLhm34kaDHq5k0RV/aX+oz6Y6s0tTZRJ
         OUdX9BZsTtTy0Ab91jo1ngbsf5fq7QpyYXLx/5FTE/8zaFS4cLOBf+liyG4+T7JkEiNb
         4c01Z5cSFaocskjjbunAXyOYW26zPfA/BnhADOxiAcMqVuTuCmoEkJpQLyWkdhFQ0eiX
         r71kl0ACpZ9v2J3OHVMiJ06biEYHci4/pYFwa1Qtcy5hotWwjyT5pXf8InPEhtnAuEZi
         r5sw==
X-Gm-Message-State: AOAM53345Gev3mwzFi2+87wCNjj1JIb0Xzc3KcfaiVAuKb9f6g/g1cRQ
        G7O+T4yChjRCfN6HPEBNXeE=
X-Google-Smtp-Source: ABdhPJxXh7GJkFLdzwdO+w8S4G8OwPnSPiNjiC/TBAUeQFIvbOwGiFGbeWFIeIcjO9Kfddli03t9HQ==
X-Received: by 2002:a54:4583:: with SMTP id z3mr646796oib.103.1644330791558;
        Tue, 08 Feb 2022 06:33:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ac5b:5b34:9736:bce3? ([2600:1700:e72:80a0:ac5b:5b34:9736:bce3])
        by smtp.gmail.com with ESMTPSA id a10sm5199732otb.58.2022.02.08.06.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 06:33:10 -0800 (PST)
Message-ID: <9c79d950-8d42-829f-7a92-6dbbeabbdf73@gmail.com>
Date:   Tue, 8 Feb 2022 09:33:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare
 repo
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
 <CABPp-BG4m6i+yobjnD6UC5S5n3k-HbB7Y5uUNEvrD79ErOoYHg@mail.gmail.com>
 <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cT7GwyhPOBdqDDh8jGm+mWK1x9Gt4Zebcw34dgFyaufkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2022 12:02 AM, Eric Sunshine wrote:
> On Mon, Feb 7, 2022 at 11:14 PM Elijah Newren <newren@gmail.com> wrote:
>> On Mon, Feb 7, 2022 at 1:33 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> Updates in v6
>>>  * Updated documentation to use "working tree" over "worktree" and "" over
>>>    ""
>>
>> Not sure what "" over "" means.
> 
> Probably related to my review comment[1] about spelling it
> "$GIT_DIR/worktrees/<id>/" rather than
> "$GIT_DIR/worktrees/<worktree-name>/".
> 
>>>  * Delay some allocations to avoid leaking memory in error conditions.
>>>  * Use "main worktree" over "base worktree" in comments.
>>>  *
>>
>> Was the empty bullet point meant to cover the new patch 6?
> 
> The "Updates in v6" section was botched a bit. If you look closely,
> the remaining bullet points actually ended up in the "Updates in v5"
> section. The complete "Updates in v6" section should have been
> (approximately):

Whoops on mixing them up. Sorry about that.
 
>  * Updated documentation to use "working tree" over "worktree" and
>    "<id>" over "<worktree-name>"

this is the issue for the empty quotes. GGG thought these were HTML
tags, so made them disappear. I should have used `<id>` and `<worktree-name>`.

>  * Delay some allocations to avoid leaking memory in error conditions.
>  * Use "main worktree" over "base worktree" in comments.
>  * Removed use of git_configset_get_string_tmp() and added a patch that
>    removes its public declaration.
>  * Fragile variables are replaced with better ones.
>  * Variable names and code style improved.
>  * Several test cleanups in patch 5.
> 
> [1]: https://lore.kernel.org/git/pull.1101.v4.git.1643136134.gitgitgadget@gmail.com/T/#m4926177771017bbea82c33e9e03e6a9a004ebf24

Thanks for cleaning up my cover letter!
-Stolee
