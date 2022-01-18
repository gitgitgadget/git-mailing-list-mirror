Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76651C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiAROnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:43:01 -0500
Received: from mout.web.de ([212.227.15.14]:53377 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbiAROnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 09:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642516953;
        bh=E/HMCJ7UzM2Q7QxGpXODkwYCfntGOcVy4TUDj0HtHRE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=exWynCs3+VkIpbrv43GMjiHWPiAFuNJ223hIZ/lprjBXb+9UT9zr4dGfK1Clfrvf1
         DMh58phK2APqgsuAb4B5LjgQfQ4Q4lh6GeANse44OmSHHfV74KacxBKFBlVq0YA+6I
         k9Hwdnt3o+LF/z7UsfjEBeOMcEgqGIQtiSFHb0JI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxYXF-1mPh561p0L-00xSHm; Tue, 18
 Jan 2022 15:42:33 +0100
Message-ID: <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de>
Date:   Tue, 18 Jan 2022 15:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file
 names
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
 <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W/rMscqxenCGaZvLDQZf56vD/UU+OeurcC2mQg0A0ZmtIpxWADj
 4Q8jowykkb9KHeGCrPoZpzGS6SB3YgJWDXJbNuooM+YhWdUWLE+VdV4v1b3TREtHSV2+F09
 SH/xWEdqQooKRtJy9TMXd6PqxcP63nmPkdvu5XD43D5zwl3NCEmxRW3G8cHyKIths6HCiQZ
 5297dEpm8shghjiQeDTkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q16GRx1ruR0=:s6yiKu59lRWXsMfiE60H5H
 iXuCOnliqV/tJUdLeKdVAxIbFOV/0CTwmTbsihgo88OI1xWJxJUwbi86NF1+BBwiKHqJFFgU4
 8W6sAE+sdiIJRWYLsKCaFRlLzQBUl8CFVGGR2lTEmEfbt0gfRflOvUnZBVfyvXwbUa2rZMeux
 ybnG7doZyNDWloCk0m/4Gco88DyZnCSY1ZMmspNApTh93io7v0bc8ezpnMoZdZhwjdrEXohT2
 y32fY/ACK3sV4PHwASdV1G1DPuN2pS2vXk0it9tuW9KfXHGV4EgDQdUHx/PVFrGerH85BdwQK
 gS7edPJlZzHKJIRvjSQgpZEIWsTqsL/aBOf3pxzly+iACYJUrunavBsywq9yYN4LvvS6f8Sqp
 vvR61npCjGdBh72uNyp/BcrZAzikRi9GToaWqYMltB7rTBtdEikY3l5LfIgDdsVGcOn1VWoqn
 Gx7YVeibY1Wh/8wbNVZa2pkWbylHuV3JGYBsEvfwkrGisR2bJq/1aqCrWQyJTSLvUtiNcYFB/
 VseJhUFfJ5kzEHrY1tQAjf/W9b/MOL7FN5ZjLDc8BuiAWraEj/bhbejLNbqIDA1SRJQPQ+j78
 1L0l304/HkqWr3y693UJwYrS9mWFgvHgRJBF8OOA69R5YepCIEvPQ7zU/1OQBnnBXVSBGNkAr
 cxQQ0btprwghWQDHogBfVmy/FXkZEHDlnBjYA0UuPz8UNf7JLvq7aA0792KSUzByqXiZuImPo
 tDQMtMLFxfW01OfMslKgFLWIwGl6ksIXkz8fcIdRyfU5nsvODB40D/2vKuPOeGQ/j+yRmUbYi
 4i2RPA1ltoUK/+eFMKwxChQMO3093bMzE2PWhUiPMGev9UlKF05zjTbY9SkKZoi4yFlBB+cog
 lhox6VZ5yu7pSIIkbi6XVhnczJXmhPb6goxi7A2LQ9H+wCbBk7DaN9LkXt8M8Bmdvj/BMidAs
 Rac7a0qJ5oeXVyGsKHSnXLSP6p/T/WqimBj4gMzRxJuhGZ0j3eTErlWR3+qjHHQ3Q7zbJMZZD
 GCa4BTvCR3v1ATomcFm8RG6DBj4GBdB2yUs8aP7+WwSMk7K+WkGhT6zr6QDMcZuVXg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.22 um 10:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jan 17 2022, brian m. carlson wrote:
>
>> The current way we generate random file names is by taking the seconds
>> and microseconds, plus the PID, and mixing them together, then encoding
>> them.  If this fails, we increment the value by 7777, and try again up
>> to TMP_MAX times.
>>
>> Unfortunately, this is not the best idea from a security perspective.
>> If we're writing into TMPDIR, an attacker can guess these values easily
>> and prevent us from creating any temporary files at all by creating the=
m
>> all first.  Even though we set TMP_MAX to 16384, this may be achievable
>> in some contexts, even if unlikely to occur in practice.
>> [...]
>
> I had a comment on v1[1] of this series which still applies here,
> i.e. the "if we're writing into TMPDIR[...]" here elides the fact that
> much of the time we're writing a tempfile into .git, so the security
> issue ostensibly being solved here won't be a practical issue at all.
>
> Then for out-of-repo tempfiles some OS's have a per-user $TEMPDIR you
> can use (e.g. systemd's /run/user/`id -u`). Finally...
>
>> Note that the use of a CSPRNG in generating temporary file names is als=
o
>> used in many libcs.  glibc recently changed from an approach similar to
>> ours to using a CSPRNG, and FreeBSD and OpenBSD also use a CSPRNG in
>> this case.  Even if the likelihood of an attack is low, we should still
>> be at least as responsible in creating temporary files as libc is.
>
> ...we already have in-tree users of mkstemp(), which on glibc ostensibly
> tries to solve the same security issues you note here, and the
> reftable/* user has been added since earlier iterations of this series:
> o
>     $ git grep -E '\bmkstemp\(' -- '*.[ch]'
>     compat/mingw.c:int mkstemp(char *template)
>     compat/mingw.h:int mkstemp(char *template);
>     entry.c:                return mkstemp(path);
>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab_file_name.buf);
>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab->buf);
>     reftable/stack_test.c:  int fd =3D mkstemp(fn);
>     wrapper.c:      fd =3D mkstemp(filename_template);
>
> This series really feels like it's adding too much complexity and
> potential auditing headaches (distributors worrying about us shipping a
> CSPRNG, having to audit it) to a low-level codepath that most of the
> time won't need this at all.

Good point.  Please let me think out loud for a moment.

mkstemp() is secure (right?) and used already.  mkstemps() was used as
well until b2d593a779 (wrapper.c: remove unused gitmkstemps() function,
2017-02-28).  What's the difference?  The former requires the random
characters at the end (e.g. "name-XXXXXX"), while the latter allows a
suffix (e.g. "name-XXXXXX.ext"); that's what the added "s" in the name
means, I guess.  And apparently mkstemp is everywhere, but mkstemps is
a GNU extension.

git_mkstemps_mode is used by mks_tempfile_sm, mks_tempfile_tsm and
git_mkstemp_mode.  The latter uses no suffix, so could be implemented
using mkstemp and fchmod instead.

mks_tempfile_sm is called by write_locked_index, mks_tempfile_s,
mks_tempfile_m and mks_tempfile.  Only mks_tempfile_s uses a suffix,
but is itself unused.  So an implementation based on mkstemp and fchmod
would suffice for mks_tempfile_sm users as well.

mks_tempfile_tsm is used by mks_tempfile_ts, mks_tempfile_tm and
mks_tempfile_t.  Only mks_tempfile_ts uses a suffix.  Its only caller
is diff.c::prep_temp_blob, called only by diff.c::prepare_temp_file,
called by add_external_diff_name and run_textconv in the same file.

So if I didn't take a wrong turn somewhere the only temporary file name
templates with suffixes are those for external diffs and textconv
filters.  The rest of the git_mkstemps_mode users could be switched to
mkstemp+fchmod.

Temporary files for external diffs and textconv filters *should* be
placed in $TMPDIR.  Do they need suffixes?  I guess for testconv
filters it doesn't matter, but graphical diff viewers might do syntax
highlighting based on the extension.

Can we get extensions without mktemps or git_mkstemps_mode?  Yes, by
using mkdtemp to create a temporary directory with a random name and
creating the files in it.  There already are mkdtemp users.

So AFAICS all use cases of git_mkstemps_mode can be served by
mkstemp+fchmod or mkdtemp.  Would that help?

> So instead of:
>
>  A. Add CSPRNG with demo test helper
>  B. Use it in git_mkstemps_mode()
>
> I'd think we'd be much better off with:
>
>  A. Split out callers of tempfile.c and mk.*temp in wrapper.c that creat=
e tempfiles in .git
>  B. <the rest>
>
> I honestly haven't looked too much at what <the rest> is, other than
> what I wrote in [1], which seems to suggest that most of our codepaths
> won't need this.
>
> I'd also think that given the reference to CSPRNG in e.g. some glibc
> versions that instead of the ifdefs in csprng_bytes() we should instead
> directly use a secure mkstemp() (or similar) for the not-.git cases that
> remain after the "mktemp in a dir we chown" v.s. "mktemp in shared /tmp"
> are split up.
>
> Maybe these are all things you looked at and considered, but from my
> recollection (I didn't go back and re-read the whole discussion) you
> didn't chime in on this point, so *bump* :)
>
> 1. https://lore.kernel.org/git/211116.864k8bq0xm.gmgdl@evledraar.gmail.c=
om/

