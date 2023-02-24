Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D9C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 19:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBXTYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBXTYo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 14:24:44 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08D18177
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:24:43 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o12so113709oik.6
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YcFikVsDNw4YOL6gNX6U40KTB1IiNPI+rBGRjNCtPc=;
        b=EO2DjTP6UsGgI4IueonbUl6cgvt3lbdS5jo+sgzeitzD0/T3mM/NBJBOCrzUaKFNZp
         /PaJA0JKGdvzCYKu9VuMa+eExvZLxxFt/F7Vub8wHy2kLGXyl8y5duiXv0JlhwIJdTW2
         UN838cgqf20lWP207Is1BEm4xxRQPfusb0MReUjGF6Sqe6sT0Zynrk27Y8lQspTG7Qer
         y+A1r3HG3CnQai+U9/RjsKjQ2s8vLQlBIdnXJkhZYTO9TcDg9V83cMg/hPTl0cb+sJE6
         9igukNL50QicrN+VTmCicbqYUdyZH2xi0YaGF0BQpHnvtD1vQskhx6ElUl8LnxHG9Zhp
         C7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YcFikVsDNw4YOL6gNX6U40KTB1IiNPI+rBGRjNCtPc=;
        b=4N82I/0cLl1QA8Nqi8lyS5p+4nAGQQUoQWHo0VLOIOWr6lcCbsDGyPcigqs5Xu2vmh
         gLRDca/nmP/+RWoinyie0UuG7Xx9VeZc9eG+mmrvsvwVM58ZvGw8Y/oVidgkmQLjXlGP
         wWmzeEnKqvS5M8EoJASO/IqcoOOftiCLqRUHXW7UoPUnUj8rfwWm68a7klaA2wDFM3ln
         a+Nl2/61LohmNKk8hTmpQKzCk9/U4SwLLfT1t3/8M/r1PIjtWoB+WyYvIGX6RYC0z+IS
         9ZAvC3fmNsZpzzSsO5hvoIL/rngMWtQw+RRHnTIc2nuoaM1mUSV0HlT/ZCF6NggpqiqU
         l6IQ==
X-Gm-Message-State: AO0yUKUrbY1LzvgaITlNrrJwYlRiUlqyw8jTP8Oh0qzcHGi+i1p7fwwT
        SFBlZpBa87BHCELvFNAa1j3FgyFmhrFkAIIYuqs=
X-Google-Smtp-Source: AK7set+EMUglLzh/1OzWs9TQ3pcyRILJ1kT5rZXlKM571qKk7q1vIER339yGwklioBN8wYHMaOMXInF0RZI2IUGnXEY=
X-Received: by 2002:a54:4105:0:b0:378:80e1:cdf2 with SMTP id
 l5-20020a544105000000b0037880e1cdf2mr1493715oic.5.1677266683023; Fri, 24 Feb
 2023 11:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230223053410.644503-2-alexhenrie24@gmail.com> <b4be9cb3-c24b-4377-bab3-5d53035efdf8@gmx.de>
 <xmqqy1on0yla.fsf@gitster.g> <CAMMLpeQKJeZn4rcTJzFR-ixQXKQMT7t-BKvJqXV4o_4VM=tHYg@mail.gmail.com>
 <xmqqcz5z0wdb.fsf@gitster.g> <CAMMLpeSH1itopDuON=7ms_7Li7Qk+9dhzKjT5f7UE11posKK=g@mail.gmail.com>
 <xmqq8rgm29fw.fsf@gitster.g> <CAMMLpeTvyYgGNBQWtRBg3ZNuXeCMxiem-5LAdu0ex7XCuf0wAA@mail.gmail.com>
 <xmqqpm9yzxky.fsf@gitster.g>
In-Reply-To: <xmqqpm9yzxky.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 24 Feb 2023 12:24:26 -0700
Message-ID: <CAMMLpeRGvmpEnxN-qq+2dhzF1bzmBYjW51ojX+9mAnyP92EAKQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Phillip is concerned about people and scripts assuming that
> > --rebase-merges is equivalent to --rebase-merges=no-rebase-cousins,
> > see [1].
>
> Isn't that already broken when you introduce rebase.merges
> configuration?  People and scripts are already relying on the lack
> of rebase-merges to flatten, and script writers will be surprised to
> receive a "bug report" complaining that their script does not work
> when the users set rebase.merges to anything but no.

Yeah, I don't know why breaking the assumption that --rebase-merges is
equivalent to --rebase-merges=no-rebase-cousins is any worse than
breaking the assumption that not passing --rebase-merges is equivalent
to passing --no-rebase-merges. And the assumption is broken whether
one new config option is introduced or two, so splitting the option up
probably wouldn't make Phillip any happier.

> > Tao and others are probably not going to like it if --rebase-merges
> > without an argument undoes a rebase.merges=rebase-cousins
> > configuration.
>
> That is why I suggested to keep --rebase-merges= (with no value or
> an empty string) only for those who came from the world where it
> defaults to no-rebase-cousins and there was no rebase.merges
> configuration.  If --rebase-merges= is given from the command line
> without value *and* rebase.merges configuration is there (which is
> Tao's concern?), the command line option can error out asking for an
> explicit value to countermand whatever value is configured.
>
> Wouldn't that work for folks from both camps?

Maybe. I still don't like the idea of --rebase-merges="" ever being
not equivalent to rebase.merges="".

-Alex
