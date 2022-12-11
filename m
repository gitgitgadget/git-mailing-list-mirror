Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56ABC4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 18:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLKSab (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 13:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLKSa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 13:30:28 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC08A447
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 10:30:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id m204so9346081oib.6
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 10:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKnibp2IjwOCLvhESg21Q83RaGhuoSjq7wosnOr8aIE=;
        b=o08M6tn9oE63100tn85bf7z3SVuBFDka7jZAHfO5SQ2r04MazppEg7+3D+gJkI8SIe
         BeXK4SKzIUzFPVe7AZrRk7Y/nm9d3+dLIYq5OjF/eQnUmbyinwjAZj9koGWfLXpsFBh6
         lk4MnW09oCmR/egHbP4b7kta17p1Om+l4eeDK4ECzc3v4uVsoCg+fW0vxFTMZ/vTFonO
         PRfsiva+8T/yDnghT8AIrS9/BJIEtnAAFPuGDZ9CDFnYetODlLhjUzQDworkYhT3oV9a
         wy9g0SsX1T8no65UuyJGr3nVziGRxszmNJRa9IEkxi5jMixfWgDfvi+Gd/NLZ05oeceC
         XbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKnibp2IjwOCLvhESg21Q83RaGhuoSjq7wosnOr8aIE=;
        b=kxWvhmxoOwWoVR+8CFzkjUJeiws2LyELH3Fg77KvplCcgKlpFzKF75KaDj3teODPMO
         SAtwMiCSN+HESfeaTZwwV5KbEHGKOYeMRzp+5xOPouWGHvBD9fA8nuVQtBTBgZFz4GVL
         u9YwKKfe4KK24ndCvHRg45BUC1SCCAShRMRynbMH5ah8uRJobZ/+UNQy+NHNSC8AXOfF
         jitsc61F6tHS0Y9oI+qOqU/IKyNBW+zMtfuRg4Ab0xIL6cZjq7rbQHjnVl8sZO5Us7Qt
         JemrOzkJxTbTScjqS9mqvcbozpsdXAm3XWn6gLsm7Xd7tvT7KUZcNSX/S2azrzVdlPH/
         jI0A==
X-Gm-Message-State: ANoB5pnD/+VVDbJ17ayqnouNslR752de4Q+df6mi43U31OwX6JDgXGX0
        sWxGGsBN9TTKhdATaeN6iBH8fLQCPWUJPRksgrSigGFnsPI=
X-Google-Smtp-Source: AA0mqf73xfxfQw4SqpIWhPab5oeMYg0lPaaH6PKQmiN7v07njFPqnHR0qUTUymZhuI9eD0MQUEd1s5v+Khn0m24sLQA=
X-Received: by 2002:a05:6808:21a9:b0:355:7d0f:27ae with SMTP id
 be41-20020a05680821a900b003557d0f27aemr427561oib.133.1670783425466; Sun, 11
 Dec 2022 10:30:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com> <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
 <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
 <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com>
 <CABPp-BH5RhHR-KhhumuhZGy2F4ypUBoqgAatY5MKkQsB46KM4g@mail.gmail.com>
 <CAPkN8xLN_fKdbU8ugxLYJ1YeCJ8CxBWh+kdhAq1mR8hfAe-NAA@mail.gmail.com> <CABPp-BEqvmSaqVrK=nQsk-8PNXq6Pzq4Y-=RopYwTDjtyitAuw@mail.gmail.com>
In-Reply-To: <CABPp-BEqvmSaqVrK=nQsk-8PNXq6Pzq4Y-=RopYwTDjtyitAuw@mail.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Sun, 11 Dec 2022 21:30:08 +0300
Message-ID: <CAPkN8xJ_B_t7L6bErsFB+rp6fzy7PO55myWqyJWPNbTgiQ69ow@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 8:58 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Aug 10, 2021 at 8:51 AM anatoly techtonik <techtonik@gmail.com> wrote:
> >
> > On Mon, Aug 9, 2021 at 9:15 PM Elijah Newren <newren@gmail.com> wrote:
> > >
>
> [2] https://lore.kernel.org/git/CABPp-BH4dcsW52immJpTjgY5LjaVfKrY9MaUOnKT3byi2tBPpg@mail.gmail.com/
>
> Signed commits is just one issue, and you'll have to add special code
> to handle a bunch of other special cases if you go down this route.
> I'd rephrase the problem.  You want to know when _your tool_ (e.g.
> reposurgeon since you refer to it multiple times; I'm guessing you're
> contributing to it?) has not modified a commit or any of its
> ancestors, and when it hasn't, then _your tool_ should remove that
> commit from the fast-export stream and replace any references to it by
> the original commit's object id.  I outlined how to do this in [2],
> referenced above, making use of the --show-original-ids flag to
> fast-export.  If you do that, then for any commits which you haven't
> modified (including not modifying any of its ancestors), then you'll
> keep the same commits as-is with no stripping of gpg-signatures or
> canonicalization of objects, so that you'll have the exact same commit
> IDs.  Further, you can do this today, without any changes to git
> fast-export or git fast-import.

Took me a while to process the reply. Let's recap.

I want to make a roundtrip export/import of
https://github.com/simons-public/protonfixes which should get exactly
the same repository.

# --- fast-export to exported.txt
git clone https://github.com/simons-public/protonfixes
git -C protonfixes fast-export --all > exported.txt
# --- check revision of the repo
git -C protonfixes rev-parse HEAD
# 681411ba8ceb5d2d790e674eb7a5b98951d426e6

# --- fast-import into new repo
git init newrepo
git -C newrepo fast-import < exported.txt
# --- checking revision of the new repo
git -C newrepo rev-parse HEAD
# 9888762d7857d9721f0c354e7fc187a199754a4b

Hashes don't match. The roundtrip fails.


Let's see if --reference-excluded-parents helps.

# --- export below produces the same export stream as above
git -C protonfixes fast-export --reference-excluded-parents --all >
exported_parents.txt


Because fast-import/fast-export don't work, you propose to keep the old
repo around until it is clear which commits I am going to modify. Then
make a new fast-export starting from the first commit I am going to
modify with --reference-excluded-parents flag. Is that correct so far?

Then given this partial export and old repo, how to init the new repo
that fast-import can apply its tail there?

What if I have multiple commits that I modify, but I don't know which
of their parents was first? And when I touch commits from different
branches, how to recreate their parent history intact in one repo?

-- 
anatoly t.
