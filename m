Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF45C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbiANURs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 15:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbiANURr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 15:17:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F76C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 12:17:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t24so37988406edi.8
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 12:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I99qYJACibOYtzsOjsSdBpEurB7HRwogUrpi+KvTsvQ=;
        b=OWLg2ruPmucPQahITcUd6M9PGVS503C6NRcrbAm0SYLshaDb7uCS7OnH4Ty0VsCMMi
         U5v/LaBjEMA7qIW1ogfozh9iiSJB2k8sy/W36mWzcWvQuM4uBJIrUDHK6ioJMI9UNQ5n
         94pBJ+m/zmJE8YS1+bO1406si9wxrzZ63czq3sOK9NEl8R9DApoqqhZ5gA40oYHOvqmw
         hM2Ne0wQCE9sV6bnN1NKUekf6UKld4NuWt5lw5cVIf0pZjZiVQ8iyp6kjbHvNcYNcpSz
         Bx5jVqWUdT4tNLp/vyPauumSJ3BlIYkkbq+nshhkt+RDgbebGk/nKwwj8bgpr1+e+LBv
         aXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I99qYJACibOYtzsOjsSdBpEurB7HRwogUrpi+KvTsvQ=;
        b=H3scYDdCiyEhtWMe41ahlhOBGkYHMlUXjBCsdIi7F5Kk6cSXNhu4yO9GFtxnlB+3So
         Au20d47+Z09AgoaGJD4FkbVVvMHw9+nqDNzIHxtsvc/DvdjFfzpMMSNjFvk0AHJgQ+29
         tM8D0D1Bii7blUFpfeHFbqmB/8qXBkeS/Z4GmmNq5f/DZ5qsx5FpkbkIv7D9xTxagc5q
         aYq01iMyzq030LBWQZCKfLiqBpoUoOVMvduUBJ6ECuZwaxA1/Djz4CDNv/Ov+7w/Rl7q
         8bvbT4ERtFRGDLUjqI08N+veADCHSMe7DurWunSjmDfgshqWniCQswqQN2NWZil2lWg3
         1ITw==
X-Gm-Message-State: AOAM5333r1ggD3zGyLgwBEdE7LnuSnovEaXc2yXER6qd4mRIIyU+EKSf
        9/PVFT/Ls0fKUr0QBY4bEtg=
X-Google-Smtp-Source: ABdhPJw5rXojY3bq2qN08bGkzOqnZ4Ax6WuqB2iuJKMPF7AkZ0kbZ9N7K6oyIUXVmODVH95Klj3EOw==
X-Received: by 2002:a17:907:f96:: with SMTP id kb22mr7065341ejc.159.1642191465617;
        Fri, 14 Jan 2022 12:17:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb40sm2104626ejc.80.2022.01.14.12.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 12:17:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8T16-001E5h-Cw;
        Fri, 14 Jan 2022 21:17:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
Date:   Fri, 14 Jan 2022 20:57:17 +0100
References: <cover.1642129840.git.dyroneteng@gmail.com>
 <xmqqfspqeun5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqfspqeun5.fsf@gitster.g>
Message-ID: <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Junio C Hamano wrote:

> Teng Long <dyroneteng@gmail.com> writes:
>
>> +test_must_fail 'Exchange the order of "--heads" and <remote>' '
>> +    git --version &&
>> +    git init "test.git" &&
>> +    test_commit -C "test.git" one &&
>> +    git -C "test.git" ls-remote --heads ./. > result.1 &&
>> +    git -C "test.git" ls-remote ./. --heads > result.2 &&
>
> I would say that this is working exactly as designed.  As with the
> unix tradition, after the command name, first come options
> (e.g. "--heads", "-v", etc. that begin with a dash or two dashes),
> then arguments like "origin", "master", "." that are not dashed
> options/flags.
>
> Then among the arguments, we generally take revs first and then
> pathspecs.  "git help cli" explicitly mentions this, because it is
> specific to "git" command suite, but it does not mention "dashed
> options/flags first and then args", primarily because, at least back
> when the documentation was written, this was taken as granted, iow,
> those who wrote the "gitcli" documentation thought it was a common
> knowledge among users that did not need to be spelled out.
>
> Apparently, it is not a common knowledge at least for you (and
> probably others).  Perhaps we should add a paragraph to the cli help
> and explicitly mention "options first and then args", before we go
> on to say "among args, revs first and then pathspecs".

I don't think this summary is accurate.

We have multiple commands that are in GNU-fashion loose about whether
you provide options first before no-option args, or after. E.g. we
accept both of:

    git push --dry-run <remote> <ref>

And:

    git push <remote> <ref> --dry-run

The "tradition" you're referring to accurately summarizes how POSIX
specifies that things should work.

But when GNU came around its option parser was generally happy to accept
options and args in either order. E.g. these both work with GNU
coreutils, but the latter will fail on FreeBSD and various other
capital-U UNIX-es:

    touch foo; rm -v foo
    touch foo; rm foo -v

The relevant documentation being
https://www.gnu.org/prep/standards/standards.html#Standards-for-Command-Lin=
e-Interfaces;
specifically:

    "Note that the GNU version of getopt will normally permit options
    anywhere among the arguments unless the special argument =E2=80=98--=E2=
=80=99 is
    used. This is not what POSIX specifies; it is a GNU extension."

Now, as to git's behavior we mostly follow the GNU style. The default
behavior of parse_options() is to accept the looser GNU style. In this
case we're explicitly passing the PARSE_OPT_STOP_AT_NON_OPTION flag.

But why is that?

Most things that do that are doing so because we're parsing things in
two passes, i.e. for commands that have sub-commands, e.g.:

    git commit-graph [opts] [subcommand] [subcommand-opts]

In those cases we use PARSE_OPT_STOP_AT_NON_OPTION on our first pass, so
that we'll stop at "subcommand", then we'll generally continue the
parsing as of "[subcommand]" without that flag.

The general exception to that rule, as you note, being things that take
pathspecs, although for some of those we'll apply other custom
disambiguation.

In this case a look at ba5f28bf79e (ls-remote: use parse-options api,
2016-01-19) will show that it was faithfully converted from an ad-hoc
custom option parser using the "BSD-like" option parsing discussed
above.

I really don't see why we wouldn't take this patch given that the
command has one parse_options() invocation (so no subcommand
complexity), and doesn't accept pathspecs etc.

We should aim to make the command line UX consistent when possible, not
slavishly bug-for-bug follow whatever the behavior of the
pre-parse_options() code was.

We can't do that in some cases, but this case seems like a pretty clear
case where simply removing the PARSE_OPT_STOP_AT_NON_OPTION flag would
be an improvement. It's not ambiguous, and makes invocations that
currently (and inconsistently v.s. our usual behavior) error out work.
