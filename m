Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4CDC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCF32064A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIJXAOH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633350AbgDNUpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633343AbgDNUpQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:45:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94008C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:45:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s63so10771628qke.4
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E+q+vnyyvVNh0Vc8o9PFLYp5gno8t8lje/T3iF7Z25g=;
        b=WIJXAOH5pqkuvVKGreAxePPAWzy0SFzD1qlJYwm/nyTv/T8m+zxirBZCIsqCohBKYN
         5Z3NA37KNx5mlvUll0RFUseJablMMpJV03Mo1l1zgBezGCesy/L0nlTzKsp4t8yYXA66
         ZT+Y6qcXzim6bUrX93XDWCqZVa5nMiSebNegBAVOfEiPT845cfiO2RGajBmMTm75YwPH
         t6OC6vo9+axx4ixyIVflrclra0HolIsAlB8KmFPJ005ys3drwsjrlFjdo/Gv5xThwwgm
         jKMpdBAAcj6ZNzC3Hj0d/i/YqMUjQH5I5Edc78GAy36LqSJLq/l1RtbMqUkqdgDrDfP9
         uK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E+q+vnyyvVNh0Vc8o9PFLYp5gno8t8lje/T3iF7Z25g=;
        b=LrRuvOo/dHDhrqfJCmYRK3GWOGe+sU3UZkBF25FJW+oZIvwzjnagHkoHI9JJ7uLbPH
         c87nHZoh3LhcdDR/+bzHg0KVMh4L/CkQQPOeZ3/hBwbKDx7Kvzd4aIutBRuczTOIK7xa
         z/JAZoNTTmCZ0L12x9tBR3b9Y3tLRqijjM9mCMyPbysiTHr47zeR8MwpRviIKpBTtbVy
         KBG7sjUI4aihbE+O/yHB7KsksZq/J4rr2O3JxxjyIw72o5kmwIHxGHh7pi/JN1FC/ybL
         K5loZ4Z7SLyzjnsZSjhjfFLkj5OPBlKHy+0CU53eikHBUjL5frsLLZk6nIEJvi3pVbPK
         HBPA==
X-Gm-Message-State: AGi0Pubkthmm+z0nL3nu6Po+Zx8lKX12JIJTRJTtN/mbhCsuaFXzm1SA
        ck+pSsz3yhELSpXtPzN6RHg=
X-Google-Smtp-Source: APiQypIN+8l6qxg1arkqTxqDp414wQ0XLC+DMnIQUuIqYVBTHtYgGODc3O675NupQ5b8cY7h7NLcDg==
X-Received: by 2002:a05:620a:16b0:: with SMTP id s16mr23518526qkj.204.1586897115841;
        Tue, 14 Apr 2020 13:45:15 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id c8sm11378819qke.90.2020.04.14.13.45.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 14 Apr 2020 13:45:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: rebase backend change interaction with rebase.abbreviateCommands and autostash
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CABPp-BGSQ-FLv-9PS8EJGCivd2pMwYi57mgqKP_7U6HoRuxgAQ@mail.gmail.com>
Date:   Tue, 14 Apr 2020 16:45:12 -0400
Cc:     git <git@vger.kernel.org>, Alban Gruin <alban.gruin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09D4E5D9-9F7C-447B-9E46-C7B98EF1BD38@gmail.com>
References: <34B51521-42CD-445B-AE91-4A659A7FE661@me.com> <CABPp-BGSQ-FLv-9PS8EJGCivd2pMwYi57mgqKP_7U6HoRuxgAQ@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 14 avr. 2020 =C3=A0 16:30, Elijah Newren <newren@gmail.com> a =
=C3=A9crit :
>=20
> On Tue, Apr 14, 2020 at 1:27 PM Philippe Blain <philippe.blain@me.com> =
wrote:
>>=20
>> Hi,
>>=20
>> I just had a bizarre error related to the change in the merge =
backend. I don't have a full reproducer yet but the following sequence =
should hopefully give some hints.
>>=20
>> In my config for this repo I have `pull.rebase=3Dtrue` and in my =
global config I have
>>=20
>> [rebase]
>>        abbreviateCommands =3D true
>>        autoSquash =3D true
>>=20
>> Also my local `master` branch tracks `origin/master`.
>>=20
>> If `master` on `origin` is at the same commit as my local master =
branch, and I have some uncommitted change so I must use `--autostash`:
>>=20
>> ```
>> $ git pull --autostash
>> Created autostash: 6a6c685
>> Applied autostash.
>> error: nothing to do
>>=20
>> $ git pull --autostash --apply
>> # or right that just works for `git rebase`
>> ```
>>=20
>> Now if `master` on `origin` is ahead of my local `master`:
>>=20
>> ```
>> $ git pull --autostash
>> remote: Counting objects: 6, done.
>> remote: Compressing objects: 100% (6/6), done.
>> remote: Total 6 (delta 4), reused 0 (delta 0)
>> Unpacking objects: 100% (6/6), 758 bytes | 6.00 KiB/s, done.
>> =46rom <redacted>
>>   42033de..a3d6919  master     -> origin/master
>> Created autostash: cdae23b
>> Applied autostash.
>> error: nothing to do
>>=20
>> Now if I stash manually and re-pull:
>>=20
>> $ git stash push -m "test rebase merge"
>> Saved working directory and index state On master: test rebase merge
>> $ git pull
>> Updating 42033de..a3d6919
>> Fast-forward
>> .gitconfig | 1 +
>> .tmux.conf | 2 +-
>> 2 files changed, 2 insertions(+), 1 deletion(-)
>> error: nothing to do
>> $ git pull
>> Already up to date.
>> error: nothing to do
>> $ git -c rebase.abbreviateCommands=3D0 pull
>> Already up to date.
>> Successfully rebased and updated refs/heads/master.
>>=20
>> Note: I also got  "error: nothing to do"  when manually running the =
commands in the last test of t/t5572-pull-submodule.sh ("branch has no =
merge base with remote-tracking counterpart') (and again using `git -c =
rebase.abbreviateCommands=3D0` succeeded).
>>=20
>> Cheers,
>> Philippe.
>=20
> What version of git are you running with?  Does it include Alban's
> fixed for the rebase.abbreviateCommands error?
> =
(https://lore.kernel.org/git/20200330124236.6716-1-alban.gruin@gmail.com/)=


I was not aware of this patch series - I'm at v2.26.0-106-g9fadedd637 =
(on `master`), so no it does not include it.

Thanks!

