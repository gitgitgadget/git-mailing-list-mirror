From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 06 May 2013 10:06:29 -0700
Message-ID: <7vhaigrqay.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
	<CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 06 19:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZOs7-0007Cz-4J
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab3EFRGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 13:06:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57119 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3EFRGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 13:06:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB49C1C177;
	Mon,  6 May 2013 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bu7W5lP/f5V7Avu3Cf34N3iSbXw=; b=Darlt9
	aAO6Le/W5bVd2yTjKhq7SWUZuzPktyTz3krk4jmPTPiRhldP9zKlRr4h/ed6D+8o
	H31DTYng9msJQxno70vj/e7apBYqiPhVw9EMrJqr0AEDalbhvxq5RAj13oNS3rbN
	B7joW/JrlAUzmXHGTvMz4ZR5TsuoWRzc/okaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkkvcuCASON9oU9x7hMEQIHt7Wvv+1v5
	X9ueDmTEG8BBjGanT1FYJRGSLHqncasN3J2fhv5AeD+de9K1VtyCZYbchUIqmuOg
	WOh08IkEIghHL/kXNh8HCpEXZV+2y53eeOUUfhFfoiaoD1Vo5sCXU5mUss0Mg62F
	kUqbZ4ZYK7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C221C176;
	Mon,  6 May 2013 17:06:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 091AE1C175;
	Mon,  6 May 2013 17:06:30 +0000 (UTC)
In-Reply-To: <CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
	(Johan Herland's message of "Mon, 6 May 2013 00:26:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C31C3F0-B66F-11E2-84CB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223473>

Johan Herland <johan@herland.net> writes:

> Let me try to summarize my views on how refnames should work in Git, to
> see if we can identify where we differ on the principles (or if we, in
> fact, differ at all):

Thanks; I think I already said where I think we differ in a separate
message, but a short version is that the point of remote.$nick.fetch
mapping is to solve "The remote may call a ref $this, which is not
the refname I want to or can use in my repository, so here is the
rule to use when importing it in my local namespace.  With the
mapping, I can name the ref in my local namespace conveniently."
E.g. their "refs/heads/master" cannot be our "refs/heads/master" at
the same time, so use "refs/heads/origin/master".

The result of the above mapping, be it remotes/origin/master or
remotes/origin/heads/master, should be designed to be useful for the
local use of the ref in question.  If you further need to remap it
when using it locally, there is something wrong in the mapping you
defined in your remote.$nick.fetch mapping in the first place.

We do not force any structure under refs/remotes/; it is left
entirely up to the user, even though we would like to suggest the
best current practice by teaching "clone" and "remote add" to lay
them out in a certain way.

Another thing is that refs/remotes/ is not special at all.  If notes
hierarchies taken from a remote need to be somewhere other than
refs/notes/, it is perfectly fine to introduce refs/remote-notes/ if
that is the best layout when using them locally.  What is special is
refs/heads/ in that they are the _only_ refs you can check out to
the working tree and directly advance them by working on the working
tree files.

> I would support disallowing multi-level remote names, although I don't
> know if it is commonly used, and would break many existing users.

I somewhat doubt it.

We very much anticipated the use of multi-level branch names from
the very beginning and have support (e.g. in "for-each-ref" and
"branch --list") to group/filter them according to prefixes, but I
do not think there is anywhere we consciously try to give support
for multi-level remote names to treat groups of remotes that share
the same prefix.

>> *2* Perhaps "bar" in the above is spelled "topics", and the
>>     hierarchy may be used to collect non-integration single topic
>>     branches from more than one remote.  An example that is more in
>>     line with such a usage might be:
>>
>>     [remote "jh"]
>>         fetch = +refs/heads/*:refs/remotes/topics/heads/jh/*
>>     [remote "jk"]
>>         fetch = +refs/heads/*:refs/remotes/topics/heads/jk/*
>>     [remote "fc"]
>>         fetch = +refs/heads/*:refs/remotes/topics/heads/fc/*
>>
>>     and I would expect "git merge topics/jh/rbranch" to merge the
>>     "refs/remotes/topics/heads/jh/rbranch" topic branch.
>
> I like the use case, but not necessarily your expectation. ;-)
>
> With the above configuration, and my series as-is, you could simply do
> "git merge jh/rbranch" to merge the "refs/remotes/topics/heads/jh/rbranch"
> topic branch.

That dropping of 'topics/' is the issue.  The user wanted to group
them under 'topics/' hierarchy and made a conscous effort to set up
the fetch refspec to map these refs there.  These are done all for
convenience when she deals with refs in her namespace in the
repository.  What justification do we have to second guess the user
and force her to drop it when naming these refs?

> Furthermore, I don't see why you want/need the extra
> "heads/" level in the refspec.

Just like you wanted to have separate kinds of refs under a single
remote, the layout is grouping kinds of refs other than branch heads
related to the "topics" (as opposed to "integration branches").
