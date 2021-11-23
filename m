Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA0C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhKWRJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhKWRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:09:57 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0836C061714
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:06:49 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p2so45095196uad.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uh3x310FbbWQWJCUN5i9Kp9WHcfuj+QDjU3m0NfH31I=;
        b=UI9i0ooD+hF/XsL8wXCKNjqypq3cKtLkuPn7rpWn5LgAqSnuE6A9vCW/ycq0YNDCKm
         I/RS/nXX8pTi1CSjVw5ntbkMtv4zrMBAETdJFUEQsInU5KOtf6HxoqDiz2zCogTnlk6c
         rBr5sBWK1JOJycJCIX1ni4/4/LZhnnQAYSifziA1c+5Of8sR39On7o021JA/Qg/PZ+eY
         sZbwdcRSSlLqljgyVe+S7yk/ZeeLrcO/p9D3Oxvnn6pT4HeUmPLplxbnxGhZwKVgOObM
         6HkHRhOqO0gwwsXVekWmoljU/udgz+9ghx26dQ7p0Fs8xar+rGMyZQlHdh9iGtUp6MAL
         R/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uh3x310FbbWQWJCUN5i9Kp9WHcfuj+QDjU3m0NfH31I=;
        b=F6xmXaM5/U5pe2Q59N5mC6qyALlM5jWyR+FxJEv7p+v8QFUfMcWLyAsqee2CZTlXSE
         HFW/IyHSNgR9ghJqotQSCagWy76ALNJh0mlw/QWoluwMb66kqzzrzvimHKj7jMdIm+Fm
         re/MAeVuI/c94DsyiaA2PTw04+Jt6RYJAOFVlOypPqRBpie1xCS4XwzTjj0UVzlmIfus
         0GbczZzfJlCeHMoFALwJoDWAnmtGd64Jb+SlTah/5oTTivMlEnvSGcaSQYPvM4VJ5m7U
         TwwTqarmkrqO6pBc+0L0zEwzQa+CKoafIAiG4IumiZGyt3xaG0MMxKLYA7jmsX02pKop
         vBfg==
X-Gm-Message-State: AOAM5310BUCXcFavlCjz9M6ICrdCBdOuvLtohA/R8I0fOE3uSur9wwyP
        KatJzhmSvcS5c9yJVIUZQBv/h2lKhwcb5BOZ1qijz0cGdV4=
X-Google-Smtp-Source: ABdhPJwLVzGG2+p591jj8Usq2A5/m0BV0cmJExfYotbWocHMr90L/nIghFQpvFO1+p/4BOrrpLR4D+6glhfeC1/rut8=
X-Received: by 2002:a67:cb04:: with SMTP id b4mr11821144vsl.17.1637687208602;
 Tue, 23 Nov 2021 09:06:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <8a1b094d54732b8b60eacb9892ab460a411bcec3.1637590855.git.gitgitgadget@gmail.com>
 <xmqqr1b7bz5v.fsf@gitster.g>
In-Reply-To: <xmqqr1b7bz5v.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 23 Nov 2021 18:06:37 +0100
Message-ID: <CAFQ2z_PhazkdC8JOqDW-=VD4iLq_==x23+fN7T-Vp9M2DoW=qw@mail.gmail.com>
Subject: Re: [PATCH 3/4] test-ref-store: tweaks to for-each-reflog-ent format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 11:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Follow the reflog format more closely, so it can be used for comparing
>
> There is no v$n designator on the title line, but I have this
> feeling that I've seen this patch before.  More importantly, I

you have, as part of a RFC to drop "update reflog if reflog exists".
Since we didn't get consensus there, I'm offering up its predecessors
separately.

> or something along the line?

sure. I'll update the message

> > @@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, s=
truct object_id *new_oid,
> >                      const char *committer, timestamp_t timestamp,
> >                      int tz, const char *msg, void *cb_data)
> >  {
> > -     printf("%s %s %s %"PRItime" %d %s\n",
> > -            oid_to_hex(old_oid), oid_to_hex(new_oid),
> > -            committer, timestamp, tz, msg);
> > +     printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
> > +            oid_to_hex(new_oid), committer, timestamp, tz, msg);
>
> Looks good to me.  We might want to make the printf format
> conditional to add \t%s only when msg is not empty, though.
> Hopefully such a change would follow the reflog format even more
> closely to make 4/4 unnecessary?

I think the conditional formatting of \t is impractical. It makes things li=
ke

  (metadata, msg) =3D line.split('\t')

in Python require special casing in case msg is empty.

> > diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> > index a600bedf2cd..76b15458409 100755
> > --- a/t/t1405-main-ref-store.sh
> > +++ b/t/t1405-main-ref-store.sh
> > @@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
> >
> >  test_expect_success 'for_each_reflog_ent_reverse()' '
> >       $RUN for-each-reflog-ent-reverse HEAD >actual &&
> > +     head -n1 actual | grep recreate-main &&
>
> I am not sure how this new test helps validate the change to the
> code.

It's for consistency with the preceding test. I can make a separate commit.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
