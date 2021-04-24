Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB5C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 05:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B30611BE
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 05:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhDXFTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 01:19:23 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:41792 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhDXFTW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 01:19:22 -0400
Received: by mail-ej1-f49.google.com with SMTP id mh2so55205929ejb.8
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 22:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbheiMaaoY5Fab6wK9jxrGtAEXWDOosrXO10/a6/4QM=;
        b=l4ymFl2MD8GZhF+/yEygDF2+u65oE4ZTp3KFo5YnDXNYmz2jZerYJuV0LKNde+jTnT
         8JNnVdyUVmO9Bfl+jHeGXHCWiyYbfVT2vv9QTioSmXL9EQUGC6kfyblwWwUHVPzJ4cI/
         AxXMVMOifzD2mwgiBZi5KctyHCytwjecdSG1MU0t3b3lBUN9I36zbR7dKRv9oY+TR/Xe
         zlhc3qWAfI+WjZF+/awQkiqial/sR2fSLDSTLM9Mmr0aiHnUnKkNldxo5OMxl1cTp8/v
         i0on90GuBbFw0rTMGiyepcqGGS8F38Hg9CXsy0Iz2KbljYjUZfwyItVH2WpDYUxhNc2E
         j2lg==
X-Gm-Message-State: AOAM5326YwtnrszrflN53gj1hQSYGuz/+mJwJhRJ7FNc3PdLLa1S31j2
        rgt8rc2r6LSetHkg9MEP9wD0wpUlrcTfQIJMC5w=
X-Google-Smtp-Source: ABdhPJzSVLryjuoHfEhUwv8jR+CYJcNMTQFgGyC1g/nv8QKC2k9Lh7fQEN4BvAlfLmhamhHtwlVsuecw9zILvH8Loxo=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr7785955ejd.168.1619241524308;
 Fri, 23 Apr 2021 22:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-19-lukeshu@lukeshu.com>
 <CAPig+cTb-h=Qb9asvh+MVH2s5uj7szP_QOPpcm1bqdE6DK9V7g@mail.gmail.com> <87zgxoa7cj.wl-lukeshu@lukeshu.com>
In-Reply-To: <87zgxoa7cj.wl-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Apr 2021 01:18:33 -0400
Message-ID: <CAPig+cQ_7eVgdYuci1JeVwU89VOeOU6kzZ9=yw1ySR9RXzjuTA@mail.gmail.com>
Subject: Re: [PATCH 18/30] subtree: use $* instead of $@ as appropriate
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 7:50 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> On Fri, 23 Apr 2021 14:40:31 -0600, Eric Sunshine wrote:
> > Nit: I have some trouble following what the commit message is actually
> > trying to say with "smash things" and "separate strings". It might be
> > simpler to say merely that use of "$@" in these particular instances
> > is overkill and possibly misleading to readers not familiar with the
> > finer details of $* vs. "$@".

Oof, I somehow misread the code this patch is touching and ended up
confusing myself, and the confusion bled into my review comments.
Sorry.

> How's this:
> ---
> subtree: use "$*" instead of "$@" as appropriate
>
> "$*" is for when you want to concatenate the args together,
> whitespace-separated; and "$@" is for when you want them to be separate
> strings.
>
> There are several places in subtree that erroneously use $@ when
> concatenating args together into an error message.
>
> For instance, if the args are argv[1]="dead" and argv[2]="beef", then
> the line
>
>     die "You must provide exactly one revision.  Got: '$@'"
>
> surely intends to call 'die' with the argument
>
>     argv[1]="You must provide exactly one revision.  Got: 'dead beef'"
>
> however, because the line used $@ instead of $*, it will actually call
> 'die' with the arguments
>
>     argv[1]="You must provide exactly one revision.  Got: 'dead"
>     argv[2]="beef'"
>
> This isn't a big deal, because 'die' concatenates its arguments together
> anyway (using "$*").  But that doesn't change the fact that it was a
> mistake to use $@ instead of $*, even though in the end $@ still ended
> up doing the right thing.

This explanation spells out the problem nicely.
