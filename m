From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore: root most patterns at the top-level directory
Date: Tue, 27 Oct 2009 23:03:28 -0700
Message-ID: <7vmy3cys0f.fsf@alter.siamese.dyndns.org>
References: <20091027011024.GA29361@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N31dI-0002DJ-MO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 07:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbZJ1GDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 02:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756754AbZJ1GDe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 02:03:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753AbZJ1GDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 02:03:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D768D6980A;
	Wed, 28 Oct 2009 02:03:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cTwYBooUew7lScMdcB6jNo+nG7M=; b=tG9Kkb
	uDklaZREz37k4RTrLxTlUyYi5DlVyglVW8DQSRZssfL5W+bbIneoQ2/Vgsbog54K
	W5Ay7V6R0VC7dV4nYm8btvx3RiPsZzKaLVysVJMcWGE3vYyy1qXRp/Re2qjgs5RD
	G7MFB2sBrvld8VjslBbInUesC7CQQCgA3dydo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P3hl1ccBtN/BoPZ5hS4mG+bxbuWmdhu6
	+pmHiHWeEKvGezR1rdEFvnUow3/8zGfxjILPQ1VUF5YZjAo3lg11FVX8w6WvRi9p
	ZdliTbQJHE8jGYm4qEGQZsCTv6qF5HimeddqxQoaYeSIYCdAxbPwJ2flhrFSkjoh
	A/cmZmdh8SE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8B1169808;
	Wed, 28 Oct 2009 02:03:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8440169807; Wed, 28 Oct
 2009 02:03:31 -0400 (EDT)
In-Reply-To: <20091027011024.GA29361@sigio.peff.net> (Jeff King's message of
 "Mon\, 26 Oct 2009 21\:10\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A06DCA9C-C387-11DE-806D-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131407>

Jeff King <peff@peff.net> writes:

> Our gitignore doesn't use a preceding "/" to root its
> patterns in the top of the repository. This means that if
> you add a file or directory called "git" (for example)
> inside a subdirectory, it will be erroneously ignored.
>
> This patch was done mechanically with "s/^[^*]/\/&/" with
> one exception: instead of ignoring gitk-wish, we should
> gitk-git/gitk-wish (arguably, this should be done in
> gitk-git/.gitignore, but because that is a subtree merge
> from elsewhere, this is easier).
>
> Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>
> This bit Sverre while I was looking over his shoulder. I doubt it comes
> up very often, but we should probably be modeling good gitignore
> behavior. I have to admit it looks a lot uglier, though.

How does .cvsignore and .svnignore work?  Don't they have the same issue,
and perhaps worse as I do not recall seeing a way to anchor a pattern to a
particular directory like we do in their .SCMignore files?  And judging
from the fact that they can get away with the lack of that "feature", this
perhaps is not an issue in real life?

I am actually a bit reluctant to queue this, even though I most likely
will, and then hope that we will think of a better solution later, at
which time this file again needs to change.

For example, it crossed my mind that perhaps we can change the ignore
rules so that a non-globbing pattern is automatically anchored at the
current directly but globbing ones are recursive as before.

If we do so, there is no need to change the current .gitignore entires.
You need to spell a concrete filename as a glob pattern that matches only
one path if you want the recursive behaviour.  E.g. if you have a Makefile
per subdirectory, each of which generates and includes Makefile.depend
file, you would write "Makefile.depen[d]" in the toplevel .gitignore file.

But that is a kind of incompatible change whose necessity is unproven and
has to cook and wait.
