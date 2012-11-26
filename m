From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add documentation on how to integrate commands.
Date: Sun, 25 Nov 2012 20:47:55 -0800
Message-ID: <7vy5hpvukk.fsf@alter.siamese.dyndns.org>
References: <20121124122333.BAD7B4065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com (Eric S. Raymond)
X-From: git-owner@vger.kernel.org Mon Nov 26 05:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcqcC-0007HP-5i
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 05:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab2KZEsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 23:48:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465Ab2KZEr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 23:47:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9B40A3C7;
	Sun, 25 Nov 2012 23:47:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXfGVSOWBjsvaAvsvGGRIOXsYMI=; b=GOkPza
	Ns/n7P2heWXy3PUKMm6bDlN5ssRx1Rg+3UFp06oGmYkHV1OQpT4EmRWKHwektII9
	3y0zGWdio27mB1l2Vd3QkyHmHF0RsmLgzeW06pFhJWKM8uDmwk0UWTEpx9DsRExb
	ettTBcmMEaMCqOe9ixACel+bTRMqQucI0Km5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=du+CfmMfEhiDCmJqHCpRkhOf/w2WXF0R
	UESmLfa9rXPo8k4actx1Mk++uGSowrh//QPUWnk1smDDZygOou0sGcxnM4oi0bc2
	T0ZUXVpMaM3KEKMmh5+wPxanWvEJW7/eBGdsE2xeJkHrPW84h/fHYtaKAmF3ufiW
	k14KDtDdl2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B96A3C6;
	Sun, 25 Nov 2012 23:47:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0E57A3C0; Sun, 25 Nov 2012
 23:47:56 -0500 (EST)
In-Reply-To: <20121124122333.BAD7B4065F@snark.thyrsus.com> (Eric S. Raymond's
 message of "Sat, 24 Nov 2012 07:23:33 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7255E206-3784-11E2-AA50-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210407>

esr@thyrsus.com (Eric S. Raymond) writes:

> ---

Sign off?

>  Documentation/CommandIntegration |   69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/CommandIntegration
>
> diff --git a/Documentation/CommandIntegration b/Documentation/CommandIntegration
> new file mode 100644
> index 0000000..be248f7
> --- /dev/null
> +++ b/Documentation/CommandIntegration
> @@ -0,0 +1,69 @@
> += Integrating new subcommands =
> +
> +This is how-to documentation for people who want to add extension
> +commands to git.
> +
> +== Runtime environment ==
> +
> +git subcommands are standalone executables that live in the git
> +execution directory, normally /usr/lib/git-core.  The git executable itself
> +is a thin wrapper that sets GIT_DIR and passes command-line arguments
> +to the subcommand.
> +
> +(If "git foo" is not found in the git execution directory, the wrapper
> +will look in the rest of your $PATH for it.  Thus, it's possible

As the first sentence in this paragraph does not make it clear
enough that you are defining a new term "git execution directory",
"execution directory" here may be misleading and can easily be
mistaken as if we look something in the directory where the user
runs "git" in.  We usually call it "exec path".

> +== Implementation languages ==
> +
> +Most subcommands are written in C or shell.  A few are written in
> +Perl.  A tiny minority are written in Python.
> +
> +While we strongly encourage coding in portable C for portability, these
> +specific scripting languages are also acceptable. We won't accept more
> +without a very strong technical case, as we don't want to broaden the
> +git suite's required dependencies.

Actually, we tend to avoid Python dependency for anything important
and allow it only on fringes; people who lack Python environment are
not missing much, and we would want to keep it that way until the
situation on the Windows front changes.

> +C commands are normally written as single modules, named after the
> +command, that link a core library called libgit.  Thus, your command

I would prefer to see this sentence not call libgit.a a "library".
We primarily use libgit.a to let linker pick necessary object files
without us having to list object files for non-builtin command
implementations and it is not designed to be used by other people.

> +== Integrating a command ==
> +
> +Here are the things you need to do when you want to merge a new 
> +subcommand into the git tree.
> +
> +1. Append your command name to one of the variables BUILTIN_OBJS,
> +EXTRA_PROGRAMS, SCRIPT_SH, SCRIPT_PERL or SCRIPT_PYTHON.
> +
> +2. Drop its test in the t directory.
> +
> +That's all there is to it.

And when sending a patch in, do not forget to sign off your patches
;-)
