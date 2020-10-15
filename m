Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FCC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA015206DC
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cwS9cT1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgJOUnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:43:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65157 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgJOUnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:43:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F098A15D;
        Thu, 15 Oct 2020 16:43:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o9gn9tbk4KRrEsTg6nzTCK+Ps4s=; b=cwS9cT
        1mrva/ny5rLmQICsaTfL7QoXafnDp1Ka0RLKdhtcl9v5woA1+GkAnR3suh/+iI2O
        E/3bRie24hByhoEP+h04rFthv+SliRDK/tkAxwvZAQCz+tgotORaKwHDLrHkBZA2
        THhhhwR4Sproo8KMtfpmjO1sQGsNex21P10bI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WO39NYvM7cfMta5BVjrSX1X13oazCSxx
        YqwYRG9CemRGs1YaxGBY0Cw620OG4zecEuML/rY2vcsrpke6hTYQuH0JRq7vHZ7v
        Jf7jKVFWGLnPaYpEzVW0niSQWd1bmTSnGL6YZWzwPbu/+2l/voMnVJl5KI/JaT63
        QjhtOxqFp5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDC2A8A15C;
        Thu, 15 Oct 2020 16:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74FC48A15A;
        Thu, 15 Oct 2020 16:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Spiers <git@adamspiers.org>
Cc:     git list <git@vger.kernel.org>
Subject: Re: [PATCH v1] hook: add sample template for push-to-checkout
References: <20201015184703.5015-1-git@adamspiers.org>
Date:   Thu, 15 Oct 2020 13:43:28 -0700
In-Reply-To: <20201015184703.5015-1-git@adamspiers.org> (Adam Spiers's message
        of "Thu, 15 Oct 2020 19:47:03 +0100")
Message-ID: <xmqqo8l3dxu7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14F8ED50-0F27-11EB-93D2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Spiers <git@adamspiers.org> writes:

> The template is a more-or-less exact translation to shell of the C
> code for the default behaviour for git's push-to-checkout hook defined
> in the push_to_deploy() function in builtin/receive-pack.c, to serve
> as a convenient starting point for modification.
>
> It also contains relevant text extracted from the git-config(1) and
> githooks(5) man pages.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  templates/hooks--push-to-checkout.sample | 74 ++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100755 templates/hooks--push-to-checkout.sample
>
> diff --git a/templates/hooks--push-to-checkout.sample b/templates/hooks--push-to-checkout.sample
> new file mode 100755
> index 0000000000..2c6e06f8f1
> --- /dev/null
> +++ b/templates/hooks--push-to-checkout.sample
> @@ -0,0 +1,74 @@
> +#!/bin/bash

If we want to make this part of the sample hooks shown to everybody,
we should stick to /bin/sh if we could.  Do you have to rely on any
bash-ism that are not found in other shells to write this script, or
is this just shows your inertia that you always work with bash?

> +# The hook receives the commit with which the tip of the current
> +# branch is going to be updated:
> +commit="$1"

Strictly speaking, a parameter on the right hand side of an
assignment does not have to get dquoted to protect it from getting
munged at $IFS, so this can be

	commit=$1

but it gives us an important clue.  If $1 is worth protecting from
getting munged at $IFS, then we should assume later use of $commit
must be careful the same way.

> +#echo "push-to-checkout $commit"

Leftover debugging statement to be removed (instead of commented
out).

> +# It can exit with a non-zero status to refuse the push (when it does
> +# so, it must not modify the index or the working tree).
> +die () {
> +    echo >&2 "$*"
> +    exit 1
> +}

Style (Documentation/CodingGudielines).  One level of indent is a
single tab byte in our codebase.


> +if ! git update-index -q --ignore-submodules --refresh; then

Style (Documentation/CodingGudielines).

> +    die "Up-to-date check failed"

This is "failed to refresh" (in other words, not being up-to-date is
OK and that is not what we are checking), but the patch is meant as
a faithful translation of the original, so it is OK here.

> +fi
> +
> +if ! git diff-files --quiet --ignore-submodules --; then
> +    die "Working directory has unstaged changes"
> +fi
> +
> +# This is a rough translation of:
> +#
> +#    head_has_history() ? "HEAD" : EMPTY_TREE_SHA1_HEX
> +if git cat-file -t HEAD >&/dev/null; then

Is ">&/dev/null" portable?  I'd rather see it written like

	git cat-file -t HEAD >/dev/null 2>&1

to be portable.

cf. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_07 

But there is a better way to spell it (see below).

> +    head=HEAD
> +else
> +    head=4b825dc642cb6eb9a060e54bf8d69288fbee4904

This hardcodes the object name from SHA-1 world, and will break
after the user migrates to SHA-256.

> +fi

Here is probably a better version.

	if git cat-file -e HEAD
	then
		head=HEAD
	else
		head=$(git hash-object -t tree --stdin </dev/null)
	fi




> +
> +if ! git diff-index --quiet --cached --ignore-submodules $head --; then
> +    die "Working directory has staged changes"
> +fi
> +
> +if ! git read-tree -u -m $commit; then

You forgot "" around $commit here.  Here, an $IFS byte in $commit will
get the command line munged.  I.e.

	if ! git read-tree -u -m "$commit"
	then
		...

> +    die "Could not update working tree to new HEAD"
> +fi

Thanks.
