Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E828F48
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720925634; cv=none; b=Kk/wVKSDuwfedJYosHegWUE/qSaRHcxL0sjYKOHwS31j7CCXpbl+Q26KOlqPX6gXvN+i5IrdVT82w7i4qOm7X4ieNWaM9ABbR0bKaG25XT6ppDo3fMGt7J9ljRkX9xmWxEiIC4HZma2hMBAhZZk8It+d+eD5D+5kukSGfT3FRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720925634; c=relaxed/simple;
	bh=SwHO4eO0gKQ5bcgEnc7ZiM1GuzTV1RCrpDIxtaxDnuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oldCTaE4ZCn4bT6Lxb57ldJsbPklUK1JwL1qWkDQ9qpqDmK+yTwmytOZry3l7RfagZ41aTjYkANyfgyFIwEmxyJyHAiAxDWRB+SJWMTSOY0v1o9hdWdl6xtRdc470IKgoNNTVqG0WogN74VjC+3aPzXKkEEBFS/IVoyi2i1O/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=teJKlo/g; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="teJKlo/g"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFBD421B36;
	Sat, 13 Jul 2024 22:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SwHO4eO0gKQ5bcgEnc7ZiM1GuzTV1RCrpDIxta
	xDnuk=; b=teJKlo/gPJJ76SfTrluYRjuTTg4nz8mp1udJLhoMQYle8YR6tMmfgf
	4oEZtneBgdhpN6AfR7Nxs5IXm+Xosk5La96wUEUZYtR6dRc+Cac7WrZaC94ODEFt
	YV8MSk2NrbxVJQMw1VjSf8xo7sI/7ukYnvAaPifll82Ej1fNj6uY4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D81B321B35;
	Sat, 13 Jul 2024 22:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3719321B34;
	Sat, 13 Jul 2024 22:53:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
In-Reply-To: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sat, 13 Jul 2024 12:38:41
	-0400")
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
Date: Sat, 13 Jul 2024 19:53:43 -0700
Message-ID: <xmqq8qy4adl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49472FB8-418C-11EF-A538-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> ok 34 # skip delayed checkout shows progress by default on tty (pathspec
> checkout) (missing TTY of PERL,TTY)
>
> expecting success of 0021.35 'delayed checkout ommits progress on non-tty
> (pathspec checkout)':
>                 test_delayed_checkout_progress ! git checkout $opt
>
> + test_delayed_checkout_progress ! git checkout .
> test_delayed_checkout_progress: test: argument expected

This "test: argument expected" is curious.

The shell function reads like so and it hasn't changed since
7a132c62 (checkout: make delayed checkout respect --quiet and
--no-progress, 2021-08-26) introduced it, and there are 3 uses of
"test" builtin function.

        test_delayed_checkout_progress () {
                if test "$1" = "!"
                then
                        local expect_progress=N &&
                        shift
                else
                        local expect_progress=
                fi &&

                if test $# -lt 1
                then
                        BUG "no command given to test_delayed_checkout_progress"
                fi &&

                (
                        cd progress &&
                        GIT_PROGRESS_DELAY=0 &&
                        export GIT_PROGRESS_DELAY &&
                        rm -f *.a delay-progress.log &&

                        "$@" 2>err &&
                        grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
                        if test "$expect_progress" = N
                        then
                                ! grep "Filtering content" err
                        else
                                grep "Filtering content" err
                        fi
                )
        }

I do not see how any of these tests can be fed a list of zero or
more argument that causes it to barf with "argument expected",
when

	test_delayed_checkout_progress ! git checkout .

is run.  The first "are we negated?" test gets

	test "!" = "!"

and shifts that "!" away, the second test that checks the number of
arguments do not need any extra quoting (in other words, $# can never
be an empty string, so

	test $# -lt 1

cannot become "test -lt 1" that would barf, like so:

	$ ksh -c 'test -lt 1'
	ksh: test: argument expected

And whether expect_progress gets an empty string or N (we should
have got N in there, if the shell is so broken that the first
comparison between "!" and "!" were botched and the variable got
assigned an empty string, or "local" were botched and the variable
were somehow left uninitialized, expect_progress could be a value
we do not expect), the last test to switch between !grep and grep
can never break like so:

	$ ksh -c 'test = N'
	ksh: test: argument expected

because $expect_progress is inside a pair of double quotes.

In the above "thinking out aloud", I invoked ksh because bash and
dash gives different error messages.

Another remotely curious thing is that I am not sure how "local" in
the outer shell influences the use of the variable in the subshell
(read: now I am speculating if the above code uses some constructs
that are so tricky to implement correctly and an unfortunate bug
gets triggered in your shell), but even if such a bug caused a
nonsense value to be assigned to $expect_progress, I do not see how
it can cause "test" to barf with "argument expected".

So, I am not sure what is going on at all.

In any case, this does not sound anything recent.  Do you know that
this used to work in previous releases?  Could this be caused by
changes in your environment (like which shell is used)?
