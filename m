Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77401C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB760EB9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhHQUWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhHQUVy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 16:21:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C96C07E5E4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:17:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b7so20354746iob.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aRDVF/UuudOm90VAg7kuFF6mUMWkeHzlifxhFnjq5VY=;
        b=cYGUAoFVZ8GV8LdShFV5vDiNSYQYN/OVTVyPihVC7HCeKZWz/qqxSaJNCPj2d2HRWS
         QPK9lVM63A5s0nphC2jvSVx/8FY4nB4A7ztFZBRW6rmjVXiiXpvbJL/skbYxX5xgnQfz
         bpk1tOLw/7N0//GNhTNaBSm0dzZ25t24HuhuUUhReiUYu6FSYlizQxekFWgjE9u82Mm/
         VKS3VQXbFkuROfnahXUPrXndB1Oym3LD9fNveVF1jK+MexKRuFTy4pLuweTSzg3tsu2f
         V2/JHDnLlRD1H62EY27hpp4qlxJPJ/8P/Fz65w0Gj0brmWAP/sq2J5UhKWaM2B6E20av
         syQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aRDVF/UuudOm90VAg7kuFF6mUMWkeHzlifxhFnjq5VY=;
        b=YfcartaeeNYv9QfF3PERhv77XMGu6JcXlXl0k2tyly18ukHhVfrQpaP3sxB9+gEsrH
         gfwaGAzSmw72TdUsnKbVwfS/yHyDw5zVynM56pKHijtZFIw5ahAvOSr8iTyyd/Fe2uwb
         SoXat1c0QEtAqvu53FHydhXIKdmeRxFZzkd0OVa0gz9lWHZ4v6azY7Ysm21z/nyDQnX7
         NObkVec1iANgjaHxyoS8OY7vaS5mMDhGF79ERyhIaI2VcYr5gzlPbwJpDxdWnqf9eu/1
         6e0v1OQRb9ZBfc8L1I/g6F63BQ+0DwIe245dyhzn/k9WRjI9GLbC3kq0MOjz8RLk+Yn1
         yNYg==
X-Gm-Message-State: AOAM532+SWbRnQyn4JCCEyGlXYWZt3SWvZWHqGUFLXqB43XlBm5n2HsX
        qjDGWGgM3Avc0MwM7xewW2ty4DGMOhnnIpRCl2s=
X-Google-Smtp-Source: ABdhPJxoc2fw/sI+tf9t7s/DqKbGlTA5Rylmn74s34+K/+q5Fw02wW/UhCYWPCsFfaKO1uFecEmx5kalCZJ1VbrfICs=
X-Received: by 2002:a5d:80d1:: with SMTP id h17mr4256356ior.71.1629231464106;
 Tue, 17 Aug 2021 13:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-3-mirucam@gmail.com>
 <cca9771b-035e-0aca-bcf2-115f7af364e4@gmail.com>
In-Reply-To: <cca9771b-035e-0aca-bcf2-115f7af364e4@gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 17 Aug 2021 22:17:33 +0200
Message-ID: <CAN7CjDD8n-P0-UD4e1w0VPLc+CRnho47KcA_7xRs96Hu8CQeTA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] t6030-bisect-porcelain: add test for bisect visualize
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

El mar, 17 ago 2021 a las 11:03, Bagas Sanjaya
(<bagasdotme@gmail.com>) escribi=C3=B3:
>
> On 17/08/21 15.14, Miriam Rubio wrote:
> > Add a test to control breakages in bisect visualize command.
> >
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >   t/t6030-bisect-porcelain.sh | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > index f41453cc97..99b7517400 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -976,4 +976,11 @@ test_expect_success 'bisect run fails with exit co=
de smaller than 0' '
> >       test_must_fail git bisect run ./test_script.sh > my_bisect_log.tx=
t
> >   '
> >
> > +test_expect_success 'bisect visualize with a filename with dash and sp=
ace' '
> > +     echo "My test line" >> -hello\ 2 &&
> > +     git add -- -hello\ 2 &&
> > +     git commit --quiet -m "Add test line" -- -hello\ 2 &&
> > +     git bisect visualize -p -- -hello\ 2 > my_bisect_log.txt
> > +'
> > +
> >   test_done
> >
>
> Seems like you're testing with filename with dash and space. Does git
> bisect visualize have any problems handling such filenames?
>
It was a suggestion of a reviewer in the previous version to detect
possible breakages:
https://lore.kernel.org/git/xmqq35vwh8qk.fsf@gitster.g/

Thanks for reviewing,
Miriam

> --
> An old man doll... just what I always wanted! - Clara
