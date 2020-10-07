Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC25C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB4C2083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCkXxRRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJGV3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgJGV3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:29:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF0C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 14:29:48 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so4711589qki.6
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uxucEEPO7rezEQ8O3mazwzmOQ+ZvZCRGaVtEjxCbQvw=;
        b=KCkXxRRTjWMkNZzcMF1ydOtJlIuPlMSDD4crb6GhrniUtm213Mfp0Oc9fwbI1O5BRu
         /Z+N+1F9wZx1GwMclO/MAj96xErUiS2531xu+X+0MYRvZmZZFv9a2LUSpyt1f0KdGEg5
         UdO5iywUKhUraClaJmKG6qqy69DNfhlL36t7hwyw9RPgQTDuyR9vyl6s14jqlQN7xrmH
         h97eqhD2KvBMGgERW0k2Z/Sul+qbyMKDv3mDhfCvyjjSWxW3t9S1M54ZnwvvuLHQ/Qtb
         cCkbzOOrlFhrdmU1OBG/DoJnA6YXwG8bcpLp+gQd70pEyOlRvUu/RPb7QQWwEYxJzh/F
         jkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uxucEEPO7rezEQ8O3mazwzmOQ+ZvZCRGaVtEjxCbQvw=;
        b=lC7rzTHhOcgjDRpMxMJyw4VPvhO4FYkj8Ajp7vj+8Yh203zIzidLoV/K7u948SbKRL
         IBqeydRHg4ZZ9Dk5c00GJZW0S75gS2s5SjaJiusSQxmZ68ZHjGfwpoJpk8+Hhf1mU6pt
         RLD28ymiBKLN91AWvMwTgLg2JKLloePM8uef+c0D0mK5KKg6qK0Gt4YVYZ4kcHnRhwF1
         H2Gg/2vyAO4387PQMjlWZ3O+my+k9R1ubtOg15KpkY6eU8I3iro0aRFvmGuu0DLhTEQE
         X9DtuDrlXN/B8I4K7kZD3rM2vZsGbROIJM55sCEDlRSsEYkgOuVgLAtwzGuAKyusyKXm
         RNuA==
X-Gm-Message-State: AOAM531tj6DPbzHcrnBk55izfJKJQPst+q0X4VJrTpK86vt0t2vC6LlG
        Q5kQ9eGk0/pPIEVQ+l9gaGQ=
X-Google-Smtp-Source: ABdhPJy18vu2pjBhrCYYOJa7pwpMFNzgheA9Qy0ZAjt4+ADTIPtCifyRkxkRtQbsnJhgvmAU6LMkcA==
X-Received: by 2002:a05:620a:15c4:: with SMTP id o4mr5228652qkm.166.1602106187122;
        Wed, 07 Oct 2020 14:29:47 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f14sm2333016qkh.134.2020.10.07.14.29.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 07 Oct 2020 14:29:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Checking Out Branches Containing Submodules With update=none and submodule.recurse=true Fails With fatal:not a git repository
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CABVQXt5E-R22G62W-tQieA7XiZKZiOA8Hp2xewYhwwOS8wFh0Q@mail.gmail.com>
Date:   Wed, 7 Oct 2020 17:29:40 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDB7D2C8-3164-4860-A999-F9BE565F7750@gmail.com>
References: <CABVQXt5E-R22G62W-tQieA7XiZKZiOA8Hp2xewYhwwOS8wFh0Q@mail.gmail.com>
To:     daniel mclean <maczor@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,=20

> Le 25 mars 2020 =C3=A0 00:19, daniel mclean <maczor@gmail.com> a =
=C3=A9crit :
>=20
> Hello git developers,
>=20
> Firstly thanks for a great tool!
>=20
> I have run into an issue that it would be good to get your advice on.
>=20
> I have a git repository with multiple submodules.  A few of these
> submodules are configured with update=3Dnone so that they point to a
> specific commit but so that clone operations and submodule update
> operations don't retrieve their contents.
>=20
> When working with this repository and trying to change branches, git
> is reporting a fatal error when changing branches.  This can be worked
> around by deinit'ing the submodules before switching branches but that
> doesn't seem like it should be necessary.
>=20
> The reproduction steps are to:
> - Clone the repo
> - Checkout a branch containing submodules that are set with
> update=3Dnone (git checkout branch-name)
> - Update and init submodules (git submodule update --init)
> - Attempt to switch to a different branch (git checkout other-branch)
>=20
> At this point git will report an error at the first submodule with =
update=3Dnone:
> fatal: not a git repository: ../.git/modules/no-update-submodule
> fatal: could not reset submodule index

I tried reproducing this with the following script, but it does not fail =
for me:

```
!/bin/bash

set -x

create_repo () {
name=3D$1
rm -rf $name
git init $name
cd $name
date>>file
git add file
git commit -m "add file"
cd ../=20
}


create_repo super
create_repo sub1
create_repo sub2

cd super
git submodule add ../sub1
git submodule add ../sub2
git config -f .gitmodules submodule.sub1.update none
git add .gitmodules
git commit -m "add sub1 and sub2"
git co -b other-branch
date>>file
git add file
git commit -m "update file"
git checkout master
cd ../=20

rm -rf clone
git clone super clone
cd clone
git submodule update --init
git config submodule.recurse true
git checkout other-branch
# no error !
ls -R
```

If you could try to come up with a similar reproducer, it would help to =
better=20
diagnose this failure. I was not sure by reading your message if both =
branches
involved had the same number of submodules, or the same 'update' =
settings
for each submodules, so maybe that's where your use case differs from my =
script.

> After doing some sleuthing it seems that this is because when
> update=3Dnone the submodule repository is not cloned to
> .git/module/<module name>,

I gather that's the expected behaviour, no ?

> however when attempting to change branches
> using a checkout, git then stumbles since it expects the repository to
> be there.

I've seen that happen when going from a commit where the submodule
does not exist to a commit where it does exist, (see [1], [2]), but your =
situation
is a little different.

> If my understanding of how update=3Dnone for a submodule and git is
> correct, then it seems like it shouldn't be trying to do this since it
> should know that the repository isn't there (update=3Dnone after all).
> This behaviour occurs when I have submodule.recurse set to true,
> however interestingly when I set it to false I don't run into this
> issue.
> So it seems like these two directives are providing mixed messages in
> a sense, one says don't clone the submodule repo and the other says
> look into the submodule repo and try to find more submodules.

=46rom reading the documentation of `submodule.<name>.update` [3], it =
seems
that `git checkout` should not care about this config setting, but in my =
script above,
it seems it does (at least for the value "none"), or else it would crash =
as you describe...
I've not looked at the code in depth, but I might if you can come up =
with a reproducer.

Cheers,

Philippe.

[1] =
https://lore.kernel.org/git/CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+=
d1n=3Dg@mail.gmail.com/
[2] =
https://lore.kernel.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/T=
/#u
[3] =
https://git-scm.com/docs/git-config#Documentation/git-config.txt-submodule=
ltnamegtupdate

