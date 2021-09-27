Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19873C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E192060FC2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhI0VqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:46:25 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:47182 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237009AbhI0VqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:46:25 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:2b6b:76fe:e08a:5eba])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 884395116A6;
        Mon, 27 Sep 2021 23:44:14 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1632779054; bh=blMNfMwHxSfTinICc+ObK9/X0Vi3Ty2TXaB0GW+uy+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R7qNmOJSXbBegVMp3xvZdzeOlpRIoYqxU9/VPmnOSChCeOfBrZ6tivoTFoaYdHKVQ
         63YoZWwBr3hf7SJ0RGsHb/F23knJvN+14exOHlh2aKZ3UaklQfzWg9wMndSz16r6Am
         327JZBqouO5hI7emlEHHZmLBntdAXdj1fnn2H3go=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     Derrick Stolee <stolee@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v10 0/3] maintenance: add support for systemd timers on Linux
Date:   Mon, 27 Sep 2021 23:44:04 +0200
Message-ID: <7292569.mAQTRl3RYs@coruscant.lhuard.fr>
In-Reply-To: <874ka618n4.fsf@evledraar.gmail.com>
References: <20210827210255.12565-1-lenaic@lhuard.fr> <0d1a8684-65c9-5229-0cd5-2e3f4a0914f3@gmail.com> <874ka618n4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lundi 27 septembre 2021, 14:50:28 CEST =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason a =C3=A9crit :
> On Thu, Sep 09 2021, Derrick Stolee wrote:
> > On 9/9/2021 1:52 AM, L=C3=A9na=C3=AFc Huard wrote:
> >> Le mercredi 8 septembre 2021, 13:44:26 CEST Derrick Stolee a =C3=A9cri=
t :
> >>> On 9/7/2021 12:48 PM, Derrick Stolee wrote:
> >>>> On 9/4/2021 4:54 PM, L=C3=A9na=C3=AFc Huard wrote:
> >>>>> Hello,
> >>>>>=20
> >>>>> Please find hereafter my updated patchset to add support for systemd
> >>>>> timers on Linux for the `git maintenance start` command.
> >>>>>=20
> >>>>> The only changes compared to the previous version are fixes for the
> >>>>> two typos in a comment that Ramsay Jones pointed out [1]
> >>>>>=20
> >>>>> [1]
> >>>>> https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@ra=
msa
> >>>>> yj
> >>>>> ones.plus.com/>
> >>>>=20
> >>>> The changes in the most recent two versions look good to me.
> >>>=20
> >>> I recently tested the 'seen' branch for an unrelated reason, but found
> >>> that the t7900-maintenance.sh test failed for me. It was during test =
34,
> >>>=20
> >>> 'start and stop Linux/systemd maintenance' with the following issue:
> >>>   + systemd-analyze verify systemd/user/git-maintenance@.service
> >>>   Failed to create
> >>>   /user.slice/user-1000.slice/session-44.scope/init.scope
> >>>=20
> >>> control group: Permission denied Failed to initialize manager:
> >>> Permission
> >>> denied
> >>>=20
> >>> Now, this test has the prereq SYSTEMD_ANALYZE, but for some reason th=
is
> >>> later command fails for permission issues. I'm running Ubuntu, if that
> >>> helps.
> >>=20
> >> Thank you for the feedback.
> >>=20
> >> Could you please share which version of Ubuntu and which version of
> >> systemd
> >> you are using=E2=80=AF?
> >>=20
> >> I=E2=80=99ve just tried to start an Ubuntu Impish 21.10 which uses sys=
temd
> >> 248.3-1ubuntu3 and to test the `seen` git branch.
> >>=20
> >> All tests of `t/t7900-maintenance.sh` passed including the one which is
> >> failing for you.
> >>=20
> >> As `systemd-analyse verify` should only check a unit file validity [1]=
, I
> >> wouldn=E2=80=99t expect it to fail on a cgroup manipulation.
> >>=20
> >> [1]
> >> https://www.freedesktop.org/software/systemd/man/systemd-analyze.html#=
sy
> >> stemd-analyze%20verify%20FILE...
> >>=20
> >> I tried to run
> >> systemd-analyze verify /etc/systemd/system/sshd.service
> >> and it didn=E2=80=99t produce the error you mentioned but if I `strace=
` it, I can
> >> find:
> >>=20
> >> mkdir("/sys/fs/cgroup/unified/user.slice/user-1000.slice/session-3.sco=
pe/
> >> init.scope", 0755) =3D -1 EACCES (Permission denied)
> >>=20
> >> This makes me think your version of systemd is wrongly considering this
> >> cgroup directory failure as fatal.
> >> I=E2=80=99d like to know more precisely which versions are affected.
> >>=20
> >  I am on Ubuntu 18.04.
> >=20
> > $ systemd --version
> > systemd 237
> > +PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
> > +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
> > +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=3Dhybrid
> >=20
> > I tried upgrading with apt-get, but that did not get me a new
> > version.
>=20
> It seems this discussion has gone stale, but this is still broken on
> some systems. This is gcc135 on the GCC Farm, which passes the prereq
> this commit adds:
>=20
>     $ systemd-analyze verify systemd/user/git-maintenance@.service
>     Failed to open /dev/tty0: Permission denied
>     Failed to load systemd/user/git-maintenance@.service: Invalid argument
>=20
> I don't know the systemd specifics involved, but this seems like a
> rather straightforward problem of assuming permissions that aren't
> universal. I.e. let's try to do that in the prereq instead?
>=20
> OS details, if they matter:
>=20
>     [avar@gcc135 t]$ systemd-analyze --version
>     systemd 219
>     +PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP
> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS
> +KMOD +IDN [avar@gcc135 t]$ cat /etc/centos-release
>     CentOS Linux release 7.9.2009 (AltArch)

Hello,

I=E2=80=99ve just submitted a new patch to change the way the prerequisite =
is=20
implemented:

https://lore.kernel.org/git/20210927213016.21714-2-lenaic@lhuard.fr/

I=E2=80=99m not sure what was going wrong with old versions of systemd but =
with this=20
new patch, the permission errors raised by `systemd-analyze` should now mak=
e=20
the prerequisite fail instead of making the test fail.



