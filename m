Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFAC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 11:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746EA23357
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 11:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLGLxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLGLxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 06:53:04 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26345C0613D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 03:52:24 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id b23so7359458vsp.9
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4nPYtVbAA4FMKR68Ryo1N1IA/J2vmZ10Ic2g5jeorFs=;
        b=ZahTrmqPVawp1e/1OSPF/vYToQLjWq1+faUEAjUgaWHx3Y9mGeq70pDXevuiYp9lvE
         q1S1v9a+EL3gNdOK51fO+A9YSzECUUr6Lrt4Cpq1OPolGtjiWSpct6xs0hHWAko9XeVY
         f/euwMQ3IjurIIm0svB8Z301idVf1abaK1KtVT4HjmHLYsBx6O5gd9b5sjT9BcwcRov8
         tOX45tnDffI0N+DlCfkLtqnWAnbJLOqkCqP5sEo3X5as6qFM87Y/JfXu1m1YUcEserEm
         AqA/49C2P1T2Eax4gIkQEzkk0SfN6OA0A5BAOPj19Zua869geJhtKIHjGpkGfQQwYWDY
         hTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4nPYtVbAA4FMKR68Ryo1N1IA/J2vmZ10Ic2g5jeorFs=;
        b=cL4YvkSURkvNK8VtbAYiygqNYyIb4SI33P8YJK4YBo5kqGMaiEJSEieC4JYEl61lLe
         qHHynV5+lKIQalSfD6VUeDbqVvYCtmNmsE1hWqXKm7pj+PiLKIdfTUlAUdXIhzi3J/sc
         J6nHsRahXlnmf7Y/PaPHJFs66WCSPpOeIdr12MhI971UmP75TQOBZFbnbH1x30968cbB
         RMnkjpQV8WDANqtkSkYJ40rNJhAB9NRBbjwgmwMBOcq5sLWhNmmNkX4Xqk0cc2ZjY2KE
         UptFphFCJICG2jWnXFxnW1b2sGUgFqe0RBKHkRfLXeskM/GDwCfM8EpK3KGqNvck6LwZ
         n9uQ==
X-Gm-Message-State: AOAM531igsfrGrjXGmvpF83PdvwUlm0BnPCT+dhn8AtxxOlvSbNqWP8X
        zadgrkMNNqmNtHBO7uxR+YBvg6PnjBsf70hE+z/OHg==
X-Google-Smtp-Source: ABdhPJynJLnfhoW4/wLrLy583mq5/SUzWZzpqanO3Yj2GHLgPVjVmlrR+v16lbG4tdOKEWcYe6oebFkQZStvBZkHwCk=
X-Received: by 2002:a67:f7c8:: with SMTP id a8mr11246547vsp.54.1607341943143;
 Mon, 07 Dec 2020 03:52:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.924.git.git.1606419582190.gitgitgadget@gmail.com>
 <xmqq5z5mruia.fsf@gitster.c.googlers.com> <CAFQ2z_M3OO_nR6dhw6zzE0orYxcawP1DaJ_EOL5=+RUiZgCo8w@mail.gmail.com>
 <xmqqtut2fp5z.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtut2fp5z.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 7 Dec 2020 12:52:11 +0100
Message-ID: <CAFQ2z_OsyseuPWxpj9S4R_Pp_Koa0JuJeO2gte+TLxDh+oHPNg@mail.gmail.com>
Subject: Re: [PATCH] init-db: init the_repository->hash_algo early from GIT_DEFAULT_HASH
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 12:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > If the_repository is only half-initialized at this point in init_db(),
> > then why are we passing it in refs_init_db() just a couple of lines
> > further? At what point the_repository considered initialized?
>
> I would have to say it probably depends on what callees expect.  The
> current implementation of refs_init_db() for files backend may not
> need anything other than the hash algorithm enum, but many other
> fields are missing, and they should ideally be populated, no?

I think so too, but it looks like a major refactoring by itself, which
is only very tangentially related to the reftable effort, so I'd like
to punt on it.

> For example, I see files_ref_store_create() cheats by calling
> get_common_dir_noenv() to find out where the commondir is, instead
> of ever asking the repository the ref store belongs to. At least,
> get_main_ref_store() is told to get the ref store that belongs to
> the_repository, and it would be the right place to learn relevant
> pieces of information (for that matter, I am not sure why struct
> ref_store does not have a pointer to a repository structure; perhaps
> we are seeing the result of piecemeal evolution, not a designed
> structure?).
>
> > I'm a bit at a loss here; I never learned how to cleanly work with so
> > many global variables, so I'm happy to take your suggestion.
>
> I am only interested in giving a clear direction to future
> developers where to populate the_repository's members (and nothing
> else) if their enhancement needs members other than the hash
> algorithm to be populated, as if it were the_repository initialized
> in an already working repository (I am not talking about many global
> variables, whichever you are referring to).

You said earlier that maybe ref_store should hold a link to 'struct
repository'. However, "struct repository" doesn't have a documented
purpose (there is literally no comment documenting its purpose), so
it's hard to tell upfront how to correctly configure the relation
between "struct ref_store" and "struct repository". Currently, "struct
repository" has a pointer to 'struct ref_store", which makes it
suspect for there to be a pointer in the other direction as well.

The reason I bring up global variables is that without them, the code
would enforce a much more clear relation between different entities.

Looking at the definition of repository, there seems to be some
overlap in functionality between struct repository, struct
repository_format, struct repo_settings, and config_set, and none of
these structs have a clearly documented role.   Before we change code,
it's probably better to spell out what these structs are thought to
be.

> One way to do so would probably be to do something like the
> attached.

Thanks, I've amended my patch.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
