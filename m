Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CCC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB41061263
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 09:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWJH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWJH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 05:07:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75EC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:05:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so1807205wrm.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2N8vXwvosdM8eiP9Foxx1HAmai6Y69XYU98faB+Ng1E=;
        b=UoEmUfiS8wfgPxiQFr9VArtKVYtnqrXSwQSOUZsW2bKTwDCMxa1ZT66bWIR5SQbQtH
         gX6H3tPsCx+ddEEhkT8HK+XO+NeHTz+1WVXtsnR68LZmQg4YT2PMIDOxg4MEmkfGE7RF
         nLORA9BL16wGGCCT/95la9etNyZJIpC/t7y+yingsOt66ryunnjPxZkmfzm89lcyRuJ9
         sq8dfmi3oPqx1vAU3kqFnFWzu736aeJ4FQMSkUhdX4HfI8BcyHYXF6yMo/3gzrGejpD+
         lrFoCFqOPtd5hSm52wLM1M/YaTb7V5nsibB+LuNyExoMr4Fe/xx1olS2Ur7gcgLettT+
         2+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2N8vXwvosdM8eiP9Foxx1HAmai6Y69XYU98faB+Ng1E=;
        b=Ikp1/QUupzznRVi5uLm8Q6KxAvduXmZZu/JaXhyTZmAFGOmLIJ2XGODQ/1YHPtQhgy
         pvx2Jm5PoHzJMjVtit7+qvR5b7w6vFSy6Eyj03cF3KvzreioRTVoaMTEW896gCpn4Goz
         Am86mkVA1PPgMLeQvl4gR4Ab0dysvuTT7oeAKwc0JMgKI9nH6D3H7+OhnbcPU7dnwPGy
         SUQsMFctD8MjJEjJ7WQFN+grw57Y9YZpTHxcmXHFl6QCNVpAy9X6Kk1msnfJamROe1du
         KTJVeVRpnsstImVw+N1tVUrAasu6wOcckJCqSEOdpUk8wiiUws2L8oJHDcvd8FpNu0G6
         m5Hw==
X-Gm-Message-State: AOAM5314CCRrYCpJY9w6Q8LhO04Qnx+dERkNu1jYL0xIvQDIfKEMsMR8
        3Mrhge4sIgIGUDOKkTigd1o=
X-Google-Smtp-Source: ABdhPJx4T1BL075sdsoiX330Lf2oO+oPu/3KV3d5u9wLd1r8jrMptS6Xi6c1EoLdMELBr+wde5zX0g==
X-Received: by 2002:a05:6000:1110:: with SMTP id z16mr10195769wrw.277.1624439136609;
        Wed, 23 Jun 2021 02:05:36 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id p11sm2324643wre.57.2021.06.23.02.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 02:05:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Forcing git to use a pager without a tty
To:     Avishay Matayev <me@avishay.dev>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com>
Date:   Wed, 23 Jun 2021 10:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Avishay

On 22/06/2021 23:40, Avishay Matayev wrote:
> Hi there!
> 
> Fugitive[1] is a vim plugin that wraps git and many of its commands
> into the editor in a really awesome way, I won't meddle into it too
> much as you can read about it in its README, but as you understand, it
> uses git, a lot.
> 
> Some git commands use a pager, which is usually a program that needs a
> pty to function properly (`less`, for example). Fugitive can't really
> use a pty for the pager as vim runs its subprocesses without a pty.
> Therefore Fugitive just creates its own pager (which is a simple
> window in vim) and pastes the git command output there.

If I understand correctly fugitive is reading the output of the git 
command over a pipe and putting it into a vim buffer?

> The only problem left is that Fugitive can't reliably know when git
> decides to use the pager, for example `git reflog show` does raise the
> pager while `git reflog expire` does not. Fugitive currently maintains
> an (very possibly) incomplete list of commands that need a pager but
> maintaining it manually isn't ideal.

I don't understand, if as you say above there isn't a pty then git wont 
use a pager unless GIT_PAGER_IN_USE is set which Fugitive does not seem 
to, so I'm not sure what you mean by 'Fugitive can't reliably know when 
git decides to use the pager'

> I started discussing this on an issue in Fugitive's github page[2] and
> Tim Pope (the creator and maintainer of Fugitive, thank you!)
> explained that `git` doesn't use a pager if there is no pty so it's
> impossible to override its behavior.
> 
> We had some ideas how to make this feasible (as you can read on the
> thread) but for brevity's sake I'll present the best (IMO) idea:
> Essentially, at `pager.c`, don't short-circuit in `git_pager` (or
> `setup_pager`?) due to pty absence if a new environment variable is
> present, perhaps something like `GIT_PAGER_FORCE` which will override
> the `PAGER` and `GIT_PAGER` variables. This will allow Fugitive to
> apply custom logic through to pager to know if one exists and present
> the window in vim.

I note that the latest comment [1] on the github issue talks about a 
different solution that would cause all git commands to behave as if 
there was a pty present.

[1] https://github.com/tpope/vim-fugitive/issues/1772#issuecomment-866401942

Best Wishes

Phillip

> I will appreciate any written thoughts on the matter, thank you :)
> 
> P.S. I am a complete newbie in regards to mailing lists etiquette,
> pardon me if I've done anything incorrect
> P.P.S. I CC'd Junio C Hamano because he signed off on (almost?) all
> changes to `pager.c`, sorry if that was wrong of me (You probably got
> this mail twice because of a misconfiguration, oops)
> 
> 
> 1. https://github.com/tpope/vim-fugitive
> 2. https://github.com/tpope/vim-fugitive/issues/1772
> 
