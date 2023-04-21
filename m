Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC29C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjDUVFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjDUVFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 17:05:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB071FD2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:05:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so3591649b3a.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682111106; x=1684703106;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INxez7G1KoIKkB/mK9e/1knLykQtSH1JjpOJr1bQtP8=;
        b=MPEzGnoMQSzALYMwCSpiy7zx+xSwygVjWPfms1mWZcT2vQZPuQTh9BLvubfZ7eQSNK
         7yGIPqznf6GBshe832byqQNpqvFbH9YYq4dx/+4T5C/Ztn6veRDVzZ4nLWx3U+J4ss5+
         q9NdR04C55XMkWNhMeV8SYahoZggBwqJu31Rs5Oa3uFc9Awm2lYGv2dfIgLyeUhT7Ofr
         L9aqCOITC8JiN+e7MiMh+OPqhYZrFOZhayVJGKKSVBwpw6scvo+qos9YVHAtK6mGJAEJ
         AYwHLU22zANexH+tzeyOnN0JLFxQRxHP+6hde4LlA/YTPC561tmtazVHwka466hRsdUh
         Skpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682111106; x=1684703106;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INxez7G1KoIKkB/mK9e/1knLykQtSH1JjpOJr1bQtP8=;
        b=Hyja/qsgKvys6NkIA7mV942SxzjE5/kPjJ4UKK/2ucbHRiYxafVqE/WOuEYL/zuiT6
         RwvaRCj8glx7UcXidasGOmxv4YgtYJ0PUxJ/yxLdyvONKrkSSuWkfFZM3VZ507ir6RH7
         Uy6OBoZKQ9VCg+WLqj8I+geJzq3S0N9uMTC49XwzLWMTz5YTtnCUEen3w+hlsoaH/CHK
         pxrdWytPGtji9EELlsGve4H4ApzSz8p7ep2T8BaqoEdXqaFWgiv/2KJi+2DQqDUQ40Ln
         y4qanr89aJaDNwQw+R3Mujp8UHE7fZKDD7+Aqm0o1h+hBjZXk+cTfwxT1UWOFoACp9To
         6Paw==
X-Gm-Message-State: AAQBX9f439vnNcfqfB+zO78PXzxirJvv9jiIVbWmQYysDBBvoJE9Oevo
        BtECFSJrRELUa4qhIonp/OU=
X-Google-Smtp-Source: AKy350bpPfoM8NOR0HERJB3nxk450acv5g4L+o1qirqL/R5ZWOeHyQ3iYSJAimitNQcfKX9tcwqVWA==
X-Received: by 2002:a05:6a21:170b:b0:f0:b5d3:4feb with SMTP id nv11-20020a056a21170b00b000f0b5d34febmr7028716pzb.19.1682111105580;
        Fri, 21 Apr 2023 14:05:05 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id m9-20020a629409000000b00639eae8816asm3355785pfe.130.2023.04.21.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:05:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/6] rebase --continue: refuse to commit after failed
 command
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:05:04 -0700
In-Reply-To: <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Apr 2023 14:57:52
        +0000")
Message-ID: <xmqqsfcthrpb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a commit cannot be picked because it would overwrite an untracked
> file then "git rebase --continue" should refuse to commit any staged
> changes as the commit was not picked.

It makes perfect sense to refuse blindly committing.  But this makes
me wonder what the procedure for the user to recover.  In the simplest
case, the untracked file may be expendable and the user would wish to
easily redo the step after removing it?  Like

	$ git rebase
	... stops with "merging will overwrite untracked 'foo'" ...
	$ git rebase --continue
	... refuses thanks to the fix in this step ...
	$ rm foo
	... now what?  "git rebase --redo"?  "git rebase --continue"?
	
> Do this by using the existing
> check for a missing author script in run_git_commit() which prevents
> "rebase --continue" from committing staged changes after failed exec
> commands.

Depending on the recovery procedure, this may or may not be a wise
design decision, even though it may be the quickest way to implement
it.  If the recovery procedure involves redoing the failed step from
scratch (i.e. "rm foo && git reset --hard && git rebase" would try
to restart by replaying the failed step anew), then loss of author
script file has no downside.  If we want to salvage as much as what
was done in the initial attempt, maybe not.

> When fast-forwarding it is not necessary to write the author script as

I'd prefer a comma before "it is not" here.

> we're reusing an existing commit, not creating a new one. If a
> fast-forwarded commit is modified by an "edit" or "reword" command then
> the modification is committed with "git commit --amend" which reuses the
> author of the commit being amended so the author script is not needed.

OK.

> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when fast-forwarding,
> 2021-08-20) changed run_git_commit() to allow a missing author script
> when rewording a commit. This changes extends that to allow a missing

It is unclear to me what "This changes extends" refers to.  Could
you rephrase?

> author script whenever the commit is being amended.
>
> If we're not fast-forwarding then we must remove the author script if
> the pick fails.

The changes described in these three paragraphs are about efforts
that were made needed only because the approach chosen to stop
"continue" from continuing in this situation happens to be to remove
the author script.  If it were done differently (perhaps by adding
another flag file that "continue" pays attention to), none of them
may be necessary?

> @@ -4141,6 +4140,7 @@ static int do_merge(struct repository *r,
>  	if (ret < 0) {
>  		error(_("could not even attempt to merge '%.*s'"),
>  		      merge_arg_len, arg);
> +		unlink(rebase_path_author_script());
>  		goto leave_merge;
>  	}

I agree that this is the right location to add new code to stop
"continue" from moving forward.  I do not know if the "unlink the
author script" is the right choice of such a new code, though.

Coming back to my first point, perhaps adding an advice() after this
error() would help end users who see this error to learn what to do
to move forward?

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e2..c1fe55dc2c1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1288,6 +1288,12 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>  	test_must_fail git rebase --continue &&
>  	test_cmp_rev HEAD F &&
>  	rm file6 &&

Before the pre-context is an attempt to run "git rebase -i" to
replay a commit that adds file6, stop the sequence by marking a step
as "edit" to take control back.  Then we create file6 manually in
the working tree and make sure that "git rebase --continue" fails in
the pre-context we can see here.

The recovery I asked about earlier is done with "rm file6" in this
case.

> +	test_path_is_missing .git/rebase-merge/author-script &&

This is testing the implementation.  The failed "continue" would
have removed the file thanks to the change we saw earlier.

> +	echo changed >file1 &&
> +	git add file1 &&
> +	test_must_fail git rebase --continue 2>err &&

Then we make some edit, and try to "--continue".  Why should this
fail?  Is it because the earlier "rebase --continue" that failed
did not replay the original commit due to untracked file and the
user needs to redo the step in its entirety before the working tree
becomes ready to take any further changes?

> +	grep "error: you have staged changes in your working tree" err &&
> +	git reset --hard HEAD &&

And this "reset --hard" is another thing in the recovery procedure
the user needs to take (the other one being the removal of file6 we
have seen earlier).  After that, "rebase --continue" will replay the
step that was interrupted by the untracked file6 that was in the
working tree.  OK.

>  	git rebase --continue &&
>  	test_cmp_rev HEAD I
>  '

We of course do not want to become overly "helpful" and run "reset
--hard" ourselves when we issue the "could not even attempt to
merge" message, but when we step back and see what the user wanted
to do, this is still not entirely satisfactory, is it?

My understanding of what the user wanted to do (and let's pretend
that creation of file6 in the middle was merely for test writer's
convenience and in the real scenario of what the user wanted to do,
there was the file left untracked from the beginning before the
rebase started) is to redo the A---F---I chain, making a bit of
change to F when it is recreated, and then replay I on top of the
result of tweaked F.  But instead of allowing them to edit F by
doing some modification to file1, we ended up forcing the user to
discard the edit made to file1 with "reset --hard", and "continue"
replayed I on top of the replayed F that "edit" did not have a
chance to modify.

Of course, the user can now go back to A and replay F and I on top,
essentially redoing the "rebase -i" with FAKE_LINES="edit 1 2" and
this time, because untracked file6 is gone, it may work better and
F may allow to be tweaked.  But then it does not look any better
than saying "git rebase --abort" before doing the final "continue",
which will also allow the user to redo the whole thing from scratch
again.

So, I dunno.

