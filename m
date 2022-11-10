Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF5C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiKJCke (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiKJCkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:40:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E914029
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:40:32 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z3so328954iof.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iajeUpeNwWs83iWlU6vkxCPXdcpJ9Avvd+aZQ/hiLok=;
        b=dh1YM6VpCxYQ6LAWV5PP65Cl5AEO/XTJe3o4KFOKe5hZCPLnW92jJak8PD5G5ZB350
         NEsNUoxKrN/ni4kI22LGdF10g5IeJEf/XTaQZ3YEWMJcbwE/koVenwrUuEh7eAx/bJE8
         FPpHLRNYLZ0noOqfkj7PeO/L+h0j2+S8ipmLNWsFNhrHCENU/WhxT430Yau4byPU3btJ
         U6bQLccIVYsjw06YtlfUn6kOCmY3+eopVZDR4Rw89yDqeetGg9jfRbqOm6vWJBfQndYK
         n46GR9koSDSLCBUegVY+40iULnkWvu22O+9z1bqVpMmaoeMMRs46D6qfi4UANrjJ/fYi
         LRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iajeUpeNwWs83iWlU6vkxCPXdcpJ9Avvd+aZQ/hiLok=;
        b=ddyD7WYO5GLf4W6EpTaA0B7JZ9dXhgUYkVZ/Fq02Mq5h45NO0dbaHBpFzPtan6C5Ai
         9oVQcZZJE3elg6UrONQeI/t0MvG5T2BInmx7F/TOJUfpgEDM4iPv2QK2fsoY/nrpVN03
         Z8PxjcEw7ipq7kbiywc4jS2MtxMD2USl4yQIgTxUsRNRr8/r9rEDVYB5HeaCdwgbkf+y
         efprgbiBXMKTMDBdqrkek60Ve5NjFVqCs9uuhc1WOKkdYol0ZhcK19Mrtc3/FbuWirua
         e6InwY6r0TNYcYIEL1wsMemih/C49GgKjdWiaX5s+QwAGxzOrsiktY5wpgY+VE7BJlwQ
         Prmw==
X-Gm-Message-State: ACrzQf2YcszyNthwdz34sAjrgRxYbou+EtVofJCLNlS6aHb5ooWS+csi
        uSeOn7y6+ySOYUGn6jq0cHs2Bw==
X-Google-Smtp-Source: AMsMyM5csA+26QFyhaJfOQ/8tHeaIJLb897qwocHBjf+VHe3BEs2sC786FQSydmU734dHDa/l/p98Q==
X-Received: by 2002:a02:ccc5:0:b0:375:4975:48fe with SMTP id k5-20020a02ccc5000000b00375497548femr34343743jaq.122.1668048031768;
        Wed, 09 Nov 2022 18:40:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z101-20020a0293ee000000b0037556012c63sm5269214jah.132.2022.11.09.18.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:40:31 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:40:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2xknh1TqMTdpIxE@nand.local>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com>
 <Y2R3vJf1A2KOZwA7@nand.local>
 <Y2SFGmQnx7CXtTEI@coredump.intra.peff.net>
 <oo9ssp5n-6ors-n309-2r2n-3q43rq7pn89q@tzk.qr>
 <Y2uygXD7R+fsC0as@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2uygXD7R+fsC0as@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 09:00:33AM -0500, Jeff King wrote:
> On Tue, Nov 08, 2022 at 10:16:15AM +0100, Johannes Schindelin wrote:
>
> > > As an aside, I wish there was a way to interpret per-repo environment
> > > variables in the actual action config.
> >
> > There kind of is. "Kind of" because it is not _really_ a per-repo variable
> > (those do not exist on GitHub), but there are topics you can set. These
> > are relatively free-form labels you can attach to _your_ fork, and these
> > labels show up below the "About" section and the link to the home page (if
> > any) on the right side of your respository. AFAICT these topics are not
> > inherited automatically when forking a repository, which is precisely what
> > we want. See
> > https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/classifying-your-repository-with-topics
> > for more details on that.
>
> Ah, that's very clever, thank you!

Very cute.

> For the original problem that motivated me adding ci-config in the first
> place, branch selection, I think we could do this:
>
>   if: |
>     !contains(join(github.event.repository.topics), 'ci-only-') ||
>     contains(github.event.repository.topics, format('ci-only-{0}', github.ref_name))
>
> and then by default we'd continue to build for all pushes, but if you
> add ci-only-foo as a repo topic, then we'd build only refs/heads/foo.
>
> I may see if I can work this into our workflow file. Even if we can't
> get rid of ci-config for the skip-successful-build feature, this would
> still save CPU by dropping even ci-config when the branch should be
> skipped entirely.

Yeah. I'd be hesitant to see a bunch of CI configuration knobs get
folded into the repository topics feature, but a clear "save CI minutes
if we don't care about building these branch(es)" is useful.

Thanks,
Taylor
