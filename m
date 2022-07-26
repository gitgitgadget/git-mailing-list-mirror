Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE2C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 07:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiGZHDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiGZHDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 03:03:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68E28E2E
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 00:03:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j22so24513763ejs.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WsbNQEEB9Qt/eiHRMA+QMwPATp/0EF7WN7ZR2CDJYiA=;
        b=XKwzLpVJd85CYaFHXfVb0li6Pf2tyHi9nkBz3iFvEYJtUbHNg9ohenrxNDPofbSbdR
         vjevSRLtxnfLWZVtKcHsZlG8zAD77hJ6y4IugV3gRu9h5NrWb1TWE5379CpVSxQmSldK
         WyYUGbUcaXjDsF4zlmwwauMevu/heAYMAanmHk5/ML3xesvE6QskzNsHUGufKFa61tMS
         uMmu9nyPK6AYlj8Zl1czSBUWq59HWKB/SyASGOo7bKOhqNhvzebEeWHfQg3nXc8V0dfA
         7eLYMeEPTyN9XZUIzO2bUwQzbf7BDa9kjI2HTV9X8kZdxkk0XXR8RNpfssllkA3G8HGJ
         FaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WsbNQEEB9Qt/eiHRMA+QMwPATp/0EF7WN7ZR2CDJYiA=;
        b=q4kptTSs7qrF41auL9Jw2kFCkzYH6LaZIf0gO43MVs+n79ulNi7tgUINMkuB56UcLw
         x0xcLpoPBjdn1yXm5s+kM5b8tXlt8M3i+kL8mjc1Zq1lwcBucalqUITnUaWPkmeM7HxU
         X6Lry+V1+4KaO9+QPq129SkNFI/gc94ELlg8Hq/elbTTsS8GVMRCvy3yuzSMsuOvSWUM
         vefoFHiJtuXtZT+D7WNjr2xQw9zhtZa/VBzMba1Nu0VE91UbYHA1+8sZ6vsmQVbNAg3K
         3yUJ8yEE15dGkH4pIuwJ06Jfu1GKnjS4HfTLCYrWdGEz2NPqr2nzK8sSdDBx3UY/D/OZ
         XNMg==
X-Gm-Message-State: AJIora8QMjCbxqakovBz6HIWeXAc/2Yxk6eIdPtIyjNfxkj+KxDwwrpn
        a54r3JgkUAACDvgTIltZGrB6bue/ZxY=
X-Google-Smtp-Source: AGRyM1vD/gBseRSrFO99JleNtNfbQFUj/Bn/flnwdW22zzmcaCwEmO/nZKv0s1Uny8qrj26AYhjzKw==
X-Received: by 2002:a17:907:2c78:b0:72b:64f5:11ea with SMTP id ib24-20020a1709072c7800b0072b64f511eamr13186641ejc.68.1658819027697;
        Tue, 26 Jul 2022 00:03:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id en21-20020a17090728d500b0072b342ad997sm6171560ejc.199.2022.07.26.00.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 00:03:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGEba-005xbU-2o;
        Tue, 26 Jul 2022 09:03:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/7] merge: do not abort early if one strategy fails
 to handle the merge
Date:   Tue, 26 Jul 2022 08:54:29 +0200
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <b41853e3f9908ab458bcb28684d817677e32367b.1658391391.git.gitgitgadget@gmail.com>
 <220725.864jz5qwms.gmgdl@evledraar.gmail.com>
 <CABPp-BFVZy+TtYtaKe1d25Ua3HSMrQpzkUDgfnzQvo8xzpD-3g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BFVZy+TtYtaKe1d25Ua3HSMrQpzkUDgfnzQvo8xzpD-3g@mail.gmail.com>
Message-ID: <220726.86fsionynh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, Elijah Newren wrote:

> On Mon, Jul 25, 2022 at 4:06 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
> [...]
>>
>> I'm re-rolling ab/leak-check, and came up with the below (at the very
>> end) to "fix" a report in builtin/merge.c, reading your commit message
>> your fix seems obviously better.
>>
>> Mine's early WIP, and I e.g. didn't notice that I forgot to unlock the
>> &lock file, which is correct.
>>
>> I *could* say "that's not my problem", i.e. we didn't unlock it before
>> (we rely on atexit). The truth is I just missed it, but having said that
>> it *is* true that we could do without it, or do it as a separate chaneg.
>>
>> I'm just posting my version below to help move yours forward, i.e. to
>> show that someone else has carefully at least this part.
>
> "has carefully ... at least this part" ?
>
> I think you have a missing verb there.

"reviewed", sorry.

>> But it is worth noting from staring at the two that your version is
>> mixing several different behavior changes into one, which *could* be
>> split up (but whether you think that's worth it I leave to you).
>>
>> Maybe I'm the only one initially confused by it, and that's probably
>> just from being mentally biased towards my own "solution". Those are (at
>> least):
>>
>>  1. Before we didn't explicitly unlock() before exit(), but had atexit()
>>     do it, that could be a one-line first commit. This change is
>>     obviously good.
>
> That'd be fine.  (Though at this point, I'd rather not mess with the
> series more.)

That's completely fine, to be clear(er) what I'm walking through here is
my review process & potential edge cases I discovered, but I think your
patch as-is does it all correctly.

>>  2. A commit like mine could come next, i.e. we bug-for-bug do what we
>>     do do now, but just run the "post-builtin" logic when we return from
>>     cmd_merge().
>>
>>     Doing it as an in-between would be some churn, as we'll need to get
>>     rid of "early_exit" again, but would allow us to incrementally move
>>     forward to...
>
> So, add a step that makes it glaringly obvious that the code is not
> only buggy but totally at odds with itself?
>
> builtin/merge.c was designed to allow pluggable backends and to
> automatically pick the "best" one if more than one is specified.  We
> had a bug in one line of code that defeated the design, by making it
> not bother consulting beyond the first failed backend in some cases.
> That's the bug I'm trying to address.  Your patch would make the
> inconsistency with the design both bigger and more obvious; I don't
> see how it's a useful step to take.
>
> Now, the existing design might be questionable.  In fact, I'm not sure
> I like it.  But I think we should either change the design, or fix
> things in a way that improves towards the existing design.

Yes, I don't think it's useful, sorry about the confusion. I was walking
through what the observable changes from the outside are here, and how
they *might* be split up.

Not as a practical suggestion, but as a way to understand your commit...

>>  3. ...then we'd say "but it actually makes sense not to early abort",
>>      i.e. you want to change this so that we'll run the logic between
>>      try_merge_strategy() exiting with 128 now and the return from
>>      cmd_merge().
>>
>>      This bit is my main sticking point in reviewing your change,
>>      i.e. your "a testcase for this is somewhat difficult" somewhat
>>      addresses this, but (and maybe I'm wrong) it seems to me that
>>
>>      Editing that code the post-image looks like this, with my
>>      commentary & most of the code removed, i.e. just focusing on the
>>      branches we do and don't potentially have tests for:
>>
>>                 /* Before this we fall through from ret =3D=3D 128 (or r=
et =3D=3D 2...) */
>>                 if (automerge_was_ok) { // not tested?
>>                 if (!best_strategy) {
>>                         // we test this...
>>                         if (use_strategies_nr > 1)
>>                                 // And this: _("No merge strategy handle=
d the merge.\n"));
>>                         else
>>                                 // And this: _("Merge with strategy %s f=
ailed.\n"),
>>                 } else if (best_strategy =3D=3D wt_strategy)
>>                         // but not this?
>>                 else
>>                         // Or this, where we e.g. say "Rewinding the tre=
e to pristene..."?
>>
>>                 if (squash) {
>>                         // this?
>>                 } else
>>                         // this? (probably, yes)
>>                         write_merge_state(remoteheads);
>>
>>                 if (merge_was_ok)
>>                         // this? (probably, yes, we just don't grep it?)
>>                 else
>>                         // this? maybe yes because it's covered by the
>>                         // "failed" above too?
>>                         ret =3D suggest_conflicts();
>>
>>         done:
>>                 if (!automerge_was_ok) {
>>                         // this? ditto the first "not tested?"
>>                 }
>>
>>    I.e. are you confident that we want to continue now in these various
>>    cases, where we have squash, !automerge_was_ok etc. I think it would
>>    be really useful to comment on (perhaps by amending the above
>>    pseudocode) what test cases we're not testing / test already etc.
>
> To be honest, I'm confused by what looks like a make-work project.
> Perhaps if I understood your frame of reference better, maybe they
> wouldn't bother me, but there's a few things here that seem a little
> funny to me.
>
> You've highlighted that you are worried about the case where ret is 2
> (or 128) at the point of all these branches in question.  However,
> three of those branches can almost trivially be deduced to never be
> taken unless ret is 0.  One of the other codepaths, for freeing
> memory, is correct regardless of the value of ret -- the memory is
> conditionally freed earlier and the "if"-check exists only to avoid a
> double free (and checking the recent commit message where those lines
> were added would explain this, though I'm not sure why it'd even need
> explaining separately for e.g. ret =3D=3D 2 compared to any other value).
> Three of the other code paths involve nothing more than print
> statements.  Now, there are many codepaths you highlighted, and
> perhaps there are some where it's not trivial to determine whether
> they are okay in combination with a different return value.  And it
> may also be easy to miss some of the "almost trivial" cases.  I'd
> understand better if you asked about the tougher ones or only some of
> the easier ones, but it feels like you didn't try to check any of them
> and instead wanted me to just spend time commenting on every single
> code branch?
>
> I hope that doesn't come across harshly.  I'm just struggling to
> understand where the detailed request is coming from.
>
> However, perhaps I can obviate the whole set of requests by just
> pointing out that I don't think any of them are relevant.  The premise
> for the audit request seems to be that you are worrying that the
> change from die() to "return 2" (or 128) in try_merge_strategy() will
> result in the calling code getting into a state it has never
> experienced before which might uncover latent bugs.  We can trivially
> point out that it's not a new state, though: such return values were
> already possible from try_merge_strategy() via the final line of code
> in the function -- namely, the "return try_merge_command(...)" code
> path.  And a return value of 2 from try_merge_command() and
> try_merge_strategy() isn't merely theoretical either -- you can easily
> trigger it multiple ways; the easiest is perhaps by passing `-s
> octopus` when doing a non-octopus merge.  (You can also make the
> testcase more complex by combining that with as many other additional
> merge strategies as you want, e.g. "git merge -s octopus -s resolve -s
> recursive -s mySpecialStrategy $BRANCH".  You can also move the
> octopus to the end if you want to test what happens if it is tried
> last.  Lots of possibilities exist).

Thanks, that all makes sense & addresses any questions I had, which were
just if we were sure that this behavior was expected.

>>  4. Having done all that (or maybe this can't be split up / needs to
>>     come earlier) you say that we'd like to not generically call this
>>     exit state 128, but have it under the "exit(2)" umbrella.
>
> I don't see how reading your set of steps 1-4 logically restores the
> design of builtin/merge.c, though.  An example: what if the user ran
> "git merge -s resolve -s recursive $BRANCH", and `resolve` handled the
> merge but had some conflicts, while `recursive` just failed and
> returned a value of clean < 0?  In such a case, builtin/merge.c is
> supposed to restore the tree to pristine after attempting the
> recursive backend, and then redo using the best_strategy (which would
> be `resolve` in this example case).  Your steps 1-4 never address such
> a thing.  Your steps might incidentally address such a case as a side
> effect of their implementation, but that's not at all clear.  Since
> the whole point is fixing the code to match the existing design, it
> seems really odd to split things into a set of steps that obscures
> that fix.

You know more about the wider context here, I was just poking at the
narrow code change & seeing what the side-effects were of the changes
being made.

>> Again, all just food for thought, and a way to step-by-step go through
>> how I came about reviewing this in detail, I hope it and the below
>> version I came up with before seeing yours helps.
>>
>> P.s.: The last paragraph in my commit message does not point to some
>> hidden edge case in the code behavior here, it's just that clang/gcc are
>> funny about exit() and die() control flow when combined with
>> -fsanitize=3Daddress and higher optimization levels.
>>
>> -- >8 --
>> Subject: [PATCH] merge: return, don't use exit()
>>
>> Change some of the builtin/merge.c code added in f241ff0d0a9 (prepare
>> the builtins for a libified merge_recursive(), 2016-07-26) to ferry up
>> an "early return" state, rather than having try_merge_strategy() call
>> exit() itself.
>>
>> This is a follow-up to dda31145d79 (Merge branch
>> 'ab/usage-die-message' into gc/branch-recurse-submodules-fix,
>> 2022-03-31).
>>
>> The only behavior change here is that we'll now properly catch other
>> issues on our way out, see e.g. [1] and the interaction with /dev/full
>> for an example.
>>
>> The immediate reason to do this change is because it's one of the
>> cases where clang and gcc's SANITIZE=3Dleak behavior differs. Under
>> clang we don't detect that "t/t6415-merge-dir-to-symlink.sh" triggers
>> a leak, but gcc spots it.
>>
>> 1. https://lore.kernel.org/git/87im2n3gje.fsf@evledraar.gmail.com/
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/merge.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 23170f2d2a6..a8d5d04f622 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -709,10 +709,12 @@ static void write_tree_trivial(struct object_id *o=
id)
>>
>>  static int try_merge_strategy(const char *strategy, struct commit_list =
*common,
>>                               struct commit_list *remoteheads,
>> -                             struct commit *head)
>> +                             struct commit *head, int *early_exit)
>>  {
>>         const char *head_arg =3D "HEAD";
>>
>> +       *early_exit =3D 0;
>> +
>>         if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0)=
 < 0)
>>                 return error(_("Unable to write index."));
>>
>> @@ -754,8 +756,10 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
>>                 else
>>                         clean =3D merge_recursive(&o, head, remoteheads-=
>item,
>>                                                 reversed, &result);
>> -               if (clean < 0)
>> -                       exit(128);
>> +               if (clean < 0) {
>> +                       *early_exit =3D 1;
>> +                       return 128;
>> +               }
>>                 if (write_locked_index(&the_index, &lock,
>>                                        COMMIT_LOCK | SKIP_IF_UNCHANGED))
>>                         die(_("unable to write %s"), get_index_file());
>> @@ -1665,6 +1669,8 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
>>
>>         for (i =3D 0; !merge_was_ok && i < use_strategies_nr; i++) {
>>                 int ret, cnt;
>> +               int early_exit;
>> +
>>                 if (i) {
>>                         printf(_("Rewinding the tree to pristine...\n"));
>>                         restore_state(&head_commit->object.oid, &stash);
>> @@ -1680,7 +1686,10 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
>>
>>                 ret =3D try_merge_strategy(use_strategies[i]->name,
>>                                          common, remoteheads,
>> -                                        head_commit);
>> +                                        head_commit, &early_exit);
>> +               if (early_exit)
>> +                       goto done;
>> +
>>                 /*
>>                  * The backend exits with 1 when conflicts are
>>                  * left to be resolved, with 2 when it does not
>> @@ -1732,12 +1741,18 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
>>         } else if (best_strategy =3D=3D wt_strategy)
>>                 ; /* We already have its result in the working tree. */
>>         else {
>> +               int new_ret, early_exit;
>> +
>>                 printf(_("Rewinding the tree to pristine...\n"));
>>                 restore_state(&head_commit->object.oid, &stash);
>>                 printf(_("Using the %s strategy to prepare resolving by =
hand.\n"),
>>                         best_strategy);
>> -               try_merge_strategy(best_strategy, common, remoteheads,
>> -                                  head_commit);
>> +               new_ret =3D try_merge_strategy(best_strategy, common, re=
moteheads,
>> +                                            head_commit, &early_exit);
>> +               if (early_exit) {
>> +                       ret =3D new_ret;
>> +                       goto done;
>> +               }
>
> Incidentally, this is essentially dead code being added in this last
> hunk.  This final `else` block can only be triggered when
> best_strategy has been set, and best_strategy will only be set after a
> merge strategy works (possibly with conflicts, but was at least
> appropriate for the problem).  Anyway, by the point of this `else`
> block, we've run multiple strategies already, at least one worked, and
> the "best" one was not the last one tried.  So, at this point, we
> simply rewind the tree and rerun the known-working merge strategy.  (I
> guess you could say that maybe the merge strategy might not return the
> same result despite being given the same inputs, so theoretically
> early_exit could come back true and this hunk isn't quite dead.  Just
> mostly dead, I guess.)

The idea here was to leave the "is it really dead?" question aside, and
just move the code towards running the post-builtin code we run when we
don't call an early exit().

