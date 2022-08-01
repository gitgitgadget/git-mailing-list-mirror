Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B3C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 10:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiHAKPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiHAKO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 06:14:58 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5F2CC97
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 03:14:57 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id m67so3126294vsc.12
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V4gws5j+BkW+HXdr7cIDN7dgHLgUlDp0Rquz/1EuNa0=;
        b=ITt+ut/Xl6jC1qmgZQ2jARTSVviZnacLQTu6Mct0ekNwJsKBBodwcPc0f2axioazJ1
         lPXk4IarSPHxOI68mdQHRwaZ6fiNWRh+Nt9WhdGtKNqjaseNh8MxWAx9MGpBaY+lTNRL
         DKWgONPFbXYaGVlvZvu3PPPJ7OKwO/cyxBfnbSK/FquDgQZ3tyV59ABLWQLEhCWvS1B3
         WntgQkfxHcUxtl1OiY1JyWUbiL/8tzVNikyewdHAg6KXxTYbDHLUc63vvDlSO7WAbU1A
         o0N1pHPHyIYppKiZmiXpiPfP4QNcVogjFUmuPnmXSYDcCvgFafBYi3PekpECAU2HZp0p
         DUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V4gws5j+BkW+HXdr7cIDN7dgHLgUlDp0Rquz/1EuNa0=;
        b=0o2XlWo8KFubjWQ3eBKJ09mPHbCzdD2INJTeov3fF/9oyS8U1ajlFxV2zPtNkj7y+J
         JnFDwwysKFONQsZsStqf/Fj72uu3I3e+iIlsz7AuqUt9yn6DzVOPRJhzL0h3wL5KL1Px
         sAer2hiwVbbm+l8+7WKl0P3/kIkyA842yoUCYH9kCxx9f6d6vxLSedJbzvLgDKEWv4nF
         m49FUK0N25Pa4FJ74oDfIEmjbHv+rKlT8mvJ/YXejwfliB+AwhJd3wqxDyHiTLYsB4gx
         /rRSvOQbpxdYuaHq6uHmBxVKp7p0rP6ffX2/4HrvQrk6F5xclOtDhmmk/litpUQY1yLV
         Fjig==
X-Gm-Message-State: ACgBeo361AKVd8z8X9oFZFRgx/GNTBEiYiQICqE1ncZSj9mM/LzkefFK
        C65lsZwPeTvCHlQigjQ9pdKLgkJ+3iPNMuPMMEKYNA==
X-Google-Smtp-Source: AA6agR5XwMH5kRpRpStZKuEySPEy46xq9/jY7MXsoLM1G7ZjgjGeLY8i7UYwoW/EnGnw7c1VZFH3+AamHdw7sl+ra0k=
X-Received: by 2002:a67:d90a:0:b0:386:a043:2e25 with SMTP id
 t10-20020a67d90a000000b00386a0432e25mr537466vsj.31.1659348896255; Mon, 01 Aug
 2022 03:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
In-Reply-To: <CAJoAoZmsuwYCA8XGziEA-qwghg9h22Af98JQE1AuHHBRfQgrDA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 1 Aug 2022 12:14:44 +0200
Message-ID: <CAFQ2z_PMZJ0CeEsruhQ_dAna1yTc+z1+p0SaeGg6+XsiKnZ=xQ@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 30, 2022 at 1:50 AM Emily Shaffer <emilyshaffer@google.com> wro=
te:
> Gerrit has tried to support something sort of similar to this -
> per-branch read permissions. They were really painful! So much so that
> our Gerrit team is actively discouraging their use, and in the process
> of deprecating them. It turns out that on the server side, calculating
> permissions for which commit should be visible is very expensive,
> because you are not just saying "is commit abcdef on
> forbidden-branch?" but rather are saying "is commit abcdef on
> forbidden-branch *and not on any branches $user is allowed to see*?"
> The same calculation woes would be true of per-object or per-tree
> permissions, because Git will treat 'everyone/can/see/.linter.config'
> and 'very/secret/dir/.linter.config' as a single object with a single
> ID if the contents of each '.linter.config' are identical. It is still
> very expensive for the server to decide whether or not it's okay to
> send a certain object. Part of the reason the branch ACL calculation
> is so painful is that we have some repositories with many many
> branches (100,000+); if you're using a very large monorepo you will
> probably find similarly expensive and complex calculations even in a
> single repository.


Thanks Emily,

I agree with your points, but as the manager of Google's Gerrit team,
I just wanted to add a few clarifications:

* The max number of branches we have on repositories is O(1000s). IIRC
our Android repositories are the worst offenders, because there is a
combinatorial explosion of {major release, minor release, target
device}. Pending reviews number in the millions, but we usually don't
have to evaluate ACLs fully, as the review refs aren't downloaded
commonly.

* The read ACLs are assigned to {branch-regexp, group} tuples. This
means that you can't precompute visibility either, because each
individual user may be in a different set of groups.

* Even disconsidering that, you can still do optimizations if updates
are FF (because each update only increases the visibility of each
commit). However, non-FF branch updates preclude such precomputations.
(Gerrit has non-FF updates in a number of places).

* The Gerrit team isn't actively deprecating read ACLs: the problem is
hard, because removing read ACLs on branches means that the read ACLs
move to repository level, which implies setting up complex ACL
configuration and replication infrastructure for repositories to
address existing use cases. It's currently just one of these features
that we wish hadn't been added, but now that it's there, we suffer
through it.

More generally, read permissions are hard to get right in a monorepo:
even if you stop developers from accessing the code through Git fetch,
the permissions must also be enforced throughout the entire dev stack,
including code browsing, code search, viewing CI artifacts etc.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
