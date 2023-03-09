Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28CDC678D5
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 00:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCIAQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 19:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCIAP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 19:15:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D7793125
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 16:15:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so3472465pjb.5
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 16:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678320958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD2Nx+OdzUReSFa2OyPcMnYKlzPIjLxMHn/CH5vNCrI=;
        b=mrdYV2WSKrpDTYz9GaCakuD2BKPDNzDVhsov4PCGhjcgmA5l4NXRiATtyRcfHR51jh
         TLC3GFtzSKZAjrOoPDeY/+Wd8sFfNzHz27526w5oKEfi1Wc1X947a1QzDr4AzYbYdabA
         sy0MHDzqZA/lAZMwf12VCCi/CDadVAUVDgIFRINksLdWt+GL+FnBkLuLTrrnUzmv/Mup
         M7DN4h/1IE6ZDUczcSD12OnR4NyxBamkjrSoOMxOC08m14+Zpq+B5CZ5Ct6huaczz7oC
         IDJRxj0HFyFHEiczF9lZZ9IOlRUvqsmbhO8EG+V+Ym10l+UYmiMEcvbhs+RzyQV8NKFe
         lYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678320958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD2Nx+OdzUReSFa2OyPcMnYKlzPIjLxMHn/CH5vNCrI=;
        b=uilNp2wX08EdNuv754569LHwftcYpIQ+n4huVZgcAPK0JWV4C0pIqXCaxGai0G478I
         pqYFVDgXrUsbGK7IJn9waAGKzoIALxidKrfHJs3yBjhJeljsH0Ew7AwLEufYl+8yPubr
         S8jhHntCs+M0Dky4Kuc+BzejUK7xx4h1qmWAbHk91ryT1Ds9uNls+9fqLjesmyxAzodL
         NOmS57vOO9eFpYz4y0Hv0ifrdktY1IN3pb8IrEKeBJHMNmxnJLXqz8+3I7KbUpXpCfz6
         tIxCF0OwHTrOfTvlUjJ8RjxDMMLJ5Gk9LvyTsal4ERcVT1LabxJe/hLqlX2sSOXOKNik
         Au2A==
X-Gm-Message-State: AO0yUKW0VuPwEZs100HDGqhABLf7+j2BshWibqV81LvOBrPwlSXJMG+Q
        nrjOlKMkd/UWr9CRu/a/8fxPW0uYNtkJM8WxH3vlls3qHn4=
X-Google-Smtp-Source: AK7set+SM9NCkp0wfKk9xoWylt4VRcPNJ7Wxv6egtMgNnFMrkOYgl55SMtG1+E6kI2qvP5N7IwCuArQdu24OPpd+13U=
X-Received: by 2002:a17:902:f782:b0:19d:13d2:550c with SMTP id
 q2-20020a170902f78200b0019d13d2550cmr7674224pln.10.1678320957764; Wed, 08 Mar
 2023 16:15:57 -0800 (PST)
MIME-Version: 1.0
References: <CAH74SFS3hFzYzJ6eb2YenJh4-Pf_VBzVTo8axnEtHDyaJUB-jw@mail.gmail.com>
 <xmqq7cvqrdu6.fsf@gitster.g>
In-Reply-To: <xmqq7cvqrdu6.fsf@gitster.g>
From:   Jay Asbury <vbjay.net@gmail.com>
Date:   Wed, 8 Mar 2023 19:15:31 -0500
Message-ID: <CAH74SFQ9A-hcRfrDs_vE-QhhYTB6V=dbBQQM_0Qdbx88XREwpw@mail.gmail.com>
Subject: Re: Writing to err vs std
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the clarification. Some context.
https://github.com/gitextensions/gitextensions/issues/9643 which is a
side effect of https://github.com/gitextensions/gitextensions/pull/9562

So I just wanted to get some clarification on when err vs std should
be used to eliminate confusion.

On Wed, Mar 8, 2023 at 7:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Jay Asbury <vbjay.net@gmail.com> writes:
>
> > I see things like git fetch and other processing writing details to
> > stderr and not std.
>
> I assume you meant "not to standard output".
>
> As a rule of thumb, the core of the output, the information the
> end-user asked for, is sent to the standard output, whether it is
> machine parseable or otherwise.  And other stuff like progress
> meter, warning and advice messages, are sent to the standard error.
>
> This should be documented already in Documentation/CodingGuidelines
> for our developers.  Do you think it needs to be documented for
> end-users?  I suspect that rather than such "principle", they are
> more interested in seeing what message can be squelched with --quiet
> and what can be piped to downstream with "git foo |" on case-by-case
> basis individually.
>
>
>


--=20
Jay Asbury
PC Repair and custom programs $30/hr 1hr min
My Biking Blog
