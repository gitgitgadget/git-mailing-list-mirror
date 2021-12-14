Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A96CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 00:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbhLNAb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 19:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbhLNAbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 19:31:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124CDC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 16:31:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so58288739edd.3
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 16:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJbzhAhnYJWLz4RtLwZwXW6ICotm8RqEEvNLRmvsQcI=;
        b=LDipTRnkUJ/IejmWMm0ywlfQ5eKJlBCe8rL2ibg1Xk17wKx7L9JU4eitu0HKOoWTPf
         Uv11Kh5rhes7ei0xY2KwO6zlgJTL7BPNN/RpjOt3+5a9kbJEEb03hQnh3r2a9QSBMGZ6
         DxHZYty0crVJkVf1a7/doy1l2PyFwAGT+auOF/2Xe1vhK0Ybn5AsURNrCMQBJaKeJbWH
         BtiedP1dOE9kHKidLQYJil/Wr4RuOGNxcd5KAHmwNfigqjOflhuOFMFMgw4um9BVB9TG
         kAZte/eOQe6tXJ9gYh+u9riXWPU5jIdpUr5MspzrWtFltN+Rpnrs/53LQI1zYT54xs+3
         Zidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJbzhAhnYJWLz4RtLwZwXW6ICotm8RqEEvNLRmvsQcI=;
        b=BPOPDujrI0/ngzsHkHdQZ/1cKieWhV5vTS2m0Otmdl1cT6l5lfV2CkSiV3QAgq+9Yf
         5dOvEqbqsDEX8HKjQNmtq73WxiRuA4H4B5hT0N2c4mfk8b8GZSdjVJ9rfUCljCEaEA6a
         GjeSWSAbfQ4U5caxcdyEFr+E3kl1yK5juMD9C7wpnnYNKv/FseUWOxh9hdblnu3QFqqk
         Q1KgRehXBvqUTNR0hMPnrs7POwvtg4MBXn9rnsxWw3QetaeNZlHYe/LT2Se+E192TKy5
         IOoCCxpV5TpYMReeXHdKVRZ2o10pe4nCSaJ6VzYHepPp597Y8KjyGTj/YsQ72yIQOPjl
         ocEA==
X-Gm-Message-State: AOAM532KtlphE1PmQStAEVHBeuDyQAq5UrrsHHEt/SMSpkY9SjXNlJrk
        yTsWbZYTODRCfOGaA39+SgK1EZqTv3W2zaeNoWk=
X-Google-Smtp-Source: ABdhPJwd8ex2dR5opwdoJchtkQOcoGBs9ZAuu3NlRpBuP/9UHqrhUT83YumTxooyqxax9vJZpL5dPO7bX1kMgLaopQc=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr1883887ejc.493.1639441883334;
 Mon, 13 Dec 2021 16:31:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com> <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
 <b87ec8f9-dd0d-c7b8-1c2a-edfd3d015930@unity3d.com>
In-Reply-To: <b87ec8f9-dd0d-c7b8-1c2a-edfd3d015930@unity3d.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Dec 2021 16:31:12 -0800
Message-ID: <CABPp-BHwk25XK7qT4C8KELWXObc_W2DCXusPfLSMUuUKmeCUxw@mail.gmail.com>
Subject: Re: [PATCH v2] fast-export: fix surprising behavior with --first-parent
To:     William Sprent <williams@unity3d.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 7:09 AM William Sprent <williams@unity3d.com> wrote:
>
> > However, given that it's unsafe to set revs.reverse=1 earlier, now
> > that I think about it, isn't it also unsafe to set revs.topo_order
> > where it is?  Someone could override it by passing --date-order to
> > fast-export.  (It's okay if you want to leave fixing that to someone
> > else, just thought I'd mention it while reviewing.)
> >
>
> I couldn't tell you for sure if the topo_order placement is safe. I at
> least don't see any place where topo_order itself can be toggled off in
> revision.c.  I'm sure there exists at least one rev-list argument which
> will cause unexpected behaviour, though.
>
> I agree that it would be nice to have the traversal order options be
> assigned in the same place. I guess we have three options:
>
>
>     1. Put the reverse assignment to the top (together with topo_order),
> allowing the user to disable it with --reverse, which will cause odd
> behaviour.

I'd call it broken rather than merely odd; more on this below.

>     2. Put the reverse assignment to the top and throw an error if the
> user passes the --reverse option.

Might be a reasonable longer term solution if someone wants to dive
into all the non-sensical options and mark them as such.  But I agree
that it's slightly odd only picking one specific one when we know
there's likely a pile of them here.

>     3. Keep the reverse assignment at the bottom, silently ignoring any
> --reverse option.

"silently ignored" or "dismissed with prejudice"?  :-)

> I don't think any of the three options are particularly good. The first
> one for obvious reasons. The second seems inconsistent to me as we would
> only error on --reverse but not any of the other "nonsensical" rev-list
> args. However, silently ignoring certain arguments does also not make
> for a good user experience.
>
> I think that it might be a good idea to move up the 'reverse' assignment
> and then add a paragraph to the man page for git-fast-export explaining
> that some arguments, in particular the ones that change the ordering of
> commits and the ones that change how commits are displayed (such as
> --graph), may have no or unexpected effects.

I'd rather choose option #3, like builtin/add.c does with max_count.
In part this is because...

> I've tried writing a snippet in git-fast-export.txt, which I could include
> in the next version, if you think it seems like a reasonable approach:
>
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index 1978dbdc6a..34875ef01d 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -157,16 +157,21 @@ by keeping the marks the same across runs.
>  [<git-rev-list-args>...]::
>         A list of arguments, acceptable to 'git rev-parse' and
>         'git rev-list', that specifies the specific objects and references
>         to export.  For example, `master~10..master` causes the
>         current master reference to be exported along with all objects
>         added since its 10th ancestor commit and (unless the
>         --reference-excluded-parents option is specified) all files
>         common to master{tilde}9 and master{tilde}10.
> ++
> +Arguments to `git rev-list` which change the _order_ in which commits are
> +traversed, such as '--reverse', as well as arguments which control how commits
> +are displayed, such as '--graph', may either have no effect or have an
> +unexpected effect on which commits are exported.

After your patch, --reverse won't have an unexpected effect on _which_
commits are exported, it would instead have an unexpected effect on
_how_ commits are exported (turning _every_ commit into a root
commit).  I'd rather just go with your option #3.

> >> +
> >> +               git fast-export main -- --first-parent >first-parent-export &&
> >> +               git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
> >> +
> >> +               git init import &&
> >> +               git -C import fast-import <first-parent-export &&
> >> +
> >> +               git -C import rev-list --format="%ad%B" --topo-order --all --no-commit-header >actual &&
> >
> > Same simplifications as above here:
> >     git -C import log --format="%ad %s" --topo-order --all >actual &&
> >
> > However, is there a reason you're using "--all" instead of "main"?
> > Although main is the only branch, which makes either output the same
> > thing, it'd be easier for folks reading to catch the equivalence if it
> > was clear you were now listing information about the same branch.
> >
>
> I guess the intent is to be completely sure that only four commits were
> exported, and no other refs made it into the new repository. I don't feel
> too strongly about it, but I think it is a slightly stronger test than
> leaving out the '--all'.

Fair enough, '--all' works for me with that explanation.
