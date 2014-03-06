From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC GSoC idea: git configuration caching (needs co-mentor!)
Date: Thu, 06 Mar 2014 11:24:18 -0800
Message-ID: <xmqqtxbbxh99.fsf@gitster.dls.corp.google.com>
References: <53180E40.5050308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdu8-00026J-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbaCFTYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:24:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbaCFTYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:24:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8633471B42;
	Thu,  6 Mar 2014 14:24:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nSuvPGtclBw3/WFulqq+/3AXs2A=; b=rMjAYU
	gdm+PJwAuhVGjJPqSG31Tt1nnT5iOYUzenqmsvleYAgwdACg1lwiqaXopzEQq2mj
	C2be7I7pNkLyu0/Hb4a6hNjoLAE1O8ac0jU87d74A36bcm8Rb8Qv87LA94X805wV
	p9kmkP1hTX9U8YsGtP8iFKKIXV0lNGAD+a8I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xKAoGfYocCfN2NiOEB/Q0L+pnlY8Htuh
	P2q8I57gK8w2ANXjFn6vQxKLyHrbtrP0DGIWJyDJotuRcrPj35yLP/r0nNLxjyDZ
	VzIddR/ovg8tq21exB20kg89fFOuc8gnED9hqD2qGdomAjgObk9pvglZCpbSHd3b
	ne6K6vcL+aM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B7C371B41;
	Thu,  6 Mar 2014 14:24:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6348C71B3B;
	Thu,  6 Mar 2014 14:24:20 -0500 (EST)
In-Reply-To: <53180E40.5050308@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 06 Mar 2014 06:57:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EAB3C89A-A564-11E3-928E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243536>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I just wrote up the idea that fell out of the discussion [1] about the
> other configuration features that I proposed.  As far as I am concerned,
> it can be merged as soon as somebody volunteers as a co-mentor.  The
> idea is embodied in a pull request against the git.github.io repository
> [2]; the text is also appended below for your convenience.
>
> Michael
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/242952
> [2] https://github.com/git/git.github.io/pull/7
>
> ### git configuration API improvements
>
> There are many places in Git that need to read a configuration value.
> Currently, each such site calls `git_config()`, which reads and parses
> the configuration files every time that it is called.  This is
> wasteful, because it results in the configuration files being
> processed multiple times during a single `git` invocation.  It also
> prevents the implementation of potential new features, like adding
> syntax to allow a configuration file to unset a previously-set value.
>
> This goal of this project is to make configuration work as follows:
>
> * Read the configuration from files once and cache the results in an
>   appropriate data structure in memory.
>
> * Change `git_config()` to iterate through the pre-read values in
>   memory rather than re-reading the configuration files.
>
> * Add new API calls that allow the cache to be inquired easily and
>   efficiently.  Rewrite other functions like `git_config_int()` to be
>   cache-aware.

Are you sure about the second sentence of this item is what you
want?

git_config_<type>(name, value) are all about parsing "value" (string
or NULL) as <type>, return the parsed value or complain against a
bad value for "name".  They do not care where these "name" and
"value" come from right now, and there is no reason for them to
start caring about caching.  They will still be the underlying
helper functions the git_config() callbacks will depend on even
after the second item in your list happens.

A set of new API calls would look more like this, I would think:

	extern int git_get_config_string_multi(const char *, int *, const char ***);
	const char **values;
        int num_values;

        if (git_get_config_string_multi("sample.str", &num_values, &values))
        	return -1;
	printf("[sample]\n");
	for (i = 0; i < num_values; i++)
		printf("  str = %s\n", value[i]);
	printf("\n");
	free(values);

with a "singleton" wrapper that may be in essense:

	const char *git_get_config_string(const char *name)
        {
		const char **values, *result;
                int num_values;

	        if (git_get_config_string_multi("sample.str", &num_values, &values))
        		return NULL;
                result = num_values ? values[num_values - 1] : NULL;
                free(values);
		return result;
	}

that implements the "last one wins" semantics.  The real thing would
need to avoid allocation and free overhead.

> * Rewrite callers to use the new API wherever possible.
>
> You will need to consider how to handle other config API entry points
> like `git_config_early()` and `git_config_from_file()`, as well as how
> to invalidate the cache correctly in the case that the configuration
> is changed while `git` is executing.
>
> See
> [this mailing list
> thread](http://article.gmane.org/gmane.comp.version-control.git/242952)
> for some discussion about this and related ideas.
>
>  - Language: C
>  - Difficulty: medium
>  - Possible mentors: Michael Haggerty
