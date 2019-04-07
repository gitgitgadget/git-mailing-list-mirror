Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400CD20248
	for <e@80x24.org>; Sun,  7 Apr 2019 22:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfDGWwW (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 18:52:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38419 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGWwW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 18:52:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so9967959edr.5
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SnAniOsd36jOVJiu1u94nDKUEVw8B1l9CABC6YMCOFY=;
        b=M65L7QQiv6WhZDHjbnDfImIwp57SbSI2wF1i7LT9y2uiLzR6xRtHmyIO5A8l/3wTF9
         s/AwzHCOzT7r1AmWjjRngC3y084Xy/97mdK9LxPOpyKyXToEXGTBVwXAsSfPdKJOg7hm
         jnoZO+dyw1k/KApoX7l0R70ZSYKu3faKK0ihjZTJh4uVJBgPlkjUpewFDnemD2t+BzQR
         dJ56VZWjcdMrV58xcFHw+QFi9hYKD+ntKq2WYdswarpqEY5wFzCQV/mhnL8BQxe3Oyyh
         ArVXpQjcxJOz0ziqgC/IrPti0qRgvsawbnQqWNS1Ok9b/AyHcKkPanlG48pSzjBf/kOI
         pUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SnAniOsd36jOVJiu1u94nDKUEVw8B1l9CABC6YMCOFY=;
        b=T+Ii+TcwbyUd1uJP0xdLcymvzvYlr5dT6dbTSf6mFi3e4ctCnn+AN58oxaGdgqFS6N
         avksDokGtDvWx5+FvtM5EKCDpJ1/CgDx9QtF4DBjJPt30a1RfDUr+GUtjCCBYFp+1QV1
         2XWs3ExTXJOBuzmxEz65Qnk3r/mgMuQWHfuYisylQxVkFl3Z7ixYZcG1sqSuROJo4/c+
         W4a4YarSpM5BDiaL8xiaDRmxinzSyi8Pte7p60XRMxzyDv7xs1bb7jZZYOsAOJTCYFzI
         Pv9ApfeJFgrmm8BFoB2U2DYXVUbVAwn3c1ScrZnCRa7M7CDOAWYzvXZeR7oHNkDGuQuO
         W+1A==
X-Gm-Message-State: APjAAAXMVyLKCW14ozUu15FGbMW3fDRn+I64n3p9Dm4cbymt+MovnIeX
        h4vrEMVgeg52lfoyckenGPmAWpr+bSc0QDjMdoEzSKA8
X-Google-Smtp-Source: APXvYqyKpfoZ0VuWG2H0lj2JS8HcixjMdTu2hD6CowKnGjxCXJMxZKBniR37g3W0js7ZuXvm1+uCCPyEKGgL6dWcJKM=
X-Received: by 2002:a17:906:6050:: with SMTP id p16mr14414287ejj.173.1554677540024;
 Sun, 07 Apr 2019 15:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
In-Reply-To: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 00:52:08 +0200
Message-ID: <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus

On Sun, Apr 7, 2019 at 10:48 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> This is my proposal for GSoC with the subject "Make pack access code
> thread-safe".

Thanks!

> I'm late in schedule but I would like to ask for your
> comments on it. Any feedback will be highly appreciated.
>
> The "rendered" version can be seen here:
> https://docs.google.com/document/d/1QXT3iiI5zjwusplcZNf6IbYc04-9diziVKdOG=
kTHeIU/edit?usp=3Dsharing

Thanks for the link!

> Besides administrative questions and contributions to FLOSS projects, at
> FLUSP, I=E2=80=99ve been mentoring people who want to start contributing =
to the
> Linux Kernel and now, to Git, as well.

Nice! Do you have links about that?

> # The Project
>
> As direct as possible, the goal with this project is to make more of
> Git=E2=80=99s codebase thread-safe, so that we can improve parallelism in
> various commands. The motivation behind this are the complaints from
> developers experiencing slow Git commands when working with large
> repositories[1], such as chromium and Android. And since nowadays, most
> personal computers have multi-core CPUs, it is a natural step trying to
> improve parallel support so that we can better use the available resource=
s.
>
> With this in mind, pack access code is a good target for improvement,
> since it=E2=80=99s used by many Git commands (e.g., checkout, grep, blame=
, diff,
> log, etc.). This section of the codebase is still sequential and has
> many global states, which should be protected before we can work to
> improve parallelism.

I think it's better if global state can be made local or perhaps
removed, rather than protected (though of course that's not always
possible).

> ## The Pack Access Code
>
> To better describe what the pack access code is, we must talk about
> Git=E2=80=99s object storing (in a simplified way):

Maybe s/storing/storage/

> Besides what are called loose objects,

s/loose object/loose object files/

> Git has a very optimized mechanism to compactly store
> objects (blobs, trees, commits, etc.) in packfiles[2]. These files are
> created by[3]:
>
> 1. listing objects;
> 2. sorting the list with some good heuristics;
> 3. traversing the list with a sliding window to find similar objects in
> the window, in order to do delta decomposing;
> 4. compress the objects with zlib and write them to the packfile.
>
> What we are calling pack access code in this document, is the set of
> functions responsible for retrieving the objects stored at the
> packfiles. This process consists, roughly speaking, in three parts:
>
> 1. Locate and read the blob from packfile, using the index file;
> 2. If the blob is a delta, locate and read the base object to apply the
> delta on top of it;
> 3. Once the full content is read, decompress it (using zlib inflate).
>
> Note: There is a delta cache for the second step so that if another
> delta depends on the same base object, it is already in memory. This
> cache is global; also, the sliding windows, are global per packfile.

Yeah, but the sliding windows are used only when creating pack files,
not when reading them, right?

> If these steps were thread-safe, the ability to perform the delta
> reconstruction (together with the delta cache lookup) and zlib inflation
> in parallel could bring a good speedup. At git-blame, for example,
> 24%[4] of the time is spent in the call stack originated at
> read_object_file_extended. Not only this but once we have this big
> section of the codebase thread-safe, we can work to parallelize even
> more work at higher levels of the call stack. Therefore, with this
> project, we aim to make room for many future optimizations in many Git
> commands.

Nice.

> # Plan
>
> I will probably be working mainly with packfile.c, sha1-file.c,
> object-store.h, object.c and pack.h, however, I may also need to tackle
> other files. I will be focusing on the following three pack access call
> chains, found in git-grep and/or git-blame:
>
> read_object_file =E2=86=92 repo_read_object_file =E2=86=92 read_object_fi=
le_extended =E2=86=92
> read_object =E2=86=92 oid_object_info_extended =E2=86=92 find_pack_entry =
=E2=86=92
> fill_pack_entry =E2=86=92 find_pack_entry_one =E2=86=92 bsearch_pack and
> nth_packed_object_offset
>
> oid_object_info =E2=86=92 oid_object_info_extended =E2=86=92 <same as pre=
vious>
>
> read_object_with_reference =E2=86=92 read_object_file =E2=86=92 <same as =
previous>
>
> Ideally, at the end of the project, it will be possible to call
> read_object_file, oid_object_info and read_object_with_reference with
> thread-safety, so that these operations can be, latter, performed in
> parallel.
>
> Here are some threads on Git=E2=80=99s mailing list where I started discu=
ssing
> my project:
>
> * https://public-inbox.org/git/CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8=
iaoc+b8=3DQ@mail.gmail.com/
> * https://public-inbox.org/git/20190402005245.4983-1-matheus.bernardino@u=
sp.br/#t
>
> And also, a previous attempt to make part of the pack access code
> thread-safe which I may use as a base:
>
> * https://public-inbox.org/git/20140212015727.1D63A403D3@wince.sfo.corp.g=
oogle.com/#Z30builtin:gc.c

Nice.

> # Points to work on
>
> * Investigate pack access call chains and look for non-thread-safe
> operations on then.
> * Protect packfile.c read-and-write global variables, such as
> pack_open_windows, pack_open_fds and etc., using mutexes.

Do you want to work on making both packfile reading and packfile
writing thread safe? Or just packfile reading?

If some variables are used for both reading and writing packfiles, do
you plan to protect them only when they are used for reading?

The rest of your proposal looks very good to me. Please make sure you
upload this or an updated version soon to the GSoC web site.

Thanks,
Christian.
