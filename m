Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6280320A40
	for <e@80x24.org>; Sun,  3 Dec 2017 02:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbdLCCIG (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 21:08:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751874AbdLCCIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 21:08:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0057B9281;
        Sat,  2 Dec 2017 21:08:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NcjHuZkWJIDJXEKL9ITUzh7pTXU=; b=FF8Ert
        ioncFYsXTu4fMvLVeSkznoOeW6KYhhIfhb3gZG3OK0FiLwoSSPNZeBwQEMLyAwNo
        tE5adS58uV8rKzuBPqdq7sHAe6Qy6+gT4rc7mYUaR901RjX4hLEToiT+OKEVtUfa
        4O0omhBqB34zR1i9kIZKEJ2uecsSoawQhHAik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hob8rveJmyaMzeiAGdj+bED+vR91QUUM
        19da442YdE40eZAAM9bCCZ/n15LT2K3mid6009sUU/wTplmzlFikmkqtiLdyAHLJ
        DL0PlrgS4/4Am2DR0rLviiwtpT8Yi1t80Gm06EaJQH5A7IxRmYYiEeG+qEt0TeMq
        p5m+qaHuwu8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8179B9280;
        Sat,  2 Dec 2017 21:08:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAA78B927F;
        Sat,  2 Dec 2017 21:08:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
References: <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
        <20171128163406.15452-1-kaartic.sivaraam@gmail.com>
Date:   Sat, 02 Dec 2017 18:08:02 -0800
In-Reply-To: <20171128163406.15452-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 28 Nov 2017 22:04:06 +0530")
Message-ID: <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBC140B6-D7CE-11E7-8393-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> When the N-th previous thing checked out syntax (@{-N}) is used
> with '--branch' option of check-ref-format the result might not
> always be a valid branch name (see NOTE below). This is because
> @{-N} is used to refer to the N-th last checked out "thing" which
> might be any commit (sometimes a branch). The documentation thus
> does a wrong thing by promoting it as the "previous branch syntax".
>
> So, correctly state @{-N} is the syntax for specifying "N-th last
> thing checked out" and also state that the result of using @{-N}
> might also result in a "commit hash".
>
> NOTE: Though a commit-hash is a "syntactically" valid branch name,
> it is generally not considered as one for the use cases of
> "git check-ref-format --branch". That's because a user who does
> "git check-ref-format --branch @{-$N}" would except the output
> to be a "existing" branch name apart from it being syntactically
> valid.

s/except/expect/ I suspect.  But I do not think this description is
correct.  "check-ref-format --branch @{-1}", when you come from the
detached HEAD state, happily report success so it does not hold that
it is "generally not considered".

Unless you are saying "check-ref-format --branch" is buggy, that is.
If so, we shouldn't be casting that buggy behaviour in stone by
documenting, but should be fixing it.

But because this patch is about documenting, the farthest you can go
is to say that "check-ref-format --branch only checks if the name is
syntactically valid, and if you came from a detached HEAD, or if you
came from a branch that you deleted since then, the command will say
'yes, that looks like a good branch name to use'.  That may not
match what you expect, but that is the way it is.  Get used to it
and that is why we document that behaviour here."

And the paragraph that leads to this NOTE and this NOTE itself are
both misleading from that point of view.  The result *is* always a
valid branch name, but it may not name a branch that currently
exists or ever existed.

Taking the above together, perhaps.

    When the N-th previous thing checked out syntax (@{-N}) is used
    with '--branch' option of check-ref-format the result may not be
    the name of a branch that currently exists or ever existed.
    This is because @{-N} is used to refer to the N-th last checked
    out "thing", which might be any commit (sometimes a branch) in
    the detached HEAD state. The documentation thus does a wrong
    thing by promoting it as the "previous branch syntax".

    State that @{-N} is the syntax for specifying "N-th last thing
    checked out" and also state that the result of using @{-N} might
    also result in an commit object name.

> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
> index cf0a0b7df..5ddb562d0 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -78,17 +78,20 @@ reference name expressions (see linkgit:gitrevisions[7]):
>  . at-open-brace `@{` is used as a notation to access a reflog entry.
>  
>  With the `--branch` option, the command takes a name and checks if
> -it can be used as a valid branch name (e.g. when creating a new
> -branch).  The rule `git check-ref-format --branch $name` implements
> +it can be used as a valid branch name e.g. when creating a new branch
> +(except for one exception related to the previous checkout syntax
> +noted below). The rule `git check-ref-format --branch $name` implements

And "except for" is also wrong here.  40-hex still *IS* a valid
branch name; it is just it may not be what we expect.  So perhaps
rephrase it to something like "(but be cautious when using the
previous checkout syntax that may refer to a detached HEAD state)".

>  may be stricter than what `git check-ref-format refs/heads/$name`
>  says (e.g. a dash may appear at the beginning of a ref component,
>  but it is explicitly forbidden at the beginning of a branch name).
>  When run with `--branch` option in a repository, the input is first
> -expanded for the ``previous branch syntax''
> -`@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
> -were on.  This option should be used by porcelains to accept this
> -syntax anywhere a branch name is expected, so they can act as if you
> -typed the branch name.
> +expanded for the ``previous checkout syntax''
> +`@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
> +was checkout using "git checkout" operation. This option should be

s/was checkout/was checked out/;

> +used by porcelains to accept this syntax anywhere a branch name is
> +expected, so they can act as if you typed the branch name. As an
> +exception note that, the ``previous checkout operation'' might result
> +in a commit hash when the N-th last thing checked out was not a branch.

s/a commit hash/a commit object name/;

