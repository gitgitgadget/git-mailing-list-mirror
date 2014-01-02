From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Introduce git submodule add|update --attach
Date: Thu, 02 Jan 2014 12:07:08 -0800
Message-ID: <xmqqppoap2qb.fsf@gitster.dls.corp.google.com>
References: <1388368184-18418-1-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyoY6-0005le-7B
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaABUHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:07:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbaABUHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:07:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 470215F1F9;
	Thu,  2 Jan 2014 15:07:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iGWw354Rs0A08hRDn37kuzI2FQs=; b=otcHHO
	BxB6dVGGikMB+9RZC+Ng0uT4z59A8+WeOaBDQ9CuT0ofdNi+CIydKo03+58CWSMx
	oxeoDyJkEdUTyvpsr5Ygfbl1B9F+DcPu8RuM+UqFw52rkkpWwtemv8OOG5OLS4Y2
	xMvDI7RPOgfy5L4eZMajyNcUEB4JwvsKOTDjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bI/angb1EuA0NWnqQigz7Ayo/UZovNay
	fGBJwRsVLT4tPePjmRtzj6c76M+87AaY8dgI0JrWz5VLO0VqeXpSXyFVqpb8Z5Qt
	pcemMSC3Y7ZdypMmHUTuXSR7jMxx+b8oSA7/pfpj0ZBWjIkGgQEH0FkE2n3KXyd8
	1Ru1SUPMwE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F55D5F1F8;
	Thu,  2 Jan 2014 15:07:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90C8C5F1F7;
	Thu,  2 Jan 2014 15:07:10 -0500 (EST)
In-Reply-To: <1388368184-18418-1-git-send-email-ceztko@gmail.com> (Francesco
	Pretto's message of "Mon, 30 Dec 2013 02:49:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76A0106E-73E9-11E3-8EA3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239870>

Francesco Pretto <ceztko@gmail.com> writes:

> by default "git submodule" performs its add or update operations on a detached
> HEAD. This works well when using an existing full-fledged/indipendent project as
> the submodule, as there's less frequent need to update it or commit back
> changes. When the submodule is actually a large portion of shareable code
> between  different projects, and the superproject needs to track very closely
> the evolution of the submodule (or the other way around), I feel more confortable
> to reattach the HEAD of the submodule with an existing branch.

I may be missing some fundamental assumption in your mind when you
did this change, but in a workflow where somebody wants submodule
checkout to be on branches (as opposed to detached), wouldn't it
make more sense not to detach in the first place, rather than
introducing yet another option to "re-attach"?  The documentation of
"submodule update" seems to say that its "merge" and "rebase" modes
do not detach in the first place (and it alludes to "--checkout" but
it is unclear what it does purely from the documentation, as "git
submodule --help" does not even list it as one of the options).

And if there is a good reason why detaching to update and then
(perhaps after verifying the result or cleaning it up?  I dunno what
the expected use case is, so I am purely guessing) attaching the
result to a specific branch in separate steps, does it make sense to
give "--attach" option to "update" in the first place?  That makes
the whole thing into a single step, not giving the user a chance to
do anything in between, which I am guessing is the whole point of
your not using the existing "do not detach, work on a branch" modes.

Puzzled...
