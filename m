Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41EC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21C3619AF
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCVMcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCVMbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 08:31:40 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C7C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:31:39 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c13so5456940uao.10
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YDcpXrnqAFdXQq1oayPkK57QSa4VmplCgQAUdxMg9AQ=;
        b=BRXIJV94zmqf0Wnl42upybEfRd3//tNJcmvVTbzdENyNODiUHI6wmJLlt3TiYxowXI
         +uEjPVmGgVLdwtxxRT7NksbItLjanZApUDY9XIPYtuswMUYz2VGOxfLQ3mBoM1FUycT0
         q5SWSZ+LnY8IPLnzDFC6upOuh8c53Ej+0gAWKN547SLv/SK/EdPuwHPjBC769QprsN/n
         zzOL7NInfJmLPkWJfsPl+oT9dYnZ/TvCxEkJJzQXAG4ClwFGViDAzk4HyKgJibW9/b2N
         m4SfWhhqOGs1bNgLDWea2EyD+mpBukjr2I5/kgzIVK8y4Fr9ciE/Td/3owsxcfm3QkyM
         S5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YDcpXrnqAFdXQq1oayPkK57QSa4VmplCgQAUdxMg9AQ=;
        b=JK8iRaOO4R4DqxixzvcMhCjC3f/+8GcNWJMK55Zh1c7qfGDQI2WZ+ILHaP/ilelJvD
         Wmwahag6qfj2dw4XEtQMSzvTjgQKuFvhyqepJwSUoytLqHQmkf7rMZdW4+2xdSUVDPBr
         gF+meEikh41AYKyLVIDJASqmYA6CpUgQFj/YlsAkj0sGgZG+WvOeAT4bcqCym+kkFG41
         bTiw4Eo6ByZAJeUsNCP5AMjnQ+0XhGEYs5FGc6RjbdjkjUY4twptzBFIgjTHWPwg0/S/
         5D/dGIzg/9dj4ZxpZu6jerr+9M/bJBTJjF/NHGoTJ+2/uqy+98d/NYVTbQP2pZqs993a
         yQGA==
X-Gm-Message-State: AOAM533+PjOuqMekiOusYeu3xZ90L3ALcpIK/8zY1t1OcAUd9M8Pyayo
        fLuo1jkeBThUlkYYS4N2r95+BKNm6vF0WDJlaQOXbOviDM8=
X-Google-Smtp-Source: ABdhPJw2bLje1jo85rb6dATKqQqJ8lRLvx609H0PrxiNNVQNkCA64AfTOWVo18dc2BZjUIplb3PxdKDYQ5mtMwU9Fec=
X-Received: by 2002:ab0:8b:: with SMTP id 11mr4370511uaj.83.1616416296522;
 Mon, 22 Mar 2021 05:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <5359503.g8GvsOHjsp@mfick-lnx> <CAFQ2z_MavgAGDyJzc9-+j6zTDODP7hCdPHtB5dyx-reLMSLX3Q@mail.gmail.com>
 <4400050.5IlZNYTcJN@mfick-lnx>
In-Reply-To: <4400050.5IlZNYTcJN@mfick-lnx>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Mar 2021 13:31:25 +0100
Message-ID: <CAFQ2z_NaXC-h5U3v2JtrFU8rGNHstTSN3CDoazUiUUk522sW7A@mail.gmail.com>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
To:     Martin Fick <mfick@codeaurora.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 11:24 PM Martin Fick <mfick@codeaurora.org> wrote:
>
> On Thursday, March 18, 2021 9:58:56 AM MDT Han-Wen Nienhuys wrote:
> > On Wed, Mar 17, 2021 at 10:22 PM Martin Fick <mfick@codeaurora.org> wro=
te:
> > > On Wednesday, March 17, 2021 9:06:06 PM MDT Han-Wen Nienhuys wrote:
> > > > I'm working on some extensions to Gerrit for which it would be very
> > > > beneficial if we could tell from the reflog if an update is a
> > > > fast-forward or not: if we find a SHA1 in the reflog, and see there
> > > > were only FF updates since, we can be sure that the SHA1 is reachab=
le
> > > > from the branch, without having to open packfiles and decode commit=
s.
> > >
> > > I don't think this would be reliable.
> > >
> > > 1) Not all updates make it to the reflogs
> > > 2) Reflogs can be edited or mucked with
> > > 3) On NFS reflogs can outright be wrong even when used properly as th=
eir
> > > are caching issues. We specifically have seen entries that appear to =
be
> > > FFs that were not.
> >
> > Can you tell a little more about 3) ? SInce we don't annotate non-FF
> > vs FF today, what does "appear to be FFs" mean?
>
> To be honest I don't recall for sure, but I will describe what I think ha=
s
> happened. I think that we have seen a server(A) update a branch from
> C1 to C2A, and then later another server(B) update the same branch from C=
1 to
> C2B. Obviously the move from C2A to C2B is not a FF, but that move is not=
 what
> is recorded. Each of those updates was a FF when viewed as separate entri=
es,

I think those would fail with the way that Gerrit uses JGit, because
C1 -> C2B would fail with LOCK_ERROR. I guess there are code paths in
Git (?) that will execute force-push without checking if the update is
FF or not.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
