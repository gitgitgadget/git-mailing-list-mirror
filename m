Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C302BC3DA79
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 21:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiL2VX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiL2VXA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 16:23:00 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1810B69
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 13:22:34 -0800 (PST)
Date:   Thu, 29 Dec 2022 21:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672348951; x=1672608151;
        bh=eAwg9kicCN0w/WpSZ8z8EAfMWf+Ot3dCvB5SiE5MR2A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=vj5xqICFukqlr9fpnqtKzQP4fbIGCtAAKgizbZeQVN0IuR1Be3iGz+IJrrpTLkfLp
         PII21PTtd8UAqbhrmavzl1E5NMo3K3iYxTMmxC40olD8h7x2aZVwDwDb6q53merbJv
         1xTdSzjuZL0DZFZtFDiXOJ6Y/IA1ADRl3Me+ipDnrboZdi2o6Sqqu2RooCbQPUVC/M
         mogXJv7LXcwZnqvJc5e1GlVOlAXibQ9rDUxrMkFnFxNXhCUFJor7YcuzmTW9Iqj4ob
         KmYjF/cvRW2XTjjgb8v8gJcl3FkNuijk2dlnmsjza4tlvqk4YvwvE23WJ0hQcuaPjh
         twbAyFg38TxCw==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221229212129.kukzn324lm45ewsv@phi>
In-Reply-To: <221229.86v8lutr6g.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <221228.868risuf5x.gmgdl@evledraar.gmail.com> <20221229063823.ij3jjuaar2fsayju@phi> <221229.86v8lutr6g.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/29 11:42AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Thu, Dec 29 2022, Jacob Abel wrote:
> >
> > [...]
> > Note: The two extra tests added in the diff wouldn't be in the next rev=
ision but they
> > are there to demonstrate that things work as expected with this change.
> >
> > [...]
> > +test_wt_add_excl -b poodle --detach bamboo --lock --reason "'the reaso=
n'" main
> > [...]
> > +test_wt_add_empty_repo_orphan_hint 'the context' --lock --reason "'the=
 reason'"
>
> I haven't even tested this, but I'm still confused here, isn't this just
> a solution in seach of a problem?
>
> To answer your question above: Yes, you can come up with shellscript
> code that handles this sort of quoting problem, but it's generally a Bad
> Idea and should be avoided.
>
> *If* a function needs to take arguments that are quoted it's much better
> to "unpack" those arguments in full, and then pass them on, see e.g. how
> the "test_commit" helper in test-lib-functions.sh does it.
>
> But in this case there was no need whatsoever for doing any of this, as
> none of the tests wanted to pass such arguments, they didn't need to be
> quoted at all.
>
> But now for this reply you've come up with one such test, hence the
> "solution in search of a problem?" above.
>
> I.e. is this a useful test, or just an excercise to stress generic quote
> handling we don't really need?

The latter. I included a note in my reply that those two tests were include=
d
solely to illustrate the behavior was as expected and would not be included=
 in
the actual patch revision.

>
> I originally suggested creating these trivial helpers in an earlier
> round because it avoided the copy/pasting of a series of tests, I think
> the v5 you had
> (https://lore.kernel.org/git/20221212014003.20290-3-jacobabel@nullpo.dev/=
)
> struck the right balance there, although as Junio noted it might need
> the tweaking for $@ v.s. $*.
>
> But once we have to handle quoted arguments the better solution is to
> just ... not use that helper. I.e. there's no reason you can't just do:
>
> =09test_wt_add_excl -b poodle -B poodle bamboo main
> =09test_wt_add_excl -b poodle --orphan poodle bamboo
> =09[...]
>
> Then:
>
> =09test_expect_success 'worktree add with quoted --reason arguments and -=
-orphan' '
> =09=09test_must_fail git worktree add  --orphan poodle --detach bamboo --=
reason "'\''blah blah'\''"
> =09'
>
> You don't need to make test_wt_add_excl() handle that case.

I generally agree. I was mostly just trying to address the spirit of the
suggested changes.

As I mentioned at the end of my most recent reply to Junio [1], I'm OK with
either the diff I proposed [2] (minus the extra tests) or just reverting th=
e
changes entirely and going with what we did in the v5 patch.

At the end of the day this seems like it was a minor nit on some test code =
that
ended up leading down a rabbit hole due to the multiple layers of nesting. =
I
only proposed the diff [2] because it seemed to fully address to original
concern without doing anything particularly egregious (unlike v6 w/ the hel=
per).

So while I prefer my diff, I'm not at all attached to either solution and w=
ill
implement whatever you and Junio decide for v7 with no complaints.

1. https://lore.kernel.org/git/20221229204841.ol3r6z2pfrodv7yx@phi/
2. https://lore.kernel.org/git/20221229063823.ij3jjuaar2fsayju@phi/

