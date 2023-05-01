Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF238C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjEARQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjEARNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:13:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D346D212C
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:13:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so4890892a12.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1682961200; x=1685553200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZb7Ko2uzM+SJRqk9esZf+0mvRi8QR4Q+70qiLdcAK8=;
        b=OyOKOGQkR5tRqwzIJGf92+HQ5NGERRVmlqR0Lo9K3Ai68rpZGLM3QwpHqr6hNAsSbS
         H/+N3DY0mMt/Zh4z1de6zHB2BDWa2+dFafylqy+hHrnmZPrPwB37hVC6L1OP6Gj0WtSR
         oW4nispmB6aGTBOOwra6fLOjglleUCXHQm8Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961200; x=1685553200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZb7Ko2uzM+SJRqk9esZf+0mvRi8QR4Q+70qiLdcAK8=;
        b=geHI7YehQpr447Nw8J40hlyjz6xEBhCroLmLsLlu4n3JOjcBripBugJEtQLZR8hpYJ
         Z3R8vfuoWEd6qhxUnAtChkWJeYcozKDZRLXrJH0DbovqMKAdKnnGXR/mf3L3NSA3x3+O
         ANEu/Gjdf48CnmJvonxs0t+FyGhOedI0PJ4S08aOQIwxOKVMm4jdvcS+KRlt4cmH/lG6
         uBQ0IKQxoKu4kB0T6oinlpU0vmBGtybJ5uWJLyMRiJE64o6yyLDWkAbfCMnMJBJdhtD/
         +UjLxCW9xrqnozPy90EGaMVoHtx5dbckRVUgiXMgHRl4gy3E41dnkLGZvLkvpKlsEej2
         yB3g==
X-Gm-Message-State: AC+VfDzC17Bowmvq7i9vlaC5w4sj0qHefpJMFtfF7TqV031tkytVJIzJ
        /u2JRIQxSyAMdsRqrtoq/mJPTRwWza9kgJ6rU+CQdA==
X-Google-Smtp-Source: ACHHUZ576tJ4WX0+Fq73TZ/+psFSfeqDslDmkM9IZRdnkex6Z+Jop0CNsTqKe0Plpf0MqCJ03z6j9nfHXvPm3X/aOqM=
X-Received: by 2002:a05:6402:34f:b0:50b:c689:8610 with SMTP id
 r15-20020a056402034f00b0050bc6898610mr2662773edw.18.1682961199683; Mon, 01
 May 2023 10:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohyoaH92B9f46hwdX2S5WOYeRB2yMSKW-4UCrHe29SAZQ@mail.gmail.com>
 <xmqqpm7k6ojz.fsf@gitster.g>
In-Reply-To: <xmqqpm7k6ojz.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 1 May 2023 19:13:08 +0200
Message-ID: <CAPMMpoht4FWnv-WuSM3+Z2R4HhwFY+pahJ6zirFU-BD5r34B7Q@mail.gmail.com>
Subject: Re: Change branch in the middle of a merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2023 at 5:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > At first I hoped that "git switch" might have fixed this - and in a
> > limited sense it has, in that instead of *silently discarding* the
> > merge state/metadata, it refuses with "fatal: cannot switch branch
> > while merging".
>
> I think this is in generally seen as a vast improvement over the
> "silently discarding" to have the safety valve.
>

Heh, that's fair - my apologies for the "ungrateful" tone.

>
> I think this is mostly that nobody spent enough brain cycles to
> ponder on things like:

(I'm not sure I *have* enough brain cycles, or background knowledge,
to be sure of these things, but I have some tentative answers)

>
>  - Is it always safe to switch from a merge in progress to a newly
>    created branch that point at the same commit as HEAD?  Why?  Is
>    the story the same if the switched-to branch is an existing one
>    that happens to point at the same commit as HEAD?

To the best of my knowledge, the only role that the HEAD *ref* plays
in any of merge processing (before or after resolution), if there even
is one, is its use in the commit message.

My proposal is that keeping the original prepared merge message, but
warning about its use, makes more sense / is more straightforward than
anything else we might choose to do here, like re-generating the
message.

With respect to the safety of index operations - when conflicts have
been resolved already the index is in a "normal" state, same as a
non-merge checkout with changes, so there is no reason to believe
there would be any "unsafeness" to worry about?

>
>  - Maybe the answer to the above question is not "it is not quite
>    safe to switch during a conflicted merge, but by adjusting X and
>    Y while switching to a new branch, we could make it safe".

The sense in which it is potentially *not* safe, is that some part of
checkout may mess with the index in some way that does not expect to
encounter conflicts - given that conflicts explicitly prevent not only
a "git switch", but also a "git checkout", at this time (due to a
check for unmerged paths in builtin/checkout.c#merge_working_tree()).

As such, the "simple answer" is to address the case where conflicts
are already resolved, and defer the case of open conflicts to someone
who is better able to check or enable the safety of a switch in this
state.

I believe the urgency/criticality of opening up a "switch while you
still have unmerged paths" usecase is much lower than the
simpler-to-prove "switch before committing an already-resolved index"
usecase.

>
>  - Even if the answer to the question above is "yes it is always
>    safe", if it is not safe for a similar situation that ends up in
>    unmerged index (i.e. the index with any path at non-0 stage), the
>    way we determine if we are in "a merge in progress" situation
>    must be reliable.  Is it?

I'm not sure what "a path at 0 stage" means, but I do get the
*impression* that the conflict checks that are in place in
builtin/checkout.c#merge_working_tree() look reasonable...? That said,
I do not intend to modify or circumvent these checks, because I don't
think the user flow / use case requires it.

>
>  - Conversely, perhaps it is also safe to switch to a different
>    branch that points at the same commit as HEAD from the conflicted
>    state after some (but not necessarily all) of the following
>    operations: "am -3", "cherry-pick" (single commit), "revert"
>    (single commit), etc.  Can we come up with a reliable way to
>    determine if we are in such a situation?

I suspect it is, but I also suspect this is a far less common case,
and as such one I'm less inclined to worry about. In merge-based
workflows, merges can be *large*, and the case where you have a merge
ready, conflicts resolved, and you realize you'd like to test it on
another branch, is more common and impactful, than when you have some
(far more typically limited in scope) stash or cherry-pick...?

(Or maybe I'm just making excuses for the patch I want to submit :) )

My proposal at least is to carve out an exception, for now, only for
merges, and only with a clean (not-conflicted) index.

>
>  - These "other mergy operations" that can leave unmerged index may
>    share the same "is not safe out of the box, but can be made safe
>    by adjusting some stuff".
>
> After that is done, we could update the codepath in "git switch"
> that says "ah, your index is unmerged, so I will not let you switch"
> to instead say "your index is unmerged; let's first see if you are
> switching to the same commit as HEAD and then the way your index is
> unmerged was caused by an operation that we decided is safe to
> switch out of.  It seems to be one of the situations that could be
> made safe, so let's do adjustment X and Y and let you switch".

This is what I am proposing, but no adjustment needed if the scope is
a merge only and the index is already unconflicted.

>
> And the reason why "git switch" punts is because nobody bothered to,
> not because there fundamentally is some reason why it shouldn't work.

Yep, that makes sense.
