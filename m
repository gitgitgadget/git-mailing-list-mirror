Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4370DC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 13:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiAQNKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 08:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiAQNKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 08:10:55 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2531C061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 05:10:54 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 19so10335665vkl.2
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 05:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=McsX6sn1kzLx2a4XcJKjr+jYgPZ42dUG9yDP4O3RalY=;
        b=SyAFILc6bPhbBZF8MlD1myeSnClT/tGPQ+RYf7kXhPZgFoPZx8xSad72KfRz4m0At3
         3tswCiz1hQC/24VmrnQCYwufzlpzBlTsUTzL1llJyb7A0JkvLjRZ9BPlI4NCIsYXXRvN
         n9NVmMke5i+8lOYYDTPJj54GGSek5nZGIWBewMYgFAiPURvMSFpiphn/hINP4mUa+iBE
         ob7bACUGJ3Nw/G21BmOhmIq06UzD8SoXE1aN3V0wHk/GVLfDY/y+l94oSFDGPKp7TnMA
         MPUbv+imsi5Pl304grBfuEu4C3+wqSulB3tLC5qe1QdtY9x2xFfh8mNFHujaF1MDWXia
         +EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=McsX6sn1kzLx2a4XcJKjr+jYgPZ42dUG9yDP4O3RalY=;
        b=2OY4V75azipumY2o6QUE9WKlnedC8KE6FJ7k3oOGPeNoSU+e/DHRks70OtgA9tl9sa
         cP2V6yxFbv6hWE6bM99Ae0eMczL17xieCR29dmbERpJ9yqdBhDmMO6X5q3fmUyBUGY5+
         gPR50p6A67u09wGE4VaVaNF0otg4cIWiqenvJe9gmMsTBq2mlymFIdf7PUVAhuyUFvSb
         RQ6NYNNoo92qgSZwPm1jX6M/mBrkaplemHch6sL9/vhvrdfrHAlHenINaEBa7EnTaYGO
         GqHctpscqgGfQiSXxHFvcslGDpEJbyUEOCDokepGgQf9xd4jj4gs8aXpJ5Bg3ejQHaTt
         Bc8A==
X-Gm-Message-State: AOAM530pAdIEYigGOnMxRiilck5nriGrbihD2qAhyrxEtQkssm2HIOi+
        58C9t9YQqk3tixcWn9yiTDLwJWJtapuEZ0UVdZx9MA==
X-Google-Smtp-Source: ABdhPJyKZIs0c1tAVljAEGP8lLPAioge5WQraKemdqSKPb0Sl8IKtZhOflaXQ71H38kGOWhQ4MAqdqggzqAe7D9e/gs=
X-Received: by 2002:a05:6122:c8a:: with SMTP id ba10mr7970199vkb.37.1642425053743;
 Mon, 17 Jan 2022 05:10:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
 <e4c1cc58265ca7ae7b32b9faf41324883011d1a6.1642010868.git.gitgitgadget@gmail.com>
 <xmqqpmovds5q.fsf@gitster.g>
In-Reply-To: <xmqqpmovds5q.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 17 Jan 2022 14:10:42 +0100
Message-ID: <CAFQ2z_NLauUqf8FdWbQVxVmqx5xQ11E5t5SwDDyKyLSa9QU8KA@mail.gmail.com>
Subject: Re: [PATCH 4/7] reftable: avoid writing empty keys at the block layer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 2:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> > +     ref.refname =3D "";
> > +     ref.value_type =3D REFTABLE_REF_DELETION;
> > +     n =3D block_writer_add(&bw, &rec);
> > +     EXPECT(n =3D=3D REFTABLE_API_ERROR);
> > +
>
> The preimage of this hunk has been invalidated by your 9c498398
> (reftable: make reftable_record a tagged union, 2021-12-22).
>
> I see that the hn/reftable-coverity-fixes topic, which the commit is
> a part of, has been expecting a reroll since last year---are you

I sent a reroll on Jan 12. As that has had more scrutiny, it's best if
that lands first. This series is less urgent.

> plannning to rebuild that series after landing this series first?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
