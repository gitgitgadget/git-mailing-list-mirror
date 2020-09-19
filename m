Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D4C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC81208DB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0OuFYOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgISQSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgISQSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 12:18:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D792C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 09:18:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k18so8438303wmj.5
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uf2Beo61dkCgoFvDP3/Fm9RQj8RUA1E4iSNT9IqNads=;
        b=W0OuFYOafaHeFoG5rSNh4ZRB733leYQXzpn0uV8fsEwzRP0F/G9n0alpUysnELEP+q
         jaXMDHsTZl9QXh6ni+OQFhguVN5IHc+O2LNQffzA6N/EjFkx/xgnLV3aZ8osEwTemDyA
         NYreEWhU1C2GzEYWXyjNOXbWUZ5WhtGD/McKYgSgxtGcwnooy6BmcUx4UKKHKohxTs27
         cTz2gtRFQ5CgrVr8yR1I+nb+7FZ9NfmzO3w/TxJLv9XNqhdeQXtcbuZ8r1fSLulZUviX
         uDD6Ge53o1ms1tFEWagcX3M8f0ekBGMCcrYVWMoBqmhAUkCHIBFK+xOMarRZ44G3+dIv
         spVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uf2Beo61dkCgoFvDP3/Fm9RQj8RUA1E4iSNT9IqNads=;
        b=Su4qZJircm8eumuDsLjwtRuobJ0RvFR7BZ5Fu7nf+eOmCOU5WxDAqLqL1Um0FYd7EP
         R8JKH2RnahHToUvznUtkpeCMBaNnclLG4zinBKgGUYbvj2sYNkTIYwDxVXHxiQoearag
         r3ZB4aOkaleucuKpRzXV2qXEpglIzAOEICi4xOoE2ocAme+6WtLWhuPkAse/5dnuKo8e
         z5Z+U5Lpmdppd0DmztiKiIsbZJS/4jqHofIEDUnNoUz9NMHEcihbi8KhAo01j6Ll4+B/
         Ewdvkh92qIMSxXQ+Qzow7oB3zKVunt4HfnGJF62rskMl4p72jdhSMr8cGfl0ZS9gyaGx
         xbEg==
X-Gm-Message-State: AOAM53381ZpVBWhOmt0EMfTP0P+2ImUXmIF0m/hJ66fTlzhkaImV+BYM
        IkF/ojNl5aa4Cavm1alJW2Du/NXe+qdpi4evMN8=
X-Google-Smtp-Source: ABdhPJzpo+hwM94rfagKd6B9GeA2D/oz50ulX26rwDwvj7yLPCBcF2pfqZZASwalCXJ1IJLNjHb29zXPT/IjDCUGNAE=
X-Received: by 2002:a7b:c241:: with SMTP id b1mr21159833wmj.98.1600532333862;
 Sat, 19 Sep 2020 09:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200918222103.GA3352870@google.com>
In-Reply-To: <20200918222103.GA3352870@google.com>
From:   Richard Sharpe <realrichardsharpe@gmail.com>
Date:   Sat, 19 Sep 2020 09:17:50 -0700
Message-ID: <CACyXjPzNCvFznmu9ARaUt_gsQ+fUMgYsHtBFDDziWRmsWJyq7A@mail.gmail.com>
Subject: Re: [Wireshark-dev] Joint project with Git for outreachy
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 19, 2020 at 8:21 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi wiresharkers,
>
> Outreachy <https://www.outreachy.org/> is a program similar to the
> Google Summer of Code, providing internships to work on open source
> projects.
>
> Emily (cc-ed) and I would be interested in mentoring an outreachy
> intern on adding support for the Git protocol to wireshark.  We think
> this would be helpful for documenting the spec better, for making
> debugging easier for future Git developers, and for helping people
> working on systems involving Git (e.g. CI systems) to understand the
> behavior of the systems they oversee.  We think that a co-mentor
> within wireshark would be helpful for making sure an intern is set up
> for success (helping them find pointers, making sure their approach is
> on the right track, etc).
>
> This would be a project under the Git umbrella
> <https://www.outreachy.org/communities/cfp/git/>.
>
> What do you think?  Does this sound interesting to you?

Replying again to all this time.

We welcome any one who wants to write a dissector or help out in any
area of Wireshark, as Ronnie said.

I am more than happy to offer advice and ideas and look at code to get
new Wireshark developers going.

--=20
Regards,
Richard Sharpe
(=E4=BD=95=E4=BB=A5=E8=A7=A3=E6=86=82=EF=BC=9F=E5=94=AF=E6=9C=89=E6=9D=9C=
=E5=BA=B7=E3=80=82--=E6=9B=B9=E6=93=8D)(=E4=BC=A0=E8=AF=B4=E6=9D=9C=E5=BA=
=B7=E6=98=AF=E9=85=92=E7=9A=84=E5=8F=91=E6=98=8E=E8=80=85)
