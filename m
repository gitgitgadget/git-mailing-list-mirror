Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43246C433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiARPHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiARPHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:07:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E4C06173F
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:07:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 30so80902873edv.3
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=C2wHD9Mvajhmb9KkZRCcNB4dgvAymdrpIr+fnkcAo9o=;
        b=J5gbS+qyKG057g9jXtoWZm4sR/vucqAR20gOKjLAvt5RwrUzi08JS0IsE1AxpikSoP
         3sM/kN+qT5tMqblvGkd1XKjiQQucfipcyLjYx/Ai+S6Cdh2FyAtl0TWvVs5gRJ1KEbRF
         DgPyrJs6XlILaZ88b61MCI9iX/gtKovn+TDyGLBDSQpHd/GEj2/b15b1jnItFFpPJxgO
         nPsaJAPK/qpiiwWWcT1OpAIHuFO+jrF2d21jOzOz5rtA/ETbpHn46IPeT4V/xG0zNmpl
         +1Y3KKReBA/EqHKqIhUDrhBB91PyTzwnpZfV5pjcyG4M0Zi/hRXNjKFhLHXvHAN7hvjx
         QZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=C2wHD9Mvajhmb9KkZRCcNB4dgvAymdrpIr+fnkcAo9o=;
        b=4ao52wsA/AwW9AcfZMJeLugx4qtDWUB/SBUZCOnbdXXenhf5fSY+lSkzP3zsv4nNiN
         ujmZ+FB13RraUkC9LJTfIxem2XCM+UBIy3Ti+DsCQWd3KMKxPDm7He1gfUFbqk8/iVdl
         cthAn+JDFLgV0yOEF/2/VXEfMXd/OsqMpTUNyTCPLMsTKS0coRty7wuSp9YEaC3pgCwm
         0G9DU71VMAsFsZVpE6qBu4iKmWjhef7+eK9QF6a1Jq4WOaH351jOwsr3G/QfQnRoCCx9
         NVmhNzjAYwP3HOPXpEjF/SbSUlQjENf0cHFZ/zmQDUynetHs56yxVo6Xbe7W7CM9vmpD
         ST4A==
X-Gm-Message-State: AOAM532Z7w/mHKr4QX3W2Ch0ewuHkFIw/PsbSzclTVQRQKA2eDhhRftv
        PlVnXmuRDeNDtmiVfwsqtIjigT9sAENJcA==
X-Google-Smtp-Source: ABdhPJwT7fzJgzEDCx3MNkunGcqo5A/17aEE6c7LYnCLLR9OdOLeaXR1ZL/6Hi+TqnpZfFWccDaKYw==
X-Received: by 2002:a17:907:9869:: with SMTP id ko9mr20454287ejc.633.1642518456250;
        Tue, 18 Jan 2022 07:07:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 3sm5422509ejq.159.2022.01.18.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:07:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9q58-001cqS-Nb;
        Tue, 18 Jan 2022 16:07:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file names
Date:   Tue, 18 Jan 2022 15:51:09 +0100
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
 <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
 <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de>
Message-ID: <220118.86mtjtozex.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Ren=C3=A9 Scharfe wrote:

> Am 18.01.22 um 10:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Jan 17 2022, brian m. carlson wrote:
>>
>>> The current way we generate random file names is by taking the seconds
>>> and microseconds, plus the PID, and mixing them together, then encoding
>>> them.  If this fails, we increment the value by 7777, and try again up
>>> to TMP_MAX times.
>>>
>>> Unfortunately, this is not the best idea from a security perspective.
>>> If we're writing into TMPDIR, an attacker can guess these values easily
>>> and prevent us from creating any temporary files at all by creating them
>>> all first.  Even though we set TMP_MAX to 16384, this may be achievable
>>> in some contexts, even if unlikely to occur in practice.
>>> [...]
>>
>> I had a comment on v1[1] of this series which still applies here,
>> i.e. the "if we're writing into TMPDIR[...]" here elides the fact that
>> much of the time we're writing a tempfile into .git, so the security
>> issue ostensibly being solved here won't be a practical issue at all.
>>
>> Then for out-of-repo tempfiles some OS's have a per-user $TEMPDIR you
>> can use (e.g. systemd's /run/user/`id -u`). Finally...
>>
>>> Note that the use of a CSPRNG in generating temporary file names is also
>>> used in many libcs.  glibc recently changed from an approach similar to
>>> ours to using a CSPRNG, and FreeBSD and OpenBSD also use a CSPRNG in
>>> this case.  Even if the likelihood of an attack is low, we should still
>>> be at least as responsible in creating temporary files as libc is.
>>
>> ...we already have in-tree users of mkstemp(), which on glibc ostensibly
>> tries to solve the same security issues you note here, and the
>> reftable/* user has been added since earlier iterations of this series:
>> o
>>     $ git grep -E '\bmkstemp\(' -- '*.[ch]'
>>     compat/mingw.c:int mkstemp(char *template)
>>     compat/mingw.h:int mkstemp(char *template);
>>     entry.c:                return mkstemp(path);
>>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab_file_name.buf);
>>     reftable/stack.c:       tab_fd =3D mkstemp(temp_tab->buf);
>>     reftable/stack_test.c:  int fd =3D mkstemp(fn);
>>     wrapper.c:      fd =3D mkstemp(filename_template);
>>
>> This series really feels like it's adding too much complexity and
>> potential auditing headaches (distributors worrying about us shipping a
>> CSPRNG, having to audit it) to a low-level codepath that most of the
>> time won't need this at all.
>
> Good point.  Please let me think out loud for a moment.
>
> mkstemp() is secure (right?) and used already.  mkstemps() was used as
> well until b2d593a779 (wrapper.c: remove unused gitmkstemps() function,
> 2017-02-28).  What's the difference?  The former requires the random
> characters at the end (e.g. "name-XXXXXX"), while the latter allows a
> suffix (e.g. "name-XXXXXX.ext"); that's what the added "s" in the name
> means, I guess.  And apparently mkstemp is everywhere, but mkstemps is
> a GNU extension.
>
> git_mkstemps_mode is used by mks_tempfile_sm, mks_tempfile_tsm and
> git_mkstemp_mode.  The latter uses no suffix, so could be implemented
> using mkstemp and fchmod instead.
>
> mks_tempfile_sm is called by write_locked_index, mks_tempfile_s,
> mks_tempfile_m and mks_tempfile.  Only mks_tempfile_s uses a suffix,
> but is itself unused.  So an implementation based on mkstemp and fchmod
> would suffice for mks_tempfile_sm users as well.
>
> mks_tempfile_tsm is used by mks_tempfile_ts, mks_tempfile_tm and
> mks_tempfile_t.  Only mks_tempfile_ts uses a suffix.  Its only caller
> is diff.c::prep_temp_blob, called only by diff.c::prepare_temp_file,
> called by add_external_diff_name and run_textconv in the same file.
>
> So if I didn't take a wrong turn somewhere the only temporary file name
> templates with suffixes are those for external diffs and textconv
> filters.  The rest of the git_mkstemps_mode users could be switched to
> mkstemp+fchmod.
>
> Temporary files for external diffs and textconv filters *should* be
> placed in $TMPDIR.  Do they need suffixes?  I guess for testconv
> filters it doesn't matter, but graphical diff viewers might do syntax
> highlighting based on the extension.
>
> Can we get extensions without mktemps or git_mkstemps_mode?  Yes, by
> using mkdtemp to create a temporary directory with a random name and
> creating the files in it.  There already are mkdtemp users.
>
> So AFAICS all use cases of git_mkstemps_mode can be served by
> mkstemp+fchmod or mkdtemp.  Would that help?

That seems sensible, as a further practical suggestion it seems like
we'll retry around 16k times to create these files on failure, perhaps
trying with a custom extension 8k times would be OK, followed by the
minor UI degradation of doing the final 8k retries with the more-random
OS-provided extension-less variant.

More generally I'm still not sure if this is still a purely hypothetical
attack mitigation, or whether there are actually users out there that
have to deal with this.

Wouldn't something like this also be an acceptable "solution" to this
class of problem?

	#define TMP_MAX 1024
	[...]
	if (count >=3D TMP_MAX)
		die(_("we tried and failed to create a tempfile using the '%s' template a=
fter %d tries!\n\n"
                    "Is someone actively DoS you? Is your sysadmin known to=
 be your mortal enemy?\n"
                    "are you using Satan's shared hosting services? In any =
case, we give up!\n\n"
                    "To \"retry\" set TEMPDIR to some location where other =
users won't race us to death"),
                    template, count);

For a bonus grade we could add a few more lines and try to stat() some
of the files we failed to create, and report what UID it is that's
racing you for all of these tempfile creations.

>> So instead of:
>>
>>  A. Add CSPRNG with demo test helper
>>  B. Use it in git_mkstemps_mode()
>>
>> I'd think we'd be much better off with:
>>
>>  A. Split out callers of tempfile.c and mk.*temp in wrapper.c that creat=
e tempfiles in .git
>>  B. <the rest>
>>
>> I honestly haven't looked too much at what <the rest> is, other than
>> what I wrote in [1], which seems to suggest that most of our codepaths
>> won't need this.
>>
>> I'd also think that given the reference to CSPRNG in e.g. some glibc
>> versions that instead of the ifdefs in csprng_bytes() we should instead
>> directly use a secure mkstemp() (or similar) for the not-.git cases that
>> remain after the "mktemp in a dir we chown" v.s. "mktemp in shared /tmp"
>> are split up.
>>
>> Maybe these are all things you looked at and considered, but from my
>> recollection (I didn't go back and re-read the whole discussion) you
>> didn't chime in on this point, so *bump* :)
>>
>> 1. https://lore.kernel.org/git/211116.864k8bq0xm.gmgdl@evledraar.gmail.c=
om/

