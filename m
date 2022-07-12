Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B2CCA47F
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiGLG3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiGLG3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:29:01 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A22D118
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:28:59 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3137316bb69so70888607b3.10
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQL7PJjZsh0YCXcXC47010pKja5AtRpsTtd8haixyfs=;
        b=pgGloJGr3Qfn6YNM6RfnMLDYoM2bK3fE6KNzwKkEl/bBEgNpz3g4PgyxgGWaVJrjxT
         cMPyU+J7zM3yDTO0iV9jVcYJP365JDbz6u9zkMqRbBcTzEc6pvQJ8BphnX8iRjYJrQR6
         awrf9c0TjKtjcdpFA8u97GD5L1ywxumd6v82s/crfQt0nChqFp5gw4n37kh+mWv+pw75
         5qM90XshhM/8SL8ZEGEoC+nPbOC4LRFP2ZWAFg2EEvj2Dy2Kb/QQW/2aEdTSG88GDRRi
         Gv7v3HHODt86xjxKT99Ai/dEHAGsGRjrBeURbJsbNv5HfDOz9uM2nB5hRmfmw2FhGcOB
         DLEQ==
X-Gm-Message-State: AJIora8EA7ZEqZV8LdQe4hQndw5ypBIbme0jkLkYROSneCvfteKGdlYz
        pK4Ju+xikhfQietpq048i5hSZdcRM1I0vOYY2nQ=
X-Google-Smtp-Source: AGRyM1vue3TxhI4EEV287NtKol8+iiyFiLpJbaE0apE/kdvPm5A56zjyFhM5cdwjqrfN76veG4lUafaYOi6BTgf44qI=
X-Received: by 2002:a81:1148:0:b0:31c:ad1f:774f with SMTP id
 69-20020a811148000000b0031cad1f774fmr22477580ywr.13.1657607339027; Mon, 11
 Jul 2022 23:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com> <xmqq7d4kp8l6.fsf@gitster.g>
In-Reply-To: <xmqq7d4kp8l6.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jul 2022 02:28:48 -0400
Message-ID: <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 12:38 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Sun, Jul 10, 2022 at 10:00 PM Han Xin <chiyutianyi@gmail.com> wrote:
> >> On Sun, Jul 10, 2022 at 4:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> > [1]: `cc --version` => "Apple LLVM version 10.0.0 (clang-1000.10.44.4)"
> >> > -       git_zstream zstream = { 0 };
> >> > +       git_zstream zstream = {{ 0 }};
> >>
> >> Not a comment, just wondering, when should I use "{ { 0 } }" and when
> >> should I use "{ 0 }"?
> >
> > I don't have a good answer. More modern `clang` versions don't seem to
> > complain about plain old `{0}` here, but the older `clang` with which
> > I'm stuck does complain.
>
> I think, from the language-lawyer perspective, "{ 0 }" is how we
> should spell these initialization when we are not using designated
> initializers, even when the first member of the struct happens to be
> a struct.
>
> The older clang that complains at you is simply buggy, and I think
> we had the same issue with older sparse.

I can't tell from your response whether or not you intend to pick up
this patch. I don't disagree that older clang may be considered buggy
in this regard, but older clang versions still exist in the wild, and
we already support them by applying `{{0}}` when appropriate:

    % git grep -n '{ *{ *0 *} *}'
    builtin/merge-file.c:31: xmparam_t xmp = {{0}};
    builtin/worktree.c:262: struct config_set cs = { { 0 } };
    oidset.h:25:#define OIDSET_INIT { { 0 } }
    worktree.c:840: struct config_set cs = { { 0 } };

so the change made by this patch is in line with existing practice on
this project.
