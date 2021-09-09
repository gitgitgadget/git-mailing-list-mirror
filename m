Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96246C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 05:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E49760F13
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 05:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350648AbhIIFyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 01:54:22 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:48554 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350953AbhIIFyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 01:54:17 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:5893:3d2:2851:be4f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id A5DB34FAD92;
        Thu,  9 Sep 2021 07:53:04 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1631166784; bh=MpPzmSogbX/hzw2t7uvBhnV4X+4EapG9coeW44EDdxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=znPnhklSj1/4WdjnAQ1MAj46VVUPjYARVRdECEbbY7R/APon/rBKn9UhTcnfhO5aq
         LgGvfzG9TQX8o3bZd17r5fkRwE+LmrhYeMVsOp1c4ZfakT0PTmB2oiHbNk819oC3mz
         FYevk3PysSlWmKRi+vyPnNw+VsfQEqBIwJOdjtz4=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v10 0/3] maintenance: add support for systemd timers on Linux
Date:   Thu, 09 Sep 2021 07:52:56 +0200
Message-ID: <1749747.rkkkC1iLqI@coruscant.lhuard.fr>
In-Reply-To: <4c0c1fd4-f3f4-5e3a-abd2-0350c18b18b7@gmail.com>
References: <20210827210255.12565-1-lenaic@lhuard.fr> <28e0f22a-e9be-bb18-df0f-4d95cb6d5145@gmail.com> <4c0c1fd4-f3f4-5e3a-abd2-0350c18b18b7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 8 septembre 2021, 13:44:26 CEST Derrick Stolee a =C3=A9crit :
> On 9/7/2021 12:48 PM, Derrick Stolee wrote:
> > On 9/4/2021 4:54 PM, L=C3=A9na=C3=AFc Huard wrote:
> >> Hello,
> >>=20
> >> Please find hereafter my updated patchset to add support for systemd
> >> timers on Linux for the `git maintenance start` command.
> >>=20
> >> The only changes compared to the previous version are fixes for the
> >> two typos in a comment that Ramsay Jones pointed out [1]
> >>=20
> >> [1]
> >> https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@ramsa=
yj
> >> ones.plus.com/>=20
> > The changes in the most recent two versions look good to me.
>=20
> I recently tested the 'seen' branch for an unrelated reason, but found
> that the t7900-maintenance.sh test failed for me. It was during test 34,
> 'start and stop Linux/systemd maintenance' with the following issue:
>=20
>   + systemd-analyze verify systemd/user/git-maintenance@.service
>   Failed to create /user.slice/user-1000.slice/session-44.scope/init.scope
> control group: Permission denied Failed to initialize manager: Permission
> denied
>=20
> Now, this test has the prereq SYSTEMD_ANALYZE, but for some reason this
> later command fails for permission issues. I'm running Ubuntu, if that
> helps.

Thank you for the feedback.

Could you please share which version of Ubuntu and which version of systemd=
=20
you are using=E2=80=AF?

I=E2=80=99ve just tried to start an Ubuntu Impish 21.10 which uses systemd=
=20
248.3-1ubuntu3 and to test the `seen` git branch.

All tests of `t/t7900-maintenance.sh` passed including the one which is=20
failing for you.

As `systemd-analyse verify` should only check a unit file validity [1], I=20
wouldn=E2=80=99t expect it to fail on a cgroup manipulation.

[1] https://www.freedesktop.org/software/systemd/man/systemd-analyze.html#s=
ystemd-analyze%20verify%20FILE...

I tried to run=20
systemd-analyze verify /etc/systemd/system/sshd.service
and it didn=E2=80=99t produce the error you mentioned but if I `strace` it,=
 I can find:

mkdir("/sys/fs/cgroup/unified/user.slice/user-1000.slice/session-3.scope/
init.scope", 0755) =3D -1 EACCES (Permission denied)

This makes me think your version of systemd is wrongly considering this cgr=
oup=20
directory failure as fatal.
I=E2=80=99d like to know more precisely which versions are affected.

Kind regards,
L=C3=A9na=C3=AFc.


