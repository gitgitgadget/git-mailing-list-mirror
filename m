From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sun, 06 Feb 2011 12:04:23 -0800
Message-ID: <7vvd0xvsjc.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmAqm-000251-3e
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1BFUEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:04:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab1BFUEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:04:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5828F4FF6;
	Sun,  6 Feb 2011 15:05:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hjqx5nx/vcQAqSrsit34OyOmyVM=; b=t7BW8m
	m4eLhwvP+UI5VUcbVKlUli0CJP+9tMZytIQqmM7Od/qOiQcti040HulioyaBm9bE
	eyLRg6raFM05LjfvDCMaVZ4clZqly8Vzk/0BXWBadPK6rER6uPciPo42g56JsrRE
	WLR2gHNZFGKRyMkNH5tDetVbl0sAqv6x4O+90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TIPK4YrTyzzg2WknL/k5qcsk1bcMThOO
	Tykgdv6gnW+YCKo7lBYZmS+BWg8S7G/wl0bTqhTxoiRR8I1Q9bHUZQGTGvG11o1A
	VbBnwKJclhVBL6+9Kef9jxFM4qfT3PtoNVRVU7oiKZ9eD6ehprJITjoHhFIVZGsH
	eeIYAJCGh7I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4F5D4FF5;
	Sun,  6 Feb 2011 15:05:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7A234FF1; Sun,  6 Feb 2011
 15:05:21 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1102051449420.12104@xanadu.home> (Nicolas
 Pitre's message of "Sat\, 05 Feb 2011 14\:55\:06 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72E9C8CC-322C-11E0-8912-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166196>

Nicolas Pitre <nico@fluxnic.net> writes:

>> The latter seems like a regression for the common case of fetching from
>> two upstreams. E.g., I usually pull from Junio, getting
>> remotes/origin/v1.7.0.  One day Shawn is the interim maintainer, and I
>> pull from him, getting remotes/spearce/v1.7.0, which he previously
>> fetched from Junio. Under the current code, I can still do "git show
>> v1.7.0"; under the scheme described above I now have to say
>> "origin/v1.7.0" to disambiguate.
>
> Let's suppose that both tags are identical, as in your scenario above 
> they would be, then there is no need to call for any ambiguity in that 
> case.

I agree that we do not want refs/remotes/tags/*/that-tag-people-agree-on
in that case.  We want to store a single copy and find it there, and that
single copy has traditionally been found in refs/tags hierarchy.

I think the real issue is not necessarily that the location is shared with
local tag namespace, but is the lack of a convenient way (or just BCP) to
segregate what are local and what are official when transferring tags out
of your repository.  That is what discourages people from using tags for
their personal and ephemeral use, marking some points in their own work
with personal tags that are never intended to be published.

In the "interim maintainer" case without separate tag namespaces, Shawn
would have been using refs/tags space to auto-follow vX.Y.Z tags that
everybody agrees on and also mark his own progress with local tags, and he
needs to be careful not to push out the local tags he does not want to
share to his publishing repository, lest he contaminate refs/tags in
repositories of other people [*1*]

But the above is less of an issue, for people who use a separate publish
repository with private working repository.  All they need to do is to be
careful when they run "git push".  By default we don't push new tags
(thanks to "matching refs") nor push autopropagates tags when pushing
updated branch heads out, so it suffices only to double check the tag
being pushed is the right one when they run "git push $there vX.Y.Z", and
to make sure they never run "git push --tags".

The problem happens when people directly start fetching or cloning from a
private working-space repository, e.g. my primary integration repository
has several tags that shouldn't go to k.org mixed with the vX.Y.Z tags,
and that is perfectly fine as the organization gives me a uniform way to
call things with names without looking at many places (i.e. refs/tags vs
refs/remotes/*/tags/), yet it does not risk contaminating other people's
tag namespaces because I don't allow anybody to clone nor fetch from it
directly. That breaks down once people can fetch/clone from it.

Thinking aloud and not thinking things through, perhaps what's needed is a
namespace private/local to the repository, i.e. instead of
refs/remotes/*/tags, refs/private-tags hierarchy that I can use to store
local names, and are never seen by fetch/clone?

You can swap naming around and say my (refs/tags, refs/private-tags) can
be expressed with (refs/remotes/origin/tags, refs/tags), and I fully agree
with that argument.  The former is for tags everybody agrees on, the
latter for tags that are private.  The aversion I showed in my message
against refs/remotes/*/tags is coming directly from this observation.

Namely, you can explain refs/remotes/origin/tags with the above line of
reasoning, but how would you explain refs/remotes/$other_names/tags
hierarchy?  What do they mean, how they are useful, etc.



[Footnote]

*1* This issue actually is already present without "interim maintainer".
I have several tags in my primary integration repository that I don't
intend to publish to my repository at k.org; the gitster/git.git
repository I have at GitHub is intended to disclose what I personally
have, including the broken-out set of topic branches, and these tags are
published there.
