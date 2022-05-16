Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454DBC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 08:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbiEPIiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiEPIiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 04:38:21 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3891E0B1
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:38:19 -0700 (PDT)
Date:   Mon, 16 May 2022 08:38:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1652690295; x=1652949495;
        bh=YqL5cin3zOsAh2OxR2sHS5zxJzEhKCDsGsaHeI5FxSA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=YJMU6+EPHvwI/F5X3yqvfReyKU9iOu6waxHN5I55Jqw1D/FGDQ+KNCNtnjbxqb4qg
         EEBLv/pnxAQ+NqB34rqGiIY+HJnR/sY/U6hR/maNSPrBD9Dj0LrD0zPPzpNVs5MIa9
         K3eL8iMvEGhsq78YR8Eiyom6u2FDMxH5/ssHVIjXB3mPXZDth9SKazdkodLefu2BLR
         qmM/GD/h3N7/7sCxF4CdlrftZZDv8nRi1a9Un8KN0DwD4htiNz+WWZkCc0PJP7Mu0m
         lJsxGCqtVO+HPRvNOeh9nW8XLSiy/PWie+YhJQxNiTrS9TsGn4Jtisi7v2d8j2jBBB
         C1ONb2Ag6pGug==
To:     Paul Eggert <eggert@cs.ucla.edu>
From:   "Carlos L." <00xc@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, GNU grep developers <grep-devel@gnu.org>
Reply-To: "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH] grep: add --max-count command line option
Message-ID: <MHNbacVw7D6ZU3OJvgIqqRMu70HlgYIYQPduUEUnzWCqkGUsUGRLopGGWj-CbyjNilDcUfLB6elfSRgDOaob9cPpjeAf-I6xuMArQZ0y3io=@protonmail.com>
In-Reply-To: <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu>
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com> <xmqqilq658b3.fsf@gitster.g> <e89577f8-8f52-bf09-15f3-c534bf1a6c64@cs.ucla.edu>
Feedback-ID: 24333956:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list,

Thanks to everyone who provided feedback :)

On Saturday, May 14th, 2022 at 20:16, Martin =C3=85gren <martin.agren@gmail=
.com> wrote:
> I think this should be
>
> [(-m | --max-count) <num>]

> Please use `backticks` with `-v` and `--invert-match` so that they are
> set in monospace.

I will add these suggestions to my patch.

> Regarding the special value 0, it's a bit unclear what "has no effect"
> means. In particular, it can have an effect in the sense that when it
> is used like
>
> git grep -m 1 -m 0 foo
>
> it undoes the `-m 1`.
>
> But also, that's not how my grep(1) behaves: with `-m 0`, it limits the
> number of matches to zero. I don't know how useful that is (can that
> zero-case be optimized by exiting with 1 before even trying to find the
> needle!?), or if maybe different variants of grep handle this
> differently? If all grep implementations handle 0 by actually only
> emitting zero hits, I think it would be wise for us to handle 0 the same
> way.

I agree the wording is not clear. I did not see a good use case for GNU's `=
-m 0`, which is why I used that value as unlimited. I am not sold on using =
`--no-max-count` or -1 *just* for consistency, but if someone can point to =
a good use case of GNU's `-m 0` (especially in git grep), I will gladly con=
cede.

> Even if we want to handle the zero just like you do, I think this patch
> needs a few tests. We should make sure to test the 0-case (whatever we
> end up wanting it to behave like), and probably the "suppress an earlier
> -m by giving --no-max-count" case. It also seems wise to set up some
> test scenario where there are several files involved so that we can see
> that we don't just print the first m matches globally, but that the
> counter is really handled per file.

This seems sound. Is there any documentation on how to write tests for git?

On Monday, May 16th, 2022 at 07:57, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Good thing that this is defined as "per-file" limit. If it were a
> global limit, the interaction between this one and "--threads=3D<num>"
> would have been interesting. Perhaps add a test to make sure the
> feature continues to work with "--threads=3D2" (I am assuming that you
> have already tested this implementation works with the option).

I did and I found no unexpected behavior.

> What "git grep -m -1" should do? IIRC, OPT_INTEGER is for signed
> integer but the new .max_count member, as well as the existing
> "count" that is compared with it, are of "unsigned" type. Either
> erroring out or treating it as unlimited is probably fine, but
> whatever we do, we should document and have a test for it.

I would favor treating it as an error. As mentioned above, using 0 to descr=
ibe "unlimited matches" (e.g. the default) is my preference, but I am willi=
ng to concede if someone can think of a good use for `-m 0`. Also, from the=
 implementation side (although not as important) it looks better: if we all=
ow negative values, we need to distinguish between -1 (unlimited) and -4 (d=
isplay error to user, probably) - the patch is much simpler right now. And =
just as a side note, we avoid an issue in the pretty much insignificant use=
 case of giving a very big value (UINT_MAX) for `-m` and it overflowing int=
o -1, thus not properly limiting the number of matches.

On Monday, May 16th, 2022 at 09:28, Paul Eggert <eggert@cs.ucla.edu> wrote:
> As I vaguely recall, if "-m 1" stops before "-m 2" does, then the idea
> was that it's reasonable for "-m 0" to stop before "-m 1" does, and the
> logical place to stop is right at the start, before any matches are
> found (i.e., exit with status 1).

As I mentioned above, I do not see what this `-m 0` behavior is useful for,=
 but if someone could show me an use for it I would appreciate it.

Again, thank you everyone for your comments.
