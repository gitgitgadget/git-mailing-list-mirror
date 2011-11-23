From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: create meaningful aliases for git reset's
 hard/soft/mixed
Date: Wed, 23 Nov 2011 10:51:47 -0800
Message-ID: <7vlir6brjw.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 19:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTHvO-0001eS-0S
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 19:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1KWSvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 13:51:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab1KWSvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 13:51:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C2F06BBB;
	Wed, 23 Nov 2011 13:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DJteBdBN0qCbpBsCv6o35Vqgl4M=; b=NudFAe
	FDO51JCsHjjfdp5aSy/7QWtcVyNGhBcl3dvzy0h3X31LOXh0rTROY3mNHjpKvRjE
	4D/dW8JdIsTN969jFXpexvd9kElD173dJJx7n8KkSK+BR3aPdTFqVF9ixqwcTsz+
	+jaY1kYKDFPO3SqKOBfxSMjRn8sj/kSLUPAWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J6CJUbHUTNnQzUYaF4H8iKHdxflvEQsP
	a0GUPaL+H8P3XcaLFHfR2lfyZRHo71piLJwVL2/IXxpKNrAjfFxQd2AXIjWSPP4B
	rcZISh04QHOydcI3qh8q4I/dqwm4VbEG4itC9kKpzBj5iNI9LWLXQUqz6ec6Qe1G
	/Ijbyy0lf78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42C3A6BBA;
	Wed, 23 Nov 2011 13:51:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 796996BB7; Wed, 23 Nov 2011
 13:51:48 -0500 (EST)
In-Reply-To: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 (Philippe Vaucher's message of "Wed, 23 Nov 2011 09:28:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32C20220-1604-11E1-A4FB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185863>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> So if I recap my ideas:
>
> "I want to discard my changes" --> git reset --all HEAD^

That is discarding your changes and also the last commit.

> "I want to discard the last commit" --> git reset --index HEAD^

I do not think this has a clear meaning. "discard the last commit but
leave the contents in the working tree. I do not care a newly added files
are forgotten by the index, I'll remember to re-add them if I need to" is
what you are saying here, but the word "index" does not hint it.  When
used as an option name, "--index" means "this command usually works on or
touches working tree but for this invocation please also affect the index";
"please look at or affect _only_ the index" is usually spelled "--cached".

In any case, I think your proposal makes it even worse than the current
state, and you should aim higher. Some modes of "git reset" have
historical reasoning behind their behaviour that cannot be dismissed
easily by somebody who does not understand them, but at the same time some
of them outlived their usefulness and we may want to start thinking about
deprecating them. The first step might be to make them less prominent in
the documentation.

I am guilty of introducing "git reset --soft HEAD^" before I invented
"commit --amend" during v1.3.0 timeframe to solve the issue "soft" reset
originally wanted to.  Even though the whole point of the "reset" command
is about "resetting the index", it is an unfortunate oddball that does not
touch the index. It shouldn't have been part of the "reset" command, and
if we were doing Git from scratch today, we probably wouldn't have it
there. What it does is sometimes useful in interactive use and often
useful in scripting, but scripts can use update-ref.

"git reset --hard HEAD" is an unambiguously descriptive good name for the
option. It is a "hard reset" like power cycling a machinery to discard
anything in progress and get back to a clean slate. I do not see anything
confusing with this mode nor its name.

"git reset --keep" was introduced at 9bc454d (reset: add option "--keep"
to "git reset", 2010-01-19) as a short-hand to run something like this.

    git checkout -B $current_branch $target_commit

If we made the above command line to work (it errors out saying you cannot
update the current branch) instead of adding it a new mode to "reset", it
would have been much easier to understand what the particular operation
does. You are updating the tip of the branch that happens to be the
current branch to a different commit while carrying the local change with
you.

It also would have made number of options "reset" has smaller by one and
reducing confusion. What it does is too similar to what "reset --merge"
does, which only adds to the confusion.
