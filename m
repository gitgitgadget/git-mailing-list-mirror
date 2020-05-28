Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4272C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CF9206F1
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i680V3Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgE1OuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgE1OuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:50:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F9C05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 07:50:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so11638026plr.4
        for <git@vger.kernel.org>; Thu, 28 May 2020 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKbxO9hSDcwG9yOuVah1+KYL317B+L/Gs9Khsi6npwA=;
        b=i680V3WtcV6OoOaDcflIome0KpfzFtw7MTacwLKRCt5/DUHZnCNY0LxdGbQ7VTYCr5
         rtEdwM+c2oFqztHVeFIugFip68AnhaPPSwEmnYP6qUrmflNzgMOmXl4FobPIT/cgBe8v
         ZlkDT52eqAK5wSpyZvX21YXS68vb3psZAdu/L4Tom7BUhvvckJKy1RZdMsfOvo69DEKw
         jJXs9zR8MSBbkh/XbpxOJMAnExL5tqqgm6WnSgJQkHSvg2usQc5UkkHbPOsHCZbjsia2
         hHxDbC5691siWdl1nenPVzbflL7QGt3wuWKm3yl17rbcoEZUFh8k3SdGBQeikYiM7iCh
         832g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKbxO9hSDcwG9yOuVah1+KYL317B+L/Gs9Khsi6npwA=;
        b=jd0YlwG1CHXIfsTNOrC9s6DZo4KDL6bBsDa6c+97kCfbI0e8Yg5Srlf/Yj2cFjOfU3
         d9GSCt+JmhxStX/KO3UclgXupduBOX62NmC0lK/6qTk2+BbzcsW2/X9yobIxWJKR87dG
         I1OwQDJdOdzbeCPCJFZxoLyhYGjdQuzNRNYhoevFOtLXJuOj6NbZdoxWP6KZ1w235/vF
         enzG0roQONOdcEkH0S7MTYjnR1GQ/49mqIFrsWdLxC+Kh3NcLwsJxeCV7ysDmFyli9tU
         3Tgz/XhokioSF4Tzoaqxq9JYl8DWyssuGiGYIvbxvLM/ustw0t1nY4LZ5/ld0w5tpLY4
         3K1w==
X-Gm-Message-State: AOAM531X9LLa8CHb+C2KaL68Voea+PsG386yEwgGiQZ/yWB3q+4ZVQIJ
        aZsPvPF7rDh0175SPODyJ70=
X-Google-Smtp-Source: ABdhPJw8bJQlHXF7d6EEWEjBjTKDdO7aJipRo5RRWp6AiGJqCpeIueJEWqgH58cxQOUOV5xmgTzlnA==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr3828346plq.208.1590677421231;
        Thu, 28 May 2020 07:50:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 136sm5059572pfa.152.2020.05.28.07.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:50:20 -0700 (PDT)
Date:   Thu, 28 May 2020 07:50:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200528145018.GA58643@google.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407014829.GL6369@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
 <20200408000149.GN6369@camp.crustytoothpaste.net>
 <20200527223907.GB65111@google.com>
 <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> So while `git gc` looks like a good candidate on its technical merits, the
> usability/discoverability point of view paints a very different picture.

Here is what I take away from that comment:

    It was a mistake for "git gc" to take responsibility for operations
    like "git pack-refs".  We should migrate to a new "git maintenance
    run" command and make "git gc" print a signpost to help people find
    the new name.

That seems like a reasonable direction to me, but as you're hinting,
from a technical design perspective it doesn't change where e.g. midx
maintenance operations would go.  I would expect the routine
maintenance command, whatever it is called, to perform such
operations.  I would not expect to have to choose between two subtly
different maintenance commands, or in other words to have to pay as a
user for an unrelated naming choice.

I think it's worth discussing naming, but it's kind of a distraction
from what Brian brought up.  The real question is, do we consider the
existing "git gc" infrastructure such a lost cause that we should
touch it as little as possible?

I don't think that was Stolee's intent --- instead, I supsect that it
was just the discoverability issue you mention that led to this series
forgetting about the possibility of incorporating this functionality
into "git gc".

[...]
> I guess I would argue for the introduction of a new command, like `git
> maintenance`, which could potentially trigger a `git gc --auto`, but is
> primarily intended to run _outside_ of the users' work hours.
>
> Once we have that, we can always figure out whether there is a convenient
> way to register this via `crontab` or Windows Task Scheduler, without
> asking the users to do all of these tedious steps manually.

Wonderful, it sounds like we're pretty much in agreement.

[...]
> Therefore, I would like very much to have a `git maintenance --schedule`
> (or something like that), even if only on Windows, on the grounds alone
> that it is even more tedious to work with the Windows Task Scheduler. But
> I would prefer to have that also in my Linux setup. The convenience for
> the users (myself included) is just too compelling.

I think Josh was arguing for deferring that part to a separate series.
Otherwise we could end up spending so much time focusing on scheduling
and service supervision that the series gets delayed and no one
benefits from Stolee's work to improve how routine packing works.

Thanks,
Jonathan
