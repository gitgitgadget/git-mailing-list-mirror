Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4575C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 00:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5A961056
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 00:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhIAAFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbhIAAEP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 20:04:15 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C2C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 17:03:19 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so299209ood.6
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiuAFnmT6Vkkh7FFTVOaYDYr+1vgME+CXziDNDavgx0=;
        b=mer8Z1ltQXn4o+oL82hyOibS+3MGzz8/YyWWQL1KSPS45jL0nQzmqZv2jr3T8woBAR
         KO1Iw87f0ZJwmLX7AMagEODohgcseocl7Lv1g7Y+4lYEzkaOryOdvZzsQOo3i7Es/gIn
         d6F2v1I5vWdEg3+CCwjJoqBq7tNMSx/mb+yzsztvip1XJyQJYj7A1zvlCv1JjdGLL5n0
         7TvMb41xenHTkPHlC6NtW2Jpsuaqe7YMNcLexYFaHX2ZNp38SL2WQ2d/vo44x+XUveoC
         l1TZQOS1nV8ChKMKS25OtJndM0k6r6DUSCo85eB83yFZXAABC5pKzzG7ERbBjBoYCe+n
         rRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiuAFnmT6Vkkh7FFTVOaYDYr+1vgME+CXziDNDavgx0=;
        b=eN2/GLtiekfrtshTOvq3abHMxUsF9hEznOkN1BgWLCIfUbueJ7zBB4tjQB87KHpkih
         HbbkrY12QZRms00lWxNurmRbe7n9KpelI1KmSRRBCNbEAC8B4JIn0p/njy8G+KLG8L/B
         q4dPa9+wGemadjHMd0VGi9rn+wTWVgvWnmnDluTKNnCTg7jgNKUR4Lp4xp0pkaAj4Ugo
         I5XrrUOvxgWriuPG3NjILCjwx5/cWpYwUeU8K15ly4/vcqszbougPSUO1Qkjki6X9Es3
         niu7c5C90BVJRAvPVxDwbgaEzfvz3aYSahTE9e6uIawccqCMKEzlZYW+UD28XotYADpe
         LRmw==
X-Gm-Message-State: AOAM531w6XuQvcbp+E5CcPbNoqQHtUhXz9dBCBsSrYhrfid/tAh4m0lC
        syUefyK9LGPU3ABr613d2eqrYvQHLDomt/3KbFU=
X-Google-Smtp-Source: ABdhPJwvyXpvcMCH7ax47yIDtcHxSqzvGfLloap/pmcWg0qqIP0Job12YdECX/ok9lh49osEJ78upkefPXvmafAekXI=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr16380477ooe.45.1630454598958;
 Tue, 31 Aug 2021 17:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <df6e2774f1a5560a598dd8b46131bc6b0a261d4a.1630376800.git.gitgitgadget@gmail.com>
 <xmqqzgsxs4rk.fsf@gitster.g>
In-Reply-To: <xmqqzgsxs4rk.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 17:03:07 -0700
Message-ID: <CABPp-BEZjMLGFxSsTfRnAffom9CKRU4if4PsdTh+85L6D=FseA@mail.gmail.com>
Subject: Re: [PATCH 1/7] merge-ort: mark a few more conflict messages as omittable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > path_msg() has the ability to mark messages as omittable when recording
> > conflict messages in an in-tree file.  This conflict message file will
> > then be shown by diffing the merge-created tree to the actual merge
> > commit that is created.  While all the messages touched in this commit
> > are very useful when trying to create a merge initially, early use with
> > the --remerge-diff feature (the only user of this omittable conflict
> > message capability), suggests that the particular messages marked in
> > this commit are just noise when trying to see what changes users made to
> > create a merge commit.  Mark them as omittable.
>
> Sorry for asking something that may be obvious

No, it's not obvious.  I had a hard time figuring out the right way to
split up this series and order the patches in part because so many
little pieces are needed before I can show the solution.  So some of
this comes from the later patches, but let me see if I can motivate
the issue and solution I picked a bit more right here.

> but if you recreate
> an automated and potentially conflicting merge in-core, in order to
> then compare the recorded merge result, is there *any* message that
> is worth showing while doing the first step,

Yes, absolutely.  While three-way *content* conflicts are easily
representable within a file in the working tree using conflict
markers, *non-content* conflicts are usually not easily representable
in such a fashion.  For example, a rename/delete conflict will not
result in any conflict markers, and will result in the renamed version
of the file being left in the working tree; the only way you know
there is a conflict for that file is either because of the stage in
the index or the the message that is printed to the terminal:

    CONFLICT (rename/delete): %s renamed to %s in %s, but deleted in %s.

But relying on higher order stages in the index and messages printed
to the terminal present a bit of a problem for --remerge-diff; as
described, it ignores both those sources of input.  Here's a few other
conflict types that face similar issues:

  * modify/delete conflicts
  * failure to merge submodule
  * directory rename detection (i.e. new file added to old directory
that other side renamed; which directory should file end up in?)
  * distinct types of files (e.g. regular file and symlink) located at
the same path
  * rename/rename conflicts

In all these cases (and some others), relying on a diff of "what the
working directory looks like at the end of a merge" to "the tree
recorded in the merge commit" does not convey enough (if any)
information about the above types of conflicts.

> and where in the output do users see them?

For --remerge-diff, I chose to handle the fact that the working
directory didn't naturally have enough information, by augmenting the
working directory with additional information.  So, for example, if
there was a file named `dir/my.file` that had a modify/delete conflict
(and the user who did the real merge edited that file a bit as part of
conflict resolution), then I would also add a `dir/my.fil
e.conflict_msg` file whose contents are

"""
== Conflict notices for my.file ==
CONFLICT (modify/delete): dir/my.file deleted in HASH1 (SHORT
SUMMARY1) and modified in HASH2 (SHORT SUMMARY 2).  Version HASH2
(SHORT SUMMARY2) of  dir/my.file left in tree.
"""

Creating this file means you see something like this in the
remerge-diff (note there are diffs for two files, with the synthetic
file appearing just before the file it has messages about):

diff --git a/dir/my.fil e.conflict_msg b/dir/my.fil e.conflict_msg
deleted file mode 100644
index 2bd215a32f06..000000000000
--- a/dir/my.fil e.conflict_msg
+++ /dev/null
@@ -1,2 +0,0 @@
-== Conflict notices for my.file ==
-CONFLICT (modify/delete): dir/my.file deleted in HASH1 (SHORT
SUMMARY1) and modified in HASH2 (SHORT SUMMARY 2).  Version HASH2
(SHORT SUMMARY2) of  dir/my.file left in tree.
diff --git a/dir/my.file b/dir/my.file
index 09c78c725a3b..79f9d1fb7611 100644
--- a/dir/my.file
+++ b/dir/my.file
@@ -950,15 +912,15 @@ int my_func(struct stuff *data,
                                        rq->timeline,
                                        rq);

-               old_func(data, 1);
+               new_func("for funsies", data, VALID);
                obj->value = 8;
                obj->read_attempts = 0;
        } else {
-               err = old_func(data, 0);
+               err = new_func("for funsies", data, INVALID);
                if (unlikely(err))
                        return err;

-               another_old_func(data, obj->value);
+               another_new_func(data, obj->value, INVALID);
                obj->value++;
        }
        obj->read_attempts += 1;


The `dir/my.fil e.conflict_msg` file is definitely slightly weird, but
any solution here would be.  I think it's fairly intuitive what is
meant.  No one has commented on this choice in the 9+ months it's been
in use internally by ~50 users (even with -p implying --remerge-diff
automatically to make it more likely people have used this option), so
either it really is intuitive, or it doesn't come up much.  It could
well be the latter.
