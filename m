From: Junio C Hamano <gitster@pobox.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Fri, 22 Aug 2014 11:37:19 -0700
Message-ID: <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
	<047d7b624d36142d46050131f336@google.com>
	<20140822154151.GK20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:37:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtiS-0002tc-RB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbaHVShc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:37:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60360 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaHVShc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:37:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 055C13311C;
	Fri, 22 Aug 2014 14:37:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EY8W8btj7nj9R6SH1Xm541g6OkM=; b=cerITx
	dZjn9OHj6KUt9NHdL6f1JdD1eO0B+PyYMabqNGRDW6votbPCLpKzMZC9kP2JZPZm
	nBVQ8rwxdbIjYIncKa2+ha5iwu/r3HNqb6/lCkb0K3fFMKvDRzFesJ1NQERFwpkx
	ZdvZUk8WXTpVpdSyLnD5oK5jl7ISdhQAjYXo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MVZrj4GcFC419v00dG5QxluGm17BNsX6
	FQLdXnwBd9OkUxjyCxs52web7tHJBMUvzEFWCpdl8npyeDprvxCuHzyl+60B5bXB
	aKMmYvZGXVLMZh4yP2LNplpyokr5dfOFf5iMNlmL2Uk0vEswF8i2Rgp89RqJFPZQ
	AdWaAXUv/lU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D98533311B;
	Fri, 22 Aug 2014 14:37:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCB2933105;
	Fri, 22 Aug 2014 14:37:21 -0400 (EDT)
In-Reply-To: <20140822154151.GK20185@google.com> (Jonathan Nieder's message of
	"Fri, 22 Aug 2014 08:41:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5A8EF95A-2A2B-11E4-AF56-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255691>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael Haggerty wrote[1]:
>> Jonathan Nieder wrote:
>
>>> The check-ref-format documentation is pretty unclear, but the
>>> intent is that it would be used like
>>>
>>>	git check-ref-format heads/master
>>>
>>> (see the surviving examples in contrib/examples/). That way, it can
>>> enforce the rule (from git-check-ref-format(1))
>>>
>>>	2. They must contain at least one /. This enforces the presence
>>>	of a category like heads/, tags/ etc. but the actual names
>>>	are not restricted.
> [...]
>> Thanks for the explanation and the pointer.

I wanted to follow this discussion, especially the ellided [...]
"pointer", but had a hart time finding what "pointer" was.

Anyway, the true origin of ONELEVEL as far as I recall was to give
us a way to say "in this code path, we also expect to be fed HEAD,
ORIG_HEAD, etc., so please do not subject us to the 'at least one
slash' rule.", implication of which is that the 'at least one slash'
rule was to expect things are 'refs/<anything>' so there will be at
least one.  Even back then, that <anything> alone had at least one
slash (e.g. heads/master), but the intention was *never* that we
would forbid <anything> that does not have a slash by feeding
<anything> part alone to check-ref-format, i.e. things like
"refs/stash" were designed to be allowed.

That the function does not reject what does not begin with "refs/"
when ONELEVEL is not in effect is just being loose.
