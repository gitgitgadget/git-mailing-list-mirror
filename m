Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3564EC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115B420708
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anZJlWmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEAOkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgEAOkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 10:40:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4CC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 07:40:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so8052589qtv.3
        for <git@vger.kernel.org>; Fri, 01 May 2020 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d4GKSOUolyRA0U6nzBMruiGJSJR/lyuMHPS1d4o3zA8=;
        b=anZJlWmi4/tYvPiWSRh7cKra1tB1jaiGGp9S7Lv5CiLZuGjLv2TMGfsGFTCSwthh/L
         d9xfc3KIMHa70c5WwYquLSu8xFA8rVG8gmKd+5LJaqnvGavpZ16jjFx11Cpl8AD3b8Qn
         h15Vg0bVIRPyzBc/1vXyVIYZri9YuchK+MdUzgOrl5Qega2r78s0ftho8G6xO7Zh4fFQ
         ntOrox7AT/zrIoiL3WGIcpa7LX7Ewpq+D/SItpFjhKUQaIyaYRWHAVg0nY1+UUl6+c7j
         opl7lQj5e7jgYEYpQ3i/glb3zTTFuK4axEPccHNDCfA27Ts8ZeqC6XpeUoNE3BCjbLms
         RyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d4GKSOUolyRA0U6nzBMruiGJSJR/lyuMHPS1d4o3zA8=;
        b=OmWKieHgJ8zj9tFIsI2w3U7DDq8str6numUyrARXnVC1lUKZJ6WO98RRxKprWxuud9
         mZ110S+rMe/ZWopIkGoOMGA0z6d86FzYYLkFk05Zq7DmpTq0DOrFH+DRWp0W8O60RWGd
         9QRT2hXOs2Ugf8X4VZ1F9sb6ZVN/5UqaaxRctCgR5IaWbScmr0yRSx8Qj/2FWGRdRJ1c
         1FbLSl6GSlv8A07QOf0LbUsOLcLKFFLG2C7pUn4btNrcIrJ/Z+2GVcLyKnr2CJ60EBaZ
         H+EC3eeMTUG+t8gK3HEF/WoPO2ny4XrkRUc4iBMvN3g6LWPsoGqwGT1lLZ+zaFNlLK84
         w4GQ==
X-Gm-Message-State: AGi0PubFARn6zEk06SlWj43WdZTecHeio21f9A0nyebnht9Nq7lKRbi6
        qJx2RKyyxezLM1Qp8BJhiks=
X-Google-Smtp-Source: APiQypLykbsocxKbBmgG2+ROjBBC6RyUAR7UBDC/EHCaCpaKVryOlnCONmQeJzkALMX01R5lXqGAOQ==
X-Received: by 2002:ac8:3581:: with SMTP id k1mr4177861qtb.50.1588344015563;
        Fri, 01 May 2020 07:40:15 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id d17sm2839353qtb.74.2020.05.01.07.40.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 01 May 2020 07:40:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git checkout --recurse-submodules doesn't like checking out an older commit after a submodule was removed
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200501005432.h62dnpkx7feb7rto@glandium.org>
Date:   Fri, 1 May 2020 10:40:03 -0400
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C3FF354-F10E-4822-ACF8-31417B05C099@gmail.com>
References: <20200501005432.h62dnpkx7feb7rto@glandium.org>
To:     Mike Hommey <mh@glandium.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

> Le 30 avr. 2020 =C3=A0 20:54, Mike Hommey <mh@glandium.org> a =C3=A9crit=
 :
>=20
> Hi,
>=20
> Doing the following fails:
>=20
> $ git clone --recurse-submodules =
https://github.com/trailofbits/winchecksec/
> $ cd winchecksec
> $ git checkout --recurse-submodules =
93ffe67dbfc757bf6f440d80b8acf88e652ed60a
> fatal: not a git repository: ../.git/modules/pe-parse
> fatal: could not reset submodule index

Thanks for the report, I can reproduce that with Git 2.26.0.

> The main reason is that the pe-parse directory/submodule was removed =
in
> the commit that follows 93ffe67dbfc757bf6f440d80b8acf88e652ed60a =
(which
> is current master).

Yes, indeed. If you look at the code for `git clone`, you will see that =
the `--recurse-submodules`
flag causes `git submodule update --init` to be called in the "checkout" =
phase of the clone [1].
This means that only submodules that are present in the HEAD commit of =
the default branch (or=20
the branch to be checked out if using the `--branch` flag of `git =
clone`) will be cloned.

This also means that they won't be cloned if using `git clone =
--no-checkout`, and similarly they won't be=20
cloned if they are present in a different branch then the one being =
checked out by `git clone`.

However, the `submodule.active=3D.` config value will still be written =
to the local configuration [2].
This is why `git checkout --recurse-submodules` tries to checkout the =
submodule when checking
out commit 93ffe67db.

> This also leaves the tree in a bad state, and it's hard to fix =
anything
> from that state.

Indeed, the files are written to disk as in commit =
93ffe67dbfc757bf6f440d80b8acf88e652ed60a,=20
but HEAD is not updated, and so files appear modified and .gitmodules =
appears untracked.
For me,

    git reset --hard && git clean -df

returned me to the initial state (master checked out) without errors.

However, trying to get to the intended state =
(93ffe67dbfc757bf6f440d80b8acf88e652ed60a
checked out with its submodule) is indeed pretty hard. The first thing I =
tried=20
(after the reset and clean above) was to checkout 93ffe67 without the =
`--recurse-submodules` flag.=20

    git checkout 93ffe67

This succeeds. However, note that if  `git clean -f` is used instead of =
`git clean -df` above,=20
then the pe-parse directory (with only its gitfile inside) is left =
untouched and the checkout fails with=20

    fatal: not a git repository: pe-parse/../.git/modules/pe-parse

and HEAD stays at master. A subsequent `git status` fails the same way. =
However=20
`git status --ignore-submodules` does not error (and shows that the =
files are *staged*
as in 93ffe67, which is very confusing!)

Anyway assuming we used `git clean -df`, then the checkout of 93ffe67 =
succeeds, but
the submodule is not checked out. Trying `git submodule update` (with or =
without `--init) fails:

    fatal: not a git repository: =
/private/var/folders/lr/r6n2057j0dzd4gdb614fp0740000gp/T/winchecksec/pe-pa=
rse/../.git/modules/pe-parse
    Failed to clone 'pe-parse'. Retry scheduled
    BUG: submodule considered for cloning, doesn't need cloning any =
more?
    fatal: could not get a repository handle for submodule 'pe-parse'

I noticed here that the submodule config file =
`.git/modules/pe-parse/config` was written by the=20
first failed recursive checkout with this content:

    $ cat .git/modules/pe-parse/config
    [core]
        worktree =3D ../../../pe-parse

I next tried `git sub deinit --all -f` and retried `git submodule update =
--init`, but still got the
same error. This is in part because the deinit leaves and empty file =
`.git/modules/pe-parse/config`.
Removing this file and retrying gives the same error. Removing the =
directory  `.git/modules/pe-parse/`=20
and retrying finally succeeds in cloning the submodule.

Afterwards, alternating `git checkout --r master` and `git checkout --r =
93ffe67` both succeeds.

In my opinion there are several things that are going wrong here:

1. The most user-friendly approach, I think, would be that  `git clone =
--recurse-submodules` would
look at the history of all branches and clone any submodules it finds. =
This would require the most
code modification, and might not be desired in some cases, so maybe it =
should be opt-in=20
(i.e. adding supplementary flag).

2. Maybe it would be safer to *not* write `submodule.active=3D.` to the =
config if no submodules=20
are present in the HEAD commit of the branch checked out by `git clone`. =
This would alleviate=20
the situation you got (the recursive checkout would succeed, the =
submodule would not be=20
checked out, but `git submodule update --init` would clone it and check =
it out.)

3. I think `git checkout --recurse-submodules` should not leave the tree =
and the submodule config file
in a hard-to-recover-from state if it can't correctly checkout the =
submodules. It should abort completely=20
and cleanly and say it can't find the submodule repository, and tell the =
user how to clone it.

4. I think `git submodule update --init` should succeed in cloning the =
submodule if the=20
`.git/modules/pe-parse/` directory exists but is empty. I also think it =
should succeeds=20
if the only file in it is an empty `config` file. Probably it should =
also succeed if
the config file contains the `core.worktree` config as above.

5. I think `git submodule deinit --all -f` should not let an empty =
config file in the submodule repository.

I'm CC-ing some people that I *think* are working on some aspects of =
submodules=20
(Jonathan and Emily, forgive me if that's not the case!) in case they =
want to add to the analysis above.

Cheers,

Philippe.

[1] =
https://github.com/git/git/blob/d61d20c9b413225793f8a0b491bbbec61c184e26/b=
uiltin/clone.c#L821-L847
[2] =
https://github.com/git/git/blob/d61d20c9b413225793f8a0b491bbbec61c184e26/b=
uiltin/clone.c#L1087-L1092=
