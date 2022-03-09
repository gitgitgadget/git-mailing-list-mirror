Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E942C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 01:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiCIBVn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Mar 2022 20:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiCIBVh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 20:21:37 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D763F1198
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 17:17:27 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id eq14so887382qvb.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 17:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5p38+yFaJYCpoQLM9mcHPRRu6NEYT8brn0peP3H7j1o=;
        b=c9DJoFXS8HREpiHkhnHz7SgNnoqieZZE6/5Wtgu1DzoBv+AeOJUc+8gjQW47vu2KT7
         kwnnp8VXlCKFFm98UPAeTVtlz362kbnkQlhJ21iYite9jPugltgCRoiMTFHk/zBq/Mo8
         1kzie2NUs1rdZFMV2D32i1CPySXIy5xKw4vz8DR8R7hHgtlBVlAbi09GyrAl+aKJjgPw
         KqOxIJrIrEoFOuvMq/njNngiTZDVT+fOfYuQlIB69eOm418xgwC4x2qXOqbFo7HKnNVz
         hyxvQ39Q34kE3FP9odWIIGOyGVVWol5ib34GtYr1PWYytOmYkKrweKBDQs60hra+yp0U
         hYEA==
X-Gm-Message-State: AOAM531+OJ3qb6t03g6kN2iS5nWmAJcyO8dZM2rR3Bk7Ml164U5T7ELb
        pWcBnqweigXqPbQOhwZsr8NwgusHjn1occgx2qufNJU7txuVUg==
X-Google-Smtp-Source: ABdhPJybZlrjb7uwxGeGyybNTN5pxXO7b6uEIJqaIA1crmYZR8kDyZCgJqJuVNEY7Kt6tq0eR2aISvFhRHdgzZnynKk=
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id
 21-20020a170902c21500b0014ff1c29fe3mr20083565pll.145.1646784358419; Tue, 08
 Mar 2022 16:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com> <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
 <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
In-Reply-To: <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Mar 2022 19:05:47 -0500
Message-ID: <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 6:58 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 8, 2022 at 6:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, Mar 8, 2022 at 6:44 PM Carlo Marcelo Arenas Belón
> > <carenas@gmail.com> wrote:
> > > +               local _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null)
> > > +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
> > > +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'
> >
> > No need for `cut` since `awk` can accomplish the same by itself.
> >
> >     if echo "$_GLIBC_VERSION" | awk '/^glibc / { if ($2 - 2.34 < 0) exit 1 }'
> >
> > should work, I would think.
>
> Nevermind, I forgot you want to better support "2.34.9000" matches.
> Though, awk should still be able to do so on its own, one would
> expect, but not too important.

This seems to work, though it's getting a bit verbose:

    awk '/^glibc / { split($2,v,"."); if (sprintf("%s.%s", v[1], v[2])
- 2.34 < 0) exit 1 }'
