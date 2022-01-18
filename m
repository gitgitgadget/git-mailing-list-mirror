Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF0C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbiARQoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:44:55 -0500
Received: from mout.web.de ([212.227.15.4]:46769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346352AbiARQop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642524258;
        bh=cW1oltUn8XOl/nfyTkLbQwvmFKUijyC/qaS4Isx7HIc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sECLIgU3e6S8VvE1B7OM/qqPyyuMcYcmVn4BMCsN07tEERcDkz/WOF15A/2rzR0Yf
         a5kpniptPEvuOzwcjiyo72G0X4StfZe6AC1+O4JB/088pRS0GgRvyuFz7U3I6rbtyD
         /sbFkZmomznub2AYN7JejSpuW/BVJoHkYm7NCIIU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xw0-1nAwzV3ZZU-003oev; Tue, 18
 Jan 2022 17:44:17 +0100
Message-ID: <a36eb6e6-3e5d-287f-eecd-aaba62fc86ef@web.de>
Date:   Tue, 18 Jan 2022 17:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file
 names
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
 <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
 <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de>
 <220118.86mtjtozex.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220118.86mtjtozex.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F33EXbtCH63mixEivuvQLKMCAtVMkc0bjK3B2TwvvZ5woc1vipg
 Iy3l7X6DVTRYCHlKKO3N+cT0rs88YjeK/VcGxBGoiIyuxeZwQaM8z9pNmTvA8P44uBQCIcW
 SKUIZR97ALvNXzzvXythhmsKazAWeF1/olA+NH0QjIQGMfAn/gaxb7sjUF8qeguJMKu0Tvn
 KU9tJ2+IWmUKoNj7NHWsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZunrWLMBWmo=:PJfvNK8dOFp4XKL3Lerr6U
 IiwbG9n9PqtphcqMlYRiJ7HFN4AWbiUjG/l1U7FV6tUY1+q45RdiSFx2F71+TeTI9HaVA7dRs
 JhwdByNE1jzpIvWMk3FypVf4RZttY0J3xTcMseWoVxgxreguk+h9vA1VA7ufPRspJAGZu59FJ
 JKqC0x14PuxJW1sRjLwBODqbPAYQ9rWKsIZGcJOc8RUomC+Wx3fYg4U7/TLiz0xJzxJkNZSPS
 TaRN/Tiv3ioF0Voj0rg7LvZDQtpVXV2NYmRz/JtzIACowSrwDMdUeFARcCPvA2voSVmBzKf/a
 MMa48TzPIU1QWJ/ND/kDWntyKzfJTgRVjXwxYkrhsYa7hPycQ6jd9oo4YrVvlCzzwwZ9690te
 z5iaMU5H0uWgf4kW1ejtwMH6AjWHbBGAME+BEDKykj9vkblV2UEFoBiY5wXrXLgPYZ6Z5Trfh
 ee8kNAqt2/RlXgNrzhSfaUNQyX6W44TZ6ZI5/aQVbYNbvc9R+vbbp8gyeWv2lbC5NOWSvH1V3
 w+4TV5aXZJssHTKOQguF7DcSxGJODrSzvLXIuZVrh5qD+WfN4viNvNxod8teGzO28I+Moiba9
 fYFqKq9RSBT0tXYohQNEO26X+3HbRLJrA987FIyHyPvRae8xUAv2QN9Mt/OkOCIMg8oL7NtDq
 rx93M+gHNBfpfwmOI0z35qBmzw1NISa/gMlKg0cbzYZ1LuiTj4BgxRWAIOMHXgmGzWf1piovK
 M84gklsQGecttiJtZr1TBRtSok14anpzlV3YhCAmX4RAEOjNj2qqR4iHoMUeKdItw+2pgBLEp
 lhIJ+z3k+cr8rw0ntXA8S0qgj/XLhpM04XqWBHNKzcBoWguCloKYEWHYopUFr1PJUKovYO7Fn
 2QeiBt+iITKKl+lG9P4tFuAw19Jyig0S6O9DkPa/DAQBekoHG+EU/iPpjQVhofwSp5Gw2VBDt
 2fOO2IGNbZZTZ0megZt6y1yPtfV7r/Q+gpqU9bZSEcdOTMJnGAK98lboIjiWZEG5b8EAQlwft
 3zxoNyxIMGSiGC/eyMu8VYQCQJpbcc1817FuN4AE4BEh/G/Reu7IgkDnvatcQwdloj56tLavX
 6ka4efXP3YyVlw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.22 um 15:51 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Jan 18 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 18.01.22 um 10:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Mon, Jan 17 2022, brian m. carlson wrote:
>>>
>>>> The current way we generate random file names is by taking the second=
s
>>>> and microseconds, plus the PID, and mixing them together, then encodi=
ng
>>>> them.  If this fails, we increment the value by 7777, and try again u=
p
>>>> to TMP_MAX times.
>>>>
>>>> Unfortunately, this is not the best idea from a security perspective.
>>>> If we're writing into TMPDIR, an attacker can guess these values easi=
ly
>>>> and prevent us from creating any temporary files at all by creating t=
hem
>>>> all first.  Even though we set TMP_MAX to 16384, this may be achievab=
le
>>>> in some contexts, even if unlikely to occur in practice.
>>>> [...]
>>>
>>> I had a comment on v1[1] of this series which still applies here,
>>> i.e. the "if we're writing into TMPDIR[...]" here elides the fact that
>>> much of the time we're writing a tempfile into .git, so the security
>>> issue ostensibly being solved here won't be a practical issue at all.
>>>
>>> Then for out-of-repo tempfiles some OS's have a per-user $TEMPDIR you
>>> can use (e.g. systemd's /run/user/`id -u`). Finally...
>>>
>>>> Note that the use of a CSPRNG in generating temporary file names is a=
lso
>>>> used in many libcs.  glibc recently changed from an approach similar =
to
>>>> ours to using a CSPRNG, and FreeBSD and OpenBSD also use a CSPRNG in
>>>> this case.  Even if the likelihood of an attack is low, we should sti=
ll
>>>> be at least as responsible in creating temporary files as libc is.
>>>
>>> ...we already have in-tree users of mkstemp(), which on glibc ostensib=
ly
>>> tries to solve the same security issues you note here, and the
>>> reftable/* user has been added since earlier iterations of this series=
:
>>> o
>>>     $ git grep -E '\bmkstemp\(' -- '*.[ch]'
>>>     compat/mingw.c:int mkstemp(char *template)
>>>     compat/mingw.h:int mkstemp(char *template);
>>>     entry.c:                return mkstemp(path);
>>>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab_file_name.buf)=
;
>>>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab->buf);
>>>     reftable/stack_test.c:  int fd =3D mkstemp(fn);
>>>     wrapper.c:      fd =3D mkstemp(filename_template);
>>>
>>> This series really feels like it's adding too much complexity and
>>> potential auditing headaches (distributors worrying about us shipping =
a
>>> CSPRNG, having to audit it) to a low-level codepath that most of the
>>> time won't need this at all.
>>
>> Good point.  Please let me think out loud for a moment.
>>
>> mkstemp() is secure (right?) and used already.  mkstemps() was used as
>> well until b2d593a779 (wrapper.c: remove unused gitmkstemps() function,
>> 2017-02-28).  What's the difference?  The former requires the random
>> characters at the end (e.g. "name-XXXXXX"), while the latter allows a
>> suffix (e.g. "name-XXXXXX.ext"); that's what the added "s" in the name
>> means, I guess.  And apparently mkstemp is everywhere, but mkstemps is
>> a GNU extension.
>>
>> git_mkstemps_mode is used by mks_tempfile_sm, mks_tempfile_tsm and
>> git_mkstemp_mode.  The latter uses no suffix, so could be implemented
>> using mkstemp and fchmod instead.
>>
>> mks_tempfile_sm is called by write_locked_index, mks_tempfile_s,
>> mks_tempfile_m and mks_tempfile.  Only mks_tempfile_s uses a suffix,
>> but is itself unused.  So an implementation based on mkstemp and fchmod
>> would suffice for mks_tempfile_sm users as well.
>>
>> mks_tempfile_tsm is used by mks_tempfile_ts, mks_tempfile_tm and
>> mks_tempfile_t.  Only mks_tempfile_ts uses a suffix.  Its only caller
>> is diff.c::prep_temp_blob, called only by diff.c::prepare_temp_file,
>> called by add_external_diff_name and run_textconv in the same file.
>>
>> So if I didn't take a wrong turn somewhere the only temporary file name
>> templates with suffixes are those for external diffs and textconv
>> filters.  The rest of the git_mkstemps_mode users could be switched to
>> mkstemp+fchmod.
>>
>> Temporary files for external diffs and textconv filters *should* be
>> placed in $TMPDIR.  Do they need suffixes?  I guess for testconv
>> filters it doesn't matter, but graphical diff viewers might do syntax
>> highlighting based on the extension.
>>
>> Can we get extensions without mktemps or git_mkstemps_mode?  Yes, by
>> using mkdtemp to create a temporary directory with a random name and
>> creating the files in it.  There already are mkdtemp users.
>>
>> So AFAICS all use cases of git_mkstemps_mode can be served by
>> mkstemp+fchmod or mkdtemp.  Would that help?
>
> That seems sensible, as a further practical suggestion it seems like
> we'll retry around 16k times to create these files on failure, perhaps
> trying with a custom extension 8k times would be OK, followed by the
> minor UI degradation of doing the final 8k retries with the more-random
> OS-provided extension-less variant.

You can't use the suffix-less mkstemp if a suffix is necessary.

Retries would be handled by mkstemp and mkdtemp IIUC.  To an extent.
E.g. https://cgit.freebsd.org/src/tree/lib/libc/stdio/mktemp.c seems
to just count up, which doesn't help if an attacker guessed the first
name correctly.  So maybe some kind of EEXIST loop is still necessary.

> More generally I'm still not sure if this is still a purely hypothetical
> attack mitigation, or whether there are actually users out there that
> have to deal with this.
>
> Wouldn't something like this also be an acceptable "solution" to this
> class of problem?
>
> 	#define TMP_MAX 1024
> 	[...]
> 	if (count >=3D TMP_MAX)
> 		die(_("we tried and failed to create a tempfile using the '%s' templat=
e after %d tries!\n\n"
>                     "Is someone actively DoS you? Is your sysadmin known=
 to be your mortal enemy?\n"
>                     "are you using Satan's shared hosting services? In a=
ny case, we give up!\n\n"
>                     "To \"retry\" set TEMPDIR to some location where oth=
er users won't race us to death"),
>                     template, count);

You mean users should be educated to stay away from shared temporary
directories on multi-user systems?  Good advice.  I'm also not sure
how relevant it is these days -- doesn't everybody get their own VM
these days? :)  Anyway, there are probably some who cannot follow it,
e.g. because their $HOME quota is exhausted.

> For a bonus grade we could add a few more lines and try to stat() some
> of the files we failed to create, and report what UID it is that's
> racing you for all of these tempfile creations.

Sounds fun, can enliven the office.  Once the fisticuffs are over --
PLOT TWIST! Turns out the RNG handed out the same "random" numbers to
everyone. ;)

>
>>> So instead of:
>>>
>>>  A. Add CSPRNG with demo test helper
>>>  B. Use it in git_mkstemps_mode()
>>>
>>> I'd think we'd be much better off with:
>>>
>>>  A. Split out callers of tempfile.c and mk.*temp in wrapper.c that cre=
ate tempfiles in .git
>>>  B. <the rest>
>>>
>>> I honestly haven't looked too much at what <the rest> is, other than
>>> what I wrote in [1], which seems to suggest that most of our codepaths
>>> won't need this.
>>>
>>> I'd also think that given the reference to CSPRNG in e.g. some glibc
>>> versions that instead of the ifdefs in csprng_bytes() we should instea=
d
>>> directly use a secure mkstemp() (or similar) for the not-.git cases th=
at
>>> remain after the "mktemp in a dir we chown" v.s. "mktemp in shared /tm=
p"
>>> are split up.
>>>
>>> Maybe these are all things you looked at and considered, but from my
>>> recollection (I didn't go back and re-read the whole discussion) you
>>> didn't chime in on this point, so *bump* :)
>>>
>>> 1. https://lore.kernel.org/git/211116.864k8bq0xm.gmgdl@evledraar.gmail=
.com/
>

