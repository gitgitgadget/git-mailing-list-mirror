From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/14] t/t5505-remote: test multiple push/pull in remotes-file
Date: Sun, 23 Jun 2013 14:49:54 -0700
Message-ID: <7vr4fsebul.fsf@alter.siamese.dyndns.org>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
	<1371887901-5659-12-git-send-email-artagnon@gmail.com>
	<7vobaxfdx9.fsf@alter.siamese.dyndns.org>
	<CALkWK0nFySj_Xztfwjp=FAhz=dBxgmwZ9YG=PY=7HZLfw0P8aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 23:50:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqsAr-0005qd-S8
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 23:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab3FWVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 17:50:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab3FWVt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 17:49:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C0CE2A580;
	Sun, 23 Jun 2013 21:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oQXAmPVTgsmynD1xsfwS1B6DS/4=; b=QpZrPl
	hBxYITnxtdmS9CHdW80z373dqlf2w2fId/TeF7pif4xDIH1Ij+znfkDO81wFHQLD
	U8o7L2kA5P9D9TFI9E6kZOgvd/H8hlJaxeViJCO+6pdJlH2/cf9rCZpTm4PNdbVZ
	+AV7cTtb9LOVHoWmJNBcCyvjWAAvyjAbgVL3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UrYWohoVC9R6BC+uJbXKyKKqhw3Q+X9L
	BjqHq3dIFA3LYOn5Zq5ShPPbcIRHJQavSnGjXrhMRWLq5mNvIr0ACp9EpsiZSQRH
	ctAvla4FcT/gaeZeAVVh6++UKr6PWEcZfK+RbTR90pfISSaimCqxnwHDTHXfPB8w
	ZX5K7rnz3CM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 705BD2A57F;
	Sun, 23 Jun 2013 21:49:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C49A02A57E;
	Sun, 23 Jun 2013 21:49:55 +0000 (UTC)
In-Reply-To: <CALkWK0nFySj_Xztfwjp=FAhz=dBxgmwZ9YG=PY=7HZLfw0P8aw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 23 Jun 2013 13:58:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7A73046-DC4E-11E2-B6C4-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228763>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I disagree.  It is trivial to prove that the tests in t/remote will
> break if this fringe feature breaks: I don't know where "we will never
> know when we break them" is coming from.  

If you remove tests that configure the remotes via the .git/branches
and the .git/remotes mechanism to lose test coverage, and then
remove the call to read_branches_file() or read_remotes_file() from
remote_get_1(), how would you make sure these tests that originally
expected these configuration mechanisms to work notice the change in
behaviour?

> Why should I know about this
> fringe feature when I'm reading/writing tests for fetch-merge-logic?

That is exactly why I asked you at the very beginning:

    I say "minor" only because I think the cost of keeping these old
    mechanisms alive is very low (if it is a heavy burden on the
    maintenance, please tell me and how).

If we are not deprecating and keeping them alive, anybody who is
touching the codepath to deal with "struct remote" should be at
least aware of these mechanisms to keep them working.  If it is a
heavy burden to do so, then keeping them alive is not "minor" at
all.

I've been operating under the assumption, from your response to the
message in the original discussion in v1, that we are in agreement
that we are not deprecating or removing them.

And if we are deliberately keeping them alive, there is no need for
you to paint them "fringe".  You may not use it, and you can write
in your blog or e-mail or whategver that you do not use it, but that
label does not belong to our codebase and documentation as long as
we are keeping them as supported feature.

Of course, .git/branches, being a single liner format, will not get
extended to support richer features that in-config remotes will
learn, so you cannot build on existing tests that use the mechanism
to show new features.  You would need to introduce tests based on
the in-config remotes to demonstrate new features such as the
support for triangular workflow.

Because the .git/remotes/ files are designed to be extensible by
introducing new fields, theoretically it may be possible to extend
it to support new features, but we will not.  We will keep existing
users' existing use cases before new features are introduced in
recent Git alive, without adding anything new.  People will be
migrated out of these old mechanisms over time that way.
