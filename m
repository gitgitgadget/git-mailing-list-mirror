Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A93C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800C120732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHqWoQKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgDMLQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgDMLQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 07:16:48 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA23C0A3BE2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:16:48 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l84so5075705ybb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GCYgECHf+wLp7UZ1LI8udsrkQCKJl5C8ErRLjmqTNRM=;
        b=kHqWoQKipW4SFEgsao3IcrCe1oTzcar/sFTjIrDBVG4Cp0momycbKSwqR4tA0hygGT
         lVxstIRBtM9lUs55I6FopS0wytq8PwKxsycdC21L7cNhYwKajHx/aMHijM5/sctlUxwo
         /OqdsW++Rk8HECAG0/Yn9XFgIvxr24Y7durAgZX7OCFkuAnHhkEij3/fzyypYbpJiCVu
         hsjunTeciyKrT10HSt6+CIOz3aP8FBsxBqmriiIo9aPenGekvKO5sBiSC0ClB0T9wnre
         MZWyYbFnW40pDQov9U/Qvqdl3NEum8gYtdRXzj20Eh/x0sMKZfa/l08fxWbPA81RAUQz
         GCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GCYgECHf+wLp7UZ1LI8udsrkQCKJl5C8ErRLjmqTNRM=;
        b=myfCrAiFk1Adt2yyCEZwNVTb8bHVI+piT8Rur7gKce0nGI9vmw6m5ZZZnLoftY48Iz
         j3XA/o6DwUJKc+AmKzdGKzo0SnoLP3H+5EP5jj2VxRWHmGxZCcY9xlQTuQcbNKWJtI6v
         fHf6EB0x31wzW1+8dnZlHAwmbsv8eL9d4CmH0prPVTumx6oDq61GtfhiDFpc3hqlNTsB
         bhycFVHbHjQsErIBF+vRPv5odU91kOtErBoU05uKJUg/AhX/H21gw7cVz8lkiu58J2fT
         h+ENh245x4xe2pBPWwL8d3gQPEzmzRogN1a0ZBy3jqjpmwuRInFEM+MWbfATTa8xtMWB
         mjpw==
X-Gm-Message-State: AGi0PuZqx1vzPxc1lNuDavdbcnvt2aePSiORldFKiC1p5sbgkry6gm9H
        +7Hw2uI2Onkx9qIB1wSDSIefweLdePMPCTUShi8=
X-Google-Smtp-Source: APiQypJIUGfpcB63CPAXgqhD3d/Yab29MKTva/yE8x7PZozFrmB0dX+iz562+KjTq/Dx3GKS3SygPep5zRUtZH3dq/s=
X-Received: by 2002:a25:446:: with SMTP id 67mr28126768ybe.478.1586776607565;
 Mon, 13 Apr 2020 04:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200407120813.25025-1-worldhello.net@gmail.com>
 <20200412133022.17590-5-worldhello.net@gmail.com> <xmqqwo6kcr83.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo6kcr83.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 13 Apr 2020 19:16:36 +0800
Message-ID: <CANYiYbGDxA62wUhaAZYzzHnhjkTppQjPL-Q=xQZtJ6Rdj0fbEg@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] receive-pack: new config receive.procReceiveRefs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > +     if (strcmp(var, "receive.procreceiverefs") =3D=3D 0) {
> > +             char *prefix;
> > +             int len;
> > +
> > +             if (!value)
> > +                     return config_error_nonbool(var);
> > +             prefix =3D xstrdup(value);
> > +             len =3D strlen(prefix);
> > +             while (len && prefix[len - 1] =3D=3D '/')
> > +                     prefix[--len] =3D '\0';
> > +             string_list_insert(&proc_receive_refs, prefix);
>
> This smells like a copy of the hidden-refs configuration parsing,
> which uses string_list_append(), and its result is used for look-up

So this means I copied it from elsewhere ;-)
Will replace it from string_list_insert()  to string_list_append().
