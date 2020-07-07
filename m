Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFBAC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378D720738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOdS0JJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGGRPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGRPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:15:44 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C0C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:15:44 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id b24so5985064uak.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nMCVVSyQ3OZOjUvQKDs+vh5gLeMs22VckndocDXSGfk=;
        b=KOdS0JJVCYNju6VrURMHBIxP98Ih1Hg8QSLQHM+4HR2f3uYs5WW+9deV767n+LociP
         aZkBuye+rUB9h3U5CswpwaeZwobgrUkhw8Wao9Y3TuwoPLc9Y6RCnh0FWH5qU4C159DI
         s1xWmM8MUqLbPJk/oC1CgUkqk4z5asrgNembsctQyvytln0nIbQhq2pV9uKaTtp8zVo0
         5EzSWsvik7NJ9q68tUq6B+mbta46nf7cmyt1dqg63koVeXUwBCs7wx/IKoP9ydjt/6uA
         +unsL30tGdyX2UqhICGbopMdTA17bKcD6XAj9bgTj5WZeDoHlP/SlI3R8fWN1jyrUjVM
         lssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nMCVVSyQ3OZOjUvQKDs+vh5gLeMs22VckndocDXSGfk=;
        b=X3t3eXPicn6kW6PTgYTCYMvbJaWU5j+DC4JOG3JTHZ20RridICvaTANHqhvJuRNaEE
         Hipf78PwVXpCZbDdJg2u/7at0nkRqI2J4G591jQYWK22On4std4S+614ALoP5GJZ02Ge
         0T6Vhi+WEuvXXwT/Xwvg0OxxiJZK9ugEjB3cJBXGOIhzvr5oKQh7Ch0hHcUZFm71VvEp
         8fHb2ludOUapijpvFgd4/3k1KeXNf0IwyUvNRHzndG+j0nPPNlXEgOIhcYJ4b81AchUw
         72HCSC5A5qeSDiJfvtXuXneK9Geooq9NEI5lZxJ7PPbHzavcYboSy0elPzrrEkpBxBWG
         RCAA==
X-Gm-Message-State: AOAM531LTialgRqSqhwwmwb0csvgun3maV4G9rrppJ1wLjuN0VxmIQbi
        hF9EP1+nNIU/NaxlJtHGbGLP9V0r0FjtpmFrd7RVzQ==
X-Google-Smtp-Source: ABdhPJy4FQ6pyfbIf13MrqmXh/7dZnB9AeX/byLulzMBE+SeIO78Wl7/9DJKk23zUgSpfvcTR/0u1HobJgsDnv40eyM=
X-Received: by 2002:ab0:15a4:: with SMTP id i33mr4602042uae.85.1594142143624;
 Tue, 07 Jul 2020 10:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
 <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
 <xmqqimf09ypc.fsf@gitster.c.googlers.com> <CAFQ2z_OPbcX9FGsFnmraAUpTu2eKuf2PZ+DO-CTWvaBZD6WQQQ@mail.gmail.com>
 <xmqqv9iz5p2v.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9iz5p2v.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 7 Jul 2020 19:15:32 +0200
Message-ID: <CAFQ2z_P37j32O71Z+NxNNU7-xLfYf-Rz-MvbYakcpaysiep9Zw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 7, 2020 at 5:20 PM Junio C Hamano <gitster@pobox.com> wrote:

> >> The reason why I asked what this patch thinks the definition of
> >> pseudoref is is because of this thing.  Shouldn't this line be fixed
> >> not to depend on the files backend?  Likewise for $(cat .git/PSEUDOREF=
)
> >> in the remaining two hunks.
> >
> > This patch doesn't introduce reftable yet, so both definitions are
> > equivalent for the sake of this patch.
>
> But at the end of the tunnel, we do want to see people stop
> expecting that .git/PSEUDOREF file is what PSEUDOREF ref is, no?  I
> think that is what "pseudo refs are not just files directly under
> $GIT_DIR, but managed by the backend" means, and that in turn is a
> valid justification for other changes introduced in this patch.
> Expecting the effect of modifying pseudo refs _after_ the code is
> changed that such modifications are properly done through the ref
> API to appear on the filesystem feels like it goes against the
> reason why we are making this change, compared to checking to see if
> the pseudoref really got updated as desired via the ref API, at
> least to me.

I can fix this specific instance here (which is what I think you
want), for this commit to practice what it preaches. At the same time
there are probably about 100 or so other places where the tests check
the file system directly for ref(log) existence, so it would never be
totally consistent.

The only way to systematically find the offending places is to
introduce a new ref backend and then fix all the tests, and I think
that goes outside the scope of this small series.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
