Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B00E81E1D
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJFRHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjJFRHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:07:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA277DB
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:07:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c16bc71e4cso28012431fa.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696612070; x=1697216870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OfwJP1heeLGPmcfT7bmyMzzKsbHnvgmUAQAEjjKA4XA=;
        b=HcX7M5Xi4IvqLBNS3bhq1EOjx84yDc7d0W9vxuS5f6t8Gj/myzi4vcr+Pb1CPMEIV+
         YtQJ0dX7jc+QmSFEs1p+14tabq1Fmv//VaaAGQ+8JFqX/P8Sp1HeITBQeptuOlXBzyUZ
         jbF3P1QYlBTyA9PgktddptXWwCsoPz6pbZLDl1dTO8l0B2iBgSVlFmnEw91PCYsfm19u
         rdUogejYz+XPh19pJmL9ppzohZuqUxuVI7+mILk9ABXylJu7xDpc+v989Yt5noGO5a7Q
         aAOEXC82cpb+/DFOzriW5wiG9N77OMEuO3vkEvej2rDJa8c/GgQiyzpYgHZmkaGvHDa9
         vXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612070; x=1697216870;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfwJP1heeLGPmcfT7bmyMzzKsbHnvgmUAQAEjjKA4XA=;
        b=rCDaz5qgBdVsk196jcRCpmopXbvDtH+yeTG0xJ8QX1IOldotbR/UdXxxdjr/fX7acH
         /OYE7Dp3pp4g3zuy1k594yEIOVMgw45NMdwuZXP8evtMe8DYcatxdMF1+IvJ2/YhowL0
         yuerWVlYw6xQf4JcUuouMNIwZcvbbH7n+a5wWY8onL1tLLJpmRPmGmqUlb6/yngY+hUA
         Wg1d/s9XomoYUL8HHvnun0+WZXtVoGOY4d7dcwB52lCAX+FIc5G6W2f7Eq8+hYRLU+1e
         An+z34zDpdjITFZghPHd/wtoYgOu2f1/ingnAlfCz5vRIc5ogfFRoqFJ2xpYgC6Xk98s
         Bqzg==
X-Gm-Message-State: AOJu0YxQT7xAwOEXw3lzYeYABAPD8qSxSwbPsaAiNEWe7/+2ZBi/eHIv
        60o06IKTaKaoanTIdNAr+GGjXWYxHao=
X-Google-Smtp-Source: AGHT+IFzYCCFbQKdv2bqjXsBJ/cVBY8T2fI16uuOjBukcq9e15q8pnR6Z4J3fjOyjf9LlLIFMRrKsA==
X-Received: by 2002:a2e:8310:0:b0:2c0:a99:68e7 with SMTP id a16-20020a2e8310000000b002c00a9968e7mr7916058ljh.19.1696612069462;
        Fri, 06 Oct 2023 10:07:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u15-20020a2ea16f000000b002b97fe43238sm862279ljl.19.2023.10.06.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:07:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
Date:   Fri, 06 Oct 2023 20:07:48 +0300
In-Reply-To: <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 6 Oct 2023 07:41:51 -0700")
Message-ID: <87r0m7r863.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> On Thu, Oct 5, 2023 at 2:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Sergey Organov <sorganov@gmail.com> writes:
>> > +--remerge-diff::
>> > +     Produce diff against re-merge.
>> > +     Shortcut for '--diff-merges=remerge -p'.
>>
>> I suspect that many people do not get what "re-merge" in "against
>> re-merge" really is.  As "combined diff" and "dense combined diff"
>> are not explained in the previous two entries either, and expect the
>> readers to read the real description (which more or less matches
>> what the original description for "-c" and "--cc" had, which is
>> good), it would be better to say "Produce remerge-diff output for
>> merge commits."  here, too.  It makes it consistent, and "for merge
>> commits" makes it clear the "magic" does not apply to regular
>> commits (which the above entries for "-c" and "--cc" do, which is
>> very good).
>
> Perhaps:
>
> Produce remerge-diff output for merge commits, in order to show how
> conflicts were resolved.

Will use this description in re-roll.

>
>> > +separate::
>> > +     Show full diff with respect to each of parents.
>> > +     Separate log entry and diff is generated for each parent.
>>
>> In the early days of Git before -c/--cc were invented, we explained
>> this mode as "pairwise comparison", and the phrase "pairwise" still
>> may be the best one to describe the behaviour here.  In fact, we see
>> in the updated description of combined below the exact phrase is used
>> to refer to this oldest output format.
>>
>>     Show the `--patch` output pairwise, together with the commit
>>     header, repeated for each parent for a merge commit.
>
> I like this.
>
>> or something, perhaps.  I added "repeated" here to make the contrast
>> with "simultaneously" stand out.

Please let's left it for some follow-up, as this patch does not rephrase
original, just changes the presentation.

>>
>> > +combined, c::
>> > +     Show differences from each of the parents to the merge
>> > +     result simultaneously instead of showing pairwise diff between
>> > +     a parent and the result one at a time. Furthermore, it lists
>> > +     only files which were modified from all parents.
>> > ++
>> > +dense-combined, cc::
>> > +     Further compress output produced by `--diff-merges=combined`
>> > +     by omitting uninteresting hunks whose contents in the parents
>> > +     have only two variants and the merge result picks one of them
>> > +     without modification.
>> > ++
>> > +remerge, r::
>> > +     Remerge two-parent merge commits to create a temporary tree
>> > +     object--potentially containing files with conflict markers
>> > +     and such.  A diff is then shown between that temporary tree
>> > +     and the actual merge commit.
>>
>> The original says "two-parent merge comimts are remerged" so it is
>> not a failure of this patch, but the first verb "Remerge" sounds
>> unnecessarily unfriendly to the readers.
>>
>>         For a two-parent merge commit, a merge of these two commits
>>         is retried to create a temporary tree object, potentially
>>         containing files with conflict markers.  A `--patch` output
>>         then is shown between ...
>>
>> would be easier to follow and more faithful to the original
>> description added by db757e8b (show, log: provide a --remerge-diff
>> capability, 2022-02-02).
>
> I like it.  Perhaps it may also benefit from explaining why this mode
> is useful as well:
>
>     For a two-parent merge commit, a merge of these two commits is
>     retried to create a temporary tree object, potentially containing
>     files with conflict markers.  A diff is then shown between that
>     temporary tree and the actual merge commit.  This has the effect
>     of showing whether and how both semantic and textual conflicts
>     were resolved by the user (i.e. what changes the user made after
>     running 'git merge' and before finally committing).
>
>> Either way, it makes readers wonder what happens to merges with more
>> than 2 parents (octopus merges).  It is not a new problem and this
>> topic should not attempt to fix it.
>
> We could add:
>
>     For octopus merges (merges with more than two parents), currently
> only shows a warning about skipping such commits.
>
> if wanted.
>
> But perhaps I've distracted too much from Sergey's topic, and I should
> submit these wording tweaks as a patch on top?  I'm fine either way.
>
>> [Footnote]
>>
>> * When a project allows fast-forward merges, something like this can
>>   happen (and Git was _designed_ to allow and even encourage it)
>>
>>   - Linus pulls from Sergey and sees merge conflicts that are very
>>     messy.  Sergey is asked to resolve the conflict, as Linus knows
>>     Sergey understands the changes he is asking Linus to pull much
>>     better than Linus does.
>>
>>   - Sergey does "git pull origin" that would give the same set of
>>     conflicts Linus saw, perhaps ours/theirs sides swapped, resolves
>>     the conflicts, and comits the merge result.  He may even add a
>>     few other improvements on top (or may not).  He tells Linus that
>>     his tree is ready to be pulled again.
>>
>>   - Linus pulls from Sergey again.  This time it is fast-forward,
>>     without an extra merge commit that records the Linus's previous
>>     tip as the first parent and Sergey's work as the second parent.
>>
>>   - Linus continues working from here.
>>
>>   In such a workflow, merges are nothing more than "combining
>>   multiple histories together" and the first parenthood is NOT
>>   inherently special among parents at all.  The original "-m -p"
>>   (aka "pairwise diff") output reflects this world view and ensures
>>   that all parents are shown more or less as equals (yes, the first
>>   parent diff is shown first before the other parents, but you
>>   cannot avoid it when outputting to a single dimension medium).
>>
>>   This world view was the only world view Git supported, until I
>>   added the "--first-parent" traversal in 0053e902 (git-log
>>   --first-parent: show only the first parent log, 2007-03-13).
>>
>>   With the "--first-parent", with "--no-ff" option to "git merge", a
>>   different world view becomes possible.  A merge is not merely
>>   combining multiple histories, which are equals.  It is bringing
>>   work done on a side branch into the trunk.  To see the overview of
>>   the history, "git log --first-parent" would give the outline,
>>   which would be full of merges from side branches, each of which
>>   can be seen as summarizing the work done on the side branch that
>>   was merged, and it may occasionally have single-parent commits
>>   that are hotfixes or trivial clean-ups or project administrivia
>>   commits.  With "-p", "git log" would show the changes the work
>>   done on a side branch as a single unit for a merge, and individual
>>   commits if they are single-parent.  The life is good.
>>
>>   It all breaks down if the "diff against the first parent" is done
>>   on a merge that is not bringing the work on a side branch in to
>>   the trunk.  The merge done in the second step Sergey did for Linus
>>   in the above example will have his work on the history leading to
>>   its first parent, and from the overall project's point of view,
>>   the second parent is the tip of the history of the trunk.  Showing
>>   first-parent diff for a merge that was *not* discovered via the
>>   first-parent traversal would show such a meaningless patch.  This
>>   is an illustration of the fallout from mixing two incompatible
>>   world views together, "--diff-merges=first-parent" wants to work
>>   in a world where the first-parent is special among parents, but
>>   traversal without "--first-parent" wants to treat all the branches
>>   equally.
>>
>>   All the other <format>s accepted by the "--diff-merges=<format>"
>>   option are symmetrical and they work equally well when in a
>>   history of a project that considers the first-parenthood special
>>   (i.e. work on a side branch is brought into the trunk history) or
>>   in a history with merges whose parent order should not matter, so
>>   unlike "--diff-merges=first-parent", it makes sense to apply them
>>   with or without first-parent traversal.  It however is not true
>>   for the "--diff-merges=first-parent" variant, which is asymmetric.
>>
>>   And that is why I think use of "--diff-merges=first-parent"
>>   without "--first-parent" traversal is a bad thing to teach users
>>   to use.
>
> Thanks for writing this up.  In the past, I didn't know how to put
> into words why I didn't particularly care for this mode.  You explain
> it rather well.
