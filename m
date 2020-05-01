Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EE5C28CBC
	for <git@archiver.kernel.org>; Fri,  1 May 2020 02:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD2206B8
	for <git@archiver.kernel.org>; Fri,  1 May 2020 02:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4Vgyuik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEACYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727949AbgEACYj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 22:24:39 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FDBC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 19:24:38 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id b5so5573309vsb.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 19:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m21RC3Mug7zdPu91uu4ZNj6I+7uPqSWXTh7RbF2p33E=;
        b=r4VgyuikaKgdQ+wuq2A1B94EsgH3U5gx0MXTNmmIlhtaRxI0YZExPfc5ffTHfEYaCt
         xrNdai9CfZRDLmcQ35nLHsSPp+lpU1jzcc/9nT/gsociDOweMz8aBUEViW9hpRkAf0Z+
         M9OEKSmbFpwFQ1pkG90mzgckReM/dqKcsbG+iYliXTpRmMl6hLV0Icox02QmgTD87e9Z
         rMHOijrqvKvBomB2eDbP2t/WdJYr5Pkx/GK3wo0DuAvsPyyGpr2v3dB1gkSkK9OTHtV7
         EV1zarx8ron1/ghBiIfO5EeYoaQLegsoA2h92QnKWMaCmc0v/CY/xW+f1JLFIPIsJEee
         GOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m21RC3Mug7zdPu91uu4ZNj6I+7uPqSWXTh7RbF2p33E=;
        b=mtFrsKVVGWs7UVDfPawTOb7FtYlYbcVGVXzfxBkY/QRmbpqgNTpvQKXDJ+CUBPJn9M
         pNpGTM1N4Q9TEy7hWeKjVFxv9pfjrI3alM8Y0winNTl+5m/G500wJF8SpxoW4M6EE0V4
         Q13dt17h32ZydzDzDhpkGij1mBoScSFNzVjNKpDfnrAhSljPY4wTD69oH5ZN0v0EQTcG
         RnrAuiT4XhGKemGa9YU3TTPoioExmb1mIPiDnCoVKQ+K043z31KOpuCrrFX+FDW7xJfF
         Gyf3tBUKqNwqLFAP8Gq1pwWpBcy/gNlRDa6GFQH9OQAcuQorlfON7TMr7wqMPh4lmXZR
         uD4g==
X-Gm-Message-State: AGi0PuZSlNsm0CdcjBA97dDkDajPuyGzhX6WjqBQZtDopeLKin2W85oo
        uO+kL4m8HGdhXnhpkMoe2j6ISf3cbze8J7vkQ7g=
X-Google-Smtp-Source: APiQypJJmFz3pvXitsINPQgsmKjeAZDFXSyi2AZ417/JwcdB5DdDTXl7Xip2/vEw5XdkWe8PrWFA9MHx927q+ZRhI1w=
X-Received: by 2002:a05:6102:3025:: with SMTP id v5mr1748384vsa.16.1588299877330;
 Thu, 30 Apr 2020 19:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200430011959.70597-1-carenas@gmail.com> <20200430160642.90096-1-carenas@gmail.com>
 <xmqq1ro4sp1p.fsf@gitster.c.googlers.com> <20200501003041.GD33264@Carlos-MBP> <xmqqimhgph3z.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimhgph3z.fsf@gitster.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 30 Apr 2020 19:24:14 -0700
Message-ID: <CAPUEspiD10bYsCDoHM6PJdidyofNadJL0bexjiNNZCXNU+Ay_Q@mail.gmail.com>
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus
 lines from store
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 6:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> > the problem is that practically speaking, if users in Windows and Macs
> > edited the file they "might" had saved lines with the wrong line ending=
 (*)
> > (part of the reason I added a warning about "encoding" to the documenta=
tion),
> > and those are difficult to "see" as invalid.
> >
> > using the non _lf() version ensures any trailing '\r' character would
> > get removed from the credential and allow us to use them, instead of
> > silently failing.
>
> You are forgetting why we are fixing credential-store, aren't you?

indeed, and thanks for the clarification.

you are correct this was a bad idea and is better to warn them instead
(even if only
during get operations and for the lines that were processed) than my "solut=
ion".

FWIW though, my change wasn't going to change the file on disk but only all=
ow
the line to be processed.

gave up already on sneakily "fixing" corruption issues after Peff
called me on it
and yes, another version you will never see had a PARSER_TRIM flag added ;)

Carlo

PS. should we really do the warn even in store/erase operations as a
followup or is the warning not useful as is, and probably then all
operations should be quiet (as Jonathan suggested originally?) and we
could do warn (and maybe fix) in a different change (maybe adding a
fsck command of sorts)?

> When fixing something, it is tempting to see if you can cover a bit
> more area with the same change.  But you should make it a habit to
> stick to the absolute minimum first for safety.  When contemplating
> to step out of the absolute minimum, you need to think twice to see
> if that extra "fix" really fixes, or if it potentially harms.
