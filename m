Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A3DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGLHOE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 12 Jul 2022 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGLHOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:14:03 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFE5141C
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:14:02 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p129so12504998yba.7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pALt5B/LHadXAz29mjMYjJx2V7WXF/uRKhpLsbUQV+4=;
        b=VaxR6e60GAD233rReiprc8IKaYo8tUYmUCiPjvoVUYReRX9oPAr0avnfzNLF7/M8In
         MUA+K4Ir5HPHp6zNRu14HDsNG0Nr6oGxwmfbUhYjZvTmIjUg4rmHb8vw1/rLhlj6/5iR
         1XXh/YLuiXUAGj/ua0OmM0lbdpmEmy18s8Ptdh3fmGs6ZbxZsB0INDF23tUNLeZi67OH
         LEB/p1ZyCKHhKwaYCroPFS/45koV2q9ffss1tfk8eXF/SEkt7tPBc7Uo1r8VS2DrwLN/
         o4GXwOdjAENQShO8FOXtCuVMYLX41TSkHyCNRkbFo7MHp5wNVQoFGCYw60t4TA+3XPTT
         vY8g==
X-Gm-Message-State: AJIora8Rm32CKptw9ZiMLzSip8M91QTa6SPnXtmomEQmeOP65YeaQo60
        NDlc/Tp+TYdDlCvi968lLR47gnDl7PSdpqmXmzPJ7DTWuwakCg==
X-Google-Smtp-Source: AGRyM1tO2MxM7wwz3xJC/A52QZP26ra8ckWE68IFt75l/5os2/R58uDwefP2ev1UMwoc1PG1o4LADko3BGgRc/rYw2A=
X-Received: by 2002:a25:2e09:0:b0:66e:308b:59d1 with SMTP id
 u9-20020a252e09000000b0066e308b59d1mr21910760ybu.475.1657610041552; Tue, 12
 Jul 2022 00:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g> <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
 <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
In-Reply-To: <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jul 2022 03:13:50 -0400
Message-ID: <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 2:55 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 12 2022, Eric Sunshine wrote:
> > I can't tell from your response whether or not you intend to pick up
> > this patch. I don't disagree that older clang may be considered buggy
> > in this regard, but older clang versions still exist in the wild, and
> > we already support them by applying `{{0}}` when appropriate:
> >
> >     % git grep -n '{ *{ *0 *} *}'
> >     builtin/merge-file.c:31: xmparam_t xmp = {{0}};
>
> Not so fast :) If you check out "next", does compiling
> builtin/merge-file.o there complain on that clang version now? I changed
> this to the "{ 0 }" form.

No, builtin/merge-file.c doesn't compile, and I discovered that just
after sending the email to which you responded. I haven't yet prepared
a patch for that new instance since I don't know if Junio feels
inclined to pick up such a change.

> If not I wonder if this has to do with one of git_zstream being
> typedef'd, or with the first member being an embedded struct (I couldn't
> find another example of that). For the former does the patch at the end
> & "make builtin/unpack-objects.o" make it go away?

No, the patch you included doesn't make the problem go away (even
after I fixed all the "error: must use 'struct' tag to refer to type
'git_zstream'" errors which showed up throughout the project after
applying your patch).

> >     builtin/worktree.c:262: struct config_set cs = { { 0 } };
> >     oidset.h:25:#define OIDSET_INIT { { 0 } }
> >     worktree.c:840: struct config_set cs = { { 0 } };
>
> Uh, and here are some other examples, so those also warn if you make
> them just a "{ 0 }"?

Yes. (Full disclosure: Even though the two worktree-related instances
come from commits by Stolee, I'm pretty sure I'm the one who asked him
to change them from `{0}` to `{{0}}` during review for this very
reason.)

> > so the change made by this patch is in line with existing practice on
> > this project.
>
> It is nice though to be able to use standard C99 consistently, where a
> "{ 0 }" recursively initializes the members, I think that's what your
> clang version is doing, it's just complaining about it.

Agreed, it would be nice to use plain `{0}`.

> Since this is only a warning, and only a practical issue with -Werror I
> wonder if a config.mak.dev change wouldn't be better, i.e. to provide a
> -Wno-missing-braces for this older clang version.

I'm in favor of this. It would, of course, require extra
special-casing for Apple's clang for which the version number bears no
resemblance to reality since Apple invents their own version numbers.
