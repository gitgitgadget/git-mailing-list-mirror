Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA24C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F910222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 13:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aQsIL5hI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBNN2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:28:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:49479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNN2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 08:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581686920;
        bh=B/YfM7jdDPKk+BHaFQjlyN0b4mpwYYFEjYHv1o87jok=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aQsIL5hIjWqw06x74nY1kwxfJ+oOjT0lACb/OeOdO6VxKRjEuTTiA/66oWKy6NFmX
         d9Yk8tF7yZ0vHD3C5O97/wyoZJGzxbEmXpnrCEmZL+FAF9ESQxikG/9rq2YPn6+zjH
         D3EF5ZCEReIwZnfua0VALsnxIQc8tEcxfh8rn3cI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1jfnj241JL-00eaEA; Fri, 14
 Feb 2020 14:28:40 +0100
Date:   Fri, 14 Feb 2020 14:28:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     chriscool@tuxfamily.org, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 1/1][RFC][GSoC] submodule: using 'is_writing_gitmodules_ok()'
 for a stricter check
In-Reply-To: <20200213163819.6495-1-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002141428020.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2002131435301.46@tvgsbejvaqbjf.bet> <20200213163819.6495-1-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zfmQJApLnMy87MUSp6x3rsS3JSHEmLCwcesSgTSi+r2wXAw5ay3
 7o/iu5jUj9dFsDYYDUWmbn7z3BYcB0NAAnfD2pquWHkg5AR5XmlFx8A55T/5FVjVevQNMic
 aHsrJ3nz+et5uRgNP1p4sFDbZ4VdXZln1mQNQF6YY6bu/Cl+fXpnJZwBf4WR7mJYTe2+xFI
 wGmpXsDwiGhZB9PGYARBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ubpnh9KKeE=:/+jOCP+an2q00LTTGQMOlc
 j+tDnkr6TeEG2advUEmIkAjO/8l3+72jmtNxUU3KTb7y3JgE28gCMJsSibeyi4ANy/xFtvIWx
 O+O4AmH3okLKYlkpqlD1unQYf8K9ciPGbD4prvZbEaDe6x1CyQtxNMg+k7beh1Y1Ldg+n+Row
 Py3vChZ+FQ1tWk0jG2M701sD4C1YAD9KolvGEhts0aqxQtGY6/GKphHVXtCqBOczQCs8S6dwK
 eiQpN8EwFRg4BbgkX2nSDjTwSR5VQ7Be+PUE8Qa2NK00KViqZR+Tj32tS6UIdUQUFqy/P1+KB
 /OAUKTC4O4TVrEgZCjcIU7LswmAVS0G9yF/QGo6XJpzquL3wFHDIc4CV7R8pHbkO4P9evsFCh
 IvaThS5YtHD1cPxgTORJGLgANq1XERZeGLg5RZil++9TjFC1pgo/LXyJuAD0dw61Opn6lGYRY
 OMX+rd14Wv4JAnM11bM8mNVS4Vma1yYHqmjz9X8kjnp/Pj9Nd5r1qbiaC12OG62Tz3rSswv1N
 WXX7a2eo8N504A2KaAWobvIwq+/pCDLmcOgwsq3YZeCWOJ3ct4mDuWWCu4xgd61sbeLBRlfsA
 W7EaPwojh7BVtLbf8279KcnAkEgDP9kym4bkMUzuGi68ueV86eqIDJP6MWvsrcjAvEzxt/Sbt
 LZs/8MmJrnuKg52EnXdsNmY8AZ7dvaPojsz3rVYYo/EWF4vJw8huqHqyuj1PqAU6X025Dwoj+
 zYP3XNLy9EFuEqsXjF6duCyfVsIxSjC04Fnx2P4X5/2UHaXrP5QHo/Lrg/y6GbRgxllPT12Km
 dqiE30I6qJowzOX/bzeuxMLo1tVOuIBJyfObFujYsZkt8Cn4i2dx9mgdTjn9JIs0O+EMZTdsp
 rPEV27razZChpTyDyp+RNaoyBnFqWfAg29pmrQBuXn5KmMwvEb2m2U5kYNRf9Dw1pmLAnDUHg
 ZtIQ0f6OfbSWXyoxWYKVfOg8PrByJPhqPj7L4nDfSrEOSbIZHEXdxicUE71aqRrbxYGAIv4lw
 3FP/amUqgRysEqL+BQ2b7WESOD0QW+nDY0hib/p38gg2xI2QMBFAxM0HF9ozA0ECooEDE5V8z
 XvzNsWwUXX/Lu8NyF9gDZi9h9xP443ZSdoPk7WaxFUw2RmQlCtOzcxOnTpFgnBP61111S22gw
 fyz8/hUz5qJBusd+5ntiCBcRbmlzpVt/gfGNvGrlOyXs8sIQ/fQkRp2464LDmQ8KWgE67wSwG
 1O60zspEE+EQTvVpI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Thu, 13 Feb 2020, Shourya Shukla wrote:

> I understand your point of view here. What I am trying to say is that we
> must update our .gitmodules if atleast the function
> 'is_writing_gitmodules_ok()' passes.

Well, you know, I totally overlooked something: your patch replaces

	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */

by

	if (is_writing_gitmodules_ok())

which is incorrect: it should _at least_ replace it with

	if (!is_writing_gitmodules_ok())

Note the `!`. The reason is that this statement guards an early exit from
the function, indicating an error. In particular, the code before said: if
this file does not exist, error out.

The new code (with the `!`) would say: if the file does not exist, _or if
`is_writing_gitmodules_ok()` fails, error out.

But that function does not do what we want: if we rewrite the code in the
way you suggested, then we would _no longer_ error out if the file is
missing if it at least is in the index or in `HEAD`.

But if the file is missing, we cannot edit it, which is what both the
"update" and the "remove" code path want to do.

> Before, we used to pass the if condition if our .gitmomdules existed and
> it did not matter if there were any traces of it in the index.

Exactly. If there is no `.gitmodules` file on disk, we cannot edit it.
Period.

It does not matter whether there is a copy in the index or in `HEAD`: the
`git mv` and `git rm` commands want to work _on the worktree_ by default.

Side note: From a cursory read of the callers in `builtin/rm.c`, I suspect
that `git rm --cached` actually does not handle the `.gitmodules` file
correctly: it would not edit it in that case, but we would want it to be
edited _in the index_.

> > But we're in the function called `update_path_in_gitmodules()` which
> > suggests that we're working on an existing, valid `.gitmodules`.
>
> But we still originally(before my patch) checked for the existence of
> .gitmodules right?

We checked for the _non_-existence.

> The functions exits with error in case of absence of the file(which
> should happen).

Yes.

And your patch changes this so that the file _can_ be absent, _as long_ as
it exists either in the index or in the tip commit of the current branch.

But the code then goes on to call `config_set_in_gitmodules_file_gently()`
or `git_config_rename_section_in_file()`, respectively. Both of these
functions _expect_ the file to exist.

Therefore, the condition that your patch now allows would lead to
incorrect behavior. A test case would have caught this, which is actually
a good reminder that patches that change behavior should always be
accompanied by changes/additions to the test suite to document the
expected behavior.

> > So I do not think that we can proceed if `.gitmodules` is absent from
> > disk, even if in case that it is _also_ absent from the index and from
> > the current branch.
>
> Yes that is one case, but the other case is that _if_ the file exists,
> it **should** not exist in the index or our current branch(which must be
> necessary to ensure before making any updates to the file right?).

Assuming that you are talking about the conditions that have to be met
_not_ to error out early from those functions, I disagree: both of these
functions operate on the `.gitmodules` _file_. They require that file. It
must exist. Otherwise we must error out early. Which the existing code
already does.

> This is the case which was not covered before but I have tried to cover
> it in my patch.

If you truly want to cover the case where we want to edit the
`.gitmodules` file even if it does not exist on disk, but only in the
index and/or the current branch, then those functions need _quite_ a bit
more work to actually pull the contents from the index, and/or from the
tip commit, _and_ to put the modified contents into the index.

However, I am not at all sure that that is a wise thing to do (except in
the case that we're talking about `git rm`'s `--cached` option,
in which case you would _definitely_ need quite a bit more modifications
e.g. to extend the signature of at least `remove_path_from_gitmodules()`
to indicate the desire _not_ to work on the worktree file but on the index
instead, and that mode should not even allow `.gitmodules` to be absent
from worktree and index but only exist in the tip commit of the current
branch).

So I am afraid that the patch is incorrect as-is. It would require a
clearer idea of what its goal is, which would have to be reflected in the
commit message, and it would have to be accompanied by a regression test
case.

As things stand, I don't think that this patch is going in the right
direction.

If, on the other hand, the direction is changed to try to support the
`--cached` option, I would agree that that would be going toward the right
direction.

Ciao,
Johannes

> Is this explanation correct?
>
> Regards,
> Shourya Shukla
>
