Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE4AC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 07:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD8561058
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 07:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbhHZH1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbhHZH1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 03:27:00 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A8C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 00:26:13 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v26so1430849vsa.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sqxejpRdHvoMOPWW+l7vxW5Q65PcyYBFgZTzwNxniQQ=;
        b=rwAYUCw1dhmNm6EjutsT9uvdSmVz5fCqgzqFErjzTfk1+Fpg7TZEbNv5jnCaAPNk06
         EvcMUmwt6A/QFPydgIVyW/hHDdb2Bo/hK/q+5ibLhsMwF4lRYUm9OuCgu0t0YsVPThie
         u4Xze3rPasXjNSxr4eFaqE9/YUWjryKzoTQ+0gZq2c4aMmR2UxrK5ijbgv9/ID04cC/Q
         gspbCm1pbU1vNsRHVIlUfYahPVM5rXyW69LkNYtdoQYfqudl509uHEHWL6bq1UUdF4c8
         reN5dFobC3CDDcaml2ezEgR2C5deK03aPDtN9cxGcu5PckFECncscU1ibJ+r5Y/cvEti
         rfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sqxejpRdHvoMOPWW+l7vxW5Q65PcyYBFgZTzwNxniQQ=;
        b=rYMTRkexb3u97vfce+eF8loiDkDEiYR7iDMiHA5v4s4DmE8iqhuWF+BTrKxFADGOU7
         HS2bZZZybkPO9dEwsEYNuhOUICKUjbIdrhfd1sHQpF6diW2nVDcLzqG8LBXZx1I43/o0
         QoHaCmQMsVHq7xoqDbGVFouxKYMU0F2q1cEZQ6NgHC05ALEUj6Cg/eeKAu3YRxdAfAMt
         nPsQTwAPx+uW2sMjbK/QuzFRghyDp2Cz9cGiY24BxSxDt+fDLyhntUbE8F8fFiorD/Qh
         wHcWhw6LRW9LA5ECeP7RqOgzbXlGVeBUCIzRsF2mlNJ2Jr9d5lLWr/TtnPBfO+Bu+ST3
         IyHw==
X-Gm-Message-State: AOAM533W5Mpdob9M1sT9h4+Wfhqkd6nwUYSsMuhCfmVzWMBPKw6jPXI7
        7E6Opuuyjwu03H7JqY70hFJiMPy70Gbn8H7Vf09qGg==
X-Google-Smtp-Source: ABdhPJxYOYvzEXY4tOKBa+TsARjg3W6cNv79baLiXkqQyp7yhg5+aHfWkSX68FWnbe3+dwwlAUFkvW/y4Owa6lUbVMU=
X-Received: by 2002:a05:6102:5f1:: with SMTP id w17mr1208005vsf.21.1629962772419;
 Thu, 26 Aug 2021 00:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de> <xmqqr1ehgq8t.fsf@gitster.g>
In-Reply-To: <xmqqr1ehgq8t.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 26 Aug 2021 09:26:01 +0200
Message-ID: <CAFQ2z_Mwj0+uWO-Ly8MTHmidjf=1P-9K1n2f0DSNzN=Or2t=bw@mail.gmail.com>
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with --force
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 11:37 PM Junio C Hamano <gitster@pobox.com> wrote:

> > +test_expect_success 'branch --delete --force removes dangling branch' =
'
> > +     test_when_finished "rm -f .git/refs/heads/dangling" &&
> > +     echo $ZERO_OID >.git/refs/heads/dangling &&
> > +     git branch --delete --force dangling &&
> > +     test_path_is_missing .git/refs/heads/dangling
> > +'
>
> This goes against the spirit of the series merged at c9780bb2 (Merge
> branch 'hn/prep-tests-for-reftable', 2021-07-13).
>
> Can we creat the dangling ref and test the lack of "dangling" ref in
> the end in a less transparent way?

agreed. Try the ref-store test-helper's update-ref command?


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
