Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89258C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 01:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbjDEBir (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDEBiq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 21:38:46 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6882D6A
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 18:38:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54601d90118so495044257b3.12
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680658724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXy0+Ac8K9jKkdxs2NR9DLQ+YMeEw3N3csW+9ERnX+0=;
        b=YKMqzLNvj0l8YMKfWck4v1aZigAUsEQ7MnRmSaJEeQ4VoF7UEfPDciirhNmHcebie7
         FVPgyIjN1q1t33E0cSQ8fFO8iJMeejgmQNpk2Tarf76iZI2DtRt/oI8LDGYDU+HuOYvr
         cnBKHw+9V9IIPkLn05MGPkJ2yTeWmxV9Vj1+e54TO0nCLSRJRRtOg7Lpaq2fnNc3x6hr
         EGrBg/kZRua8hVSRDbRfYLp+Ttc7LIGuvD2oZRFyGjvHLpt98TNzhwnEcVXT2mgW/Aij
         NdChpofkiD2QeNDABnNpmvxlLuzvBk3xNlKx7sM2MBtpgNkr8ynMglvsdsNCZEsnEWZo
         lwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680658724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXy0+Ac8K9jKkdxs2NR9DLQ+YMeEw3N3csW+9ERnX+0=;
        b=rsdFup2dy0pPUrHNu/sAzeG3Qf55rgnLviafzQM3Cks1eR8oPKL0cfPcPsfqXONjs6
         J3U7hDvCgf3Y02FvqHi24JZYEgsHToy98i4o/+jwtOXRnAx5dteqioJrV61wqWhU9Av7
         KxNqlsqRtNYcXqzqDt7AVHqV/Y72hvbCzUmT7PDrHltXfUciy9VbXvR/AEJ2s0NL47qF
         7iAofIwhMLHEVgAHNHvKvUlK5j90A6sFE7pcp+gVzJo+F8xDrnTtKMi5d5fswS0VKvfL
         9B9t2vyfXVJf2sqqNNrnUUU0sJizSmI6XN/zQLG68y6yuHx48vD7uOTIv/klim+TaZWr
         uxvQ==
X-Gm-Message-State: AAQBX9czpnVOhZtMJd2XGhmdQEkRoTeVLZsj2L14I0EJAfb7eUrBMhvc
        rfisCRREkWC+m2rmRxJwTtMg7FOuLVLxQGXQrgWm/mxQmlE=
X-Google-Smtp-Source: AKy350ZGVBfO8jw1uOxAH3IiHLJI4hXxlFYKYcXRRhQIM13+nXLhbwGftE1eqzLcGuADTTGZxgtklk4G05wnv4bQ3lM=
X-Received: by 2002:a81:ce07:0:b0:53d:2772:65d with SMTP id
 t7-20020a81ce07000000b0053d2772065dmr2721769ywi.9.1680658724471; Tue, 04 Apr
 2023 18:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <harpgnimhcdp2m6hww7ht7pgxvchllvrncnwoxkivaorb5xhm7@5rcr2p7hcp4x>
In-Reply-To: <harpgnimhcdp2m6hww7ht7pgxvchllvrncnwoxkivaorb5xhm7@5rcr2p7hcp4x>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 4 Apr 2023 20:38:33 -0500
Message-ID: <CAMP44s1TBUmc6mhGSWQ1v+E5_VRqnCUXURHs2cM-vE22eyndsQ@mail.gmail.com>
Subject: Re: mirror clone does not keep HEAD updated
To:     =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 11:35=E2=80=AFAM Daniel Mart=C3=AD <mvdan@mvdan.cc> =
wrote:
>
> I'm testing `git clone --mirror` to properly mirror a repository on
> github.com. It appears to be working well, except for keeping HEAD
> correctly in place.

Git does not set or update the remote HEAD, that's something the user
is supposed to do (for some reason).

The only exception is when cloning a repository.

In my opinion this is completely unintuitive and unhelpful. 99.99% of
the time I want the remote HEAD to be pointing to where the remote's
HEAD is pointing to.

I implemented patches to fix that [1], but they were never merged.

It's particularly wrong when you are mirroring a repository, as in your cas=
e.

> Am I holding the mirror wrong somehow? As far as the manpages say, `git
> remote update` should be enough to fully mirror all refs.

That's what I would expect, but that's not true.

I find that most of the time I need to read git's code to actually
understand what it's supposed to do. I don't bother reading the
documentation.

I've updated my old RFC patch adding tests and an option to make it
work with mirrored repositories as well. With
`fetch.updateHead=3Dalways` the mirrored clone always has the HEAD
up-to-date.

Cheers.

[1] https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@g=
mail.com/
[2] https://lore.kernel.org/git/20230405012742.2452208-1-felipe.contreras@g=
mail.com/T/#ma012c4823814936a3ab8755d1d2b805d61b43133

--=20
Felipe Contreras
