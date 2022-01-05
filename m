Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54EAC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiAERcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbiAERcb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:32:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54538C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:32:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so165005479edq.6
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xgd3I66z8Ihz0OrKsdD+M6WJNuYIelY6rUzYIL185fA=;
        b=aRpfFoH3Uo/0U2F7UOkCNyoZtsF+kiO8u2oXrxJAMzZU15Ryp450YJmgZZ3M3IXLQT
         6RWjGPjYYWFx8Wau5bR7pJhD8rm3TqAYuSaORzHE4mPUQK5xEy3lhWTQgNzFiLkMItzf
         zAJBwy4pFo1iSV3UOPX6uZ2Cz2C8VrwhxK2g4vAo8eo3y/DTMaMvk3uaUPyYq5ACmwnH
         RMPEQVtNRZqqpSl6N9NJLoyn8J59O8ISbnfWur73aUOXY0apUPqny0mkjsSNFJHi/6+L
         tHhrAubb4GCUpL8Do+Bk+v9c5ACQdNXlzpZotSD891B9BAZDmpOjxk2idQk06Bj+nkFx
         RfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xgd3I66z8Ihz0OrKsdD+M6WJNuYIelY6rUzYIL185fA=;
        b=D/BTF9ON7z1yDZdk8iQVfh6NWpdnt4vf9NWfJeBajAwjwQRX++gw80UVd7LFGevLaJ
         ft05HfvLm6ebw6B7bc1nykbCrsg2VxmkHcLtQGWz84/2Hr8dheAEZ7r5lNPiIrQyvksf
         /78n8bcGUlT5AASWD2Dze1odGTiombBjO8D0UZg16kQV7oPJ/Yr7YTMQFyg0SL93NB0R
         4LMPWS/0bGtuUlK/JHGH1jf5brT/mKi/QDfYYIejw3byqrmuhYm6dOlbSrqmaKeTlNO1
         d4cITkv1Hc1Gu6BeayIpo2dIj36Ik4p3a4yvw1BAR+ipTgCG2QOjhD6vpgAA59u4/aq3
         Gnng==
X-Gm-Message-State: AOAM532iMoZ1qxy9z50nGid/wuorZ3QZzW300IUnuAn/ebnHAeCGWEuY
        oixZAdA8YlKGEoLJQ5HmCSHXDMacb4vet/H7EGtnnkst4cTuXA==
X-Google-Smtp-Source: ABdhPJzuBIBiMNKMOV/qLMC+2NCcerLkT9535d2PUrOJj3gIO+/laviCyfsRu0aIir7sTxo3cEc7Heix0FyXqq7e2Ng=
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr55618889edz.153.1641403948827;
 Wed, 05 Jan 2022 09:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
In-Reply-To: <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 09:32:17 -0800
Message-ID: <CABPp-BEeBpJoU4yXdfA6vRAYVAUbd2gRhEV6j4VEqoqcu=FGSw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 8:53 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > During the 2nd Virtual Git Contributors=E2=80=99 Summit last October, a=
nd even
> > before, the subject of performing server side merges and rebases came
> > up, as platforms like GitHub and GitLab would like to support many
> > features and data formats that libgit2 doesn't support, like for
> > example SHA256 hashes and partial clone.
> >
...
> > The first patch in the series adds the new command without any test
> > and documentation.
> >
> > The second patch in the series adds a few tests that let us see how
> > the command's output looks like in different very simple cases.
> >
> > Of course if this approach is considered valuable, I plan to add some
> > documentation, more tests and very likely a number of options before
> > submitting the next iteration.
>
> Was there something you didn't like about
> https://lore.kernel.org/git/pull.1114.git.git.1640927044.gitgitgadget@gma=
il.com/?

Since I already had some fixes queued up for that series based on
feedback from Johannes Altmanninger and Fabian Stelzer, I decided to
submit those so you wouldn't have to stumble over the same problems.
So see https://lore.kernel.org/git/pull.1114.v2.git.git.1641403655.gitgitga=
dget@gmail.com/
instead (which also now has a pointer to this series in the cover
letter).
