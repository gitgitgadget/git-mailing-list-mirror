Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65821854
	for <git@vger.kernel.org>; Sun, 26 May 2024 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716766019; cv=none; b=TxTzvcm4VKCFWZJBhtajXngCbAp9vZaJ14fVEjgYEiJ1E8+MNwsq9NFqq9Ct5ejsGOg/edw++cOOgQDe1bAW4aCGhF2ZYW0CZSnEV8P4qJI6VMcQW41bJsRg7pZ/cO7lAPnhmL8nLUhvUf+jjimSKYfaIBPr5YidikfukjSMvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716766019; c=relaxed/simple;
	bh=oMkm2TbBx6WJspBbcfCHHT//u3I//Jj8sMRt94jkY08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgZiyQpC2Ex7SA9O+P20GQUzht5ERk+KizpBpeyRKT1E9XUKAupy4YTvvXC+ywYEYHNFh5GnXeQz2NRrW4Yuonk/nHJlog6UtrYmRFNnPjPhVaBfaPMlXCeCL3YgtLf7xTbbpiMibwVMnPRuhh1VkeILA0ZJxJuNoOIL+tF5l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EZWr7wli; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EZWr7wli"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8C112CF0A;
	Sun, 26 May 2024 19:26:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oMkm2TbBx6WJspBbcfCHHT//u3I//Jj8sMRt94
	jkY08=; b=EZWr7wliknxHqObtrsmmii9/3/B0r9VJnTEG1gbsjo+l+bMQxllZ4Y
	nMPHGgWfitQgzyTeMT/S1Abg4dfqrdA2Khg3va3l/28mwQqDaSwxV6NC1bxPMVW/
	iw95D802CdFumyrbivecYfj5D8MAq+O1BFwOqF/5f3rRorK0TRMlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D0C2E2CF09;
	Sun, 26 May 2024 19:26:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 429D12CF08;
	Sun, 26 May 2024 19:26:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v6 2/3] Documentation: alias: add notes on shell expansion
In-Reply-To: <20240525234454.1489598-2-iwienand@redhat.com> (Ian Wienand's
	message of "Sun, 26 May 2024 09:44:34 +1000")
References: <20240525012207.1415196-1-iwienand@redhat.com>
	<20240525234454.1489598-1-iwienand@redhat.com>
	<20240525234454.1489598-2-iwienand@redhat.com>
Date: Sun, 26 May 2024 16:26:51 -0700
Message-ID: <xmqqa5kcduis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6EC0F774-1BB7-11EF-BDDE-25B3960A682E-77302942!pb-smtp2.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> +* If the shell alias is the full path to a binary, it will be executed
> +  directly with any arguments as positional arguments.
> +* If the alias contains any white-space or reserved characters, it
> +  will be considered an inline script and run as an argument to `sh
> +  -c`.
> +* When running as a script, if arguments are provided to the alias
> +  call, Git makes them available to the process by appending "$@" to
> +  the alias shell command.  This is not appended if arguments are not
> +  provided.

These are not technically wrong per-se.

> +** For "simple" commands, such as calling a single binary
> +  (e.g. `alias.myapp = !myapp --myflag1`) this will result in any
> +  arguments becoming additional regular positional arguments to the
> +  called binary, appended after any arguments specified in the aliased
> +  command.

But the single-command script still receives the arguments in
argv[], so what the alias command has to do is the same.  The
earlier ones that are "not technically wrong" are merely
implemenation detail.

In a single command case, e.g., "[alias] single = !one", you may
write

    #!/bin/sh
    echo "$1" | grep "$2"

in 'one' script, and "git single 1 2" will be turned into

    start_command: one 1 2

i.e. one receives two arguments in argv[].  It is an implementation
detail that we can bypass "sh" or "-c" or "$@"

If you write exactly the same thing like

    $ git -c 'alias=single=!one ' single 1 2

you'll instead see

    start_command: /bin/sh -c 'one' "$@" "one " 1 2

because the trailing SP in the alias disables the optimization to
bypass a more generic 'sh -c ... "$@"' construction.  What gets run
is an equivalent of the reader saying

    $ /bin/sh -c 'one "$@"' "one " 1 2

bypassing git from the command line.

What the script (one) has to write does not change at all either
case.

As I keep saying over multiple iterations, the above three bullet
points stress too much on the minute implementation detail while
failing to tell readers that the end-user alias receives the rest of
the command line as arguments.

> +** Care should be taken if your alias script has multiple commands
> +   (e.g. in a pipeline), references argument variables, or is

"argument variables" -> "arguments".

> +   otherwise not expecting the presence of the appended `"$@"`.  

"otherwise not expecting" is SIMPLY BUGGY but the readers may not
understand it unless you tell them that the arguments are fed to
their aliased command by appending them.

When you look at the implementation detail of "sh -c '... $@' -
$ARGS" as something to fight against, readers would lose sight to
see the crux of the problem they are trying to solve.  I think it is
a wrong way to frame the issue.  The problem readers are solving when
coming up with their own alias is this:

    How would one write a single-liner that can take arguments
    appended at the end?

I think giving that to the readers upfront, i.e. "when you write an
alias, you are forming a single-liner that takes arguments appended
at the end", would go a long way without having them lose sight in
the implementation details of "sometimes args directly come in
argv[], sometimes your alias is wrapped in "sh -c" and "$@" is used.
They do the same thing to feed the arguments to your script.

Going back that 'one' example, if 'echo "$1" | grep "$2"' was what
you wanted to run,  how would you write a single-liner that does

    echo "$1" | grep "$2"

and can take its arguments at the end?  You do *not* want to see
your invocation of the alias

    $ git single 1 2

turn into 

    $ echo "$1" | grep "$2" 1 2

of course, and remember, "$@" is merely an implementation detail
that the end-users do not need to see.

Of course the simplest one-liner, if you had the "one" script
already stored in the file, is to say

    $ one                                  1 2

i.e. "[alias] single = !one".  But calling that a "single-liner" is
cheating.

You can do one of two easy things.

    $ sh -c 'echo "$1" | grep "$2"' -      1 2
    $ e(){ echo "$1" | grep "$2"; };e      1 2

The earlier string (before "1 2" is appended) of either of these
gives you "a single-liner that takes arguments at the end" that does
the "echo the first one, pipe it to grep that looks for the second
one", which you would make the body of the alias.  If the reader
understands the earlier example that stores it in a file, the former
is more mechanical and straight-forward rewrite of it.  The latter
may be a bit more convoluted, but says the same thing in the same
number of letters.

HTH.
