Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C703C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 06:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C7661040
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 06:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhDHGxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 02:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHGxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 02:53:13 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF205C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 23:53:02 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ville.skytta)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 86C1F1B00413
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 09:52:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1617864777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rav5HSL4R8qNhtZjKDnVD7eM0miDELX2Te6rVP7y7MM=;
        b=W1p050dHi9yJDeyliiOXeJHQtdwV5LXPvecG35XG0ss1bIYiVCr2kcw5veZIYlzrELL0DX
        VRgaqDOO23sUr0FTiYn5SD6ZX7yRBtgI1sV5smZSl+JFphns+U+TSy3gu3Iv6zOlBpr+iz
        5MwX03Gk1sKJJTsIv9hcGBhWDSnnUmscmBRhBUveERStYRMGx6u2SPctvy13FWOY6jy0DH
        995bfv7k2KFOfQyWpLDiTh0uTcI8Nw5f2UW52OY/j2K5EcNIomQTBc4AJkwYmTLsQ0SK4+
        a0+bnrRXqNyQVaCL5vlMKd7OSJJnx/YTUiC4I/wRZbPV+jWKw1Aypt2cnoNKqA==
Received: by mail-il1-f169.google.com with SMTP id p8so857679ilm.13
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 23:52:57 -0700 (PDT)
X-Gm-Message-State: AOAM5335/NlHbjc4kF6GBo5XxA7z1g/RWc4s61CeiDX7EsrcXR6PV17T
        tw93l+ID1Qvc3wXB4tc8tNV3wczSCfGnkqpv3Rw=
X-Google-Smtp-Source: ABdhPJzrhg5awVNytFvjdOPBALRf6m1EDKZwNxwZXkgH4GolgMOQskeFr/f/ZfiJPf37SZt8mKOZMP3jjiwuAlarOZs=
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr5396442ilu.299.1617864776200;
 Wed, 07 Apr 2021 23:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210406181247.250046-1-ville.skytta@iki.fi> <xmqqo8er12kq.fsf@gitster.g>
In-Reply-To: <xmqqo8er12kq.fsf@gitster.g>
From:   =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date:   Thu, 8 Apr 2021 09:52:44 +0300
X-Gmail-Original-Message-ID: <CABr9L5C_+bdiv=hhbx4h1cXcOcW-9su45kNMo0i0i0zBO0j8QA@mail.gmail.com>
Message-ID: <CABr9L5C_+bdiv=hhbx4h1cXcOcW-9su45kNMo0i0i0zBO0j8QA@mail.gmail.com>
Subject: Re: [PATCH] completion: treat unset GIT_COMPLETION_SHOW_ALL gracefully
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1617864777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rav5HSL4R8qNhtZjKDnVD7eM0miDELX2Te6rVP7y7MM=;
        b=ids+SNvos0zVq4sVgbIM1MR9aTRcPPWvOis16fXPKAJQRjcXxDtx4EpJhyblMzB/ypOM3P
        wlnHEyOpcnCyagxvHn3WfmXxIOJbotZDKdwM692Yhls41uvr9odaTvuvmf5ZwYMlKSsVg9
        p2NKwXZvUzd7JxmPN/jNbAHRk6r8L9fai8mXJrhV2mhX71B/cpL2z4UlGjPkFrPH0rISHD
        QRBIdCjLGeQmh871BLWyYIoPLQRcuYEMNa3rPuOIM8S1IaGHWD6XInMrw5G6AWjsxBUG5U
        SDEqOilBZi7HWciWUC6Edz1YFQl+nFSd2qNKWNf61rP8ZYdlFz7PjTBA/TUPBA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=ville.skytta smtp.mailfrom=ville.skytta@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1617864777; a=rsa-sha256;
        cv=none;
        b=GDkhbyhcviGlgDHyF5GONcHrVKb4DpXssQ6bx7HJnfLaeF9I59ZYtek0e53W1os+dKNMPT
        KNPTx9vWWu9B8Ug/ofTs1/tvrn1CeKxdibnjnOdzQ5DJaaRn9WL2kky4/JKP1tbYZTKHST
        N+D61CTVesFYjIHbWtcPBIMXwQHTiODl+9DVJ4MSBFBO9PDPFqrn4Bgk2iJXIkjqBI9e7r
        3IPwtX+aMsWgglndMNzj0h7atIcPRRWnueeJxB8tontcd1ENmH4nO7yPmszHHKi9L1mZ9R
        pfGOJASoDTcVj4uWgh7fnqc6PEiUXUDaUOSURb3IGs6Ka+YsBGuBbgXv17rhkg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Apr 2021 at 01:16, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
>
> > If not set, referencing it in nounset (set -u) mode unguarded produces
> > an error.
> >
> > Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> > ---
> >  contrib/completion/git-completion.bash | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks.
>
> $ git grep -h -o -e '\$GIT_[A-Z_]*' master -- contrib/completion/git-comp=
letion.bash
>
> gives a few other hits.

Thanks for checking. If we want to do what was proposed below:

> I'd prefer to see that (1) the proposed
> log message explain that the patch author audited all usages of
> variables

...we need to go through not only ones starting with GIT_, but as is
written above, _all_ variables, which is a larger task.

To be clear, I haven't checked anything besides what was the subject
of and change in the patch. I can go through all GIT_* while at it,
but I'm not promising going through all variables at this point.
Hopefully that's enough to get the resulting changes merged.

Would be great if there were some automated tests to catch these
issues, as they tend to crop up over time.
