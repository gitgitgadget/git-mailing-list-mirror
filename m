Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706AEC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHAU1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjHAU1u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:27:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5718268F
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:27:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so524a12.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690921664; x=1691526464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBTXTLU5YJ9GPslzFR103O4oeud9Iuucv0aRMnXsl14=;
        b=y2uf88H2fiy+2sqfVb0D9TtwrUeObeOrLL9A5TMxgEKMwvuMiD2uga9Q6bhRV+b5qd
         /JduMPSPUa0vb4r1Est+vxBYYW7XTwFWEY/AgIiNfz9hsZ+KSdxBNpNv0RVNjuTAsVN6
         2Sh0eBJI8ZG/Mw3jLJisfU/eajxQySylj9mlGMRt1GHpZOja6HmHzPJ4o7xAv1ULrlA6
         usd0HPkYdR55AmMjjJm+Vy3geiBoCm/mzCU24XEKS+RZDat2eDJZ8mhWuheYZYs895pP
         yz3aaHLkfuiDe+Mr3H5DLBXUbQjmY5S0tr/8N1Pe9Bx/A0BS1o/JzyBM5k7haAlvXmSO
         wljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690921664; x=1691526464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBTXTLU5YJ9GPslzFR103O4oeud9Iuucv0aRMnXsl14=;
        b=Ohg/qFi3XD/ZrIU8jYlvblaK/JYM8hlN/3untf6iCtrmLPvYu2ljcMVtRhzUfBBHrG
         uZsyoo+DWvr6YFqneT6Af7xAsAo/mw3yBYsNRepMYw1ilo7TeTs+B39PHGuSGkHqwcif
         cZslawMl+ltxTrYvIdxcK0bw7sa8KrAjoxi8qLk0vOpPXFTLtGh2YND7LErDyFtrC3Xa
         lDYLRkOpKXAVIpkDCHS6GG+GMAht/g5MEKhDL15xOznJ4f3Czpb/NKqK1UnRMd2k+cvQ
         dyqYpHiphOTFyIAQtkzo+ybeJ0Mswxm8fwHfhNp856kMpLLYOkPyEoRPWu9GzDlMt4v+
         eKhw==
X-Gm-Message-State: ABy/qLYwPQMHXBfX5lqJDncBE28Vdd2xrQvuVyVSTX7B4wuZzCX4R0Wq
        kS4FPS9FgqCx7do1X7Em5GXdL4UcTVaoD8fWwhs7kk2tTGKQ/XoQr7oQY2Kt
X-Google-Smtp-Source: APBJJlENuROtxubgF4kZyuynCZgFvc+iQKneiSB09tes75rmhQ9TNXv+PtbQOmkrkRo53hdNxESpO+m8M0PyMzhMksQ=
X-Received: by 2002:a50:a401:0:b0:522:41c9:9b9 with SMTP id
 u1-20020a50a401000000b0052241c909b9mr249814edb.5.1690921664392; Tue, 01 Aug
 2023 13:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmszcynem.fsf@gitster.g> <CAJoAoZk1WiCSDqFXccG4FiwYhWUuWWmFz+ZqiXhacmfjZuE6FA@mail.gmail.com>
 <xmqqzg3abpis.fsf@gitster.g>
In-Reply-To: <xmqqzg3abpis.fsf@gitster.g>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 1 Aug 2023 13:27:33 -0700
Message-ID: <CAJoAoZngMcN-0-5q1y-zX5552QhgRHCrKULQ7hKyJgcCoSQJNQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2023, #07; Mon, 31)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2023 at 11:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > On Mon, Jul 31, 2023 at 10:57=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> >> * es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
> >>  . usage: clarify --recurse-submodules as a boolean
> >>
> >>  The "--[no-]recurse-submodules" option of "git checkout" and others
> >>  supported an undocumented syntax --recurse-submodules=3D<value> where
> >>  the value can spell a Boolean in various ways.  The support for the
> >>  syntax is being dropped.
> >>
> >>  Have been expecting a reroll for too long.
> >>  cf. <ZDSTFwMFO7vbj/du@google.com>
> >>  source: <ZDSTFwMFO7vbj/du@google.com>
> >
> > Yeah, sorry about the annoying wait. It's not something I have time to
> > reroll soon - but it's on the short list for "up next" bugs for my
> > team to get a reroll. We still intend to reroll and push through, but
> > I don't have an ETA. I'll leave it up to you to decide whether to keep
> > it in seen or drop it with that information.
>
> I actually do not quite understand this ;-) It wouldn't take more
> than 20 seconds to read the "minimally touched-up version" sent
> months ago https://lore.kernel.org/git/xmqqfs97cozz.fsf@gitster.g/
> and say "yeah, that is perfect and please queue with the fixup" ;-)
>
> Or are there still further changes in behaviours planned?

Huh, I thought that you wanted further changes. In
https://lore.kernel.org/git/ZDSTFwMFO7vbj%2Fdu@google.com/ I was
asking for opinions on adding tests; if you're fine to take it without
tests, then of course I don't have an objection to an identical patch
with objectively improved grammar in the commit message. But since you
were asking for a reroll in the What's Cooking, I figured there was
more you were unhappy with in the patch. If that's not the case, by
all means, go ahead and take it.

 - Emily
