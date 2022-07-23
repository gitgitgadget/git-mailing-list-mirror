Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73304C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 00:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiGWAgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWAgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 20:36:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2ACAE46
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 17:36:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a9so4643069qtw.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 17:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qmnZQFLpEFsGfn0Novop3rzEE97cak8ZaQlt0wOzX2w=;
        b=SzWi36WTP0xJ/HNxoeEa/BILRecZywizdxKc8memAbcszRWWvx++oIQNfsy8X58PRo
         MKfkOjG+XNtGtqhSE97ifLl8Zp+O4Aa9mNPxiy6XVLNL7x8rBIZ5UDjS7iTijg/yabvF
         duraPjKaa+z8XUzwz2xERI38giyMmNcpL9orL2z0aAbs4yhKvKFjLdt5jHx9OUVxqdUe
         HJrkOXnNnJ5qUImoBB2CKZ9Dy0at4AbA55rjExozgMhzIcCQHrZg1rUWr8ZtvNIAAR4w
         QGkxj45Fvxbhs9kAcwtEiqyzHUdxpG08facj8/xY4p7YjJOmY91qm3RTCCpO/AAKAVT8
         sbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qmnZQFLpEFsGfn0Novop3rzEE97cak8ZaQlt0wOzX2w=;
        b=zltvIhKVhJkRDuAEeJwFA1B0mRvh9/W9qcGsYHl13Ul8VZHFi4tAhySr070ukg3e78
         +UqIqH8EzzRFuFsF+iHfWkF2MsGJedxNGEyAPgOZPswesnrAeg6e71rSoZ9YQ1hmdK3p
         BxPDMNLtDR9iO/ZBQzxYgFKvH0IKJI655XRuD7lyCGclTDeNi/xtNSo3v9T684bNtF7z
         DraZ82q26vu0T7u/GsNnx9pD1RyM1L8RFTkcf+EIEsH4jZNvp+qqQFazKe6iPo7pR014
         A4AhVC4FwLoRGT6J3y2LCwiWE5Gx63W65bk0KXNA1UeIK66W1+R9l2fS0B7MPoWutYhQ
         AYfw==
X-Gm-Message-State: AJIora/mD7cN3M0HtQTb4cc6IKZM7vEBqLJvTqDX2sQ1cFVIMXW+W98G
        dHAqjcY9HGeSdcR8AnBQSoWapMgzMyelUFwOo3c=
X-Google-Smtp-Source: AGRyM1sUMq/hg5pWHIUXf38fVA81yIb4+JeYeoS26Xu4C76eczSeP+ou45GVV7uTjxeklDtRMQ6Hl/mrjWmA9K4YtUo=
X-Received: by 2002:a05:622a:1391:b0:31e:f6b2:d3aa with SMTP id
 o17-20020a05622a139100b0031ef6b2d3aamr2304099qtk.523.1658536601333; Fri, 22
 Jul 2022 17:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com> <02930448ea1fbf7084b9d78813908b6355304457.1658466942.git.gitgitgadget@gmail.com>
 <220722.86o7xhs9qg.gmgdl@evledraar.gmail.com>
In-Reply-To: <220722.86o7xhs9qg.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jul 2022 17:36:30 -0700
Message-ID: <CABPp-BFeo2nxH38D1Cvd6RLRRt8PLOH+BLsoikchWv81rbvbFg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] merge: do not abort early if one strategy fails to
 handle the merge
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 3:49 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > builtin/merge is setup to allow multiple strategies to be specified,
> > and it will find the "best" result and use it.  This is defeated if
> > some of the merge strategies abort early when they cannot handle the
> > merge.  Fix the logic that calls recursive and ort to not do such an
> > early abort, but instead return "2" or "unhandled" so that the next
> > strategy can try to handle the merge.
> >
> > Coming up with a testcase for this is somewhat difficult, since
> > recursive and ort both handle nearly any two-headed merge (there is
> > a separate code path that checks for non-two-headed merges and
> > already returns "2" for them).  So use a somewhat synthetic testcase
> > of having the index not match HEAD before the merge starts, since all
> > merge strategies will abort for that.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/merge.c                          |  6 ++++--
> >  t/t6402-merge-rename.sh                  |  2 +-
> >  t/t6424-merge-unrelated-index-changes.sh | 16 ++++++++++++++++
> >  t/t6439-merge-co-error-msgs.sh           |  1 +
> >  4 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 13884b8e836..dec7375bf2a 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy=
, struct commit_list *common,
> >               else
> >                       clean =3D merge_recursive(&o, head, remoteheads->=
item,
> >                                               reversed, &result);
> > -             if (clean < 0)
> > -                     exit(128);
> > +             if (clean < 0) {
> > +                     rollback_lock_file(&lock);
> > +                     return 2;
> > +             }
> >               if (write_locked_index(&the_index, &lock,
> >                                      COMMIT_LOCK | SKIP_IF_UNCHANGED))
> >                       die(_("unable to write %s"), get_index_file());
> > diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> > index 3a32b1a45cf..772238e582c 100755
> > --- a/t/t6402-merge-rename.sh
> > +++ b/t/t6402-merge-rename.sh
> > @@ -210,7 +210,7 @@ test_expect_success 'updated working tree file shou=
ld prevent the merge' '
> >       echo >>M one line addition &&
> >       cat M >M.saved &&
> >       git update-index M &&
> > -     test_expect_code 128 git pull --no-rebase . yellow &&
> > +     test_expect_code 2 git pull --no-rebase . yellow &&
> >       test_cmp M M.saved &&
> >       rm -f M.saved
> >  '
> > diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-u=
nrelated-index-changes.sh
> > index f35d3182b86..8b749e19083 100755
> > --- a/t/t6424-merge-unrelated-index-changes.sh
> > +++ b/t/t6424-merge-unrelated-index-changes.sh
> > @@ -268,4 +268,20 @@ test_expect_success 'subtree' '
> >       test_path_is_missing .git/MERGE_HEAD
> >  '
> >
> > +test_expect_success 'resolve && recursive && ort' '
> > +     git reset --hard &&
> > +     git checkout B^0 &&
> > +
> > +     test_seq 0 10 >a &&
> > +     git add a &&
> > +
> > +     sane_unset GIT_TEST_MERGE_ALGORITHM &&
> > +     test_must_fail git merge -s resolve -s recursive -s ort C^0 >outp=
ut 2>&1 &&
> > +
> > +     grep "Trying merge strategy resolve..." output &&
> > +     grep "Trying merge strategy recursive..." output &&
> > +     grep "Trying merge strategy ort..." output &&
> > +     grep "No merge strategy handled the merge." output
> > +'

Oops, 'resolve' should really be at the end of the list rather than at
the beginning.  And the test description should be better.

> Ah, re my feedback on 2/7 I hadn't read ahead. This is the test I
> mentioned as failing with the code added in 2/7 if it's tweaked to be
> s/exit 2/exit 0/.
>
> So it's a bit odd to have code added in 2/7 that's tested in 3/7. I
> think this would be much easier to understand if these tests came before
> all these code changes, so then as the changes are made we can see how
> the behavior changes.

This testcase belongs in this patch.  The use of "resolve" here was
totally incidental to the testcase in question; I could have used
"octopus" or "ours" or created a new strategy and used it.

(Actually, using 'ours' here runs into the problem we fix in the final
patch.  So maybe just like 'resolve', using 'ours' might be confusing
to readers of the series as they think issues from other patches are
involved.)

> But short of that at least having the relevant part of this for 2/7 in
> that commit would be better, i.e. the thing that tests that new
> "diff-index" check in some way...

I'll switch this test to using 'octopus' instead of 'resolve' just so
it doesn't get confused in this way.
