Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996D0C77B73
	for <git@archiver.kernel.org>; Mon,  8 May 2023 08:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjEHIbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjEHIbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 04:31:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FE170B
        for <git@vger.kernel.org>; Mon,  8 May 2023 01:31:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f910ea993so653997766b.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1683534663; x=1686126663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fruIB/xMs77GDmSJUJOE3ouwGAuGiFRFLthvNFhhvuE=;
        b=WPxFnbnSBAr1IDpckEHI02wW2P5FGbiUcIQ7BqDnvxxjNj9EsEK+QKczo9xFnYcDIu
         T2FsdUcEpKG/3x1NlylEBUTEmkzrpMuBy3BJKjlN48/w6aYILc2Cj/cQk11rVsBQ71mi
         vTcTT80pL+pqEXrr+5utbva6o/gaY2ya2uqX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534663; x=1686126663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fruIB/xMs77GDmSJUJOE3ouwGAuGiFRFLthvNFhhvuE=;
        b=WvpSSxsfnWtbnRa3hbtMWJthNHcS07r4F6MJSc3TmnhuQSQVM2hOGAB+u5uSGoq3sT
         97TfYZM99nPmubTtbSQo5/2LbZcShM6wl9qKUF8m4KSIsuFCGnBAOt/a0JA4Zm78a3SB
         EIiwkoveYYR+vyQPG1ZtiFHGuXC1BGV884xDNIbK986iEyW8FJxw2Pbq/H4+wzsL5FNg
         A+Ew5senBSIel567c33kLeuGakx84ETAW5vH7Qb1pTLXsi3+dNxANENwudtzO4NfnAoU
         8XH2jFMHcVB6c+IPGK35EetWN7CXjR61VC6oq6DPer+Am/L21xYO/5T+nm5Css98oJQg
         qZFg==
X-Gm-Message-State: AC+VfDyaVcxZixKbXjfNyysOlkcFhb79jYw7fb2uDPrwZM/AaT/XZpjC
        I/OlhJ/PIOTDLORkLLpS1k29m5RwLpXkvT8OBxshWw==
X-Google-Smtp-Source: ACHHUZ5Q8lfKbudKytgWTSXJlwDInOFEexBZjJtbQ/yWKuqtHt6y0u6Y487rfcWzibLorV9ckEl1ojBgFJHfSCzgWJM=
X-Received: by 2002:a17:907:7da7:b0:94a:9c9e:6885 with SMTP id
 oz39-20020a1709077da700b0094a9c9e6885mr8529322ejc.58.1683534662715; Mon, 08
 May 2023 01:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com>
 <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
 <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com> <64581fc358ede_4e6129442@chronos.notmuch>
In-Reply-To: <64581fc358ede_4e6129442@chronos.notmuch>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 8 May 2023 10:30:51 +0200
Message-ID: <CAPMMpojTjFn7JCo8QsDcOJf6NoJYASbV1bL_JxDhUr7DS12DJg@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 12:01=E2=80=AFAM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz> wro=
te:
>
> > > If we are comfortable changing the behavior of branch checkout to be
> > > safe-and-limiting like switch, then that should be almost as simple a=
s
> > > removing that condition.
> >
> > I've never heard a dissenting vote against this
>
> Here is my dissenting vote: I'm against this change.
>
> If I want to use a high-level command meant for novices, I use `git switc=
h`. If
> instead I simply want to switch to a different commit and I want git to s=
hut up
> about it, then I use `git checkout`.

Thank you for your perspective on the relationship between these commands.

I don't fully share this perspective, in two ways:
- In my experience most novices don't see or know about "git switch"
at all - the vast majority of the internet is still stuck on "git
checkout", as are existing users. Google search result counts are of
course a poor metric of anything, but compare 100k for "git switch" to
2.4M for "git checkout".
- As far as I can tell, "git switch" and "git restore" have exactly
the same power and expressiveness (except specifically the lack of
"git switch --force" support for bulldozing ongoing merges) - they are
just as much "expert" tools as "git checkout"; the main way they
differ is that they are clearer about what they're doing / what
they're for. I'd love to see "git checkout" deprecated one day,
although I'm not sure I'll live to see it happen :)

>
> You want to strip away the options for experts, in search for what?

What *I* want is a generally safe system, in which you don't have to
be an expert to avoid causing yourself problems, especially losing
work.

The specific example that motivated my wanting to change "git
checkout" here was the case of a normal (non-expert, non-novice) user
who is used to doing "git checkout -b
actually-those-changes-I-made-shouldnt-go-on-the-branch-I-was-working-on-ye=
t".
In their day-to-day work, that action will always have achieved
exactly what they wanted. The day they make exactly the same
invocation just before they commit a merge, it will do something
completely different and confusing - it will destroy a merge state,
and result in the commit, shortly after, being a regular non-merge
commot. Leveraging that committed tree in a merge commit *is* indeed
an expert action, and most novice and maybe intermediate users will
instead find themselves cursing git, and starting the merge again from
scratch - if they even notice the problem. If they don't notice the
problem, then they will instead have a new and fascinating source of
merge conflicts at some future time.

In general I *will* be willing to make things a little harder for
experts in favor of novices - absolutely.

That said, I don't believe the (new) change proposed here strips away
*useful* options from experts at all. When I said "safe-and-limiting",
I meant it in the most literal way - that there are some operations
that could be performed before and would achieve certain outcomes that
won't be possible afterwards. What I didn't mean to imply is that
those options are *valuable* to anyone - even to experts.

>
> If there was a way of doing:
>
>   git -c core.iknowwhatimdoing=3Dtrue checkout $whatever
>
> Then I wouldn't oppose such change.

I know I keep wavering back and forth on this, my apologies for my
inconstancy: *I once again think adding support for "--force" (to
checkout and switch) with ongoing operations makes sense.*

This does not achieve exactly what you seem to be suggesting above,
for two reasons:
1. It could not be implicit in config, but rather would need to be
explicit in the command
2. The outcome of using --force is not exactly the same as "git
checkout" without it (but that's a good thing)

I would (and will) argue that not achieving exactly what you propose
*is OK* because the behavior of "git checkout", without "--force",
when there is a (merge, rebase, cherry-pick, am, bisect) operation in
course, especially the way that behavior differs from when "--force"
is specified, is *not useful* - even to expert users.

I will provide a table of behaviors with a proposed patch in a few
days, but basically the main behavior we're taking away is a
one-command behavior of "switch branch and remove the (merge,
cherry-pick) in-progress state". The explicit equivalent is and will
continue to be "git [merge|cherry-pick] --quit && git checkout" -
leaving the in-progress merge changes in the index, but switching to
the specified branch.

My expectation is that this is not something even expert users find
themselves doing... ever. But I would like to know about it if I'm
wrong of course!

Something that I *do* see quite a lot in the test suite, and is
prompting my turn-about on "--force" support, is "git checkout -f
whatever" as a shorthand for "just get my worktree to the state of
that branch, regardless of the current ongoing operation".

This shorthand happens to *fail to work correctly* during a rebase
(clearing of the rebasing state was never implemented), but I believe
that has more to do with priorities and scope of changes than
intentional "let's set an extra-confusing trap for rebase" reasons.
The resulting state, where you have switched to the requested branch
and discarded any local changes, but are still in a rebase,
potentially with pending rebase sequence steps to complete, is not one
that I can see even expert users making constructive use of.

Generally, the "allow 'checkout --force' to destroy in-progress
operation states" behavior looks like an expert shortcut worth
preserving, and improving/fixing in the case of rebase.

>
> But this is not the proposal. The proposal is to break backwards compatib=
ility
> for expert users with no way to retain the existing behavior.
>

It is true that the (updated) proposal closes the doors on *specific*
behaviors as a single command, requiring them to instead be spread
across two commands. However, I believe that those are effectively
*unused behaviors*, and that the increase in consistency and safety,
for all users, by far outweighs the cost of this particular break in
backwards compatibility.

I am, again, very interested in anything I might be missing!

> Generally, breaking backwards compatibility for no reason is frowned upon=
.
>

I absolutely understand and agree that breaking backwards
compatibility *for no reason* is never the right thing - and I take
note that being clear about exactly what the reasons are, and what the
costs are, *before* talking about doing it and asking for opinions, is
advisable and something that I failed to do sensibly here.

Thanks again for the feedback, please let me know if you know of any
useful expert use cases that I *am* missing in this updated proposal.
