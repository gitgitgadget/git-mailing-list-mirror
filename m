From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 10:31:00 -0700
Message-ID: <7vr4ifejvv.fsf@alter.siamese.dyndns.org>
References: <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
 <20130412161600.GA20492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 19:31:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQhoc-0002m2-8h
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 19:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab3DLRbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 13:31:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab3DLRbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 13:31:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E3FC13369;
	Fri, 12 Apr 2013 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rrpzWl9ykQ15Q0jqbeA53lD4RC4=; b=lYojfl
	mFV3pyKyzdPx2HIIeZ/eYXwVbOtj4GhV2VH0A32fzG79QJPdcssI0MdlrKzjxXNZ
	Jd1bDIlrqLN+gtZymw3OIaYOuF2Tp1Ozg6vq3Ylu+N9cgUwY/di7yDFyaWB653Ki
	iUnNLOPShPWMeCHQ/JcHJE/ennce0Cdk/i4To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DcVZxx4A3viT5i4ExkSncUOp0E/6X80+
	aRRaZWf67Vj+IWbBbbPS1NiEkvupFBkSTY7043mFMJWW7vubmQ/SH0JPu3upOgGM
	DHpGkCxhXagQ/KKn3gMjequ9u2siyzf6yTK3zuPbDLWj2x9oD24p56w2KzkZ9h/q
	RhbWg9prlec=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1689113365;
	Fri, 12 Apr 2013 17:31:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 788181335F; Fri, 12 Apr
 2013 17:31:02 +0000 (UTC)
In-Reply-To: <20130412161600.GA20492@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 12 Apr 2013 12:16:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF55D592-A396-11E2-A8B4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221006>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 12, 2013 at 09:08:31AM -0700, Junio C Hamano wrote:
>
>> OK, then...
>
>> -- >8 --
>> Subject: [PATCH] doc: clarify that "git daemon --user=<user>" option does not export HOME=~user
>
> I'd add this motiviation to the body of the commit message:
>
>   The fact that we don't set $HOME may confuse admins who
>   expect $HOME/.gitconfig to be respected. And worse, since
>   96b9e0e3, a git-daemon started by root is likely to fail
>   to run at all, as the user we switch to generally cannot
>   read ~root.
>
> This still feels ugly, like we are documenting some gotcha
> that is going to hit most admins, when we could be helping
> them in the code.

I agree that it feels a bit wrong to sound as if we are blaming the
messanger (the one that notices a possible misconfiguration), but
you are correct that we should make a note on why we think it is a
good idea to add this piece of extra documentation in the history.

Will add the above before queuing.

> One option we have not explored is an environment variable
> to loosen git's requirement. I'm thinking something like
> GIT_INACCESSIBLE_HOMEDIR_OK, which could be set by default
> when git-daemon uses --user.
>
> That would leave all existing setups working, but would
> still enable the extra protections for people not running
> git-daemon (and people who use git via sudo could choose to
> set it, too, if they would prefer that to setting up HOME).

Perhaps.

Right now, the only case people noticed was that we complain when
the effective user cannot even tell if config file(s) exists or not.
Labelling this option as "Treat unreable as missing" is fine, but
"an inaccessible homedir is OK" is vastly different.  Imagine a new
version where we start _requiring_ something to exist (and we read
from it) and imagine further that the expected place of that thing
is somewhere inside $HOME. We cannot keep the promise to those who
set "an inaccessible homedir is OK" option when that happens, as we
may need that piece of information we wanted to read from there in
order to properly operate.

In any case, I think the loosening is an independent issue.
