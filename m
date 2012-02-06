From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Mon, 06 Feb 2012 14:31:14 -0800
Message-ID: <7vbopb61cd.fsf@alter.siamese.dyndns.org>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 23:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuX5n-0000NB-H1
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 23:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab2BFWbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 17:31:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab2BFWbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 17:31:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 359587090;
	Mon,  6 Feb 2012 17:31:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pdisw4AEWkxmAtvz7VFNeSLJFOM=; b=PKSgKb
	WP9Pk061/aVNhRh7F979FRF9oZAwZqFk2LFcRBRMtgnIMgI/Q2UWDvoDhoE4aQwA
	bna0oPmvWdfUX1fwLLybt9wuYvjIe9a2djr2H7U7ZTXgb7TBIvUZvAOlYy5J59m7
	JXX3Q28zNe4CHcTx0XH190ElUCncUbGw2W3rY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHg0YnHg4nQt3gQkBwX/ZdUfIaxbgh2h
	s8p2ORZX5KNM4qk50i4MgV7Ri3+CYeZWfHTlGKwA/w9oGFBcsgFeG0qdWzpOWa/7
	e1x67zWn5B6Jx3PGBH+FEb9wypMPoOJwtxpdWJFpv9WMrsAqQt1EE4LhjGMTNSWL
	SOJqMJ/n5ZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ECA3708E;
	Mon,  6 Feb 2012 17:31:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ABC9708D; Mon,  6 Feb 2012
 17:31:16 -0500 (EST)
In-Reply-To: <20120206095346.GA4300@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 04:53:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48676356-5112-11E1-8A54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190115>

Jeff King <peff@peff.net> writes:

> This wasn't documented at all; this is pretty bare-bones,
> but it should at least give new git hackers a basic idea of
> how the reading side works.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/technical/api-config.txt |  101 ++++++++++++++++++++++++++++++++
>  1 files changed, 101 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/api-config.txt
>
> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> new file mode 100644
> index 0000000..f428c5c
> --- /dev/null
> +++ b/Documentation/technical/api-config.txt
> @@ -0,0 +1,101 @@
> +config API
> +==========
> +
> +The config API gives callers a way to access git configuration files
> +(and files which have the same syntax). See linkgit:git-config[1] for a
> +discussion of the config file syntax.
> +
> +General Usage
> +-------------
> +
> +Config files are parsed linearly, and each variable found is passed to a
> +caller-provided callback function. The callback function is responsible
> +for any actions to be taken on the config option, and is free to ignore
> +some options (it is not uncommon for the configuration to be parsed
> +several times during the run of a git program, with different callbacks
> +picking out different variables useful to themselves).

It woud be easeier to read if you stopped the sentence after "some
options" and made the "It is not uncommon..." a first-class sentence
outside the parentheses.

> +A config callback function takes three parameters:
> +
> +- the name of the parsed variable. This is in canonical "flat" form: the
> +  section, subsection, and variable segments will be separated by dots,
> +  and the section and variable segments will be all lowercase. E.g.,
> +  `core.ignorecase`, `diff.SomeType.textconv`.
> +
> +- the value of the found variable, as a string. If the variable had no
> +  value specified, the value will be NULL (typically this means it
> +  should be interpreted as boolean true).
> +
> +- a void pointer passed in by the caller of the config API; this can
> +  contain callback-specific data
> +
> +A config callback should return 0 for success, or -1 if the variable
> +could not be parsed properly.

This matches what I have always thought, but I think I recently saw a
series that adds callbacks that return 1 to mean "I have understood this
variable, so callers should not look at it any more".  It felt wrong, but
I did not find anything in the config.c API framework to prvent such a
local calling convention.

> +Basic Config Querying
> +---------------------
> +
> +Most programs will simply want to look up variables in all config files
> +that git knows about, using the normal precedence rules. To do this,
> +call `git_config` with a callback function and void data pointer.
> +
> +`git_config` will read all config sources in order of increasing
> +priority. Thus a callback should typically overwrite previously-seen
> +entries with new ones (e.g., if both the user-wide `~/.gitconfig` and
> +repo-specific `.git/config` contain `color.ui`, the config machinery
> +will first feed the user-wide one to the callback, and then the
> +repo-specific one; by overwriting, the higher-priority repo-specific
> +value is left at the end).
> +
> +There is a special version of `git_config` called `git_config_early`
> +that takes an additional parameter to specify the repository config.
> +This should be used early in a git program when the repository location
> +has not yet been determined (and calling the usual lazy-evaluation
> +lookup rules would yield an incorrect location).

Do you want to say somethink like "Ordinary programs should not have to
worry about git_config_early()"?  Differently put, if you are learning the
config API by reading this document and cannot tell which one you should
be calling, you are way too inexperienced to call git_config_early() and
you would always want to call git_config()?
