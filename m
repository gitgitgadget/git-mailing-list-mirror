Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DDBEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 18:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFOSdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbjFOScq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 14:32:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE735B3
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 11:32:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso1660a12.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686853918; x=1689445918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSECjdyF+C/EWr2sTMBoqX536mwPDKk9dzj863PvdTg=;
        b=3irDmX4EOOKXU9lE6M9R+O3xx9g25qK+mG5hJu2HpucQV1ayjm6uPTiYSsHfOWaz2Q
         iLcPysiMc6w/TWQfPYbZHeeqhLsvCRq3KnBLIU8yKfC4RGSAVut0l1h40M9diHOFbxQ6
         zqXvVSGKrigWVEdn6ISYx6aSmxTIK+v+c8ISdgdQ5Q9fGfxJRcOeZ5yl2k4p36+GgCdb
         XFQMK5Uhxz+7u8debAGdIlYf4SnZPGxbLVP2DTFrOALzFLSQ/Q0ULO262HOo2/q/2N1O
         Sv5KEOvnU8HSHkYHgelcPqhzvK5JWBEwEliTWPIhYZwhFdC8ElgtIKXyq4rY47lKUul6
         9GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853918; x=1689445918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSECjdyF+C/EWr2sTMBoqX536mwPDKk9dzj863PvdTg=;
        b=H4mEdNm1nNhjJIL43EFNtJa2lOcuZuy7zUDN9NCe4VygGUgzQgQzFKnXt4E08ta0GF
         C1+9uMnJk0sIRIxDbS0WPlSEHf4G1+Ha4wyyR1p+2XU/OTNWDXfFoJsVak/A1Y5Qj3gj
         3CIzhp5Nf4q9fHVFlfeos/vImfgSSYX+Ln+i36vZ4HJ1EjfSCbWDs9mrwDnX2ULAuzxF
         ZmQG43WqWN8PLPfHvyKkg6VtgdBuBYxz1TRPB9Xe0pfWbvk7Vs7kBEqgGFoNb6YhAglK
         DhvktApTmcURBymrrSxExzbVyqYylFbjloWaBq7N4LNjU+1s+v1Yn84vNeJIIqdeGSpE
         Nxmg==
X-Gm-Message-State: AC+VfDybAv8g6ICmbcSAGocU5eHjMc/S81JQRy70Gvv0hQeUIY37yGFn
        Jo7Jcrz5ceBWP1eVqEBPDtWBHyzhcs2A4yj7xuM53To9iEMT8VKGijohgA==
X-Google-Smtp-Source: ACHHUZ4yhA0ba8GWZXTAANJfWJYJj3L2tnp7H97UlvRRUR6olg7GpacbgWi6sPs5q/W/M2IuydYFIjVqzUCkohLggTw=
X-Received: by 2002:a50:9faf:0:b0:514:92e4:ab9f with SMTP id
 c44-20020a509faf000000b0051492e4ab9fmr97966edf.7.1686853918209; Thu, 15 Jun
 2023 11:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFySSZB5AvP04fF+Uk4E6JovxQGQpU0eUXW3KjeMxffQHmm9Sw@mail.gmail.com>
In-Reply-To: <CAFySSZB5AvP04fF+Uk4E6JovxQGQpU0eUXW3KjeMxffQHmm9Sw@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 15 Jun 2023 11:31:46 -0700
Message-ID: <CAJoAoZ=pKx413d28Y_984AMA4WqC5WzbDLWZ0iJCCH4zgRTEcA@mail.gmail.com>
Subject: Re: Video conference libification eng discussion, this Thursday 17:00 UTC
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks, the notes from today follow:

*   (asynchronous) What's cooking in libification?
    *   Patches we sent regarding libification
        *   WIP v3 of unit test project plan is on list
(https://lore.kernel.org/git/c7729b66a42b77dfe9ef61ba7c81e78e00b4021d.16863=
52386.git.steadmon@google.com/)
    *   Patches for review related to the libification effort
*   (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
    *   [calvinwan] I stuck git-std-lib into Google's monorepo and
built it, Glen built his config patches on top of git-std-lib in
Google's monorepo too, it works, we can call some stuff from our
internal VFS, so yay!
    *   Patch available upstream Soon(=E2=84=A2)
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list at the beginning of
the meeting.)
    *   (see calvin's topic below)
*   [calvinwan] How should compatibility files interact with libraries
in the Makefile? Most files in compat/ only have a dependency on
git-compat-util.h, but there are some files that have higher level
dependencies. For example, on Linux, git-std-lib only needs
compat/strlcpy.c and compat/fopen.c. In the Makefile, COMPAT\_OBJS
already exists and correctly contains the set of files, but also
contains compat/linux/procinfo.c and compat/qsort\_s.c. Neither of
these files are necessary for git-std-lib and while qsort\_s.c is a
harmless inclusion, procinfo.c contains problematic trace2
dependencies. Therefore if a user of git-std-lib attempts to call a
problematic function in procinfo.c, they would encounter build errors.
Under different build settings (eg. on different OSes), it is entirely
possible that certain functions in git-std-lib would break and users
would have to supply their own implementation. To summarize the
problem, I would like to piggyback off existing Makefile logic for
compat files, but also ensure that no problematic files are included
across OSes.
    *   Currently git-std-lib is a set of files by itself, compat
library is another set built by itself, link against it to make
git-std-lib run
    *   How do we keep using correct compat libs, make it work across
OS and build system boundaries, without including too much that breaks
in libified world?
    *   Config.mac.uname could take a flag for git-std-lib for linux,
and we'd have to add another flag for every OS, and then do the same
for every other library, so doesn't scale very nicely.
    *   Emily: should COMPAT\_OBJS be split into smaller multiple sets?
        *   Calvin: yeah basically
    *   Emily: can we just not expose procinfo/qsort\_s via that API
boundary? Is it ok to include too much if it's not used?
    *   Calvin: I'm worried about git-std-lib working on Linux and
breaking on another system because of the compat stuff not being
populated
    *   Glen: I suspect we don't want to target all of COMPAT\_OBJS -
stuff like fsmonitor doesn't ever need to go into the std-lib. I think
that's the set of platform-specific stuff we need for the Git binary,
so can we distinguish the set of platform-specific stuff that's needed
for the std lib?
    *   Calvin: yes, but we'd have to do the same distinguishing for
config, objstore, other libraries. And we'd have to do that across
each OS.
    *   Glen: but for platforms which don't implement the thing we
want, they'd already have to reimplement the library even to build
normal git?
    *   E.g. for linux and darwin we can ship the compat stuff with
the git-std-lib and our users can use it; platforms that don't have
the impls will have the same problem they have today.
    *   If we're correctly defining COMPAT\_OBJS\_LIB in the makefile
then there's not really any makefile modification that needs to happen
    *   Emily: does git-std-lib + compat-lib cover 100% of business
logic libraries?
    *   Calvin: but where does procinfo go, for example?
    *   Glen: if procinfo is just useful for trace2, then we should
include it with trace2, not with everything, right?
    *   Calvin: for sake of argument, if it's needed in the config
library then it also has to be included by config library, right?
    *   Glen: isn't it the same as other libification, that we are
moving implementations/dependencies closer to their sole user
libraries?
    *   Emily: do we see any other problematic dependency chains? Or
is it just this one? If it's just this one that might be ok?
    *   Calvin: then I think this means we have a makefile where
git-std-lib only includes the bare minimum it needs; at some point
    *   Emily: i think putting the platform-specific stuff into
git-std-lib keeps with the vision of git-std-lib being the "one stop
shop" for building and running any other git lib, so it would be OK to
include compat stuff not needed just to run git-std-lib code, as long
as it doesn't have a dep on another git library (like procinfo does).
    *   Randall: does the platform stuff remain in the standard git codebas=
e?
    *   Emily: everything stays in the git codebase and mailing list
stuff and so on
    *   Randall: is compat/ moving into the git-std-lib or staying
where it is? Where will the platform stuff live?
    *   Glen: git-std-lib is a .a that contains the code we think most
lib users will need, and we'll build it from the same git tree that
the rest of the git code lives in
    *   Randall: procinfo doesn't have any nonstop stuff there, it
would just be a stub for nonstop, want to make sure we can still make
it work
    *   Emily: procinfo leaves stubs if there's no platform-specific
stuff, so we want to make sure that procinfo still leaves stubs on
e.g. nonstop
    *   Randall: yeah, and then i can make sure it still works once we
have a series

On Wed, Jun 14, 2023 at 9:29=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> Hello folks,
>
> Google is hosting a standing engineering discussion about libifying
> Git, for contributors interested in participating in or hearing about
> the progress of this effort. Expect this discussion to be free-form
> and casual - no powerpoints here!
>
> We typically hold this meeting every Thursday at 10am Pacific (17:00
> UTC) via Google Meet.
>
> To get an invite to the video conference and the notes document,
> please reply to this email. Please also add points to the agenda
> (template follows) if you want to raise awareness of them.
>
> We'll choose a topic to discuss at the beginning of the meeting, and
> I'll reply afterwards with the notes.
>
> *   (asynchronous) What's cooking in libification?
>     *   Patches we sent regarding libification
>     *   Patches for review related to the libification effort
> *   (asynchronous) What happened in the past 1-2 weeks that interested
> parties or intermittent contributors need to know?
> *   (asynchronous) Where are you stuck? What eng discussions do we
> want to have? (We'll choose a topic from this list at the beginning of
> the meeting.)
> *   Session topic: TBD
