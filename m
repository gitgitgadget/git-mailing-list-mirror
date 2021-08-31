Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13FCC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B618661027
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhHaPgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhHaPgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 11:36:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25340C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:35:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so28384619wrh.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VMjx8nPcJSf0JLq2OVMs3ZmQYUaHc93pO1X9oMLg2hg=;
        b=UdRd/ftVCy/G6DQNWzDvCACrlsXTPWrrwp2UDopG+NWQVCOo/4lVQZ5HuTU16LXeMt
         0/VyRjZ5904MMuTBoltmoD4WFcFz1pA7p5Lb4xBI65Yi6tZzc+rVwkRsTGgNCFIejtFR
         rQV9R0+sKWCYdKCD1fZ8CN0MCV0zaxUdh2bkxX+O8MDmqd44YzBI66gTHXXKVBAnn8JZ
         IrebxOk8MoyWpHA2G/6sDIww1s9TOpADvzfY86XXtuJL/PJahZYqo05qyJSFZjtOOYtS
         REhmzVtHF46HQwn9VEgzPRrjYCkZxW42DHWIj9dIBScJfne1voBnyBR6vBpMKYUhR97g
         HiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VMjx8nPcJSf0JLq2OVMs3ZmQYUaHc93pO1X9oMLg2hg=;
        b=oYNnGY9xQFWEybTF6+DwWDrrs25XVZAGDfwzh5GbGB/I1b2akcg3KI7d/mqHaRa5G6
         fRKsBDimPOQzvJvwBp+Kq/Vv858xUKGv1gMxT+JUzdLVeNlgeKCae7AJjTn8uql1fFse
         W9Gt3qCxBUcM4wkXQMJMBNlQAbuDrorvGtJ/w/ZWDblf1hNZv+oqx0sUUgsQ4UFn5D4R
         rSiw71YuLhGYry/uMaDmh2WMMywWGfpXKECffuloZI4FDrFDz2XTAcMAf9UbktHp/gnX
         /OyY9wd+w5lRzK2vQuJywIqtjdQ/U7P8p9TezPmgDddaaX64X35R2LqKGYtilqblSEDR
         qxmg==
X-Gm-Message-State: AOAM531Wnxz6ngZgt1igXMpTsKzpLBOLLKNCRnWBRfidvmJne7GNO+MX
        0VmTrEfamr2qa9AlT1p/esv0zOGkw+2QU2dG40QhWbXK/CCoWw==
X-Google-Smtp-Source: ABdhPJwjRKl8mMTnkMrhqejYHygA3S+vgpZPFCfRu8G2foNISVgxFhzp6tGyMNfuhTsxwrUMQM1Q31vuMK26RgTuAdM=
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr32582393wrr.2.1630424138600;
 Tue, 31 Aug 2021 08:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
 <YS0tNoAa/0VQe1OW@coredump.intra.peff.net> <xmqq35qq4t1x.fsf@gitster.g>
 <YS1DnGTDo5ZG8Iw4@coredump.intra.peff.net> <xmqq4kb639xt.fsf@gitster.g> <87sfypwuwx.fsf@evledraar.gmail.com>
In-Reply-To: <87sfypwuwx.fsf@evledraar.gmail.com>
From:   Bruno Albuquerque <bga@google.com>
Date:   Tue, 31 Aug 2021 08:35:22 -0700
Message-ID: <CAPeR6H7_V+ypzyN39e27+NCRqG-nA17sgq=qtefzFF3Dg50bnA@mail.gmail.com>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stef Bon <stefbon@gmail.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 7:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

[Replying again as I used HTML mail by mistake. Sorry.]

> I.e. someone setting up a git server probably isn't going to suspect
> that one day their server load is going to go up by some big % because
> some developer somewhere is using a local IDE whose every file click on
> a directory is a new remote server request (i.e. the case where
> "object-info"'s functionality is expanded like this).

Do you mean by someone directly sending object-info requests? I am
working on wiring object-info to some of the existing tools
(cat-file/ls-tree) so this is the general idea about how I see this
being used:

- object-info would be used when it made sense but only if the actual
object being queried is not already fetched locally. If you think of a
virtual filesystem that is backed by, say, partial clones, this mostly
means retrieving metadata information to be displayed to the user.
- Still in the context of a virtual filesystem, metadata is usually
cached locally independently of Git itself, further reducing the need
to call object-info (but, of course, this is a brittle assumption as
it is not controlled by Git).
- git cat-file, for example, would be changed to support real batching
and then send a single request instead of the multiple requests it
does currently.

My point is that I understand where your worry is coming from and as
long as someone can send arbitrary requests then it is possible your
scenario of a heavier server load can potentially happen but as far as
the expected canonical usage, I do not think this would be a problem
and, in fact, under some usage patterns it might make things better
(mostly due to batching support in object-info).

With all that being said, I don' t think making it optional would be
an issue so I have no strong feelings about this. I am fine with
whatever is agreed to be the best approach.

> I found myself wondering this when reading serve.c the other day,
> i.e. why we have "always_advertise" for object-info, but it seemed
> innocuous enough given how it's described in a2ba162cda2 (object-info:
> support for retrieving object info, 2021-04-20).
For what it is worth, The same change is now being reviewed in JGit
and there the feature is conditionally enabled. But that was a
side-effect of needing to deploy it to multiple servers before making
the feature available to clients.

--

Bruno Albuquerque | Software Engineer | bga@google.com | +1 650-395-8242
