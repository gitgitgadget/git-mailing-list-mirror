Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA1DC6FD1D
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 01:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjDEB4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 21:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjDEB4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 21:56:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDC73599
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 18:56:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id m16so20604949ybk.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 18:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680659790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm+rIWYL29a8ncefGggBR9VDdCRoLP98sFuSuZnyBvc=;
        b=Y3krF08d23J9yqtWpTAD9VrNdlZLYBP1gG+I1PzQL+4Zmiu/gak6ELjoAYXX2KA2HW
         IsvOVxhvKXCk4zNZjHqncoKq4kiKXJmacrtuGstih3G8zKA38VJlKD3+UQH5WJPeRcNd
         7U1I3RCyjilnqrgdXf1Ntvkmoir/HxEA2rRHmNcqqLQvZLyLdiq/Ed+6sn3wslFGa/in
         ONl2M2G5wX1+hn7az6wTaI3WFWEc/UpgxqJeSZXIFvsydfgAXH9IUVC8ZOB+pxOaQYso
         5t9vVz90ntwdZ/nt5RHV3TiAxxlgBVOl/ulzVHMUcjTbasWXTafsDuhENeV2nR8tCrqT
         fLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680659790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm+rIWYL29a8ncefGggBR9VDdCRoLP98sFuSuZnyBvc=;
        b=szyNApoH9Askcvo04UvaFHpcF3/puO3F4to8KliVuEDnnSQKHZhvpnorjPvy+RYZIo
         o138JJ+DpfB0alnrDRQaUJYp7yJrgHDOm3pBMsWM4/O8BBuuLxbwdsxUKAWIG+nIYKnM
         P7JSs8X8uIHfPcv7Y1cbhFU+/9DZ3D/n96sNYbB4xf+6bBtJLGNDcsKHMYvzOp+mfPwM
         dzW17r9efbl39/6N9vTFOG6TuYlKmHJBXIrjSaDT+UECiwSyzVOzl6cwz3kdl+T4ZWWL
         3BW4PgVso/vq2pc0BiRwn+nIyBxcBrt+RenNV7pYYeUJ6Cp3NSOeJF/O2mwWUHZjrU+u
         FMNA==
X-Gm-Message-State: AAQBX9fIq/3VFIu5pLYQs4US487twlBzfbSY3iafnobJWSfKxWJBi+al
        RSGP6wh6N3/MQsEy2GT2Ckk9nKVatFTcK74nyLk=
X-Google-Smtp-Source: AKy350YgF782v0off2vroLgRl+uQptjmJb5Hzf6nlpx0tbrJVStgGX9dVSSexTN8zCFNnTNVntOmQZNgBpnxja8l95w=
X-Received: by 2002:a25:6646:0:b0:b6b:d3f3:45af with SMTP id
 z6-20020a256646000000b00b6bd3f345afmr870309ybm.1.1680659790057; Tue, 04 Apr
 2023 18:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <harpgnimhcdp2m6hww7ht7pgxvchllvrncnwoxkivaorb5xhm7@5rcr2p7hcp4x> <xmqqileb1u34.fsf@gitster.g>
In-Reply-To: <xmqqileb1u34.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 4 Apr 2023 20:56:18 -0500
Message-ID: <CAMP44s1DrFY7ZxfdFwVDd=uJpdxkEDf8irAzEKmcih2MEuv0Aw@mail.gmail.com>
Subject: Re: mirror clone does not keep HEAD updated
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 12:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Daniel Mart=C3=AD <mvdan@mvdan.cc> writes:
>
> > I'm testing `git clone --mirror` to properly mirror a repository on
> > github.com. It appears to be working well, except for keeping HEAD
> > correctly in place.
>
> There is no such feature in "git clone" or "git fetch" to check what
> branch the remote HEAD is pointing at and move the local copy around.

Only because you didn't merge the patches I sent a while ago [1].

> Modern versions of Git these days have a protocol level support to
> convey that information, and I think it is feasible to invent such a
> feature to automatically repoint refs/remotes/$remote/HEAD to
> whatever remote-tracking branch found in the refs/remotes/$remote/
> hierarchy.

Or just repoint it to the remote's HEAD, which is what everyone expects.

> We are pretty much "somebody should initiate the process to scratch
> their own itch, and we will help them in doing so" community, so you
> or somebody who reads this thread interesting will hopefully start
> such an effort ;-)

That has not been my experience. Even when I scratch somebody else's
itch, there is not much help, and the patches don't end up being
merged.

Cheers.

[1] https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@g=
mail.com/

--=20
Felipe Contreras
