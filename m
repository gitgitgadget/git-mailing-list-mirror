Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE6C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EB964E0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 10:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCOKZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhCOKZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 06:25:10 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E2C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 03:25:10 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id s8so16010080vsc.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5UZQuVgo+OizUvLaCMD9KmFBCJ00swf4Uke/XtcODVI=;
        b=nyDhXMG6Dxq2B7m4dOqqGkdbdOsJ59NBgll0XCsac2ovYXU1fUZtzm9FEp0cCWfRRT
         faHJqtyM4DOJZVjiOMMSZj46SkhXUPZCsM/PY+c4Wmh6aIEIRuI3RsIvAhkqwgVtROGZ
         gu1ew7LBxLRbfryAhn3iXwoX6HgWejRhrF9kAiojFkThXxCcVLWYkL5VRw/KKfiMV3jf
         WThFZ67gMBoHG/32Rnj665SBt1RPaUufRnsyaMBT5F2C3JXZa4Te6t31qpfrtAMQZF9b
         +sKDX/eUBc0ZoQPTL/hH/rIva4MfbtmnfTHnzElU/X+BDm9MtFcvmM0niqGweH8sS7lm
         P/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5UZQuVgo+OizUvLaCMD9KmFBCJ00swf4Uke/XtcODVI=;
        b=WmCcfrcXzvTmVSlRb91BIwgtbOWsMheyMasXk/hPjK6GMoYFcqUSEax5hP+UO8S3Yx
         dJ2Xm9v6ZFNbUBUK0T/fWad7WzPaOMZZusXGSMAh+1TsBe/b0YqSV+vy9mPAbCbUhxY1
         /0p1+FwRHmuyS4ATJTYqjGNjaFrNmak0YSL20qid2o6GSTaINDUh0LfQMuyvFvNFCdqR
         7YWqWI1/+6vWVmRe4J7h5TOzs7N9+y5UH4qzEjVBw7u5zOda7f/INf+5ObU0hC/a5HxW
         03eQJMHuIwV4HGwQZ1NEZcA2bQD6hhoPAIdp8gdLpyDlHcocMD/XqwxFQ7Kxz7MdREOv
         xRLQ==
X-Gm-Message-State: AOAM531NO66kiccPmeT2YotpfwB9ZmT2HO59GxJJ8B0MfxgSsUyOfQEN
        yMQz45TKwLgld6ykE00LK7Wr/64LoKfPViGbDpbRMQ==
X-Google-Smtp-Source: ABdhPJxAsO67S6FMnXT5cLEiCi9qCGZ45771FXX9KNDS9soiOUtr5IL62cUwIFEzJr9XnMhVi2fmupfYtqexpayeUFw=
X-Received: by 2002:a05:6102:c10:: with SMTP id x16mr13212514vss.54.1615803909570;
 Mon, 15 Mar 2021 03:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6r9efgh.fsf@gitster.g>
In-Reply-To: <xmqqa6r9efgh.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 15 Mar 2021 11:24:58 +0100
Message-ID: <CAFQ2z_OMLEWh_RBR3H_rV3VGmmdaqXFVUuBJnhayb3_=mj+e8w@mail.gmail.com>
Subject: Re: [PATCH] SQUASH??? calloc(nmemb,size)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 7:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Please squash this in to an appropriate step in your series;
> otherwise it triggers a Coccinelle check when merged to 'seen'.
>

folded in, thanks.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
