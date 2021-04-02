Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58232C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 05:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7E26108B
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 05:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhDBFc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 01:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhDBFcz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 01:32:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701CC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 22:32:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so2949418pfn.6
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x7NvXUmpNNOyHhG4JCsTaQ/lj2hVHQ9pechFwUt1x84=;
        b=MPL1NR4Ra+QvTxIqTd2VfFCAkNGCjamDoTNtv9KDubN4GWqqAF6RdxSwsYzCnQgiyi
         HiT+XIUo3gIVLgLmZOANMa2XOTBqlYrl7liIEY8lPHogKifEberW/lJs7xkzLyhbts6z
         ydW74Li6hw3s63IMH+FXBhvP9POOxKdN5IF2SwKVfNtKREG7Cjc35d/CaKclzcefDu0Z
         5srfCecwBTcLDHelXoXNpHudxnwu1dG0pvQangnyEduc1QWB2wQxvzBcuoezgS6HI6Ot
         LZlC9CcIjuD0Q58lQn7LgCM6O2DEkCWd9zQxyzwBtBqnBinFxQcYYafp5Xp8KO/peVVW
         BNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x7NvXUmpNNOyHhG4JCsTaQ/lj2hVHQ9pechFwUt1x84=;
        b=ZcZmrQ3hd4ZngWjemOVvrC9AxnhiwaG+04g9CxrWTxqi0wnZaqbu3ee8jffBFClaas
         EQ2/i3tWA4GM/CeN1B3lNZ7uwgv9+DbBC0mogTfLpE0Hgcb0vXycV7RqXTKL2EFCv7jS
         4kgY+tjUp/Y3+loFAPtMnuErFD+QUGWwK7rVZkgP6PGEm7tMaaIeRs+kwMCgo9s21yzW
         3iu0W1sVOrgAtn0CsOT1LDFNW33I1XNiqGP4VS9r1d+TK9kJVcSWNJ5kEarDiYBY0K7o
         XSs2Mdrm+MRcLfazN+QNeEVt8g9LcKI9Q6QPLDwPNDgdjqXsvS0X4dXWRACp6ZjGAmUM
         KcQQ==
X-Gm-Message-State: AOAM532gFQNDEnS8Tx+3JyyJ/qjzT6wziShOiafWY0s/uAWUZA3t6gta
        03P6tzJhFxIyma3ejg+OwayojdeP3NkzNw==
X-Google-Smtp-Source: ABdhPJxW1pbW4wNY6hgH0c8NaCvyETvRytQ3UHfiu+b0whkgSxUIdCjYqlD3IOoDuyyidIA7t2sNzQ==
X-Received: by 2002:a63:ab05:: with SMTP id p5mr10522725pgf.149.1617341574588;
        Thu, 01 Apr 2021 22:32:54 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-29.three.co.id. [116.206.28.29])
        by smtp.gmail.com with ESMTPSA id c16sm6623563pfc.112.2021.04.01.22.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 22:32:54 -0700 (PDT)
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
Cc:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
Date:   Fri, 2 Apr 2021 12:32:50 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/21 18.40, Chinmoy Chakraborty wrote:
> Greetings mentors,
> 
> This is my draft proposal for the GSoC project, Convert submodule to builtin.
> 
> It would be really helpful if you could review the draft and present your
> 
> views on it :).
> 
> 
> Regards,
> 
> Chinmoy Chakraborty.
> 
> 
> Link: https://github.com/chinmoy12c/GSoC/blob/master/GSoC_Git_proposal.pdf
> 
Looking from your proposal, you seems like you're using Kali Linux as
daily driver. Why do you do that? AFAIK Kali is for penetration testing
purposes. I assumed that you know what you're doing if you use this
distro as your general-purpose distro. And why not using Ubuntu/Mint/Debian/
Arch? Please see [1].

[1]: https://www.kali.org/docs/introduction/should-i-use-kali-linux/

But anyway, because we're at Git ML, let me review your proposal:

> The following helper functions would be required to be implemented● A function to guess the directory name from the repository string.
> ● A function for normalizing path, that is, removing multiple //;
> leading ./; /./; /../; trailing / .
> ● A function to check for tracked directories properly as pointed out
> by Kaartic Sivaraam on the thread:
> https://lore.kernel.org/git/ce151a1408291bb0991ce89459e36ee1
> 3ccdfa52.camel@gmail.com/.
> ● A function to check if the path exists and is already a git repo,
> else clone it.
> ● A function to set the submodule config properly.
> After implementation of all these helper methods, the main
> `module_add()` function would be implemented using the helper
> functions listed above as well as those helper functions which are
> predefined.

I know these helper functions will be required for porting `git-submodule.sh`
and used by `module_add()`, but do you have any justification for these?

Anyway, I copy-pasted the quotation above from your proposal in PDF format.
but when I pasted it into text-only mail, it looks rather ugly.
So next time when sending GSoC proposal for Git, I would like to see
proposals in Markdown format (as well as PDF) for the reason above.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
