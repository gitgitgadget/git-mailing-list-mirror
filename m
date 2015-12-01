From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Tue, 01 Dec 2015 13:47:01 -0800
Message-ID: <xmqqegf57sfe.fsf@gitster.mtv.corp.google.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
	<CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 22:47:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3slX-0006QK-SF
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 22:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbbLAVrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 16:47:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755737AbbLAVrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 16:47:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 289442E2A6;
	Tue,  1 Dec 2015 16:47:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hIyQ5bFmQGMUHFP8zorH3HYsdlA=; b=LURg7Y
	CXpoau3BnBP2V8136CTiPV9qFFDKq1wHw0IUe1BaRCcpm2/htxf98ykloQiDjwxJ
	AIvK7OCRvYJ/BYNsKOnhLmNhU1o8lPNoY5xQ8ogPmCqlHv6WjnmsSTPX15iONCg/
	yXDf6qgKF/ybmOlh3TbTWaqKJZ6Jgp2kHq1/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pb6FuzbWDEYK8cbcOW0Dn4uROz8rR9Ul
	UlLTgh24osTMdhYpEV5wbGKXkd2QRKmfu04ZlDxr8McWQwgSjaaQzoe+YsBEPZq+
	gtTnzUZq8J3akGRC76u4fXH8ErC4TByALE2zG6C5+e42ivUj34hRhDyLZo/mDXc3
	/q3Uy3qLim0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F3C62E2A4;
	Tue,  1 Dec 2015 16:47:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A57CC2E2A2;
	Tue,  1 Dec 2015 16:47:02 -0500 (EST)
In-Reply-To: <CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 1 Dec 2015 13:15:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E858E2A-9875-11E5-BA92-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281856>

Duy Nguyen <pclouds@gmail.com> writes:

> maybe
>
> git clone --commit-id <sha1> repo (*)
>
> instead. Detached head is implied, and this way you don't have to
> disambiguate sha-1 vs refname. And --commit-id can also be added in
> git-fetch. Actually the git-fetch case is even more interesting, what
> do we do with refspec..
>
> (*) as usual, we accept committish sha-1, not just comit sha-1, so
> --commit-id may be confusing..? Or maybe just go with --tag where we
> accept either tag names, tag sha-1 or commit-sha1

I agree with you that it is sensible to think this topic around
"fetch" not "clone".

I however do not think "--commit-id" is a good name for that option.
You are naming the option after what it is that is given, not after
what the commit specified with that commit-id is used for.  It is
just as nonsense as renaming the "--not-merged" option used in
"branch --not-merged $commit" to "--commit-id" because the option
takes the object name for a committish.

Besides, "git fetch" can grab any object, not limited to committish,
which makes "--commit-id" a doubly unsuitable name for the option.

I do not think you would need a new option for this, by the way.
Just add a new syntax for the LFS of a refspec that cannot possibly
be confused with existing choices of what can come there (i.e. an
empty string to denote deletion, or a partial refname), e.g. come up
with an appropriate string in $sign and allow the following:

    $ git fetch ${sign}c78f7b5ed9dc
    $ git fetch ${sign}c78f7b5ed9dc:refs/remotes/origin/frotz

to do the obvious thing, perhaps?  We could even allow some form of
extended SHA-1 expressions with some restrictions (e.g. limit its
use in a protected friendly environment to avoid excessive resource
use at the server side):

    $ git fetch ${sign}c78f7b5ed9dc~12
    $ git fetch ${sign}HEAD@{4}:refs/remotes/origin/frotz

The ${sign} signals two things.  (1) That the endpoint of the
history (or the name of the object being fetched, be it a blob, a
tree and all its contents, a commit and everything reachable from
it, etc.) is specified and (2) that the specification will be
interpreted at the remote side.

Hmm?
