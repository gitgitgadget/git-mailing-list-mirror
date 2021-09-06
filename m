Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A4C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4374C60E52
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 10:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbhIFKiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhIFKh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 06:37:59 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A815C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 03:36:54 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a14so3581604uao.0
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OrxwssozbrJV1Y1AuaV/3fV7H15RrRKhbm3VV4zCj+Q=;
        b=pVcqc+9avg6TNMwVBGFf4dOFXxLD30so8XXTpNfbj2T9bLXAfHSmsAK/Qq/0V+CUCs
         Qlt3ij8Vc6quXxHPPlMw3xYBJDEKT2HbeX7Rs4cSLfALyOyBQuBqmwpv/3Q6mn7HpAJs
         fYgM1TVtPKSjBHwC3wllPAV0EB3k2564MRDo5Dt/+2BzznT+pXTMigpdo4mazYuxbb3F
         aY095S7+HVNSVm4f/jI1u6OR1LiUaRQNt8S/E37KOmB0UPxsLg5tAKnQR8wkKmitlFln
         QSZlbPepm6VV7wNKnSZmmtwLemx0Wvy/A4husqS/tWLkrlzoaT/6mWHGAEuqLXwWJBtb
         bZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OrxwssozbrJV1Y1AuaV/3fV7H15RrRKhbm3VV4zCj+Q=;
        b=Z0EIVcIncscVf1MfZ1CkeaYOr2DAItfnRxQDQ4jlsBw8zBLG2MlOvf/rNJiMg+drOF
         J/dC16lRbEXZQgN1gBhNuCfCBRDOxI5S34s/uX0LXOszQFSbnAoEjU2XO8QuQ8Q8+NmW
         GlDaCqXUh/Kp3jTLkDpn0mQK2g7dNNpC6F7PU7or9R3Vg1cjUdFRfda8aQbqDfPW4GbE
         y4eff5LZOhWnJfAzUIwTAkmb1JYS8mSN9e1B8YZ5K3tjQG3I1Lx+zRJN44qvwgFC1g20
         9X3O3bQvSujF5Hzz45EzlahGzH3ESbGvqS+2UKhwNfK0b/EaPpGQqyoPDCerbYu6veNt
         lMkw==
X-Gm-Message-State: AOAM532CJTghGYQgLFM/opxlscnm1tvM+N72ChrtcKpEw29CI86crpHG
        +uPfml0EItysKCfQwKMUu/clKg+vraXOAv35V+w9TQ==
X-Google-Smtp-Source: ABdhPJz8vgVutZGNkDg/uOvO/EkH4KzRb4fF0pBLfQUdW1Z5U+4UqjliKPl4h3rXfiyqt7VWRYT5pTLjg2phOAOEaHc=
X-Received: by 2002:ab0:330a:: with SMTP id r10mr4880794uao.47.1630924613408;
 Mon, 06 Sep 2021 03:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35qmiofp.fsf@gitster.g>
In-Reply-To: <xmqq35qmiofp.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Sep 2021 12:36:41 +0200
Message-ID: <CAFQ2z_N8pUsp3cdBpybHBD-V9_1sARCZvSxr0UkMfcwCoQfCbw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 3, 2021 at 12:48 AM Junio C Hamano <gitster@pobox.com> wrote:
> * hn/reftable (2021-08-26) 29 commits
>  - SQUASH??? https://github.com/git/git/runs/3439941236?check_suite_focus=
=3Dtrue#step:5:700
>  - reftable: fixup for new base topic 3/3
>  - reftable: fixup for new base topic 2/3
>  - reftable: fixup for new base topic 1/3
..
>  The "reftable" backend for the refs API.

I posted a subset of these patches as
https://lore.kernel.org/git/pull.1081.git.git.1630335476.gitgitgadget@gmail=
.com/

As discussed with AEvar, it will probably speed things up if we can
focus on getting the base library submitted without hooking it up to
Git. This would avoid cross-interactions with other pending topics,
and reduce the size of the more controversial topic (hooking it up to
Git).

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
