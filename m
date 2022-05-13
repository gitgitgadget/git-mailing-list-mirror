Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8242CC433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 05:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiEMFQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 01:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiEMFQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 01:16:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC11B797
        for <git@vger.kernel.org>; Thu, 12 May 2022 22:16:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ks9so14080131ejb.2
        for <git@vger.kernel.org>; Thu, 12 May 2022 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+slbLGcAXSQrpn+JXJBYgxNZEgVay314V59Ud4sJFQo=;
        b=apHns8LNmEeSDEknlZ3lQdXOYYpJekDWP+4IiJsHoMvBXC2b6rdUSF9sbqsW/m7prT
         cQQknMzbnYLKVKs1FEGv/vtz8A8+D2n+tscYw9gYMbs6bsqJryIvJP6UNcU/NMot7Y7e
         IW40I1vvK283TvvQTfrNvyU1zoqxHtCaW7IwWTT/RpQaUUZqUZ5FuBu4486Pb1ajb36h
         ZkYhQfrYnvHSyX2eamAg14ROsmNmPwIALpuTlYjfsZ7ZaYOjD8jYn5kEprjAloZaUZfK
         4vF/OMX3Gzs3OjB3l8DZu90jAfljFUAX4pgstXAPyc6vtMNOONSHBueFNQDyaLPcnAQX
         JpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+slbLGcAXSQrpn+JXJBYgxNZEgVay314V59Ud4sJFQo=;
        b=ptp6hDcm9+ulN0YzvLqZB0agYr2NjAN8cxiRtmmqBEcKjyQTR90TqntdLTBa9R+z9P
         vHRseazBdGn89G0MzKu+xeEfeWLRUnWNxSFnSGcHFCFZEGJHV+6jNo4Q/wQLK3y3kedr
         KAbg5rhDrOD+HbUVGs2n/Txlvs6RbT17KXnJyVF3ej5zEj2VXcjdGsWtRhnYc55/0lTX
         oXB/1NQKxoIPQM+87wYaH9Pu6/C5YgRwE+Q6UOQWpw8c4IJxscBzVQ5CBs/c9Z9bMT/c
         N2tiATvUbIZqPpcLsjBsnTGfwKpj9DK7roUSn65Jis8FpSOonvt8x9BRnh3ovoZ8NvFF
         QuDg==
X-Gm-Message-State: AOAM531W+T9DlCL6hKJ36soCXgp/bZxtuF8t0wPb+Jc+7Aefy+J20YqJ
        o9oyF3R3nGXU6cH5URgLuyNo5JrFuM2utC6JauVZpULyL34=
X-Google-Smtp-Source: ABdhPJzBtJv0AGWRCcmNvxxGYj/Lv2kPV8D+P3G2Qhct4oMgQhfg/YsaItySFmdYCsf0ZUiDQ20zj8tF9iYnJFAxtPc=
X-Received: by 2002:a17:907:97c3:b0:6f9:971b:9dc0 with SMTP id
 js3-20020a17090797c300b006f9971b9dc0mr2692952ejc.269.1652418964160; Thu, 12
 May 2022 22:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
 <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
 <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
 <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
 <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
 <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com> <xmqqk0aqhia1.fsf@gitster.g>
In-Reply-To: <xmqqk0aqhia1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 May 2022 22:15:52 -0700
Message-ID: <CABPp-BGOGLUPOn20yWzCrBYCykiet0=5UfbkuGC78f-QoWVvYg@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2022 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >     Merge with strategy octopus failed.
> >
> > Also, if we check `git status`:
> >
> >     $ git status
> >     On branch main
> >     Unmerged paths:
> >       (use "git restore --staged <file>..." to unstage)
> >       (use "git add <file>..." to mark resolution)
> >     both modified:   base
> >
> >     no changes added to commit (use "git add" and/or "git commit -a")
> >
> > And in git-merge-octopus.sh we see:
> >
> >     case "$OCTOPUS_FAILURE" in
> >     1)
> >     # We allow only last one to have a hand-resolvable
> >     # conflicts.  Last round failed and we still had
> >     # a head to merge.
> >     gettextln "Automated merge did not work."
> >     gettextln "Should not be doing an octopus."
> >     exit 2
> >     esac
> >
> > and in builtin/merge.c, we see:
> >
> >     /*
> >      * The backend exits with 1 when conflicts are
> >      * left to be resolved, with 2 when it does not
> >      * handle the given merge at all.
> >      */
> >
> > Which means git-merge-octopus.sh is claiming it can't handle this type
> > of merge, and some other merge strategy should be tried, and
> > implicitly that it didn't leave any conflicts to be resolved because
> > it can't handle this merge.
>
> Correct.  Near the beginning of the loop you found the above
> comment, there is this code:
>
>         if (use_strategies_nr == 1 ||
>             /*
>              * Stash away the local changes so that we can try more than one.
>              */
>             save_state(&stash))
>                 oidclr(&stash);
>
>         for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
>                 int ret, cnt;
>                 if (i) {
>                         printf(_("Rewinding the tree to pristine...\n"));
>                         restore_state(&head_commit->object.oid, &stash);
>                 }

Side-comment, which becomes important below: The save/restore code in
builtin/merge.c appears to be broken to me.  As noted in the code
above, stash will be set to null_oid() if save_state() returns
non-zero (which happens when "stash create" has no output, which
happens if there is _initially_ no state to save, i.e. if there are no
local changes before the merge started).  restore_state() is a no-op
whenever stash is the null_oid, meaning in that case it won't actually
rewind the tree to a pristine state to undo the changes of the
previous merge attempt.  So, if:

* The user had no local changes before starting the merge
* Multiple merge strategies are applicable
* The first merge strategy makes index/working-tree changes, but
returns with exit status 2

Then the restore_state() called before the second merge strategy will
do nothing, and the second merge strategy will be working on an index
and working tree with garbage leftover from the first merge strategy.
While this may have never been triggered (in what case do we have
multiple merge strategies that all return an exit status of 2?), I
suspect we want to fix this problem with something like this:

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee..7f3650fb09 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -378,11 +378,11 @@ static void restore_state(const struct object_id *head,
        struct strbuf sb = STRBUF_INIT;
        const char *args[] = { "stash", "apply", NULL, NULL };

+       reset_hard(head, 1);
+
        if (is_null_oid(stash))
                return;

-       reset_hard(head, 1);
-
        args[2] = oid_to_hex(stash);

        /*

> but that save-then-restore triggers ONLY when there are multiple
> strategies to try.  Unfortunately, octopus has no friends to fall
> back on, so we do not do the save-restore dance on the calling side.

If octopus did have a friend which also failed in the same way, the
restore_state() that you highlighted would only trigger for the first
such strategy and not the second.  However, restore_state() would
still be called after the second strategy, it would just come from a
later section of the code, highlighted here:

    /*
     * Pick the result from the best strategy and have the user fix
     * it up.
     */
    if (!best_strategy) {
        restore_state(&head_commit->object.oid, &stash);
        if (use_strategies_nr > 1)
            fprintf(stderr,
                    _("No merge strategy handled the merge.\n"));
        else
            fprintf(stderr, _("Merge with strategy %s failed.\n"),
                    use_strategies[0]->name);

Interestingly, the restore_state() call here does trigger even when we
only have octopus, but in that case it's a no-op because stash will
always be the null_oid because of the special case "use_strategies_nr
== 1" in the code you highlighted.

> > But it clearly decides to leave the
> > modifications it made to the index and working tree around, which just
> > seems wrong to me.
>
> If merge-recursive or merge-resolve is asked to merge a single
> commit to the current branch without any other strategies to use as
> a fallback, they leave the working tree and index into a state where
> the end-user can conclude the conflict resolution and commit the
> result.  In spirit, we are in the same situation, aren't we?

I don't think it's quite the same.  Those strategies return an exit
status of 1 on conflicts; if they returned a 2 (that is, if they all
returned a 2), meaning "I don't handle this", then in spirit we'd be
in the same situation.  If they all returned a 2, then best_strategy
would remain NULL and the code would do the restore_state() I
highlighted above in the (!best_stratgegy) block.  I believe the
intent of that restore_state() call was meant to make the working tree
and index be clean afterward (even if that's not its effect as I
mentioned in my side-note about its brokenness), and thus there would
be no conflict resolution for a user to perform.

However, some alternatives...

Perhaps you are arguing that git-merge-octopus.sh should return a 1
here instead of a 2, i.e. octopus handled the merge as far as it
could, but there are conflicts for the user to address?

Or are you saying that if all merge strategies return a 2, we just
treat the last one as good enough and consider the merge to be in
progress?  If that's your intent, we should probably remove the
restore_state() call in the "!best_strategy" block, and add a call to
write_merge_state(remoteheads) so that .git/MERGE_HEAD and friends get
written; something like this:

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee..397eb9c228 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1721,14 +1721,13 @@ int cmd_merge(int argc, const char **argv,
const char *prefix)
         * it up.
         */
        if (!best_strategy) {
-               restore_state(&head_commit->object.oid, &stash);
+               write_merge_state(remoteheads);
                if (use_strategies_nr > 1)
                        fprintf(stderr,
                                _("No merge strategy handled the merge.\n"));
                else
                        fprintf(stderr, _("Merge with strategy %s failed.\n"),
                                use_strategies[0]->name);
-               apply_autostash(git_path_merge_autostash(the_repository));
                ret = 2;
                goto done;
        } else if (best_strategy == wt_strategy)


> The user, if they want to proceed against octopus's opinion, would
> resolve the current conflict, read-tree -m the next one, ..., to
> conclude and commit the result.

That may be reasonable, but are there a few usability questions here?
In particular, would users know which trees have been merged and which
remain that they need to call "read-tree -m" on?  Would they even know
that repeated invocations of "read-tree -m" are in order?  Also, do
they just memorize "read-tree -m", or would they perhaps expect "git
merge --continue" to invoke it for them?

> So I am not sure if it is a good idea to unconditionally "reset --merge"
> in this situation.

Yeah, I think it should be handled by builtin/merge.c given how it's
apparently meant to be handling saving and restoring state.
