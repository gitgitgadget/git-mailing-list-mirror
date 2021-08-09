Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADAC432BE
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342F760EB9
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhHIBgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhHIBgb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 21:36:31 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B4C061757
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 18:36:10 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 75so1185627uav.8
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 18:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ol3HHjhGQJwsYyVchFXjMqq4BmSrQZFkziEqDr0L8M0=;
        b=mwUjStrKi3xYOlp4PXBUDiaEpo2MPjFIhyOhgeZb6B3zDwY+n5ucdQF34vRMIrWhvA
         dHMyEurOKN2RX3uniLQpEXhA5T47oq1BMAhCpjn8W/F975EpQDXiQivtIeDPnGV5pMKM
         JEMhBSJf1J4yQTt3DCFVQlK2joPzlOmxttqf/PMYo2nKdn0gH/FN+bD1D9g3qTZdU6N0
         NbDo2KSqQ0zDPgCxlZUj+/BIgj48WPzq2EQ7+JaLKsVAAeFIefZWF+Umx6hobVRXm74l
         WcBBdELD46sqMHwKAUy72kuZQve7HU3TMtpeaVQqQBoQqy6mj2019tUZ6rabOSpU+Rhw
         QK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ol3HHjhGQJwsYyVchFXjMqq4BmSrQZFkziEqDr0L8M0=;
        b=VDOZmrKpmjTe/fVU7Zym+TU8qJI1ovk8nePLi9t7IrvDMkN7iMrl+S1DNBZhLSyVN5
         jxj2xi7dwsOrJ0fedv8PC2kE0uqbnzzjmRMCP2LbUGh6+b4heZVrNXRAz6/xg+a+N4wV
         BW/KDAhj3d4TQurcS4Wl63a/dJn4RbEuSMwcNk87tPN4KzwGtfRoFZfFzZaNAUQC2yBg
         AGUMqHy5X2B1nn59jjdMR898A3u3MagMZFRpjMgMVuKF6VLlX+IkZEBIMy7SWB0yuvNR
         uEEBvznmkK7al0xHQ6uyVKROMMiDcjq8xxgTYON+NSSCeWuKO4GJONoFxJ8Ef1iKIDsD
         2CLw==
X-Gm-Message-State: AOAM530bzqErHOOMBcEjqGKlUF6N41ao9bQYqZqTSsm6d4EPW71uAtcu
        Q5MHGlz/ADwaZvsQsW4Qcs1qSpRctiY6rIr/KD4=
X-Google-Smtp-Source: ABdhPJxpj39IJ15AwIOg8SvQhQ56VM0ndRmzpq8hA0mmstvGTpK7TcghhuNmm154DXW2UqpkUR5wq+Sqa77HMFe4wJA=
X-Received: by 2002:ab0:3896:: with SMTP id z22mr13856915uav.2.1628472969996;
 Sun, 08 Aug 2021 18:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210627024718.25383-1-e@80x24.org> <20210629205305.7100-6-e@80x24.org>
 <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org> <bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de>
 <20210807224957.GA5068@dcvr>
In-Reply-To: <20210807224957.GA5068@dcvr>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 8 Aug 2021 18:35:59 -0700
Message-ID: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
To:     Eric Wong <e@80x24.org>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 7, 2021 at 3:51 PM Eric Wong <e@80x24.org> wrote:
>
> Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> > Am 06.08.21 um 17:31 schrieb Andrzej Hunt:
> > > On 29/06/2021 22:53, Eric Wong wrote:
> > >> [...snip...]
> > >> diff --git a/oidtree.c b/oidtree.c
> > >> new file mode 100644
> > >> index 0000000000..c1188d8f48
> > >> --- /dev/null
> > >> +++ b/oidtree.c
>
> > >> +struct oidtree_node {
> > >> +    /* n.k[] is used to store "struct object_id" */
> > >> +    struct cb_node n;
> > >> +};
> > >> +
> > >> [... snip ...]
> > >> +
> > >> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid=
)
> > >> +{
> > >> +    struct oidtree_node *on;
> > >> +
> > >> +    if (!ot->mempool)
> > >> +        ot->mempool =3D allocate_alloc_state();
> > >> +    if (!oid->algo)
> > >> +        BUG("oidtree_insert requires oid->algo");
> > >> +
> > >> +    on =3D alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid)=
);
> > >> +    oidcpy_with_padding((struct object_id *)on->n.k, oid);
> > >
> > > I think this object_id cast introduced undefined behaviour - here's
> > > my layperson's interepretation of what's going on (full UBSAN output
> > > is pasted below):
> > >
> > > cb_node.k is a uint8_t[], and hence can be 1-byte aligned (on my
> > > machine: offsetof(struct cb_node, k) =3D=3D 21). We're casting its
> > > pointer to "struct object_id *", and later try to access
> > > object_id.hash within oidcpy_with_padding. My compiler assumes that
> > > an object_id pointer needs to be 4-byte aligned, and reading from a
> > > misaligned pointer means we hit undefined behaviour. (I think the
> > > 4-byte alignment requirement comes from the fact that object_id's
> > > largest member is an int?)
>
> I seem to recall struct alignment requirements being
> architecture-dependent; and x86/x86-64 are the most liberal
> w.r.t alignment requirements.

I think the problem here is not the alignment though, but the fact that
the nesting of structs with flexible arrays is forbidden by ISO/IEC
9899:2011 6.7.2.1=C2=B63 that reads :

6.7.2.1 Structure and union specifiers

=C2=B63 A structure or union shall not contain a member with incomplete or
function type (hence, a structure shall not contain an instance of
itself, but may contain a pointer to an instance of itself), except
that the last member of a structure with more than one named member
may have incomplete array type; such a structure (and any union
containing, possibly recursively, a member that is such a structure)
shall not be a member of a structure or an element of an array.

and it will throw a warning with clang 12
(-Wflexible-array-extensions) or gcc 11 (-Werror=3Dpedantic) when using
DEVOPTS=3Dpedantic

My somewhat naive suggestion was to avoid the struct nesting by
removing struct oidtree_node and using a struct cb_node directly.

Will reply with a small series of patches that fix pedantic related
warnings in ew/many-alternate-optim on top of next.

Carlo
