Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A932CEE021D
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 05:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjIOF5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 01:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOF5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 01:57:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BC1BC7
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 22:56:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-530199bca8eso2809912a12.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 22:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694757416; x=1695362216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynj8QeKl17gUxZyJEKZ1EWLby7Qgm7G7qD3So4YEikw=;
        b=ZmhSAb/LPkdaAAszuxWdzHxxXngyhJhRXkz5LfZ7hIyqEdC7SlK7HvG/as/7R1paLM
         RygVKrYpguJWdVDkFYxFoCPDM3KiVDW0AOZ65TCeOib2uHhr/Q6H6YBdiVP7eFHGts5k
         BM7IduRVvJ8Nik36TmqzZ01MQxn8FK4dbR/CL+0yfruK6ZpTC4R68BYSXtdHuICpnL37
         MtuRNj75KsIeXIjSj7MgNQzEm6jj29mmViskRUQQslD85plKUGQiS2GsLXyw9Bqm12Pg
         UyaUcg4rXGSyE5Me9cyY8mQTA+IkHvDtwQ/uOy+kj3VOqyRKBVTWKDIYCjZDvrh1RM5f
         ecoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694757416; x=1695362216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynj8QeKl17gUxZyJEKZ1EWLby7Qgm7G7qD3So4YEikw=;
        b=nck7BajgwCSPftmenqXlBqkUNCFDEDrJEjOVVe3oGU9gUsynvJ/DyvwtIKrwstdCSQ
         x/DmaBWRUXKdL7FizLNKQpjasSMUD5yYCYQk5l526YxG8sZdJnyrMC865swc9eAv/nQn
         lXrMnA20d3dKFY52GYzgjMXwCFK96ha0ZnnRI9z2a4uVuNqZfsCmbuzQRMdf7TNdwfg1
         3Q1HGWA1GbMSy/8fFN34rGN+O/bQg4uGgGyWrKbu+CdZVS9MpMG6EFRgAA7zZbd8u9nn
         OSnVVhU1ijnHdZ6GGsmgvwL4WU7YPS2jQDSPZ1MNWtsrHa4oplKihzLCvtGkIaXMqS+X
         0eRA==
X-Gm-Message-State: AOJu0YyO2Z1vmCt8rNowb3quccGuoOA6SbZouM39vR7UwGV1gYMu+7Ii
        wuhoWzbqXIZmNH6OX/bLgR48wUZf0aEFF4TMQIA=
X-Google-Smtp-Source: AGHT+IGcUzWd0Mbax3ShbW0BsAP7pES2BO7hqQVZ3chdf88qXLqs0XY/+EEyoBtrAT9IQvubtrsiCHmfKK606+RTnc4=
X-Received: by 2002:a17:906:254:b0:9a2:143e:a070 with SMTP id
 20-20020a170906025400b009a2143ea070mr1001174ejl.20.1694757415877; Thu, 14 Sep
 2023 22:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693946195.git.me@ttaylorr.com> <cover.1694632644.git.me@ttaylorr.com>
 <xmqqa5tpluyj.fsf@gitster.g> <CAP8UFD1rDb-iYf4LYb7n=K4KpQ-JR-JK4TkQpGJ-TCfTNFFbnA@mail.gmail.com>
 <ZQNKkn0YYLUyN5Ih@nand.local>
In-Reply-To: <ZQNKkn0YYLUyN5Ih@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 15 Sep 2023 07:56:44 +0200
Message-ID: <CAP8UFD0aqZx6_d1AeJO0SBCLo7+AOJaVM93CCk5h5+fd7=VW+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 8:01=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Sep 14, 2023 at 01:10:38PM +0200, Christian Couder wrote:
> > Ok, I will try to review and merge this with
> > cc/repack-sift-filtered-objects-to-separate-pack soon.
>
> I took a look at how much/little effort was going to be required, and
> luckily the changes are isolated only to a single patch. It's just your
> f1ffa71e8f (repack: add `--filter=3D<filter-spec>` option, 2023-09-11),
> and in particular the `write_filtered_pack()` function.
>
> I started messing around with it myself and generated the following
> fixup! which can be applied on top of your version of f1ffa71e8f. It's
> mostly straightforward, but there is a gotcha that the loop over
> non-kept packs has to change to:
>
>     for_each_string_list_item(item, &existing->non_kept_packs)
>             /* ... */
>     for_each_string_list_item(item, &existing->cruft_packs)
>             /* ... */
>
> , instead of just the first loop over non_kept_packs, since cruft packs
> are stored in a separate list.
>
> In any event, here's the fixup! I generated on top of that patch:

Thanks a lot! I will very likely use it in the new version I will send
after your series has graduated.
