Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24015CA0FE1
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 13:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbjIANTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjIANTY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 09:19:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7B94
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 06:19:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so19780745e9.0
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693574359; x=1694179159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=if+6yiFaFZRb+R3ORbcDpl37fwCI9fefNImpSPenp28=;
        b=e02WVLvB1DH6/YrULSqb89cvqRltjR8kaEBS5WB1FoysHNoZNLFyi7nBj+UtheiCWC
         2PmfDHKIYEvt9k3aU+X6lM/ygHf8Qp/kHiJ19kP6AAvxZLz9888fIYYKajJixba6vorG
         Y4qQsRgBZ/r0379vPmPa3ihcu35AKftWEoGv+XPJUrolkeNPOUkt4uKIjJLruBKXMU7A
         s5uvOxgvq30RyiPga+/VyWBVzFCGHfAteN0w3aQs29VVBZwCY6TjVuTLIjLPnh1+tgva
         Zu5Dtj54RgeMwg6hWbaf6jkIUSdJOBuMBfY39xtyJS3UT+wnSWDjhc0g84kU50o6kIT6
         fOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693574359; x=1694179159;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if+6yiFaFZRb+R3ORbcDpl37fwCI9fefNImpSPenp28=;
        b=KjsR1B9T4CtzscGEbhtNXbd80t7WNPuJrXYZjsF+fbDISxH+hwaWmwTb4ixOHmAM+/
         JWhZ0LB3dxoaXFfmzXyoxIPFgqwi/8xkqOQSQQOERocVIWl33k+5jpFAVN1aEIzK4zzn
         nPjU6qyZ+bT1VfAxh3PIs1p303YLlCZqCBLF0yA8WFINbLeyv8TjhDZu9peTJxPjimkK
         tOEIvSHyR0YofmXwt7Y+x8f8BNahpu5mmGnICBGxkkO8yXZIDpaXIE7+5xh9YAPHd39o
         PObSnZQNptOyEMTDyjz7QNcKGMmzQ8mLpj1DgT1fr31Hd5e4EBconFQt0L7isBSOUuTI
         g6mw==
X-Gm-Message-State: AOJu0YztVUp83zKzo/CZGSmATm9WVw+A+8b/XbkavQpd1FNMO6JnEd6q
        lp4gO36U0r0vYVknzx9ukwNi0IOPh/MXiQ==
X-Google-Smtp-Source: AGHT+IET0SKvXIoAp8Tics57RK5PHwE70EW+i+hY8kHjwGFFZh+tsO3Zd0eTIpxxZw4nbkfUya3f0A==
X-Received: by 2002:a05:600c:6010:b0:401:dc7e:b688 with SMTP id az16-20020a05600c601000b00401dc7eb688mr1739469wmb.6.1693574358994;
        Fri, 01 Sep 2023 06:19:18 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k15-20020a05600c0b4f00b003fee6f027c7sm7931668wmr.19.2023.09.01.06.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:19:18 -0700 (PDT)
Message-ID: <6127b570-5e9b-404f-9802-9135a1c9f31f@gmail.com>
Date:   Fri, 1 Sep 2023 14:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing without
 a forkpoint
Reply-To: phillip.wood@dunelm.org.uk
To:     Wesley Schwengle <wesleys@opperschaap.net>, git@vger.kernel.org
References: <20230819203528.562156-1-wesleys@opperschaap.net>
 <20230819203528.562156-2-wesleys@opperschaap.net>
Content-Language: en-US
Cc:     Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20230819203528.562156-2-wesleys@opperschaap.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wesley

On 19/08/2023 21:34, Wesley Schwengle wrote:
> When commit d1e894c6d7 (Document `rebase.forkpoint` in rebase man page,
> 2021-09-16) was submitted there was a discussion on if the forkpoint
> behaviour of `git rebase' was sane. In my experience this wasn't sane.
> Git rebase doesn't work if you don't have an upstream branch configured
> (or something that says `merge = refs/heads/master' in the git config).
> The behaviour of `git rebase' was that if you supply an upstream on the
> command line that it behaves as if `--no-forkpoint' was supplied and if
> you don't supply an upstream, it behaves as if `--forkpoint' was
> supplied. This can result in a loss of commits if you don't know that
> and if you don't know about `git reflog' or have other copies of your
> changes. This can be seen with the following reproduction path:
> 
>      mkdir reproduction
>      cd reproduction
>      git init .
>      echo "commit a" > file.txt
>      git add file.txt
>      git commit -m "First commit" file.txt
>      echo "commit b" >> file.txt
>      git commit -m "Second commit" file.txt
> 
>      git switch -c foo
>      echo "commit c" >> file.txt"
>      git commit -m "Third commit" file.txt
>      git branch --set-upstream-to=master
> 
>      git status
>      On branch foo
>      Your branch is ahead of 'master' by 1 commit.
> 
>      git switch master
>      git merge foo

Here "git merge" fast-forwards I think, if instead it created a merge 
commit there would be no problem as the tip of branch "foo" would not 
end up in master's reflog.

>      git reset --hard HEAD^
>      git switch foo
>      Switched to branch 'foo'
>      Your branch is ahead of 'master' by 1 commit.
> 
>      git log --format='%C(yellow)%h%Creset %Cgreen%s%Creset'

For a reproduction recipe I think "git log --oneline" would suffice.

>      5f427e3 Third commit
>      03ad791 Second commit
>      411e6d4 First commit
> 
>      git rebase
>      git status
>      On branch foo
>      Your branch is up to date with 'master'.
> 
>      git log --format='%C(yellow)%h%Creset %Cgreen%s%Creset'
>      03ad791 Second commit
>      411e6d4 First commit

Thanks for the detailed reproduction recipe, I think it would be helpful 
to summarize what's happening in the commit message, especially as it 
seems to depend on "git merge" fast-forwarding. Do you often merge a 
branch into it's upstream and then reset the upstream branch?

I tend to agree with Junio that the current default is pretty 
reasonable. Looking through the links from the cover letter it seems 
that the current behavior came from a desire for

	git fetch && git rebase

to behave like

	git pull --rebase

I think the commit message for any change to the default should address 
why that is undesirable. Also we should consider what problems may arise 
from not defaulting to --fork-point when rebasing on an upstream branch 
that has itself been rebased or rewound.

Best Wishes

Phillip
