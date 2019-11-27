Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EDC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F7120684
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tb/qYbH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0Pbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:31:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36304 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0Pbz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:31:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2120643wma.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=h6ma99dQ8vr9p9XoOw7Z/B5qatJzGFzG5BY0aKtdIe8=;
        b=tb/qYbH5qOMd/6SwtWZtZpl487/rscCO4iTczh2f2zyFfrp3S8+J3IzNLrTUwd3muW
         302DT7ePbD/Z/gu5+t8LFsSdVg4A1CUgdNSxEA9lphAxqvMKZKB5HFRdDzQjyl+38XqF
         7l6sPRAbl5tPDtJoIVu5eS4nh/39/HrBdT7uJyGcz7y5V17mBNUezr1Lt1FOlNztHYl1
         1/RoXgbdlxJhfhAO52ukglKX9oUf8RLBOzfSPyQpcKTya9C+rYbUMCCnsSDNjfmnXCS9
         W93bFPwkDngXuqdz2+pBA3gmlC6/47qUF58dwFlg6aeyVAP9zlPvG7LfmrP+dw/XWJnf
         bGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=h6ma99dQ8vr9p9XoOw7Z/B5qatJzGFzG5BY0aKtdIe8=;
        b=T3LO8n1JApX5P2qgr4VnA9ABS486tHwSVm01+iKMoreTOAHLW+lXEzg6+gbT9sk6rD
         3qbCH0qf5VL/PlIuQMv3kWPEtRwrmEysuiS3P4qGo7Ocwue3fydYN4DCOfD5OUOxSwFS
         Mf1h7zBMVIh/F8cCj29sGYLaCmOYJD5EhZFO5yUus3lrNF9AfuWapl0wyUrkiCvnYEpE
         xlQeiXT15eEXM9PGIhhjyyLvao+muiZvTMLBoLGPpACV9iuf03wqrkIvlbvBnTqT0yL4
         mDpdYoiMr1+BOxPla9Iq0hL3oEseo3pTDLbVOMnlP444JYeGYgpzqCn6MCRV5ers15q9
         XULg==
X-Gm-Message-State: APjAAAVQLqQ/4Dmc7Fo5tKpReoftuPEFMwbiC+saPNpR1IIAyIW8GGHt
        AbUGjVj6MtHDGilpnA/KPzw=
X-Google-Smtp-Source: APXvYqxuDmsY1lgxuPRgHHwhltVc7IlUEia39EadFjRWD/YSzDiG24XIu4k+N/B3aOMnhKYy3pN1aQ==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr5168454wma.89.1574868713115;
        Wed, 27 Nov 2019 07:31:53 -0800 (PST)
Received: from evledraar (h53132.upc-h.chello.nl. [62.194.53.132])
        by smtp.gmail.com with ESMTPSA id o10sm7119480wmc.42.2019.11.27.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:31:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Git at SFC <git@sfconservancy.org>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: This list is now also archived on lore.kernel.org/git
References: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local> <20191120195556.GA25189@dcvr>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20191120195556.GA25189@dcvr>
Date:   Wed, 27 Nov 2019 16:31:51 +0100
Message-ID: <87woblnxnc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 20 2019, Eric Wong wrote:

> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
>> Hi, all:
>>
>> I used Eric's public-inbox.org archives to set up our own copy on
>> lore.kernel.org and identical list archives are now available on that
>> server.
>
> Almost :)  I forget it exists, but there's the "gmane:$ARTICLE_NUM"
> altid mapping search support on my server for legacy gmane URLs.
>
> Instructions to set it up:
> https://public-inbox.org/meta/20160811002348.9719-1-e@80x24.org/
>
>> I spoke with Eric and he recommends that official project documentation
>> starts using lore.kernel.org/git URLs in daily use and git's official
>> documentation in order to allow him more freedom of decision when it
>> comes to hosting his equipment. The URLs at both domains remain the
>> same, e.g.:
>
> Yup,  .org TLD renewal costs will likely go up and I won't pay
> higher costs to keep .org domains.
>
> The system running public-inbox.org (and the recommended
> onions(*)) will stay running and will have bleeding edge
> code on it.
>
>
> * Accessible via Tor, no need to depend on registrars:
>   http://hjrcffqmbrq6wope.onion/
>   http://ou63pmih66umazou.onion/
>   http://czquwvybam4bgbro.onion/

I think it would make sense for the Git SFC arm of things[1] to consider
taking over the public-inbox.org domain rather than letting it expire
(of course contingent on your approval) and turning it into a CNAME (or
other redirect) for lore.kernel.org.

We have a lot of mailing list and some (~130 commits) git.git commit
references to that domain. It seems like a worthwhile expense to me to
pay for the renewal of it rather than having it turn into e.g. some spam
landing page as the registration expires.

1. Disclaimer: I'm one of the people who'd vote on making that decision
   if it came to that, but this E-Mail is, as they say, just like, my
   opinion, man :)
