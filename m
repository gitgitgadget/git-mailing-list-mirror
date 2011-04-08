From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 08 Apr 2011 12:27:05 -0700
Message-ID: <7vaag04k8m.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:27:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8HL0-00062L-13
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab1DHT1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:27:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680Ab1DHT1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:27:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F21F4AAF;
	Fri,  8 Apr 2011 15:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DcN+9+/YDfX8qASjdPc+DBqxX3k=; b=N0L+a+
	zKfGqNj0jFGuOjYHVgxmtrBd8kZVLFNuSQp+VXjO7m1SOFXNeiHxZUmp5JPH897l
	gs5rUZRdGZ/AQMbAsyiIpFnmocxSitY7uP2UqbogBAcbJuEpsyNnjh0s0qz56AN8
	yLEvMwRSIVfpuRWE4PRiCT6rE8jVkFhneSydQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkeJ4wcUelURruRh8GyyV01OsRUa5G3p
	IRo9iwexSh5IT3adoYbWY0nH2r7TC30LaMuhV9UL/fxYQxcYzcaHOqDqN663670u
	nqvFd+mJSj/UOw7O1OSJ2xrXCWPijsRwzPyoHlYeYzyE1B/T9L2G5y9KjTiCzzXF
	UUg4rjZ3qkE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B4874AAC;
	Fri,  8 Apr 2011 15:29:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 329904AAA; Fri,  8 Apr 2011
 15:29:02 -0400 (EDT)
In-Reply-To: <20110408175149.GA3917@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Apr 2011 13:54:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7862AEEE-6216-11E0-B094-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171147>

Jeff King <peff@peff.net> writes:

>> What remains is the downside of the configuration variable,
>> namely, that it makes git behave differently depending on who you are and
>> in which repository you are using it, hence making it harder to help
>> and/or teach others.
>
> I have never been a fan of this reasoning. Sure, it is slightly harder
> to help people when the system is configurable. But dropping
> configurability comes at the cost of people who are using the system
> day-to-day. And isn't making it pleasant to use every day more important
> than the minority of times you are telling somebody else how to use it?

I probably should stated it differently.  I dropped it during this round
because they are _not_ needed to help the transition, but it is a possible
additional feature.

Let me try to explain the train of throught a bit better.

People seem to expect "add -u" without any pathspec to work on the whole
working tree structure even when you are in a subdirectory, similar to
"git commit -a".  We will be changing "add -u" in the longer term to do
so.

After the transition happens, people can easily say "add -u ." to limit it
to the current subdirectory, and people can say "add -u ." even today to
be explicit (which would help them transitioning).

Before the transition, however, there is no pleasant way to cause "add -u"
to add everything when you work in a subdirectory, short of saying:

	(cd $(git rev-parse --show-cdup)/. && git add -u)

With ":/", we gain an easy way, "git add -u :/", to say "whole tree".
That is the only thing this series does.

Up to this part, I think we both agree are good thing.

Now, imagine you were born in a world where we had the :/ magic from day
one of git.  Different commands "git add -u", "git grep", "git ls-files"
without pathspec operate differently, and for some reason (e.g. usability,
similarity to other people's corresponding command, or historical reasons)
some of them operate only within the current subdirectory while others
operate on the whole tree.  The default behaviour might even be different
between versions of git or user configuration.

Because we assume that you already have both "." and ":/" to easily be
explicit in that world, "teachers and helpers may have to scratch there
head wasting their time" is no longer an issue.  If you are teaching
others, you ought to know about "." and ":/", and whether we add the
configuration mechanism or not, you ought to know that you should be
explicit to protect yourself from the differences between 1.7.X and 1.8.0
versions in the first place.

So I agree that "costs teachers and helpers" is much less of an issue.

You can certainly introduce configuration variables e.g. "addu.treewide",
"grep.treewide", "lsfiles.treewide" (or even "core.treewide" to cover them
all) to change the default behaviour for each user or each repository.

The real question would become: if it is worth the maintenance cost of
additional code to help users who want to avoid typing "." (or ":/") all
the time in the environment they control.  I don't know the answer to this
question yet.

A good new is that we had to conflate the discussion with "but there is no
pleasant way to tell 'default to local' commands to work on the whole
tree" justification for configuration variables before ":/".  With ":/",
that excuse will be gone and the discussion can be much more simplified.
