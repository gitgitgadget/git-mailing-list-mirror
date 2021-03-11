Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A962C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC71764FEB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 13:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhCKNCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 08:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhCKNBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 08:01:41 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FCC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 05:01:41 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id k76so455213vkk.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 05:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CmkpLRkUPRurvEKPSLqk3pIVMnaEUYzVbIQwq9drL8Y=;
        b=Je5yP2sMsIhX2mTXHBrzkOyS6hODTn8b39H7yviCSU9NfrqQ308BcUAXTRqWiCds2T
         LEF0EQRcWIVh4VoMhRThZoOuBHi8UO5XDfSEI4SGq1Rcw+2Ho+c+ja9O3UIPzvsQzIA7
         wlEXXbO1yJN5AqKFd3RwC/eC8eFd9wIws8pnaaIc2jgUYcygKFel8f5ntu6OS1MVyKKr
         oPbwIphdEhCM/36tRRrQ20++Ym1tnNZlhHFPRd9rNsXCvWP48mkpaSdwk2EI1bl92uNu
         plUZd6E7joiD7mznVWOqRQih6Lh7qK+koY6rF+7mhIE4WsDNqkX9pimwyyJts3qPS2OP
         DLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CmkpLRkUPRurvEKPSLqk3pIVMnaEUYzVbIQwq9drL8Y=;
        b=F8JmsA7oCDwj/Xxmc3Jaimc/OzW4gkspH5nI6MYhKxFSfU+lJ0BSb+KSleY5OMq8iT
         InKTAuyZruBTe8tcB6Q16CT4XbNc0V/HiF6Wk3/BsP4LAF9SnVNtoGUm/K15G6/dG6jb
         EQIpNIt9Lg1/adxCcjSPvH5sUCZ3iS43XZ5zFy5nQnMGbQ5CMWUvHuNh2OXrrM9R7iMB
         +bYRaoYuOJMtErYAEmub87k8j5EGcQZJsebDsLwaatRXl1MaMj9gJS5K6ZijYBi27sBI
         m3PUlhy02NNbicp653CkaaWq7JFnQeGAvc4vUVRRzLyJJEAG5U5iWC8uNrQUXyjO7sX3
         lSIA==
X-Gm-Message-State: AOAM532iyIsP3BvJKCV5TTdT4nLK+zP7PJyc1uV9PYfC6BK0+KbyCqzh
        bMfirIDP7iDZ6Bdmn/5woW/Iil/qZea1d5oRX2hrtA==
X-Google-Smtp-Source: ABdhPJzdVQVclkkTabdOnc6JQyXfrBPJix5tLOPa9ym4NzxQSc8IPHTlPzld0cHtoTAbS7aUrkrcRev89ZaRrcMa0y0=
X-Received: by 2002:a1f:c7c3:: with SMTP id x186mr4671579vkf.0.1615467700022;
 Thu, 11 Mar 2021 05:01:40 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmtvafl62.fsf@gitster.g> <87r1klhq3y.fsf@evledraar.gmail.com>
In-Reply-To: <87r1klhq3y.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 11 Mar 2021 14:01:27 +0100
Message-ID: <CAFQ2z_NL1NYunAKwGGF2eK4hMS11gz_4VUw1rhd2rmPw60OZ9Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Mar 11 2021, Junio C Hamano wrote:
>
> Some notes, mostly on my own topics:
>
> > * ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
> >  - tests: get rid of $_x05 from the test suite
> >  - shortlog tests: rewrite to get rid of --abbrev=3D35 hardcoding
> >  - test-lib: remove unused $_x40 and $_z40 variables
> >  - git-bisect: remove unused SHA-1 $x40 shell variable
>
> FWIW (mostly for other readers) I suggested in
> https://lore.kernel.org/git/87tupigf02.fsf@evledraar.gmail.com/ just now
> that we drop 4/4.
>
> I thought we had better testing for --abbrev (turns out only I do with
> local patches), so unrelated to this we've had some regressions in its
> handling due to lack of testing (which this would remove more of...).
>
> >  Will merge to 'next'.
> >  In the longer term, we might want to remove filter-branch and nudge
> >  folks to more modern tools.
>
> Did we ever have a re-discussion of adding Elijah's
> git-filter-replacement-whose-name-I-always-forget to git.git? :)
>
> > [...]
> > [Graduated to 'master']
> >
> > * jt/transfer-fsck-across-packs-fix (2021-03-05) 1 commit
> >   (merged to 'next' on 2021-03-07 at c79f295216)
> >  + fetch-pack: do not mix --pack_header and packfile uri
>
> LGTM, see below about ab/fsck-api-cleanup though...
>
> >  The code to fsck objects received across multiple packs during a
> >  single git fetch session has been broken when the packfile URI
> >  feature was in use.  A workaround has been added by disabling the
> >  codepath that avoids keeping a packfile that is too small.
> >
> > [...]
> > * hn/reftable (2021-03-08) 17 commits
> >  - SQUASH??? calloc(nmemb,size)
> >  - SQUASH??? allow t0031 to run with any default branch name
> >  - Add "test-tool dump-reftable" command.
> >  - git-prompt: prepare for reftable refs backend
> >  - Reftable support for git-core
> >  - reftable: rest of library
> >  - reftable: reftable file level tests
> >  - reftable: read reftable files
> >  - reftable: write reftable files
> >  - reftable: a generic binary tree implementation
> >  - reftable: reading/writing blocks
> >  - reftable: (de)serialization for the polymorphic record type.
> >  - reftable: add blocksource, an abstraction for random access reads
> >  - reftable: utility functions
> >  - reftable: add error related functionality
> >  - reftable: add LICENSE
> >  - init-db: set the_repository->hash_algo early on
>
> It would be nice to have a post-release revival of this, Han-Wen, any
> plans for that?

yes, that would certainly be nice :-).  It's currently perf period at
google, so (I'm a manager), I'm somewhat busy.

However, the primary reason nothing has changed is that I posted a
large round of updates early December, in response to reviews from
Google's git team, and I haven't gotten any code review or other type
of feedback since (except your one message about the errno side band)

Is there anything I should do to get this moving again?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
