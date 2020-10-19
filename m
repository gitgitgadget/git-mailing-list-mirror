Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E4FC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C4F2225F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 17:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ddhI0PgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgJSRlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgJSRlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 13:41:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CEC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:41:30 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g7so1009429ilr.12
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KRd/nQC9BE58qbzasY/qG8KheSLfKqNiYFvS1dr6134=;
        b=ddhI0PgOmSNY1m6qyLxM5Bm/zhxJNEPuCugOsrsGb4d15KC8k9LVWWD07eTmtxy+fD
         wGi2MVYN/7IYo0CDrJ4XGvkfUQHn+scs+SB0gEM2d7/bdazYmrns6lPaNqa3OistV8mS
         rNOB2OD0CzbEZ9zuKXggPL8Lg5Zjx9Xa0cwh4NQ0RMMqkiX0A0ukpnapTxy4Z9Nt9e8o
         gADJT9UdZY+MLd84CxXZDg8GODype0apMQeKCjkmHfDhyiBxuyekeqUKfVkrTkhZRKKJ
         EQq6nG4e8g3KFnt1vznhaVeUfiVk66BWkspnuynXgD6EnTr00fM4ewuLxEDLG32miQw0
         IaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KRd/nQC9BE58qbzasY/qG8KheSLfKqNiYFvS1dr6134=;
        b=crNNZ1+6+gROcGk+tdCeiSiHP1RKgL6e6aGuk5ff4Q04S5Gra9CmS0cMCL/TDen3dD
         GSTZQPQBwPY2J05U6KMWT7qAqIPVBE7M4dkj6nY+VJdDiy6SrewIlcJz91zUhyqknRzQ
         09GCK3hdsxOkwHqmZAyQWcUdPYBYdP5+UKmzuLCg5czFsmAwD/JEkIGa8rFkEsk+jBaY
         kLWqr0+6kLDXtUgHwdH2gWb8GlibqHNKE/ja3r0DoE8cVqRy1aRUtMU2JXWK53qeP1uo
         /erljRAc/MoUdIDHFQKDah0YMzO9NgloVeXcha8/Ac8RniVO4K616nO4G1rg68BCJVnt
         t3NA==
X-Gm-Message-State: AOAM531PQ8ymxfGjzTovxIVZjZJjVK98/ztehw1d67Kidv45nG/lo5lk
        3CslW1GP/pC/up/vHyKjVJ+tsnAkfDSdHWaP
X-Google-Smtp-Source: ABdhPJy0dNz5J/Y3vvkI7PLv9jxkWc+rfpdWOOdMO8044Qhw/Jc64igonHJAa82RIwQUTc1nSVNrCA==
X-Received: by 2002:a05:6e02:c6:: with SMTP id r6mr954435ilq.184.1603129290016;
        Mon, 19 Oct 2020 10:41:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:c096:f5e9:cd72:773e])
        by smtp.gmail.com with ESMTPSA id 69sm415431iou.42.2020.10.19.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:41:29 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:41:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Sami Boukortt <sami@boukortt.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: French translation: =?utf-8?Q?incorrec?=
 =?utf-8?Q?t_translation_for_error_message_in_=E2=80=9Cgit_push_=3Cremote?=
 =?utf-8?B?PuKAnQ==?=
Message-ID: <20201019174127.GA42778@nand.local>
References: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAb+AL_xObsexRXL_fZdhj2FNQsOLzEz3_mZqd1Yz7F0=-havA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sami,

On Mon, Oct 19, 2020 at 05:59:54PM +0200, Sami Boukortt wrote:
> Hi,
>
> I just noticed a misleading translation. When running `git push foo`,
> one can get an error message that looks like this:
>
> > fatal: You are pushing to remote 'foo', which is not the upstream of
> > your current branch 'the-branch', without telling me what to push
> > to update which remote branch.
>
> In French, that message is:
>
> > fatal: Vous êtes en train de pousser vers la branche distante 'foo', qui n'est
> > pas une branche amont de votre branche courante 'the-branch', sans me dire
> > quoi pousser pour mettre à jour quelle branche amont.
>
> which incorrectly refers to foo as a remote *branch*, as opposed to
> just a remote.

Thanks for pointing it out. My French skills are poor (and getting worse
each day), but this seems reasonable to my limited knowledge.

> In the error message for `git remote rename a b`, remotes are called «
> serveur remote » (« fatal: Pas de serveur remote : 'a' »), so this
> could be what to change the message to. « qui n'est pas une branche
> amont » would also have to be changed.

If you are up for it, you can send a patch changing the po/fr.po file.
See for more on how to do that the Documentation/SubmittingPatches, and
po/README. Here [1] is an example patch that recently modified the
French translation.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20200827223527.36788-1-sandals@crustytoothpaste.net/
