Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0393C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC75D613C2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGNWck (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhGNWck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:32:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A5C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:29:47 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w1so3142945ilg.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYEvYWr3ElTy3yShNVM8+B5NZBUV1l7TLE+arZ+lcVk=;
        b=LzjrsO52MCVsI4Kk2lNeqXklvnyr80547A2XcvxWVVNKG6VGWNaRiqli4cgT9PwJKs
         0g0M4sBtY58m+Mxg3NL7t9gj/JcshqaEGBdscQD3IMy1OmUDaWAc+S4O4vzwFYEoeHsB
         Nq+6n/DUtLN1cxG9O8BvFfM7opCx5m+TGK7Z6u5aDJVIUacMkZRd3yjdPwTW3dLjZGUW
         mjKDbB4FD+wmQxuLXIMl5p9q2/iRkdaaTrp8YdmRHgor0KtLneS8n/Ba+Uln8doasf3s
         BnNv8KkoRUcF01n8zxvM8e3HXX8In9WuJhGk0t7Z6+iKS6GGoY1ThsbMqZbrkHwJNSup
         /d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYEvYWr3ElTy3yShNVM8+B5NZBUV1l7TLE+arZ+lcVk=;
        b=geM4E48BFKdJVfQ/qp3TQTWRGp9QHy1dLZboggAUTuWqbAvJDzreVZ+M0ip4BThpK5
         0MbbxQjjKRS7Q1z/My4TMkJqJ+2owCfT4NmWkxXLKrAAZaco60ng+bEw+ghJqn8yV/Rf
         g+++Npu1aHbEbfMw2C19zjZ8xmfaaOShd0DSNfSFQ4EH/CEJtnyZRdfnbrX3YZvWKkzS
         xdNSyFHoXPvBm4SMmQyg+wNIGrTo5gOJmWwUFoIipimmGvoC1LdNk0bK32HjD5E09WTB
         Wr8qicWa+RasohK2Tq1G2+6BCakFhiFnabN3hwAmnMuW/Tu0bLnzxdYA4Csiia7zypdH
         PFag==
X-Gm-Message-State: AOAM531Bk1iHVIAv/tCbu8V4YgqolTweG7UdwRK1dxWWsk207i1g2Wuz
        XhKLLZsGleezazvanntuD0qTQA==
X-Google-Smtp-Source: ABdhPJwqN4hCTPu+oVU4i7++KZZTZnzzTQBljGAXHoZd3n2Z4t3MglwJ6+H32auml5N5U4U7emtYTA==
X-Received: by 2002:a92:dc4a:: with SMTP id x10mr100921ilq.166.1626301787046;
        Wed, 14 Jul 2021 15:29:47 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id r8sm2005817iov.39.2021.07.14.15.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:29:46 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:29:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>, F@nand.local
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci(check-whitespace): restrict to the intended
 commits
Message-ID: <YO9lWk4NVfe/yK8Y@nand.local>
References: <pull.995.git.1626300577.gitgitgadget@gmail.com>
 <b63a5bbc63ba17449a91913ab28c268db5fa3650.1626300577.git.gitgitgadget@gmail.com>
 <xmqqwnpsttx0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwnpsttx0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 03:25:15PM -0700, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Unfortunately, this means that we no longer can rely on a shallow clone:
> > There is no way of knowing just how many commits the upstream branch
> > advanced after the commit from which the PR branch branched off. So
> > let's just go with a full clone instead, and be safe rather than sorry
> > (if we have "too shallow" a situation, a commit range `@{u}..` may very
> > well include a shallow commit itself, and the output of `git show
> > --check <shallow>` is _not_ pretty).
>
> Makes sense.
>
> As long as you have pull-request base, I suspect that you could
> shallow clone the base and incrementally fetch the rest to update,
> perhaps?  But I do not know if it is worth doing so for a small
> project like ours.

Agreed, and...

> >      - uses: actions/checkout@v2
> >        with:
> > -        fetch-depth: ${{ env.COMMIT_DEPTH }}
> > +        fetch-depth: 0

...I wondered whether "fetch-depth: 0" was the default and whether or
not this hunk could have just removed "fetch-depth" entirely. But the
default is "1", and "0" means "fetch everything". So we really do need
it.

Thanks,
Taylor
