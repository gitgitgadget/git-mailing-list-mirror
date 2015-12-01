From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Tue, 01 Dec 2015 14:22:29 -0800
Message-ID: <xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
	<CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
	<xmqqegf57sfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 23:22:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3tJl-0000FN-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 23:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbbLAWWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 17:22:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757039AbbLAWWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 17:22:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 296393015B;
	Tue,  1 Dec 2015 17:22:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCSO0N7MmmqOZTVaidv6ySjD3MA=; b=k8tJbj
	MfNyhjlR3KpAWoCJNJ+HCRTyNuSOpwVhEVIXadkW35M0gDmo2Jg4fV7okRbYPWI2
	0aJfunlsBD17CmwJ+ssxzaTLS4nb0kUr1ezAIi7KmmxdMxSN9L8o7y0ZyczVxGvv
	sYD0Ymuh0kKa0YyeAGbbwm/NgQapA4pE+QtEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bvSObmvLkB7rzpa3radg8hE5kJlGIWyK
	/qYWvstYE6PrEhrE/fROhDl3Ppj9vsCWwpdCZwZEH9tuXSnY3snYq7VLXJUtUC43
	QCrWMxuiLrS1/ZtlEV4UsF7+vx9g3H+69qNIbB+mleS5KiOmLH7q3DsFqT7una7n
	gtmxkXeS4Lc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 205313015A;
	Tue,  1 Dec 2015 17:22:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7CA9A30159;
	Tue,  1 Dec 2015 17:22:30 -0500 (EST)
In-Reply-To: <xmqqegf57sfe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 01 Dec 2015 13:47:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02DA6398-987A-11E5-98AC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281858>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think you would need a new option for this, by the way.
> Just add a new syntax for the LFS of a refspec that cannot possibly
> be confused with existing choices of what can come there (i.e. an
> empty string to denote deletion, or a partial refname), e.g. come up
> with an appropriate string in $sign and allow the following:
>
>     $ git fetch ${sign}c78f7b5ed9dc
>     $ git fetch ${sign}c78f7b5ed9dc:refs/remotes/origin/frotz
>
> to do the obvious thing, perhaps?  We could even allow some form of
> extended SHA-1 expressions with some restrictions ...

Note that the above example already uses a form of extended SHA-1
expression, and I personally do not think we should support it in
the very initial version.

This is because the actual object name, if resolved on the remote
side, will not be known by "fetch".  To support the "resolve on the
remote end", we would need protocol extension to have the remote end
tell the "fetch", i.e. "you asked to fetch HEAD@{4}, the exact
object name for that is 030000f4c81729d2cb862a317e41a60a7111b98d";
otherwise we cannot add a line to FETCH_HEAD and cannot update the
RHS of the refspec.

Instead, we should limit us to 40-hex object name and nothing else
in the initial incarnation.

i.e.

     $ git fetch ${sign}c78f7b5ed9dc1c6edc8db06ac65860151d54fd07
     $ git fetch ${sign}c78f7b5ed9dc1c6edc8db06ac65860151d54fd07:refs/remotes/origin/frotz

If the remote end (which, as Peff pointed out earlier, already knows
how to respond to a fetch request for an exact object when
configured to do so) allows such a fetch to go through, "fetch" can
(and will) update the ref named by the RHS of storing refspec with
the current code, so there is no need to do anything special to
support this.

As to ${sign}, I was tempted to say an empty string might be
sufficient (i.e. "do not use 40-hex as your branch name"), but it
probably is a bad idea.  A single dot "." would be a possibility
(i.e. a ref component cannot begin with a dot), but squating on it
and saying "anything that begins with . must be followed by 40-hex
(and in the future by an extended SHA-1)" would rob extensibility
from us, so perhaps ".@c78f7b5ed9dc1c6edc8db06ac65860151d54fd07" or
something?  That is leading "." denotes "this is an extended refspec"
and the next character denotes what kind of extended refspec it is.
For now we say that "@" denotes "exact object name is used instead
of a(n abbreviated) refname".
