From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Mon, 10 Oct 2011 09:45:30 -0700
Message-ID: <7vaa98okwl.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <4E91FD57.7050808@drmicha.warpmail.net>
 <7v4nzhrebp.fsf@alter.siamese.dyndns.org>
 <4E92919F.2030007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 10 18:45:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDIyy-0006yn-DA
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 18:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1JJQpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 12:45:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219Ab1JJQpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 12:45:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96CA95488;
	Mon, 10 Oct 2011 12:45:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PZB5Lh0v0kHBzcWVMs4oX73OLmo=; b=kHK3yI
	9zFvPjm98cebZuOGNydmrlKtso8YZySw+hDSIF8G5/kNJ25KjOr0YTjbn0NXUBsn
	2BN6ntC8LmUhVg989RRmFq5ToRmtHKGYGhzKosuap+JyVNwlsSupWUDLJaDGhQM0
	FhtkEsgt312IN3y5WgU35+NX+WZCqgfIwP02s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CMvQvNrjYPyjJLFCJQcWMqeRzT9LC1pu
	vy9ZAxAMnNCcfl7o27dkjPZnnERLBI2TYfj9yXdNOPFIrPGpFrJ7S/SJWVWLDv7l
	IobcOQ/lvRbRY2rYAKtOmY6qMpd7Hl1rIsH2OnpuyzZshT9WqtnnIq86uncPfJ6v
	knntOBxavnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0805487;
	Mon, 10 Oct 2011 12:45:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210DF5486; Mon, 10 Oct 2011
 12:45:32 -0400 (EDT)
In-Reply-To: <4E92919F.2030007@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 10 Oct 2011 08:33:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44B7F6DC-F35F-11E0-8088-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183247>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> What norm? --amend keeps some header fields and discards others. In
> fact, signing a commit "without changing it" (i.e. keeping tree, parents
> etc., alias "--amend -C HEAD") should be the normal use case for signing
> the tip of an existing branch. I mean, I have no problems adding to this:
>
> git help fixup
> `git fixup' is aliased to `commit --amend -C HEAD'

You are *additionally* saying "-C HEAD" in an non-standard alias. Isn't
that enough indication that a vanila "--amend" is intended to record the
commit based on the updated context in which the new commit is made?
E.g. the authorship of the patch is still the same but committer
information is updated.

> But what is the best default for the workflows that we encourage (commit
> early, ...)? You answer a pull-request which happens to be a
> fast-forward, sign the tip and suddenly you've taken over ownership (and
> changed dates)??? Signing a commit should not do this.

I personally think a pull that is made in response to a pull-request,
i.e. the upstream merging from lieutenant, especially when the
authenticity of the puller matters, is perfectly fine with --no-ff.

Unlike the sign-less "we together made these history and nobody really
owns the result" (aka "Linus hates --no-ff merge because people do that to
leave a mark by peeing in the snow, without adding anything of value in
the history"), the whole purpose of signing a commit in the scenario you
mentioned is for the puller to leave his mark in the history.
