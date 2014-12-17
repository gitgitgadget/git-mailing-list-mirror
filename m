From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 14:31:34 -0800
Message-ID: <xmqqr3vx9ad5.fsf@gitster.dls.corp.google.com>
References: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1N8A-0006UD-U2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 23:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaLQWbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 17:31:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750990AbaLQWbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 17:31:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6723128BD1;
	Wed, 17 Dec 2014 17:31:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XElbsZ7jeMNMloVq/Sg2BTu8OtQ=; b=Sko7tB
	SdAvodsv8Wy9nnbpC73R8ZQ9q3e8YjdrafHesZcCYqwZV6XdGVMIhqQi38c/LMxs
	RWhX87K4zKFl8eiTHfSQsuxX7xXD2aPT1Ua2Y1bVTtbUAgK24ns7HcN5wrMnHMOC
	zwBj2J6M9DWEyYRSaVSZJt/6iMmKryqdDG6T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tp1ASBtCf97UBPVl74bHGllFwnR+AXIo
	Irjzwy+Uk5vrR/BzdQQ3RqOOYpTYSeifHGyoHcLjTt/U7pp+gzvx8TWo6BNw8Pmk
	SRe9tBJrcYG3+qsuYake7dTZPRwAK3c4p5ftCLMKibtdSrTGJlXPrumHB/tz/29A
	FXj9cas1rfw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E65B28BD0;
	Wed, 17 Dec 2014 17:31:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA8E628BCD;
	Wed, 17 Dec 2014 17:31:37 -0500 (EST)
In-Reply-To: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl> (Peter
	Wu's message of "Wed, 17 Dec 2014 15:18:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76CA7730-863C-11E4-932B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261500>

Peter Wu <peter@lekensteyn.nl> writes:

> git remote set-url knew about the '--push' option to update just the
> pushurl, but it does not have a similar option for "update fetch URL and
> leave whatever was in place for the push URL".
>
> This patch adds support for a '--fetch' option which implements that use
> case in a backwards compatible way: if no --both, --push or --fetch
> options are given, then the push URL is modified too if it was not set
> before. This is the case since the push URL is implicitly based on the
> fetch URL.

OK.  In other words, for those without asymmetric configuration
without a need to define pushURL, this default should be the most
convenient, as it does not have to fiddle with two variables.

> A '--both' option is added to make the command independent of previous
> pushurl settings. For the --add and --delete set operations, it will
> always set the push and/ or the fetch URLs. For the primary mode of

"and/or", I think.

> operation (without --add or --delete), it will drop pushurl as the
> implicit push URL is the (fetch) URL.

I think this description is clear enough without "(if exists)" at
the end.

> While '--both' could be implemented as '--fetch --push', it might also
> be mistaken for "--push overrides --fetch". An option such as
> "--only={fetch|push|both}" was also considered, but it is longer than
> the current options, makes --push redundant and brings the confusing
> option "--only=both". Options such as '--direction=...' is too long and
> '--dir=' is ambiguous ("directory"?). Thus, for brevity three new
> options were introduced.

Sounds sensible.

> @@ -134,7 +134,15 @@ Changes URL remote points to. Sets first URL remote points to matching
>  regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
>  <oldurl> doesn't match any URL, error occurs and nothing is changed.
>  +
> -With '--push', push URLs are manipulated instead of fetch URLs.
> +With '--both', both the fetch and push URLs are manipulated.
> ++
> +With '--fetch', only fetch URLs are manipulated.
> ++
> +With '--push', only push URLs are manipulated.

I am afraid that this part is confusing when read in the wider
context of the document.

The first sentence of this section (outside the patch) is "Changes
URL remote points to"; I expect that the most people would think
that it is talking about "remote.*.url" configuration, and the
wording for "--push" in the original is also clear that it touches
'remote.*.pushurl' instead.

In the updated text, you use words "fetch URL" and "push URL" to
mean "regardless of how these are represented by the configuration
system, the URL to be used for fetching/pushing".  In other words,
in the updated vocabulary, 'remote.*.pushurl' is *NOT* called "push
URL" (and 'remote.*.url' is not 'fetch URL').

That may be easier for new people who aren't familiar with the
configuration system (read: I am saying that it may be a good idea
in the longer term), but the phrasing does not make it clear that
they are not referring remote.*.{url,pushURL} variables.

Rephrasing these to "URLs used for fetching" vs "URLs used for
pushing" may make things a bit less confusion-prone.

In any case, we would also need to update Documentation/config.txt
which has these:

    remote.<name>.url::
            The URL of a remote repository.  See linkgit:git-fetch[1] or
            linkgit:git-push[1].

    remote.<name>.pushurl::
            The push URL of a remote repository.  See linkgit:git-push[1].

It may be sufficient to rephrase them like so:

    remote.<name>.url::
	The URL of a remote repository, used for fetching from it
        and pushing into it unless a separate remote.<name>.pushURL
        is defined.  See linkgit:git-fetch[1] and linkgit:git-push[1]

    remote.<name>.pushurl::
	The URL of a remote repository, used for pushing into it
        (if undefined, remote.<name>.url is used to push into it).
	See linkgit:git-push[1].

perhaps?

> +For historical reasons, if neither --fetch nor --push is specified then the
> +fetch URL is changed, as well as the push URL if this was not already set. This
> +behavior may change in the future.

This paragraph is unwarranted.  As you explained in the second
paragraph in the log message, the traditional behaviour was a good
default for majority of people and I do not think we saw any
demonstrated need to deprecate it.

> +#define MODIFY_TYPE_FETCH       (1 << 0)
> +#define MODIFY_TYPE_PUSH        (1 << 1)
> +#define MODIFY_TYPE_BOTH        (MODIFY_TYPE_FETCH | MODIFY_TYPE_PUSH)
> +/* The historic behavior behaves like --fetch, but does not touch the push URL
> + * configuration (and thereby may appear to change the push URL too if this was
> + * not set before).
> + */
> +#define MODIFY_TYPE_HISTORIC    (MODIFY_TYPE_FETCH | (1 << 2))

	/*
         * Our multi-line comment begins with a slash-asterisk
         * without anything else on the remainder of the line
         * and ends with an asterisk-slash, possibly indented
         * and nothing else on it.
         */

Perhaps s/HISTORIC/TRADITIONAL/ or s/HISTORIC/LITERAL/ (the latter
is for "literally update 'URL' configuration for the named remote,
don't play with 'do we have pushURL?' games").

> +	/* Make the implicit push URL explicit if the fetch URL is modified,
> +	 * except when in the historic mode (then the pushurl configuration is
> +	 * not changed). */

Likewise.

Thanks.
