Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC8C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D4961027
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhHZQI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhHZQI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:08:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CDEC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 09:07:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso2562305wmr.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I1egripQ4Dmu3lRqJX+m4zANLoJODlKQJVDGBAdcdYQ=;
        b=cd8W1GimJ9sLqxjSHBVJlTW/p668v3CxAMEkLXBVkorJEHyK5dd26aixIZRY72qy5x
         gEQV1bL5JAV9gWHsklRi0UsPmpSLaS5l+hSIxVA7dfQe2N0Ak0CAK4O6ALO9DYjSvkMA
         BFys0At6ZqYAc1k3at6dUphBzSptCLP0W0RGOd8W1Z9OF5D1nO0f2wNS6DRm+MDfRRDF
         DjLwIytn/6bHoLC54DnEl1MDkGPXc7s66Ndem0QP0vpYmUCRcGj+dy37IXgb0I9fSyuS
         jauWtiYaxj2IDvFb9Xl++Ybh7+zKNrLktyOMvv+51uQ05AYTqHyMS/YkQ/tkdWO4T0al
         vk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I1egripQ4Dmu3lRqJX+m4zANLoJODlKQJVDGBAdcdYQ=;
        b=rwxbn5JCd9vO61bAjnYDE2iBd5PYhyT4HzFoj+zplRZ0/ty6nLxurow0xgFyofJ+wo
         GQJpnOaje4qrHgWQdRSbe9mCSnofVkhwczqilXXpL80W8ndDUB7VQYT4nviwj9phBdck
         lzgGfmk8aJ0UbVIyHwb7ouI9IqV2iaE726YIcmG/izEbBDR20bULQ/tWveN3TcNuC2m1
         vdEdlekPbhICmC1zNb02vL78E30pErThxjwBcFQHJsXb1VRAdmP7tNV+OngM0hemf4wk
         QdhtxulcJgRDeGPt39vVa6KzBthO2Gxhr6Qqo+/Zu3fUTuBroeXZxfDNPgBrcoNceRBg
         yHtw==
X-Gm-Message-State: AOAM531N+B7yUY+2vAOe4Ibjv2CclEOWcMx+2yqWcwdX+SipPLMx0/Aq
        OSEO+W/ZTv+qE2ny0FI9b2Uh3vkHbSf7Bw==
X-Google-Smtp-Source: ABdhPJzh5IOIg4riMw7ZOoaLR48snKOWq/NvMOw3AFjgDKZrzHjScXZRUfSs4URp36oyngWQPYzmHg==
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr12901097wme.119.1629994059253;
        Thu, 26 Aug 2021 09:07:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d7sm3744037wrs.39.2021.08.26.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:07:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/25] Support reftable ref backend for Git
Date:   Thu, 26 Aug 2021 18:02:49 +0200
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <877dgch4rn.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <877dgch4rn.fsf@evledraar.gmail.com>
Message-ID: <87h7fcyyt2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 23 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Aug 17 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
>> This continues the work in https://github.com/git/git/pull/847, which the
>> gitgitgadget erroneously closed.
>>
>> Changes relative to last series (version 20 Jul 2021, tip: 4a5891f )
>>
>>  * fix HTTP serving
>>  * fix t1501 (use absolute paths.)
>>  * fix git-new-workdir
>>  * fixes for FreeBSD (thanks, carenas@gmail.com!)
>>
>
> What's the overall status of this topic vis-a-vis whether it's being
> proposed to be integrated or is in more RFC form?
>
> Since we discussed the non-working GIT_TEST_REFTABLE=3Dtrue in [1] & [2]
> there's been fixes to the REFFILES for the tests which has already
> landed as c9780bb2ca8 (Merge branch 'hn/prep-tests-for-reftable',
> 2021-07-13).
>
> But e.g. running t1410-reflog.sh reveals an assert failure() in this
> library's own code:
>
>     git: reftable/record.c:1075: reftable_record_copy_from: Assertion
>     `src->ops->type =3D=3D rec->ops->type' failed.
>
> (A *lot* of things in the test suite still fail, I didn't look in any
> detail. Just highlighting that it's not just remaining failures due to
> hardcoding of .git/refs/*).
>
> I took your reply in [2] to mean that you were on board with the plan I
> proposed in [1], but aside from the limited REFFILES fixes the structure
> of what's here seems relatively unchanged.
>
> So is this series still considered RFC-esque, or what's the plan to move
> this forward at this point?
>
> 1. https://lore.kernel.org/git/87h7jqz7k5.fsf@evledraar.gmail.com
> 2. https://lore.kernel.org/git/CAFQ2z_P8vgY0RRT+XSH9K3VDQt39FLqXx6qfeZqaZ=
Pkwhq1w+A@mail.gmail.com

Just a note: I didn't notice the outstanding REFFILES fixes that were
about to hit "master", so this was written with a branch rebased without
those fixes.

But in either case there's a lot of failures. Running the full test
suite also reveals at least a couple of tests running into this:

    BUG: refs.c:1039: free called on a prepared reference transaction

t1400-update-ref.sh is one of them, t5510-fetch.sh is the other one. We
then have t5304-prune.sh, t3200-branch.sh and t2400-worktree-add.sh
running into the assertion I noted above, in addition to the
t1410-reflog.sh test I noted above.
