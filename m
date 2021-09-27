Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D59C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD36F61074
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhI0M4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhI0M4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:56:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935DC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g7so9419193edv.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qs88r9pMvFE1N7Lwg5NgtGsteOr32qgRLouapcrapkI=;
        b=nitZCJF+N5x3VqRZyCwIPHeUa9Ob3BlDgzi5AwMsH+n4RdG6aTBZ19ZPdF3JvedvDV
         gKhlIJwBYAv6E6x8hlo1GGSs2dJIVE/IqlFg2PQO8c8opF9a8c543lwa6lZM6x3d+ZEF
         OkQnbhkFMbo9kkNREhqL7gJvDsE1r+LWuwUkNAMIUZduxq31ukFZQdibpaLJNuEg7+wy
         ii4ijjPb7y2fuuGBHxrpqEygMdyPQyBQNL5QANeViW891sTK9Dp6+WmlwG2Q+8p4JXWF
         CiGg7e7TCcf4lI0YRYDHuOv71itnFZJ0EH8c3UTX0sWTU+p6vjkv1NZFCs1EPfE72hhm
         va0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qs88r9pMvFE1N7Lwg5NgtGsteOr32qgRLouapcrapkI=;
        b=ORGSklSxgWNobYFDrFSgdnt1eVi9CIruTQTbQcwyIsU8b+OJIQZKnB0ouA3TrNnVil
         pQq/Apth0KccZ74/fbS1HlQ3Wq8Upk6JHlKT4o9yHoK9yPs1XBhMh1Oa/ou9SEY0y3A9
         iyxvsQMzBpN46swNBVOKA51gOyvCpy0fw/jSnRd7Cq4Qju6bVWnj7DtOdo5PUYken98X
         PrS9WygCbA36QpdAzP1CFA/CZ2AVITFJrc4hskA/m/hV8C7LDrn4284qislDDUA8bikz
         r3OB8WM8R8gPZ0JVN8VY6Z9aB3xuihsS/1bgNRXFNjLN62Xsc8303K6lNbIkg4eDlz42
         YDdQ==
X-Gm-Message-State: AOAM533nfh4CVuGSM2nKZDbpdJG73SFgAQjrjWnoCk4hwGTfZ+OLmJfa
        +kGgBafAEiL6F+c+nwKoQVi0kCSbMqjqGg==
X-Google-Smtp-Source: ABdhPJyjLd65mPnhUdI/OeRc18BM39kgg4TUJ2GXGxGgVHRkOQc8Fld7Ohfi7mft8xodz0F61eIkew==
X-Received: by 2002:a17:906:32d6:: with SMTP id k22mr26440221ejk.228.1632747264601;
        Mon, 27 Sep 2021 05:54:24 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l25sm436455eda.36.2021.09.27.05.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:54:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v10 0/3] maintenance: add support for systemd timers on
 Linux
Date:   Mon, 27 Sep 2021 14:50:28 +0200
References: <20210827210255.12565-1-lenaic@lhuard.fr>
 <28e0f22a-e9be-bb18-df0f-4d95cb6d5145@gmail.com>
 <4c0c1fd4-f3f4-5e3a-abd2-0350c18b18b7@gmail.com>
 <1749747.rkkkC1iLqI@coruscant.lhuard.fr>
 <0d1a8684-65c9-5229-0cd5-2e3f4a0914f3@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <0d1a8684-65c9-5229-0cd5-2e3f4a0914f3@gmail.com>
Message-ID: <874ka618n4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, Derrick Stolee wrote:

> On 9/9/2021 1:52 AM, L=C3=A9na=C3=AFc Huard wrote:
>> Le mercredi 8 septembre 2021, 13:44:26 CEST Derrick Stolee a =C3=A9crit :
>>> On 9/7/2021 12:48 PM, Derrick Stolee wrote:
>>>> On 9/4/2021 4:54 PM, L=C3=A9na=C3=AFc Huard wrote:
>>>>> Hello,
>>>>>
>>>>> Please find hereafter my updated patchset to add support for systemd
>>>>> timers on Linux for the `git maintenance start` command.
>>>>>
>>>>> The only changes compared to the previous version are fixes for the
>>>>> two typos in a comment that Ramsay Jones pointed out [1]
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@rams=
ayj
>>>>> ones.plus.com/>=20
>>>> The changes in the most recent two versions look good to me.
>>>
>>> I recently tested the 'seen' branch for an unrelated reason, but found
>>> that the t7900-maintenance.sh test failed for me. It was during test 34,
>>> 'start and stop Linux/systemd maintenance' with the following issue:
>>>
>>>   + systemd-analyze verify systemd/user/git-maintenance@.service
>>>   Failed to create /user.slice/user-1000.slice/session-44.scope/init.sc=
ope
>>> control group: Permission denied Failed to initialize manager: Permissi=
on
>>> denied
>>>
>>> Now, this test has the prereq SYSTEMD_ANALYZE, but for some reason this
>>> later command fails for permission issues. I'm running Ubuntu, if that
>>> helps.
>>=20
>> Thank you for the feedback.
>>=20
>> Could you please share which version of Ubuntu and which version of syst=
emd=20
>> you are using=E2=80=AF?
>>=20
>> I=E2=80=99ve just tried to start an Ubuntu Impish 21.10 which uses syste=
md=20
>> 248.3-1ubuntu3 and to test the `seen` git branch.
>>=20
>> All tests of `t/t7900-maintenance.sh` passed including the one which is=
=20
>> failing for you.
>>=20
>> As `systemd-analyse verify` should only check a unit file validity [1], =
I=20
>> wouldn=E2=80=99t expect it to fail on a cgroup manipulation.
>>=20
>> [1] https://www.freedesktop.org/software/systemd/man/systemd-analyze.htm=
l#systemd-analyze%20verify%20FILE...
>>=20
>> I tried to run=20
>> systemd-analyze verify /etc/systemd/system/sshd.service
>> and it didn=E2=80=99t produce the error you mentioned but if I `strace` =
it, I can find:
>>=20
>> mkdir("/sys/fs/cgroup/unified/user.slice/user-1000.slice/session-3.scope/
>> init.scope", 0755) =3D -1 EACCES (Permission denied)
>>=20
>> This makes me think your version of systemd is wrongly considering this =
cgroup=20
>> directory failure as fatal.
>> I=E2=80=99d like to know more precisely which versions are affected.
>  I am on Ubuntu 18.04.
>
> $ systemd --version
> systemd 237
> +PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
> +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=3Dhybrid
>
> I tried upgrading with apt-get, but that did not get me a new
> version.

It seems this discussion has gone stale, but this is still broken on
some systems. This is gcc135 on the GCC Farm, which passes the prereq
this commit adds:

    $ systemd-analyze verify systemd/user/git-maintenance@.service
    Failed to open /dev/tty0: Permission denied
    Failed to load systemd/user/git-maintenance@.service: Invalid argument

I don't know the systemd specifics involved, but this seems like a
rather straightforward problem of assuming permissions that aren't
universal. I.e. let's try to do that in the prereq instead?

OS details, if they matter:
=20=20=20=20
    [avar@gcc135 t]$ systemd-analyze --version
    systemd 219
    +PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSET=
UP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN
    [avar@gcc135 t]$ cat /etc/centos-release
    CentOS Linux release 7.9.2009 (AltArch)
=20=20=20=20
