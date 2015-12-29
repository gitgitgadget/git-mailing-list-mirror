From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Tue, 29 Dec 2015 13:34:41 -0800
Message-ID: <xmqqlh8dgcr2.fsf@gitster.mtv.corp.google.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
	<1450597819-26278-1-git-send-email-pclouds@gmail.com>
	<xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
	<CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
	<xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
	<20151223093700.GA13386@sigill.intra.peff.net>
	<567B05F0.5020604@kdbg.org>
	<20151223213140.GB21277@sigill.intra.peff.net>
	<CACsJy8Aqu9wTigWKC1-74qLUimV8PvmbDG1XeqYcbW0ZSMLSTg@mail.gmail.com>
	<20151229081222.GB9254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:34:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE1uq-0006Ey-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 22:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbbL2Vep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 16:34:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbbL2Ven (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 16:34:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0898838DD2;
	Tue, 29 Dec 2015 16:34:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kBegWeUM75xIVhvAjQQwfhDwkts=; b=vLvgB5
	udroiJi6ylgOhbQNqMW1CbmmrGPYoLv1tVFgqp7gTllbJvd14aQ6X3ATQGm0NLCh
	zvIa2quLzZWt7m5m98+W+ILzhSBxipqJtmmizq70SToN4N3klR3ykYVUfHM9+6zU
	XY33FTFyppPYIAKF3l3GattZ3SSwLvLFnk6+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VpgZ65uxmv3l1oJ/pr+yqxXMxbtOUPKa
	pDu7lBfrQdTfzhENMvl6O4tErFZkyGN5l59ut4vnuvScahraUaB8m8pZ+29XE6AT
	emfjGc38tvvLu7kSNx9tXHk7UYdluGOLnbbiok9ia7T4bC8AQifHC6CKmtZQZpuo
	ZkBupOjyWnw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F228838DD1;
	Tue, 29 Dec 2015 16:34:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B0C038DD0;
	Tue, 29 Dec 2015 16:34:42 -0500 (EST)
In-Reply-To: <20151229081222.GB9254@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Dec 2015 03:12:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8E9DC6E-AE73-11E5-945D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283150>

Jeff King <peff@peff.net> writes:

> The outer git wrapper doesn't start the pager, so its stderr still gets
> seen by the user. But the _inner_ git-log does start the pager, and then
> dies of SIGPIPE.
>
> So yeah, I think we want something like this on top of
> nd/clear-gitenv-upon-use-of-alias.

That makes sense to me.

> -- >8 --
> Subject: [PATCH] run-command: don't warn on SIGPIPE deaths
>
> When git executes a sub-command, we print a warning if the
> command dies due to a signal, but make an exception for
> "uninteresting" cases like SIGINT and SIGQUIT (since the
> user presumably just hit ^C).
>
> We should make a similar exception for SIGPIPE, because it's
> an expected and uninteresting return in most cases; it
> generally means the user quit the pager before git had
> finished generating all output.  This used to be very hard
> to trigger in practice, because:
>
>   1. We only complain if we see a real SIGPIPE death, not
>      the shell-induced 141 exit code. This means that
>      anything we run via the shell does not trigger the
>      warning, which includes most non-trivial aliases.
>
>   2. The common case for SIGPIPE is the user quitting the
>      pager before git has finished generating all output.
>      But if the user triggers a pager with "-p", we redirect
>      the git wrapper's stderr to that pager, too.  Since the
>      pager is dead, it means that the message goes nowhere.
>
>   3. You can see it if you run your own pager, like
>      "git foo | head". But that only happens if "foo" is a
>      non-builtin (so it doesn't work with "log", for
>      example).
>
> However, it may become more common after 86d26f2, which
> teaches alias to re-exec builtins rather than running them
> in the same process. This case doesn't trigger (1), as we
> don't need a shell to run a git command. It doesn't trigger
> (2), because the pager is not started by the original git,
> but by the inner re-exec of git. And it doesn't trigger (3),
> because builtins are treated more like non-builtins in this
> case.
>
> Given how flaky this message already is (e.g., you cannot
> even know whether you will see it, as git optimizes out some
> shell invocations behind the scenes based on the contents of
> the command!), and that it is unlikely to ever provide
> useful information, let's suppress it for all cases of
> SIGPIPE.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index 13fa452..694a6ff 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -245,7 +245,7 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>  		error("waitpid is confused (%s)", argv0);
>  	} else if (WIFSIGNALED(status)) {
>  		code = WTERMSIG(status);
> -		if (code != SIGINT && code != SIGQUIT)
> +		if (code != SIGINT && code != SIGQUIT && code != SIGPIPE)
>  			error("%s died of signal %d", argv0, code);
>  		/*
>  		 * This return value is chosen so that code & 0xff
