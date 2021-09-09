Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C1C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4BFB61132
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 08:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhIIIKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhIIIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 04:10:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC35C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 01:08:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g21so1486138edw.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TCTvzIwOdT5u/HbKzRHYFH1eV7XNH63aPKBuwSrQmA4=;
        b=WmiBo0xdwir+uOKI0wY0NrFC7aEH/DtRN+w49sSF3ETFFnRn+paAEm2ZklGNkM9g9i
         Iz/Qe3J4XMsQiC7RDa2WX12xhTowbDpujGTjw55kpgR9wKyoEqpf1mN0tyUdBDUzhURN
         IIqjp9PyYpLhPIXK+Gz6KAT38FK7i/9mQcjphcTbD7/703V3Gxmz+7Mlfur15r1pF7ig
         LMAE3xOgVNsEEV19lQoEe0aEBeyP3DrC2iCyc3Fz9Dxa2qfxB/QvA8pGK47EyS/FTn+A
         flWhmGZp0cXGSUmcEHNh0BHYx6WwbKMCPJGE/pQtNB6GCmfu53pZOe9pwgV0noWqZ9CI
         /H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TCTvzIwOdT5u/HbKzRHYFH1eV7XNH63aPKBuwSrQmA4=;
        b=dTtUdvxnk0CJvY7Y8N2nmDDvcd17AtXjxlQYGNkDmVLWm1nD+2Az+gfWEFi/Io8fhX
         WL5iJRKK7mG8+7/jrqixSnuWQgOUg+kWeXXJYhgFmmGPhCTnjJb4v3f828wdCNUCWhQZ
         LUHypfp3qfVrhdkRf0caFFC1AMnn6Jt0wPrsL9eyaoeoRQq9x7pBghSBifGzkvONocEj
         zsPf4DW41hApSDxlus/NGlHjhzqO3uy0GsBsx2K12630mk1ua/ljVBOJeBSNMDojNiJL
         6kipZIOghfTwTZ4iYBOLIYDyTui92ZNSsGfP7ZM0wfCnxHQ2TxirCKXh+T6V2sU/vfqG
         /Pqg==
X-Gm-Message-State: AOAM533cEZtZbrBYYanBmH4JjV6vAMY2jY8Us1pzoVKZWQ4mPGQ9g8XF
        CAPJVLKIeGmxaAHN70434leFavDsuuAG/Q==
X-Google-Smtp-Source: ABdhPJzuLdBoswRpi26Ou4Z2AqVIu3gBArsC6H2uXj0wQe2h1rYTmuaaGzCTgznrvARA+0bK8hxi7g==
X-Received: by 2002:a05:6402:4415:: with SMTP id y21mr1907630eda.79.1631174935456;
        Thu, 09 Sep 2021 01:08:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u16sm507774ejy.14.2021.09.09.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:08:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/9] packfile: avoid .idx rename races
Date:   Thu, 09 Sep 2021 10:06:24 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <cover.1631157880.git.me@ttaylorr.com>
Message-ID: <874kauf9wq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Taylor Blau wrote:

> This series is a unification of [1] and [2] which together prevent a hand=
ful of
> races when code that writes packfiles moves the `.idx` into place before =
all
> other auxiliary files are properly renamed.
>
> This can lead to races like not reading the `.rev` file even if one was
> generated and is about to be moved into place.
>
> Credit goes to =C3=86var for preparing what is more-or-less sent here. I =
polished a
> few of the commit messages, and added the second patch on top of his resu=
lt. It
> isn't necessary, but felt like good hygiene when I was reading the surrou=
nding
> code.
>
> Thanks in advance for reviewing.

Thanks a lot!

I think it's probably redundant to note it at this point but I've given
this a thorough review and it all looks good to me. I left some
comments/musings on minor points in the series, but none of those IMO
require a re-roll except perhaps the duplicate Signed-off-by headers,
depending on what Junio thinks & if he's going to fix those while
queuing.
