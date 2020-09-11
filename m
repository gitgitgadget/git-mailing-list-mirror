Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC71C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D3C22276
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AepsqA8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgIKOR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgIKNMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 09:12:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D3C061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:05:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o16so9728410qkj.10
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5un/WzoJ6d/9pNvnOBrHLPfYRxbTnxzlqBX8mvtW8wE=;
        b=AepsqA8wthd1qaUzMx0Nj4uj0xUYMJgQHZqBRqIG+GSDUhPxActoxkfv3S5v9AFPqC
         WC8/8Kz0fYyNuPUgh0RwteNyM0Jpc+MWAEvPfx5tq3IIfVpIrcKwvLSE9laqeKZb9TuO
         hJzSeUXGuTbq9JXGIofQwCMDACYzeaj0EbabXl6dcQP1PxIwscGnTHrxltO7MwQnV9qF
         n2PrPOehodcpcNXW2K1PuISGUvtasjTfbivqjWM6w/E8qZqxrIy0tTxODL4H5dUj65kA
         U2Y9hJKDVc5soedoqP776+bAQ/i3G0IOFxSwgABOBYYOV+XTystXaYIgolI68ww1y6fl
         TOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5un/WzoJ6d/9pNvnOBrHLPfYRxbTnxzlqBX8mvtW8wE=;
        b=Bth06FMKohq/DTna5EldV0xLFFTD4+R2CPHjxCR1mZ0jrXLUFOjytd000Y4JTIN3ic
         U+x+zmdTvFCfZUS+qGX6stS6NsyIRscmpLLXMeP+WwVeX9yTlQLgasDlYSbsJWa8bumT
         vYWqnu4lq+YGbUBBle96cI4HxIz49MzJB+f3xAKMtc0KUl4yC5dMxaiYM89uO8fXwI5I
         1knGDNglCqd7FUgk8yVF2R5rAFFEsosDw/QTGgFmPqFx9uizjTkGqGuQYHMmujvKdbhj
         an3DgxP0HdrYNUQVavPcJIvMq2ayHMj9FlSSeR9ucKdMOU3g1L4W468WVqRRMS7U0ZfL
         TA8Q==
X-Gm-Message-State: AOAM531ydy6Hg2T6a8VCrTCawOf2rEdSLY5ECTbs9ngE3WXubVv4+ipU
        nPDDVe6BjE+qvhdvbchzp5s=
X-Google-Smtp-Source: ABdhPJy6QTv4REJpXwbUctIBSU9ZvshRk4w8uFiOHr+WF5tpp3vdNLETgRgaAzFF8fCtSW9iOfjRnQ==
X-Received: by 2002:a37:4e45:: with SMTP id c66mr1462132qkb.36.1599829546625;
        Fri, 11 Sep 2020 06:05:46 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x197sm2710188qkb.17.2020.09.11.06.05.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2020 06:05:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
Date:   Fri, 11 Sep 2020 09:05:42 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45EB4E9E-1819-41D6-839E-A3812456478C@gmail.com>
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com> <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 10 sept. 2020 =C3=A0 00:25, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> `git ls-files` learned to recurse into submodules when given
>> '--recurse-submodules' back in e77aa336f1 (ls-files: optionally =
recurse
>> into submodules, 2016-10-07) but it does not respect the
>> 'submodule.recurse' config option which was later introduced in
>> 046b48239e (Introduce 'submodule.recurse' option for worktree
>> manipulators, 2017-05-31).
>>=20
>> Add a 'git_ls_files_config' function to read this configuration
>> variable, and adjust the documentation and tests accordingly.
>=20
> I am afraid that this will break existing scripts big time, and I
> would not be surprised if 046b48239e refrained to do the equivalent
> of this patch very much on purpose to avoid such a regression.

As I read it, 046b48239e was just the introduction of the config and
it's implementation for read-tree/checkout/reset, and the other commands
with '--recurse-submodules' would come later (as was done in the =
following=20
commits in branch 'sb/submodule-blanket-recursive').

Also, in gitsubmodules(7) [1], 'ls-files' is used as if it respects =
'submodule.recurse',
so I think that was Stefan's original plan. (It's been that way since =
the introduction
of that man page in d48034551a).

> Anybody who writes a script using ls-files _without_ passing the
> --recurse-submodules option expects that the ls-files command will
> stop at submodule boundary without recursing, that the script can
> notice and pick up mode 160000 entries in the output from ls-files,
> and that the script can decide if it wants to descend into
> submodules it discovered that way.
>=20
> It is easy to imagine that such a script will break badly when run
> by a user who has the configuration variable set, I would think.

I understand, but I would argue that such a user could easily adapt =
their
script to add '--no-recurse-submodules' to their ls-files invocation if =
that=20
is the case, no ?

> So, no.  I am not enthused to see this change.

OK, if I'm not able to change your mind, what would you think of a =
separate
config variable then, say `ls-files.recurseSubmodules` ? This would be =
more granular,
so less chance of breaking existing scripts, but still provide for a way =
to configure=20
Git to always recurse in submodules, including for 'ls-files'...

Thanks,
Philippe.


[1] =
https://git-scm.com/docs/gitsubmodules#_workflow_for_an_artificially_split=
_repo

