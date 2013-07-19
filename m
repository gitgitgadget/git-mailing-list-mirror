From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rev-parse(1): logically group options
Date: Fri, 19 Jul 2013 13:35:10 -0700
Message-ID: <7v4nbquw3l.fsf@alter.siamese.dyndns.org>
References: <8ab5f3c276e6f623a8056674c9306334efc9fefe.1374174438.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jul 19 22:35:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0HOa-0003UW-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 22:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab3GSUfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 16:35:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab3GSUfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 16:35:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC5D310A4;
	Fri, 19 Jul 2013 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rG4CyjX+uKFEACO9ba8ojfRE0E=; b=A0HHet
	qXSPaXrtEwucBxKWgSDZ01vS0L6Xyu5SCmLn/m+DjOC2/PVqwRrsYnPUhEunNWVm
	ssGwngWIfc7002uAhgYKGakgMm4sfU6FeRFKCFQeuIpFSOYzmG4wMtwr9604Q2ge
	XoGWd89I5PQYGzTscSktcDxGYSIf5Cod6wuTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CcYuVhWMCQshuhrXXIIoQqsO2/07XybQ
	cIIvyA4t+5Oj/kZn24OtdEJd3TKSnfbSowltOlz+SmNqoq4w4CSnsDOS9AxmOFEE
	bqX710Dvp16SaMwsyPht5nzCVaVcRozKq517pRWs4imXsVtKwfvitR/8MOt59j5X
	RYxrniRIj5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4159310A2;
	Fri, 19 Jul 2013 20:35:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FF0E310A1;
	Fri, 19 Jul 2013 20:35:11 +0000 (UTC)
In-Reply-To: <8ab5f3c276e6f623a8056674c9306334efc9fefe.1374174438.git.john@keeping.me.uk>
	(John Keeping's message of "Thu, 18 Jul 2013 20:07:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5E073B4-F0B2-11E2-9960-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230849>

John Keeping <john@keeping.me.uk> writes:

> The options section of the git-rev-parse manual page has grown
> organically so that there now does not seem to be much logic behind the
> ordering of the options.  It also does not make it clear that certain
> options must appear first on the command line.
>
> Address this by reorganising the options into groups with subheadings.
> The text of option descriptions does not change.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

The idea to introduce a general grouping makes a lot of sense, I think.

> +Operation Modes
> +~~~~~~~~~~~~~~~
> +
> +Each of these options must appear first on the command line.
> +
> +--local-env-vars::
> +	List the GIT_* environment variables that are local to the
> +	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
> +	Only the names of the variables are listed, not their value,
> +	even if they are set.

Honestly speaking, "must appear first" for "--local-env-vars" is a
bug in implementations of this option, I think.  It does not make
sense to ask

	git rev-parse --local-env-vars -- Makefile

and the command operates on "--" and "Makefile" in the normal
operation mode, not "local-env-vars" mode.

> +
>  --parseopt::
>  	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
>  
> +--resolve-git-dir <path>::
> +	Check if <path> is a valid repository or a gitfile that
> +	points at a valid repository, and print the location of the
> +	repository.  If <path> is a gitfile then the resolved path
> +	to the real repository is printed.
> +
> +--sq-quote::
> +	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
> +	section below). In contrast to the `--sq` option below, this
> +	mode does only quoting. Nothing else is done to command input.

> +Options for Input
> +~~~~~~~~~~~~~~~~~
>  
> +--show-toplevel::
> +	Show the absolute path of the top-level directory.
> +
> +--show-cdup::
> +	When the command is invoked from a subdirectory, show the
> +	path of the top-level directory relative to the current
> +	directory (typically a sequence of "../", or an empty string).
> +
>  --is-inside-git-dir::
>  	When the current working directory is below the repository
>  	directory print "true", otherwise "false".
> @@ -188,17 +219,10 @@ print a message to stderr and exit with nonzero status.
>  --is-bare-repository::
>  	When the repository is bare print "true", otherwise "false".
>  
> +--show-prefix::
> +	When the command is invoked from a subdirectory, show the
> +	path of the current directory relative to the top-level
> +	directory.

I am not sure if --show-*, --is-*, and --git-dir belongs to "options
for input".  They are truly kitchen sink options to ask for various
aspects of the repository and directory, and it may be equally valid
(or even more valid) to consider them as separate operation modes.
