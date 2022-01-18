Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66CCC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 09:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiARJmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 04:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiARJmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 04:42:24 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774EC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 01:42:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so76843645edd.12
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 01:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CqCCsC3LFJfcUjHwFypXLsuJ/64xz2UpZWNeit6twzY=;
        b=EZI5iAmr92+X3GBxr33M5ryLg5aWWvkh4jnYFMMiqWaTAdtDqj2+dch+SiglL98kV8
         Ajd3b+cm2YcGBqhDyoQPo+LhYUFkYC3XBzAcZT4NrLn0unKexd10rbMRlxf5/DbOgC2K
         2eZS+xhPjEvCCbdD3TaBuMu+Xcn0VlreafKvlHmRGG7sJ1TNeuZZYXEbEXBOjysFw+v6
         Sqt92zxNSQ2cyn1Py/a6y0FWWN79zDE8UCCDaNfwZWCjBmz+xiJS+0d9xXNtTqCeUNGp
         jDHd425zRs9YZpx4eRPecyedgEFB9yyacToz0YbEqlpQwOZlxngoV98Pio3kRYwPMtKF
         v47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CqCCsC3LFJfcUjHwFypXLsuJ/64xz2UpZWNeit6twzY=;
        b=JIec0XUTP9KEyBLKSFnDmKSUFlDxfn7HAcmu5w1vNTv/6S9xAtGWLEDqRXok+7TPf0
         WLB2AxniYHADhATgUPML0IQiyF1YbSKmc8Jx0sOIwa4pVwxqjr7T1oCsWFGYetP98TIw
         D9t3loHwc+BWwHz1s7muhQmHG0Y40KIRf5yGvhbKztd2Wp+LhXqlxuwyLE36jWGkwnfV
         oABt1YeiySAKEyWx3TLvZdUM/9nHTbVxpsnjAE0u/SCyjacWXgmOsBJ8wt1MQ0Nyq/vM
         rp7b4EMCYC7eVA3v4J07pGcpfJrEsvzdZ5XaIvUH1vhzUOoIZ07d7yZ1AQMBfoSHOd4R
         1UFw==
X-Gm-Message-State: AOAM532nZ7JW9mV7M0a7cwH+SBVEiUFWs4TgIrldS2AvuAHsMQyy6pH5
        5Zg1Wcdy0MVDAYr53ovtiL4=
X-Google-Smtp-Source: ABdhPJxzcQk5dMQnFwe6hCa6lHlrRaS7WVdvXYoXr4m3sj2BoTHjtAMn2Eaqg0ytP/s18TTU8qIxHg==
X-Received: by 2002:a17:907:168d:: with SMTP id hc13mr8804536ejc.470.1642498942669;
        Tue, 18 Jan 2022 01:42:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s8sm4876770ejq.203.2022.01.18.01.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:42:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9l0P-001UZx-Ee;
        Tue, 18 Jan 2022 10:42:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file names
Date:   Tue, 18 Jan 2022 10:24:58 +0100
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220117215617.843190-3-sandals@crustytoothpaste.net>
Message-ID: <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 17 2022, brian m. carlson wrote:

> The current way we generate random file names is by taking the seconds
> and microseconds, plus the PID, and mixing them together, then encoding
> them.  If this fails, we increment the value by 7777, and try again up
> to TMP_MAX times.
>
> Unfortunately, this is not the best idea from a security perspective.
> If we're writing into TMPDIR, an attacker can guess these values easily
> and prevent us from creating any temporary files at all by creating them
> all first.  Even though we set TMP_MAX to 16384, this may be achievable
> in some contexts, even if unlikely to occur in practice.
> [...]

I had a comment on v1[1] of this series which still applies here,
i.e. the "if we're writing into TMPDIR[...]" here elides the fact that
much of the time we're writing a tempfile into .git, so the security
issue ostensibly being solved here won't be a practical issue at all.

Then for out-of-repo tempfiles some OS's have a per-user $TEMPDIR you
can use (e.g. systemd's /run/user/`id -u`). Finally...

> Note that the use of a CSPRNG in generating temporary file names is also
> used in many libcs.  glibc recently changed from an approach similar to
> ours to using a CSPRNG, and FreeBSD and OpenBSD also use a CSPRNG in
> this case.  Even if the likelihood of an attack is low, we should still
> be at least as responsible in creating temporary files as libc is.

...we already have in-tree users of mkstemp(), which on glibc ostensibly
tries to solve the same security issues you note here, and the
reftable/* user has been added since earlier iterations of this series:
o    
    $ git grep -E '\bmkstemp\(' -- '*.[ch]'
    compat/mingw.c:int mkstemp(char *template)
    compat/mingw.h:int mkstemp(char *template);
    entry.c:                return mkstemp(path);
    reftable/stack.c:       tab_fd = mkstemp(temp_tab_file_name.buf);
    reftable/stack.c:       tab_fd = mkstemp(temp_tab->buf);
    reftable/stack_test.c:  int fd = mkstemp(fn);
    wrapper.c:      fd = mkstemp(filename_template);

This series really feels like it's adding too much complexity and
potential auditing headaches (distributors worrying about us shipping a
CSPRNG, having to audit it) to a low-level codepath that most of the
time won't need this at all.

So instead of:

 A. Add CSPRNG with demo test helper
 B. Use it in git_mkstemps_mode()

I'd think we'd be much better off with:

 A. Split out callers of tempfile.c and mk.*temp in wrapper.c that create tempfiles in .git
 B. <the rest>

I honestly haven't looked too much at what <the rest> is, other than
what I wrote in [1], which seems to suggest that most of our codepaths
won't need this.

I'd also think that given the reference to CSPRNG in e.g. some glibc
versions that instead of the ifdefs in csprng_bytes() we should instead
directly use a secure mkstemp() (or similar) for the not-.git cases that
remain after the "mktemp in a dir we chown" v.s. "mktemp in shared /tmp"
are split up.

Maybe these are all things you looked at and considered, but from my
recollection (I didn't go back and re-read the whole discussion) you
didn't chime in on this point, so *bump* :)

1. https://lore.kernel.org/git/211116.864k8bq0xm.gmgdl@evledraar.gmail.com/
