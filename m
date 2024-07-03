Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF12F9D4
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027822; cv=none; b=MMPRwCOjccapN2bfB+w8AtygAqGFYkR4yOE4eWPKJu8hUKv4T9DAKM7v3FISfiHvBzcRHpnGmwJQ3hVSKJPY7Yvgg5DJ3IbzD7vcdFXo+3MaABd6/1QiyeQQU48MCboswIMeoH3GTVngKQX7fNkVD212m0aOzZkhe2z179tHD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027822; c=relaxed/simple;
	bh=Mt86mztLe6zFUhwiQLmnOY7aS63SiAlgarZpT0neWgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6jFHY/8oA5IMeGStrdBYDrh2dZHJMjKf0jz/MN+B5f9/KwbpaHR/XvVTTqNvrbFI7p1CJ07cc+tPPRr6OF3fsFI50BMmxDqnqSUN/VDVniuZM11HF1/N6WwzrlQ7vQVHp2LuIZrJGQNSDiqf2TRjjc/0XrLO524yQM0T67aNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wwehwDPF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wwehwDPF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 156DF1B14C;
	Wed,  3 Jul 2024 13:30:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mt86mztLe6zFUhwiQLmnOY7aS63SiAlgarZpT0
	neWgk=; b=wwehwDPFYlkRJ8Xw4nrdLh+ilux8/gmW6nq81T+2jytvDK3HI9Yq1A
	PBHv9SZij75C4JGaP6tYgTV+E3l8uwndiZHhTewNxXiBSQa7VKFeZyfiDTvPlDWv
	dIC+/BWagHM3ehPLthtFGlmnqcytYdYCaoj14o0jpL0G3Z4f36PG8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C6C11B14B;
	Wed,  3 Jul 2024 13:30:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5565F1B14A;
	Wed,  3 Jul 2024 13:30:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Antonin
 Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
In-Reply-To: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com> (Antonin
	Delpeuch via GitGitGadget's message of "Wed, 03 Jul 2024 14:21:09
	+0000")
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
Date: Wed, 03 Jul 2024 10:30:16 -0700
Message-ID: <xmqqmsmycriv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EAAE48E2-3961-11EF-9AEE-965B910A682E-77302942!pb-smtp2.pobox.com

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> The current default diff algorithm for the merge-file command is
> 'myers', despite the default for the 'ort' strategy being 'histogram'.

It is unclear only from the above description if `ort` should match
by adopting `myers` as its default, or vice versa.  I'll go into
more detail why I think this whole thing is done in a wrong order
later.

> Since 2.44.0 it is possible to specify a different diff algorithm via
> the --diff-algorithm option.

"2.44.0" -> "4f7fd79e (merge-file: add --diff-algorithm option,
2023-11-20)".  Thanks for that patch, by the way.

> As a preparation for changing the default
> to 'histogram', we warn the user about the different behaviour this
> may cause.

There is a huge leap in logic here.  Nobody proposed to change the
default and we had no such discussion here.  That needs to happen
before anybody can warn users that "the default will change".

Once everybody agrees that such a change is a good idea, we'd need
to devise transition plan, and one of the tasks _might_ be to add
this warning to the code, among other things we may do.  The whole
process has to be designed carefully.  Having this step as the first
one is way too suboptimal and hurts the users (e.g. "what if we
decide that using histogram as the default is not what we want to do
in the end?").

> +static int explicit_diff_algorithm = 0;

We shouldn't (and we generally do not) initialize a variable
explicitly to "0".  Just let being in the .bss section take care of
it instead.

This one is flipped by diff_algorithm_cb(), which is a callback
function that deals with the command line option "--diff-algorithm",
so calling the variable to remember the fact that the option was
used with "explicit" in its name is very much appropriate.

Now on to the real problem I have with this patch.

What do you want the end-user experience for those who saw and
understood this warning message to be?  Especially for ones who do
not really _care_ what the default algorithm used is, and would
rather tell us "I'll let Git developers to choose the best algorithm
for us, do not bother me with what exact choice you made---I'll
happily use the built-in default")?

Whether they have their favorite algorithm or they are willing to go
with the built-in default, they will keep getting shown by this
message and there is no obvious way to easily squelch the message.

If we do not count "Every time you run this command, you can give
the --diff-algorithm=myers option from the command line to squelch
it" as a usable piece of advice, that is.

Stepping back a bit.

It is curious that, even though we read the merge.conflictstyle
configuration variable by calling into xdiff-interface.c, we do not
seem to pay attention to the diff.algorithm configuration variable.
Shouldn't we teach the command to do so first, as a follow-up to
your 4f7fd79e (merge-file: add --diff-algorithm option, 2023-11-20)?
If `ort` does not pay attention to it (I do not know if it does),
then perhaps that can also be fixed in the same "preparatory"
series.  It would allow us to have a way to consistently and
uniformly configure the diff algorithm to employ regardless of the
caller of the diff machinery (and if we wanted to go fancy, we could
even introduce "diff.ort.algorithm" and "diff.merge-file.algorithm"
that overrides "diff.algorithm" that in turn overrides whatever the
built-in default is).

Such a change would prepare the codebase to allow users to say "I'll
adopt the new default that will come in Git 3.0 before it happens by
setting diff.algorithm to histogram" or "I'll set diff.algorithm to
default to express that I'll go with the flow and let Git developers
to decide".  With such a preparatory change made, you can build an
equivalent of this step, but you make sure that you pay attention to
both the command line (i.e. your explicit_diff_algorithm) and also
the configuration as ways for users to express that "I've read the
warning.  Please do not repeat it."

So, in short, I do not like this patch because of two reasons:

 - It shouldn't be the first message that begins the topic of
   flipping the default diff algorithm for merge-file.

 - Even if we arrived at a consensus to migrate the default to
   'histogram' (and I do not think we even started discussing), the
   "warning" mechanism that has no easy way to squelch is not an
   acceptable component in the migration plan.

