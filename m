Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B47C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8C260F11
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 14:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbhIAOEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbhIAOEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 10:04:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104BC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 07:03:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m21so3028923qkm.13
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wCG6Bir0BytTsVcsraPc4WUBBWMVARmzsklczcTU8jk=;
        b=DlkOrOmemoGfXUQkGGCe6rfwr8lAcGbI6CFHpyaU099DqDnfrXMGFufdth5Un2AVKY
         TgUhGlGtCvarbHvPtNe4kechKwe/KaksejC8o3uk8VuU80ePEz/rXHxAy2kesdg1Q1dY
         +Ab/MTxxyRQUpFV6czoWAs+UnBkjzc58ntJhr7FXwB6M5Yr7E5e+yl7aAlif0IlhyrG2
         dKzHAzEeoPnFH93VC5eg79jxmrKg40v1Fo4JHWIMCU6XIXGE+x7cvK3HLjp6oxkgaIbu
         yzCH1/gSVAcXDfFMUfX5LqQu8SLk0WSA6Gk4MuCyUF8e0EuF5X7+HoY8sUYytCcOdhY/
         aI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCG6Bir0BytTsVcsraPc4WUBBWMVARmzsklczcTU8jk=;
        b=lqqVVqY21zvvU0PKlqXnnae1CJg6AQ1908SZ9aPfyRJjiElqhojc9bKUuW97EUFlMf
         /kptnn15IgFY28wBD7Z/wIXSNvpu81vj2ssvzZkajw+4Bvaa0/ohVPg1LsF1M4gDWXqA
         GSed3NWRxcW1YaZDpKxvF5Sub5KQa95l4bHbORxnffVvzBrauxi0begbqYhy/gtlfpf7
         BWFij/DxbCThY0tkoaSR9Zn9IwccQseJfjk3uh6plrZ4eRXBRQDTKBtLuUF0/dsbQPu/
         z1OyHkiIhW9NFS1XK7f0AkCObMOGlzhD5VmNOqIwtBueCtUbSgnJp2H70qNitquYZnOf
         RgUQ==
X-Gm-Message-State: AOAM532T0gsy4h2LVolEJFBnuS616je1Qd5YSh0/Q7YTxCwOu1coAKeH
        cnSwNvAH3bR1Pf/AVAXhtZg=
X-Google-Smtp-Source: ABdhPJwgmkszpwuI/yKbUwqEldHAJ8kRUIL0s5iPYHGN6Fh+w5RWvHw5lNze8efun80aqfD1z1VwJw==
X-Received: by 2002:a37:9b93:: with SMTP id d141mr8578450qke.236.1630505025419;
        Wed, 01 Sep 2021 07:03:45 -0700 (PDT)
Received: from [192.168.66.137] ([142.46.68.231])
        by smtp.gmail.com with ESMTPSA id x8sm12254976qts.69.2021.09.01.07.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 07:03:44 -0700 (PDT)
Subject: Re: BUG: `git commit` adding unstaged chunks of files to commits on
 2.33.0
To:     Andrew Thorp <andrew.thorp.dev@gmail.com>, git@vger.kernel.org
References: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b1c3a0ce-dc27-9e3d-f1c5-7fe1e0ae2e53@gmail.com>
Date:   Wed, 1 Sep 2021 10:03:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew,

Le 2021-08-31 à 13:15, Andrew Thorp a écrit :
> Hello all,
> 
>
> 
> [System Info]
> git version:
> git version 2.33.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Thu Apr 22 21:46:47
> PDT 2021; root:xnu-7195.101.2~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.5 (clang-1205.0.22.9)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
> 

As I read downthread, the behaviour was due to your pre-commit hook.

Normally below the "System Info" section in the 'git bugreport' template
there should be an "Enabled Hooks" section, which does not appear above.
I would be curious to know why; I'm guessing you ran 'git bugreport' from
outside your repo and so it said:

[Enabled Hooks]
not run from a git repository - no hooks to show

and you deleted that section ?

I'm thinking that maybe if the 'git bugreport' template mentioned upfront that the
command should be run in the repo where you observed a bug, maybe it would lead to
fewer back and forth like in this thread ? (CC'ing Emily who implemented 'git bugreport').

I've sent a PR [1] for the web site so that this is also mentioned at https://git-scm.com/community.

Cheers,
Philippe.

[1] https://github.com/git/git-scm.com/pull/1629
