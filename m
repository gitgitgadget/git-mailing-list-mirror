From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adds configuration options for some commonly used command-line options (GSOC micro-project)
Date: Wed, 04 Mar 2015 17:11:38 -0800
Message-ID: <xmqqvbig5jud.fsf@gitster.dls.corp.google.com>
References: <CAFAMDXbY6szmQ-gLB0_j2cYRVHCsJfszw2XU16eb6i5NJPX_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Amate Yolande <yolandeamate@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 02:11:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTKKI-0004Ud-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 02:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbbCEBLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 20:11:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753066AbbCEBLl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 20:11:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC90B3C865;
	Wed,  4 Mar 2015 20:11:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WhmWjgLvzUdXp1P8aTTfazPXLY4=; b=eHH154
	ZPOadteIbBO1Al1BWK7TbfxbzjV37Hy2watJ4XfmLmUtXtIluYq0DGlsD/2etXLi
	GcyalCB/Rlxq/BD+e841HmvOzRxJkyaUBQa3eGDPJHB3jejRiUjjnwWXrr4PgFd4
	MzBoCF3goEdtNGMf2e2yGqeFDGTL23UFGy5DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o9vTSkSN9PX8E6MwBJGOPGk4ap55528y
	Vk405gTkyDd2KAvOdQYA4tpXCtqxHhtIzxiSk1vpV4dO2kbAIEOm/cB6UHY9gm/x
	3zWfxE6KHxiGF3izLcqsqMNofJYC+NvZRIZwOc+cm0v0GSviPdxmPQQYznMw6hTi
	FWRmJD3TNMo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A50433C864;
	Wed,  4 Mar 2015 20:11:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 285293C862;
	Wed,  4 Mar 2015 20:11:40 -0500 (EST)
In-Reply-To: <CAFAMDXbY6szmQ-gLB0_j2cYRVHCsJfszw2XU16eb6i5NJPX_pQ@mail.gmail.com>
	(Amate Yolande's message of "Thu, 5 Mar 2015 00:59:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 941F561E-C2D4-11E4-97BE-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264805>

Amate Yolande <yolandeamate@gmail.com> writes:

> 	This is a patch for my work on one of the micro projects, as I intend
> to apply for the Google Summer of Code 2015 under the Git community.
> This patch gives the user the oppotunity to specify configuration
> options for some commonly used command-line options for exampel:
> 	git config defopt.am 'am -3'
> ---

Check Documentaiton/SubmittingPatches again?  It would be beneficial
to use the output of "git log --no-merges" for recent history to see
the recommended style of log messages while studying it.

>  Makefile |    1 +
>  defopt.c |   24 ++++++++++++++++++++++++
>  git.c    |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Docs and tests?

> +static int handle_defopt(int *argcp, const char ***argv)
> +{	
> +	int envchanged = 0, ret = 0, saved_errno = errno;

What is the point of having a local envchanged here, receiving the
info from handle_options() only to discard?

> +	subdir = setup_git_directory_gently(&unused_nongit);
> + ...
> +	if (subdir && chdir(subdir))
> +		die_errno("Cannot change to '%s'", subdir);

Why do you need to do this chdir() here?  Wouldn't the caller of the
codepath after the callsite you added the call to this function go
to the top-level as necessary already?

> +	errno = saved_errno;
> +
> +}
> +
> +
>  static int handle_alias(int *argcp, const char ***argv)
>  {
>  	int envchanged = 0, ret = 0, saved_errno = errno;
> @@ -517,6 +570,9 @@ static void handle_builtin(int argc, const char **argv)
>  		argv[1] = argv[0];
>  		argv[0] = cmd = "help";
>  	}
> +	
> +	if(is_builtin(cmd) && argc == 1)
> +		handle_defopt(&argc, &argv);

You used "am -3" as an example, but is "am" a built-in?

Even if it were, being able to say "git am" (no arguments) and
getting that rewritten to "git am -3", only when there is no other
arguments, is not all that useful, as a typical workflow with "am"
is to save a series of patches in a mailbox file (e.g. I would save
the message I am responding to in ./+ay-defopt.mbox) and then feed
that as an argument (e.g. "git am ./+ay-defopt.mbox").

A lazier version of me (but not me who is typing this message) might
appreciate it if "git am ./+ay-defopt.mbox" gets rewritten to "git
am -3 ./+ay-defopt.mbox" by setting "git config am.threeway yes"
once, while having an option to countermand that per invocation, by
saying "git am --no-3way ./+ay-defopt.mbox".

I think what I am saying is that an ultra-generic solution like the
patch I am commenting on implements is way too simple to be useful.

With today's code, our users can do this once:

    git config alias.am3 "am -3"

and then "git am3 ./+ay-defopt.mbox" would behave as if they typed
"git am -3 ./+ay-defopt.mbox", which would already be one step more
useful than this "only when there is no argument" design.

I think the problem with this patch ultimately came from a poor
phrasing of the Micro suggestion, which said something like "find
some common command options and add configuration".  It was meant to
allow many different people to do many different things (i.e. one
person does am.threeway and am.threeway only), not an invitation to
design something that is generic that covers all these command
options in one go.

So, perhaps limit the scope of Micro to a single command with a few
commonly desired configured options and try again?

Thanks.
