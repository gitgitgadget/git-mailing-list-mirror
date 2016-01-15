From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/11] config: add core.untrackedCache
Date: Fri, 15 Jan 2016 12:15:19 -0800
Message-ID: <xmqqlh7qha5k.fsf@gitster.mtv.corp.google.com>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
	<1452841192-620-10-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAmU-0004ak-3p
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbcAOUPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:15:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752069AbcAOUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:15:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9782039BA8;
	Fri, 15 Jan 2016 15:15:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yBQUo39eB4nNisIpvgsFRhULH3s=; b=OR0cYC
	4gSu6tKMy540/j3xPt5g5YltbB9OabX89rYnAsCSZaLQbxTwBmpjpAauqsLCE4C3
	imAJfy5m4Hzv82PNkAH1quqAzJ50PQfPzXB7KFzsUouw48rhiaJvt81eqS3eqQDy
	/Xbtts/9TMD0y4c3t0ESclqfMheJGI9wPVnzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iw5TNz+os1qa6CxdVkDzu6g/1jnQc5RS
	E6pJCYTeKLJ2HRCr2jHDAEmLjgISCIqIPJRhwITR0Z2I+1Ncbx3EOKzJnmSDn6gI
	bm832D235uHM8p5HkFtGaSLiirF/F4RkfppNMNUwvTknKrXLUEwU+/BAIiLs+Lnt
	eUl+5ZII6ZE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F22239BA5;
	Fri, 15 Jan 2016 15:15:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CB5E39BA4;
	Fri, 15 Jan 2016 15:15:21 -0500 (EST)
In-Reply-To: <1452841192-620-10-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Fri, 15 Jan 2016 07:59:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B3EDA47A-BBC4-11E5-97FB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284205>

Christian Couder <christian.couder@gmail.com> writes:

> When we know that mtime is fully supported by the environment, we
> might want the untracked cache to be always used by default without
> any mtime test or kernel version check being performed.
>
> Also when we know that mtime is not supported by the environment,
> for example because the repo is shared over a network file system,
> we might want the untracked-cache to be automatically remove from
> the index.

I'd say "fully supported" and "not supported" are bad phrasing.
Network file system may give you mtime, but for the purpose of uc,
it may not be usable, and that is when you do not want to rely on
it.  So perhaps "When we know that mtime on directory the
environment gives us is usable for the purpose of untracked cache",
and "Also when we know that mtime is not usable" or something like
that?

I think "we might want" can become a stronger "we may want" in both
paragraphs.  The second paragraph needs s/remove/removed/.

> The normal way to achieve the above in Git is to use a config
> variable. That's why this patch introduces "core.untrackedCache".
>
> This variable is a tristate, `keep`, `false` and `true`, which
> default to `keep`.

The above makes a reader wonder what are abnormal ways ;-).

    Allow the user to express such preference by setting the
    'core.untrackedCache' configuration variable, which can take
    'keep', 'false', or 'true'.

would be clearer without being muddied by an unnecessary value
judgement.

> When read_index_from() is called, it now adds or removes the
> untracked cache in the index to respect the value of this
> variable. So it does nothing if the value is `keep` or if the
> variable is unset; it adds the untracked cache if the value is
> `true`; and it removes the cache if the value is `false`.

OK.

> `git update-index --[no-|force-]untracked-cache` still adds or
> removes the untracked cache from the index,

The above is meant to be a contraction of "... still adds UC to the
index or removes UC from the index", but reads as if the original
were "... still adds UC from the index or removes UC from the
index".

"... still adds UC to or removes from the index" perhaps?

> but this shows a
> warning if it goes against the value of core.untrackedCache,
> as the untracked cache will go back to its previous state the
> next time read_index_from() is called.

Not incorrect per-se, but

    ... shows a warning ... because the next time the index is read
    UC will be added or removed if the configuration is set to do so.

may make it more clear that `keep` in core.untrackedCache does not
have to issue a warning (I saw your code correctly handles the
warning in this patch).

> Also `--untracked-cache` used to check that the underlying
> operating system and file system change `st_mtime` field of a
> directory if files are added or deleted in that directory. But
> those tests take a long time and there is now
> `--test-untracked-cache` to perform them.
> That's why, to be more consistent with other git commands, this
> patch prevents `--untracked-cache` to perform tests, so that
> after this patch there is no difference any more between
> `--untracked-cache` and `--force-untracked-cache`.

    But because those tests take a long time, `--untracked-cache` no
    longer performs them.  Instead, there is now `--test-untracked-cache`
    to perform the tests.  This change makes `--untracked-cache` the
    same as `--force-untracked-cache`.

> +Untracked cache
> +---------------
> +
> +This cache could speed up commands that involve determining untracked
> +files such as `git status`.

You are being a bit too modest by saying "could" here, I think.  If
you do not want to be overly assertive, perhaps say "is meant to"?

> +This feature works by recording the mtime of the working tree
> +directories and then omitting reading directories and stat calls
> +against files in those directories whose mtime hasn't changed. For
> +this to work the underlying operating system and file system must
> +change the `st_mtime` field of directories if files in the directory
> +are added, modified or deleted.

A reader who read only this without reading the code would wonder if
the code works correctly after a untracked path is added to a
diretory A/B (the timestamp of B would be updated, while A would
stay the same) and we ask what are the untracked things inside the
whole tree.  Of course we shouldn't "omit" scanning A down to B, but
it is a bit unclear that we didn't have such a design bug from this
description.

Unfortunately I don't have a good rephrasing suggestion.

Thanks.
