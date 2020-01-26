Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5744EC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0220720
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 14:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0eQ6V/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbgAZOJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:09:45 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35218 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbgAZOJn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 09:09:43 -0500
Received: by mail-oi1-f174.google.com with SMTP id b18so323346oie.2
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 06:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZLLOIumSe3jv1v/XSi+8WDvrtAs3PHKC8SStGFHE+E=;
        b=r0eQ6V/9fwPkhIS4pjKzWDRlKN6O2yzQMRbnl0BWPL7KUT0w+1LpZB949PENtAFdE0
         eKZNWh4jmjXeEYHjnNMpZGCxNrQxN+MIjO5ZPSmDxV9KPkaM3xzrQDyqcD9V7o2FaIMp
         TqJ7z/SHAmoipR7iTraHM0JyNB0l4zQ7amdg2uGdhDk9Btbz3A56yiCi0KHw6Whnaunu
         40fkw0D3GcSJuB0iI/ap1y0n61ecq7i83tg8V2cLQGyHhcmixWnhHNTvkpppZMyl0WsZ
         sDYrnIp0q/T86gL/C9NqpjS//l+x85BJVq4vu6RvuAJ/BKqD1s92+UNLdNCSjfNOFuy/
         kiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZLLOIumSe3jv1v/XSi+8WDvrtAs3PHKC8SStGFHE+E=;
        b=DiPJ//yVQjCgRyi6wNwFVRbvwsmm4G6Bk50YTv0Py+RFAvV8UfLUv3XNglUoTbww7s
         vkZx1ILkK4qK9wrexHCZlUpaLaOteeSnvQ1mi+uW+wHYCbt0iIEaFHAaPGSk23yOme/2
         w7XeJVgfhfdfd7c/zEwNE60S6AifwgOoZa9CF6WBGBgMBJrN5dzno7/C9Nj1f682oRJk
         Gvdpi+64y8zWkf7wTu8w5W5zMkn9jbxWL/hzpk82Zk4lMG2gQo1XAlPETcxYhqHoOBfl
         /B9cIrUiWnn1DvyKBOwNNAt14TT+YSGKqTG1IS+etAgHuz0jMjWJsKzIbfldLIZi86wc
         yCaA==
X-Gm-Message-State: APjAAAWyB4voQiCk83b/8OIExQeaUlcYUPkSBpHst+CWilHMejRMZBP1
        6Oc5RsU6N6ms3iZ8alpB2Kb6EZKcavE=
X-Google-Smtp-Source: APXvYqwErWV6tKeYkdQ15a0n5AtxcRfpUrk5rBAdQ9kISvceTS9E3bc7frdZoenqN3HWrE+/IIECCQ==
X-Received: by 2002:aca:5083:: with SMTP id e125mr5036452oib.96.1580047782393;
        Sun, 26 Jan 2020 06:09:42 -0800 (PST)
Received: from [192.168.1.76] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v14sm4347301oto.16.2020.01.26.06.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 06:09:41 -0800 (PST)
Subject: Re: Sparse Checkout Trouble (2.5.0)
To:     Elijah Newren <newren@gmail.com>
Cc:     JunkYardMail1 <JunkYardMail1@frontier.com>,
        Git Mailing List <git@vger.kernel.org>
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
 <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
 <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com>
 <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <de300697-baba-62a6-ea4c-c5bd472954c2@gmail.com>
Date:   Sun, 26 Jan 2020 09:09:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2020 3:59 PM, Elijah Newren wrote:
> On Fri, Jan 24, 2020 at 7:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>> I'm CC'ing Elijah because he also made changes to dir.c, and
>> perhaps he has some idea of what's going on.
> 
> If you think it might be related to the dir.c changes, I can take a
> look.  I don't have any immediate ideas off the top of my head.

The only thing I can think of is that these paths are already
marked as sparse, but something is requiring us to test if the
path can be created with the filesystem. I'll try to debug
more into exactly where that is. It's telling that this happens
both in cone mode and without.

> However, since I'm really suffering with "git read-tree -mu HEAD"
> being the mechanism for updating sparsity (for reasons independent of
> the issue being discussed here), I've been tempted to dig into that
> anyway to write a replacement without the nasty side-effects.  I'll
> take a look early next week and see if I can spot anything.

If by "nasty side-effects" you mean "overwrites staged changes, even
if in the sparse set before and after" then I would welcome such a
change. Otherwise, it will fall to me, and this is far outside of
my expertise. Of course, it is something I should learn, but I can
learn that during code review, too. ;)

Thanks,
-Stolee
