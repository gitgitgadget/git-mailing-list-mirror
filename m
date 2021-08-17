Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B8C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3156A60F39
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhHQNfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbhHQNfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:35:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E21C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:35:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so21526226wro.12
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bu5hQIt9s+vhcfQ1D9rq2GNSTNF07YVdtFjHVpljsrE=;
        b=e3b/baZLA1OJkYsxTnK/uQQQQPy9nzHrFtg2m3HVHZqUh4NsxElIb9C0bCtm3/Rv+x
         2JQPQnoMKFBor6SsHIa9n68J0RGKCfDDReChs44u2/YroGW3Boa1Rt0ZovuL5ZdiLVk7
         tU7KdyBomORwtcMNeQ9TcTRPsdWY3r1HvdRb93xtBWAO0/4JPKk6xivTdhestJhl8RKT
         VdXWW9Al9BGxol0O+3QHeAaysRvW+/jlYtIen0TAYimeQZ1PNc4aDBy1R/96EBpGS5RA
         WWWiLyOgppwcoYMTKkhgFDOs4nsdNEnxmBZkBfisL4ClSghG22Yx2aC0PvsYwcCRE9VF
         7XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bu5hQIt9s+vhcfQ1D9rq2GNSTNF07YVdtFjHVpljsrE=;
        b=N70/WIl7YJwi3cYI5JpfM/EGXYw0JO8ySRqdtPfHNZU1hld2cm0PJizuHnAQ0HQjQ4
         l2h7FXceKffAi3ceNsMauCpIUvjmr06bOLWT0lixOt7QbBg92ZGcfZaWTlLXHqS2a8NF
         /d8dduyLzzWkTinAJoGs3fwU/Jq2zc6LDLY+8lr31VHOlTLt+4jJODPsxAhS+rSNzt+H
         6Iw/x625aXTpnfK8Gp/0jgPedSaIQWo2ejjkfddyPKQCg31bvm6FhFekgjjFnhDJ4Imu
         3hqvAe2aG1+hDaElzrDm9anBWMJgb5vmStdZCXNIR7Be8O3oUqrCF3nLAx6nWuc9Wke3
         oPyQ==
X-Gm-Message-State: AOAM531tUAED6fyQUuVI5pdCJ0KvuRV3MyjcJKrsu36NXMEcTYQa+np+
        Q2MpP9Ji0RSMONABN8K9Dx4n1QQTnYATxqCRFAhplQ==
X-Google-Smtp-Source: ABdhPJx+owcCWyuHAvedIqcJG/iCjnANliXYL/Ja09rahEzAiMMs8uPbQU18ccRZoG5oEQCjCw7gTl+Qqhq3LF7Y430=
X-Received: by 2002:a5d:674c:: with SMTP id l12mr4184061wrw.112.1629207313356;
 Tue, 17 Aug 2021 06:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
In-Reply-To: <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 17 Aug 2021 15:35:01 +0200
Message-ID: <CAFQ2z_MhNgimn=7qcu-G823X=yTRT3xXrDP7qRiELShXY9A3AA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] reflog expire: don't lock reflogs using
 previously seen OID
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 4:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> -                       status |=3D reflog_expire(e->reflog, &e->oid, fla=
gs,
> +                       status |=3D reflog_expire(e->reflog, NULL, flags,
>                                                 reflog_expiry_prepare,

this causes reflog_expiry_prepare() to be called with a NULL oid. I'm
seeing a crash in do_lookup_replace_object() because of this in
t0031-reftable.sh.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
