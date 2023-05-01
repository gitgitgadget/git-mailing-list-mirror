Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DDC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 00:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEAAls (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 20:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEAAlr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 20:41:47 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068013D
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 17:41:45 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-549d9c2935fso1192371eaf.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 17:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682901705; x=1685493705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e28SJ9nXDMcYsPaU0NBFDMTyCTejQ0sPZUVU7huaaI=;
        b=Uxo1Gg65hNrMl9MM6Nuu3G0azc50ke4gPhqDG3Q+++ifUwnBIZeztkGEZ/d6BJr1C7
         HPqZ+tL5G0LyQbO9qQHm6RZI3Q/jLausdoFE6mtn2HmI349BUAgkJfNQiakhTimNTafd
         ag5+I4JNrrUhbcgQXtdY95SexB4LnUg7ylRobSXIwHCWlVRynawAASuQm/7bJOGPqPDc
         Dd2TZLHJYFCi/D+jfAffIoDAVaBGLb8oVAKf2UIXfN0SEpcbXy1IU8X7jkR1dN4Mlfvu
         wl5BNtLz47/cbqe9Cwf71zXiDviyHDXNgjiCJ8t5XCuuQipcKmbOIqVwBFG4oO9Zg9d1
         CDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682901705; x=1685493705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e28SJ9nXDMcYsPaU0NBFDMTyCTejQ0sPZUVU7huaaI=;
        b=h2AbcEhZED5MWvgXgO0Oh/ej2thm56/JaFmO74yYaay5K8sjLgR0soLjAHH9x4+AJa
         S8ebXEfd4frEGSl/jLbWykxm9JbG2QVU695/3O7TQhm2KURq+0jdaJqXw+uGCdgea5bz
         +z3wNu+fj9IKWQYuGACX89+Eu+6+ni4hVk0VdeBXFLN2Kpz6nh9b4GNkvMLeZQ1t/15A
         JQo1NueKtU8oMZxvu1GqcQD8ZOuNA8sI+K3BdiiOInMpD1BIrsIZ/vwJ+JTYrfMC1Q91
         3aCIOtHvGFcbN+8D9ACoDiGcQnev0tYHyeIvNjyRj5C8g3ATLl+w5gPHUaUvZ7uG89OP
         lFQw==
X-Gm-Message-State: AC+VfDyMFg9+yrAmCS5hOy4R5Z0P+C0RZlACQ5tiWFP9E+uKw9df2DZo
        nM38g18d8CP90+aQGrKFVRCMddXMNFcyuXsqjes=
X-Google-Smtp-Source: ACHHUZ6s5OU3VupsRPHmW4undMOaJhJW/cNWIP1B0B54bYoUyIP/nxwK3w13XzSm2hM+52RidXFu4TE4Goh/c6H7WLM=
X-Received: by 2002:aca:6542:0:b0:38d:fb24:6fa9 with SMTP id
 j2-20020aca6542000000b0038dfb246fa9mr5780346oiw.23.1682901704867; Sun, 30 Apr
 2023 17:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230421055641.550199-1-alexhenrie24@gmail.com>
 <20230428042221.871095-1-alexhenrie24@gmail.com> <xmqqsfcjevbz.fsf@gitster.g>
 <CAMMLpeQB1zdTEWd+=d0kaKwpzax093iLTuytZtvn0nTSJ2xT4A@mail.gmail.com> <xmqqcz3m9ch1.fsf@gitster.g>
In-Reply-To: <xmqqcz3m9ch1.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 30 Apr 2023 18:40:00 -0600
Message-ID: <CAMMLpeTWxLKtrXxLWY=3mCwh2i8jhQ7ZcivdxpY36rDBpNtK8A@mail.gmail.com>
Subject: Re: [PATCH v2] docs: rewrite the documentation of the text and eol attributes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2023 at 11:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > The new text may be slightly redundant, but it makes the
> > important part crystal clear.
>
> I tend to disagree and think it is a bit too redundant, but we do
> not have to agree on everything---after all you are doing all the
> work, and it is your motivation and your topic.

I just now realized that `eol=3Dcrlf` works when `text` is unspecified.
In that light, the phrase "on checkin and possibly also checkout"
seems to go a little too far towards implying that the eol attribute
and core.autocrlf config variable depend on the text attribute being
set. Omitting that phrase would leave the introduction with a better
balance between precision and brevity, and the remainder of the
documentation would still be there to flesh out the details.

> > Then again, maybe the fact that the `text` attribute does not
> > normalize CR line endings is a bug in Git, and we shouldn't advertise
> > it in the documentation as if it were intended behavior. What do you
> > think?
>
> Just not mentioning CRLF specifically would be sufficient.  When
> (and if) somebody actually comes and complains, we can say "CR
> delimited files are not considered text these days, we aren't doing
> MacOS System 7" ;-).

I don't think I would dare say "CR-delimited text is not text" to a
retro computing enthusiast. But I'm fine with not mentioning CRLF in
this sentence, and when the angry mob shows up on my doorstep, I will
just send them your way ;-)

-Alex
