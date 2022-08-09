Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A55C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 06:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiHIGOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiHIGOB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 02:14:01 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D271D335
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 23:13:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o2so8854667iof.8
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=68JmoKvWq2CnTEvrfL8N4KXgrLsG4XGVdYnsvabo53k=;
        b=AIsajd1z11u0VSFogBLiGh7ijpeLpzziW+wvALxq03C/zUweS07l1c2I4skzUkbKg8
         mPUZATu1lU1RBFZjiPwPfIlrva5BQvlaCBawL5WCRBQo5FaoC14B5fJ/srWb8S1Xc3M5
         9LVTgfU8AfRT7dH284SEjnENWWUD+K8VsqY5f4mSJElbtMvE0Td5+DwbsXkJubXIoAjP
         29MUa41h6F+40AeDkldoUAINwaT/GpxxvXyPN44zjyTegwY+dZMmR8FJV07cIFp2vu4a
         mNMYUqXYzFsqE/WvtIOsFxO27AefEcZULeLwHqngowD9TA10GDq+e9CtKjtuSQ4VPIBq
         iUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=68JmoKvWq2CnTEvrfL8N4KXgrLsG4XGVdYnsvabo53k=;
        b=SMydfrxRowexZOgcGUTZE0yeKIEjUU+oqbvN2HQunaS5kHWHySkgjTDEc7D33WQxLF
         6dADVaLAw5HP6nIxX8XDXHISNL2IeUGE0ohpQXoecN8PYkufD8PRZd7amQztrCaeL83A
         c3nS5bIz+W5/OwgBOpTYhP4BA2Pqb83oWDItZPWUtBkHAdyBgtUEuS7TtJECRhRiZCDC
         daMHghpk8OT34N4SJkz9Yl/OWZbAtmmV4NhVKvwBAlvb2AOKao4VxrmMisjl6K9HS/sn
         AIovWmg+RTTHhbLMntx+Mgg5toUQulQMTbpTjT/NLxuHj1Ya001Je8EEiwSjzd1sw1DY
         sTWQ==
X-Gm-Message-State: ACgBeo2cSIgYwA/2h9ZnvE+IiaZdjIyq3rgjRKkZVqO12UIsIUo8ffCO
        LnLAzs4BbgkqFAWF03Q6bx4UR2UJQYZsweDpIik=
X-Google-Smtp-Source: AA6agR4TLqKN1zFxSt1G6TXMja6aZvD6Riw1kdiKPRy8wsZxFE5OrMO6D11Z37CXEF2Y2DYEAsi/VQ/+nFtyIdANIDk=
X-Received: by 2002:a05:6638:4909:b0:343:1214:f541 with SMTP id
 cx9-20020a056638490900b003431214f541mr2950067jab.128.1660025637786; Mon, 08
 Aug 2022 23:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com> <xmqqczdau2yd.fsf@gitster.g>
In-Reply-To: <xmqqczdau2yd.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 9 Aug 2022 14:13:46 +0800
Message-ID: <CAOLTT8TSyKArOKTjbuGO=OkpciS6DH0mmVPSmiidOSHxo4thNQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter sparse:buffer=<spec>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:15=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Although we already had a `--filter=3Dsparse:oid=3D<oid>` which
> > can used to clone a repository with limited objects which meet
> > filter rules in the file corresponding to the <oid> on the git
> > server. But it can only read filter rules which have been record
> > in the git server before.
>
> Was the reason why we have "we limit to an object we already have"
> restriction because we didn't want to blindly use a piece of
> uncontrolled arbigrary end-user data here?  Just wondering.
>

* An end-user's maybe doesn't even have write access to the repository,
so they can't config a filterspec file before git clone, what should they
do now?

* If there are  thousands of  different developers use the same git repo,
and they use "--filter=3Dsparse:oid" to do different partial-clone, then ho=
w
many filterspec file should repo managers config first?

* Why not carefully check "uncontrolled arbigrary end-user data" here,
such as add a config like "partialclone.sparsebufferlimit" to limit transpo=
rt
data size, or check if filterspec file is legal? Or if git server
don't trust its
user... we can use a config to ban this filter, And within some companies,
users can basically be trusted.

 * I'm sure it would be beneficial to let the filtering rules be configured
by the user, because now many people have such needs: download
only a few of files of directories of the repository.

* sparse-checkout + partial-clone is a good reference: we have a
".git/info/sparse-checkout" for record what we actually want to checkout to
work-tree, and it will fetch some missing git objects which record in
".git/info/sparse-checkout" from git server. I know it use <oid> to fetch
objects one by one instead of "path"... But In hindsight, its performance i=
s
extraordinarily bad as a result...

Anyway, this patch represents some of my complaints about the current
partial-clone feature and I hope the community will move forward with it.

Thanks.

ZheNing Hu
