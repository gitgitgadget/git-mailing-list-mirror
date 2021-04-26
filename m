Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE68C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44461613F3
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhDZShm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhDZShi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:38 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957CCC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:36:54 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id h130so7107206vkh.11
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gbMyq48IvEenpjSvSM/fa6V78u+pzabZZBxxJru4u8M=;
        b=GHNJ3rDjD+GW2DLBdnOiz1S7y7lh8pSWHEFAOwOgUbsjGTttiLJAxqx2FAF3Cha/Jw
         HYOvt9XYmECzHc6k3QByNiI6Rxojrb07XgUQcpcAhyjR3ATOpYK9Ggirx/YJpRwk5uFC
         0o/9JDqkD4bxoiRieGl9va707pCeoU8FTVUEEbTPJgcOGV0scH3An0j8rXp4tby2ca9y
         IwxR91u+LT2GwR5svh7eAxi6mcSyIuaFPJmOdpK9cjDLeqRcMkzicv3T4bGcfdlR5njs
         PwKCLet2R/axkq9SBH5xnKq1tN5FoJXzl1/0ZvpdafUOUkgVNEu+6pobref7/0iEkw/b
         NZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gbMyq48IvEenpjSvSM/fa6V78u+pzabZZBxxJru4u8M=;
        b=psJwsyTeZLsQ6GRXs2ITulOC3uIvH9FxkwXXR5CX5Zo7vw2DKML3+DufQb9Yd1zsXp
         FCqzyu2gaqxHsnHBmKQOUJufDq5EBN/X7F9yj8O7VGM/bAeIYfVLnpT89TfCiGmx8BGd
         e8e5t51TINWzyM44WDZFYhay0X8XRljLWzon9PwrBu8BnzG6MBcVgTFyYXl03NFunxZn
         sl/+13YcHnUhDemPjNMeg63G4F+1+sU6cWv+s/igU9vTAbnam1lB3J3hvS9Ra/eDiZA8
         gRNnEGAtJiGqJh8mhO1y4uc9wE6rdqh7dM6xQy258UBmnaxbE65RpuWu5qeZYR/fnFRU
         WyNQ==
X-Gm-Message-State: AOAM531fRqHMc2fSrs53wFZ16XgM4bApXE8B0F0aQmlcm0kKzv3bPxTu
        VzfNkYIczLONAFH9I7TY2y/Ry5Yz4MPJRg88+DsJXg==
X-Google-Smtp-Source: ABdhPJyduDP/hbnQm3l8cCjyLyByIn0qDh6TGRKkBKhwrjdmEA+9JJQX4uMmlqjsc/5tFp0a1bWzoWSUk+FZ+gPhZfY=
X-Received: by 2002:a1f:5c97:: with SMTP id q145mr13934849vkb.25.1619462213514;
 Mon, 26 Apr 2021 11:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a3abc4f70e7d6bd833024f2c9b42ff731896e14d.1618829583.git.gitgitgadget@gmail.com>
 <87mtts3z2a.fsf@evledraar.gmail.com>
In-Reply-To: <87mtts3z2a.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 20:36:41 +0200
Message-ID: <CAFQ2z_M-ahhbgnvpTXhs3nR0KJKqHtE7snqrpzi_O-M1sVCfaQ@mail.gmail.com>
Subject: Re: [PATCH 14/18] t1404: mark tests that muck with .git directly as REFFILES.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -test_expect_success 'broken reference blocks create' '
> > +test_expect_success REFFILES 'broken reference blocks create' '
> >       prefix=3Drefs/broken-create &&
> >       mkdir -p .git/$prefix &&
> >       echo "gobbledigook" >.git/$prefix/foo &&
> > @@ -504,7 +504,7 @@ test_expect_success 'broken reference blocks create=
' '
> >       test_cmp expected output.err
> >  '
>
> This doesn't seem specific to the files backend at all. I.e. if you grep
> for "reference broken" in the file backends you'll find EINVAL and
> REF_ISBROKEN handling, and your refs/reftable-backend.c has the same
> exception handling, so presumably we can end up with broken refs.

I think it's not possible. In the files backend a broken ref is a
shortread (less than 40 digits hex) or garbage following the hex (or
maybe non-hex digits). This is all impossible with reftable.

I've removed EINVAL from reftable-backend.c

It's possible to have a corrupt reftable file, but that would surface
as  REFTABLE_FORMAT_ERROR, and is morally equivalent to an I/O error.
I added a test for this; it says:

++ git update-ref refs/heads/main 69af1687b671131ed0cfa61b7fcdc907a4c21f2c
fatal: update_ref failed for ref 'refs/heads/main': reftable:
transaction prepare: corrupt reftable file

> Anyway, much of reviewing this commit was trying to rediscover thing
> that should really be in the commit message. Presumably you had to run
> blame, log etc. to find the commits from Michael Haggerty and dig into
> if they were relevant to reftable. Having that information in the commit
> message would be *very* helpful.

I added some more explanation. I did not dig into the history or the
blame, as the tests seem relevant given what I know about how the
files backend works, but for that same reason irrelevant to reftable.
Maybe it should be documented more explicitly how the files backend
works?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
