From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Don't copy "submodule.<name>.update" to .git/config on
 submodule init
Date: Wed, 23 Feb 2011 16:34:45 -0800
Message-ID: <7vwrkq46e2.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D65660D.3040501@web.de>
 <7v7hcq8pil.fsf@alter.siamese.dyndns.org> <4D658D8F.2040203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:35:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPAm-00044i-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab1BXAez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:34:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab1BXAey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 19:34:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3365F4B8F;
	Wed, 23 Feb 2011 19:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DngwmUg31WHpmLTDQIPolVJH+iw=; b=SzJV3/
	Z0vp/+UfUHZJGn3H5cJyZNi1GNU+h5/jS9ogwP2mKyzQIlmJJtcLCG/MtyPaY13v
	+xsrUDkWsuuypKuA43P5Pb6oCYmaMk6aDvR9/3fdLvMnuKxOk8xrb7wwnmAM9dZ3
	Sjy3+AjYFIq5we1GDmmWmA1WqtR5yqkz6xMqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGUnyZYZHN3FbokRr2wNORwB8pogLv5t
	cMfOfMiRnvLctXidvU1OcmhmhOUm6CZV9zO1jGCrRxPymgW6e8RalYN1E3IOWLWJ
	2+/K+OEsLxaCRWMjhTw1FZ7ZSAaoGFEVHAj9T6yVa/EjsuTPUH8bSsTeaIwY8C1s
	NDpUCUnJAI8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1005D4B8E;
	Wed, 23 Feb 2011 19:36:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA8164B8A; Wed, 23 Feb 2011
 19:35:59 -0500 (EST)
In-Reply-To: <4D658D8F.2040203@web.de> (Jens Lehmann's message of "Wed\, 23
 Feb 2011 23\:43\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F09B27E-3FAE-11E0-895E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167757>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> And now I read that again I notice that I forgot to add a very important
> sentence, sorry about that:
>
> "Take the setting from .gitmodules if submodule.<name>.update is not
> configured by the user in .git/config."

Yeah, that changes everything.

> My proposal uses the values in .gitmodules for those proposed by upstream
> and those in .git/config as those tweaked by the user. Isn't that simpler
> than 1) and 2) while giving us the same functionality?

It actually is even more flexible, in that it allows the user to say "I
don't care either way; I'll follow along whatever the version that I
happen to have checked out says"; I am however tempted to think that this
particular flexibility is not necessarily a good thing to have.

> And additionally it
> is not setting the upstream default in stone (which is rather arbitrary as
> it just happened to be present in our .gitmodules when we did the "git
> submodule init" and might be different at another point in the history)?

If the setting changes the behaviour of the command so drastically, would
the "I'll follow along" mode be really sensible?  A setting in .gitmodules
might be different between 'maint' and 'master' from the upstream and
depending on which branch is checked out and you are working on, you may
get different behaviour (e.g. 'checkout' vs 'merge' vs 'rebase' depending
on the value-of-the-day in submodule.<name>.update).  Depending on the
nature of the setting, it may or may not be.

The "record once and then help the users to adjust but make aware of the
new duggestion" actually comes from a very old discussion circa 1.5.2
days:

  Cf. http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621

Imagine the upstream URL to fetch submodule from has changed over time.
You don't want to interact with an ancient and now defunct URL only
because you happen to have a checkout of an old version by reading from
its .gitmodules file.  The (2) and (3) in the previous message when taken
to their logical conclusion will be the "seen values" that is hinted in
the above message from May 2007.  Let the user record what s/he wants
under the condition that s/he has seen these choices, and do not bother
her/im again when choices do not change, but do ask permission and/or
confirmation when a new choice appears.  git-submodule script hasn't
learned to do that yet, unfortunately.

In any case, URL is a good example of variables that would want to stay
around (while giving the user helping hand to update it when choice
changes).  "update" would be a good example of a variable that may want to
be per branch (e.g. 'maint' might encourage "checkout" while 'master'
might encourage "rebase").  So most likely we would need to support both
modes of operation.

> Consider the following situation: The .git directories of the submodules
> reside in the .git directory of the superproject so their work trees can
> be safely deleted and we have means to let upstream configure which
> submodules should be populated on clone. (Hopefully this is the future ;-)

Yes, this is very much needed and that is one of the reasons we introduced
the support for textual ".git" file.

> What happens when we fetch a commit which records a new submodule marked
> to be populated on clone in the .gitmodules of that commit? I assume we

Marked by who?  The supplier of the superproject?

> would want to fetch the bare submodule into a subdirectory of the .git
> directory of the superproject so that we have it present so we can
> populate it when the superproject's commit is checked out later, no?

If the user consents (e.g. "git clone --recursive"), yes.

> Should we ask the user if he wants to fetch the bare submodule into the
> .git directory of the superproject or to ignore the clone setting while
> fetching?

If we don't know what the user wants yet, yes.  Note that explicit command
line options "git clone --recursive" and $HOME/.gitconfig counts as the
user letting us know what s/he wants.

> ... Should we ask him again on checkout time if he wants to use the
> upstream setting of checking out the submodule?

Yes if the available choice and/or suggestion by the upstream has changed,
otherwise no.
