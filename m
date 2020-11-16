Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2B2C6369E
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 17:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5CC2227F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKmMITPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbgKPRqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387625AbgKPRqP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 12:46:15 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BBAC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 09:46:15 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t5so13496451qtp.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 09:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h1+1OCSDu9DgC/eA2feVihTwfEl5djCIuEewUk8JSrI=;
        b=VKmMITPahPfNFlruqvqKR10xuu58xeUCvavlg2NaJvBGVzIovk52LlbwhLiAQVngxy
         zcgPHhDj10QGzYu04e5mEISkzmjwv4z5hOvrhRBX6geLihskLqqD8Tfuzukq/P+gHhoi
         LmTPtrDMOt1C2kj3N+UPV1OtEFO4P+mSqfaP+wCJmszlqZSDC37nrlXKnjNwm4ahLwuJ
         oRqKWoLboJ7m/hUPJrxJvgoEc/xLPvzkd0a9jclrYggMdSLB08KNaPZQGVMK9Ke5BWtk
         yQXtDtabL4VIucOgOSHPCR9nYB306iMXYeh9l7NsvjSOban8Fa5rlC/He/aWdyhHucxG
         N6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h1+1OCSDu9DgC/eA2feVihTwfEl5djCIuEewUk8JSrI=;
        b=luKmgV6UXaHID8yFNbaHK8gZ2Zj68f3jPvJYNeXNtkTNuSxrDY1utNlQaYIuFIDonQ
         Wquij+UuSmr2NXnV19244L1+MvIk4ibl4CdHZjSrj8ZCXroa0buq9gAlB0U5/Fbd0gi0
         DLOI2Lg3HyZEmKym6lXa4tY9wrCjl8A8rVoQTqnN2BKY33lpW0h6vkMRdBU2/ewpLjNh
         WpOfiju+ApObVe0QzsN3M0mWblA57mhZxIxYDNnTorgGl5gOKqBQ5c8f/wUQexxghI0t
         wFpdaxs5FlgZj906YNUe0jHvN75T3aeVd4eiHGFVh+hG2IN0a5fK+O7MohFo4CMiuMWo
         ogwg==
X-Gm-Message-State: AOAM532GBqc42pUm6cTyANS0ceOqzAoE7GDU/fjjQfTpThhsLEkzwNIk
        xze/GQwy0/4/2EiGpnCqxNw=
X-Google-Smtp-Source: ABdhPJxrc68JMz620Up4hnzvZBxSWs6r+owwk5xg4CYOr2pJXNf3jxzEup3c8R/4xxUeEiXH98VJ0Q==
X-Received: by 2002:ac8:5557:: with SMTP id o23mr15037213qtr.252.1605548774503;
        Mon, 16 Nov 2020 09:46:14 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id n4sm12858048qkf.42.2020.11.16.09.46.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 16 Nov 2020 09:46:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git-log: documenting pathspec usage
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <878sb1fpep.fsf@evledraar.gmail.com>
Date:   Mon, 16 Nov 2020 12:46:11 -0500
Cc:     Adam Spiers <git@adamspiers.org>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63667234-DCBD-4ED3-BF80-664CD5981874@gmail.com>
References: <20201116122230.eyizwe2bmqkmftch@gmail.com> <878sb1fpep.fsf@evledraar.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam, Hi =C3=86var,

> Le 16 nov. 2020 =C3=A0 07:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> a =C3=A9crit :
>=20
>=20
> On Mon, Nov 16 2020, Adam Spiers wrote:
>=20
>> Hi all,
>>=20
>> I just noticed that git-log.txt has:=20
>>=20
>>    SYNOPSIS
>>    --------
>>    [verse]
>>    'git log' [<options>] [<revision range>] [[--] <path>...]
>>=20
>> and builtin/log.c has:=20
>>=20
>>    static const char * const builtin_log_usage[] =3D {
>>            N_("git log [<options>] [<revision-range>] [[--] =
<path>...]"),
>>=20
>> IIUC, the references to <path> should actually be <pathspec> instead,
>> as seen with other pathspec-supporting commands such as git add/rm
>> whose man pages are extra helpful in explicitly calling out how
>> pathspecs can be used, e.g.:
>>=20
>>    OPTIONS
>>    -------
>>    <pathspec>...::
>>            Files to add content from.  Fileglobs (e.g. `*.c`) can
>>            be given to add all matching files.  Also a
>>            leading directory name (e.g. `dir` to add `dir/file1`
>>            and `dir/file2`) can be given to update the index to
>>            match the current state of the directory as a whole (e.g.
>>            specifying `dir` will record not just a file `dir/file1`
>>            modified in the working tree, a file `dir/file2` added to
>>            the working tree, but also a file `dir/file3` removed from
>>            the working tree). Note that older versions of Git used
>>            to ignore removed files; use `--no-all` option if you want
>>            to add modified or new files but ignore removed ones.
>>    +
>>    For more details about the <pathspec> syntax, see the 'pathspec' =
entry
>>    in linkgit:gitglossary[7].
>>=20
>> Would it be fair to say the git-log usage syntax and man page should
>> be updated to match?  If so perhaps I can volunteer for that.
>=20
> It seems like a good idea to make these consistent, if you're feeling
> more ambitious than just git-log's manpage then:
>=20
>    $ git grep '<pathspec>' -- Documentation/git-*.txt|wc -l
>    54
>    $ git grep '<path>' -- Documentation/git-*.txt|wc -l
>    161

And 'ls-files' uses <files>...

> Most/all of these should probably be changed to one or the other.

I completely agree. I think <pathspec> should be used for every command
that takes a pathspec.

In general, there can be discrepancies between the
short help of each command and the "Synopsis" section of the long help
(man page). I wonder what we could do to try to keep these more in sync.
In addFor example, some 'git blame' options appear only in the short =
help,=20

Ideally, there would be a single source of truth for both of these, in =
my opinion,
but that would mean that the documentation build would somehow have to =
be taught
to read the source code and find the 'usage' function for each Git =
command and feed that
to the synopsis section (although the synopsis is usually more detailed =
than
the usage). One can always dream...

> I've also long wanted (but haven't come up with a patch for) that part
> of gitglossary to be ripped out into its own manual page,
> e.g. "gitpathspec(5)".

That is also on my personal todo list for Git. I think it's a great =
idea. This way
commands that take a pathspec could then link directly to this new =
guide.

Cheers,

Philippe.


