Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C345C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 18:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351789AbiCUSaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiCUSaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 14:30:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7548F21E39
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 11:28:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q5so21037715ljb.11
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKBZM19RTTtzkUnRrCtNFJay5uo+4gtJF0gL4jLbt9U=;
        b=LoaiPfZM943b6SBh8tLvc6GU9vJmsf3KZ9dx9hGZ85EgbT4IQDxWEhU+zX2P1+OkoV
         8tgv+C1GHihwo0hHUCS7+CdS+EVa70LU3veGTPD0jMrlWugBGU3FwdYJzQgVRbAqRGSW
         noWrHQztyU+OEi1QqKdWLcxQxnWnodJFbVx7w8OZ2+wvcvqFHxxedMdojQXuIp12Hwfv
         e0WCmn7rEd570ALWU50gdoCrFiUslnj+DpC2phroQdDyMcXo7fcTDw348H/UfJss5gif
         rQhvmS0AR/Dje/4Dn/s/ZsKZwhXo7C+KFjnAU0Q5RjohAo0kC9sg/AUgeJ7K4cmhwHWe
         H44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKBZM19RTTtzkUnRrCtNFJay5uo+4gtJF0gL4jLbt9U=;
        b=o//pWKRlhkKMVoxdE488R/HLQ3k288hd0iPKZi3uMB2oK1HvvkahT9q0//H5VUjLeD
         phzOls8U+PMiI2rEgFAmu+TIPOuJf7CpuWGsgDF4JXWk6pSrLw8tctLdRUnKHxrBWkV8
         Ncm48bFmXwlbEsc6zCO5IjqU/RmyvJoKxK7I+6adUyxNaTaiIEFdvQE0AYpxQ6fRmBuh
         euQH6tO2EYlfgXuy4N66s2bTV3uS1jVJTi5QI/12SFCdwlNY7rG3eD1aOCudCsvFT5V9
         RSGsl4QTRkAUyCwS7HEWvd3XpBaYr6JyUDTehNVEVg8ioA1jeAkSo1qRhinmONOtHEf1
         1tiQ==
X-Gm-Message-State: AOAM533fHYSVIP4UuU7rhuthL2CqizFG5vYHOmTtQjeFcqPDU6ZVQ0AA
        OcmZZ2nDXNSdgi3Q71c1y+NdYkxMcsYK5NwAORk=
X-Google-Smtp-Source: ABdhPJxJvhwxpHaYTb2YPQkYOtrbpBgAKPxnxhlmI+EI0Go9v3G+hgnrzZGEXfCGOqrEeda2v1xJp5TmXJZHV9bB3gU=
X-Received: by 2002:a05:651c:241:b0:23e:42c1:2e4 with SMTP id
 x1-20020a05651c024100b0023e42c102e4mr16695803ljn.406.1647887322620; Mon, 21
 Mar 2022 11:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <220321.86a6dj9xja.gmgdl@evledraar.gmail.com>
In-Reply-To: <220321.86a6dj9xja.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 11:28:31 -0700
Message-ID: <CANQDOdcPAb31JY6LdMiCn26192_1wvKkHodpNEBkSh3WbD+e4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 7:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> > [...]
> > +     if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
> > +             bulk_fsync_objdir =3D tmp_objdir_create("bulk-fsync");
> > +             if (!bulk_fsync_objdir)
> > +                     die(_("Could not create temporary object director=
y for core.fsyncobjectfiles=3Dbatch"));
>
> Should camel-case the config var, and we should have a die_errno() here
> which tell us why we couldn't create it (possibly needing to ferry it up
> from the tempfile API...)

Thanks for noticing the camelCasing.  The config var name was also
wrong. Now it will read:
> > +                     die(_("Could not create temporary object director=
y for core.fsyncMethod=3Dbatch"));

Do you have any recommendations on how to easily ferry the correct
errno out of tmp_objdir_create?
It looks like the remerge-diff usage has the same die behavior w/o
errno, and the builtin/receive-pack.c usage
doesn't die, but also loses the errno.  I'm concerned about preserving
the errno across the or tmp_objdir_destroy
calls.  I could introduce a temp errno var to preserve it across
those. Is that what you had in mind?

Thanks,
Neeraj
