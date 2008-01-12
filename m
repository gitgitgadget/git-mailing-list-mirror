From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 17:53:12 -0800
Message-ID: <7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	<7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVZK-0005Xq-G7
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbYALBx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbYALBx1
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:53:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbYALBx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 20:53:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C23732DA;
	Fri, 11 Jan 2008 20:53:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 79BF632D9;
	Fri, 11 Jan 2008 20:53:20 -0500 (EST)
In-Reply-To: <9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	(Stephen Sinclair's message of "Fri, 11 Jan 2008 20:33:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70249>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

>>  * If AUTHOR_NAME+EMAIL is different from AUTHOR_NAME+EMAIL that
>>    I would normally get for myself, or
>
> I thought of this, however if the purpose of this is to handle a case
> where you do a commit from a new and unconfigured user account, "that
> I would normally get for myself" is undefined, since this information
> is (rightfully) not propagated by git-clone.  This is why I made it
> unconditional, (or perhaps something you could could turn off, but
> would by default be on), but I figured there would be objections since
> I admit it's not always useful information.

What are you talking about?

In a properly configured repository, telling you who git thinks
you are is _ALWAYS_ useless (that's the definition of "properly
configured").  Just admit it.

The only case it is of any use is to remind people who amend
other people's change.  Showing the AUTHOR for the commit being
created would add value (and the knowledge that git shows AUTHOR
in that situation would help remind you that it will be
recording your own name if you do not see that line).

>>  * If AUTHOR_NAME+EMAIL contains garbage identifier commonly
>>    found when misconfigured (e.g. ".(none)" at the end of
>>    e-mail),
>
> That's more interesting to me.  I just checked my logs and I do see
> that in at least one case, this .(none) was not appended.  The
> computer in question was configured (not by me) with a domain of
> ".local", so the commit has <machinename>.local as part of the email
> address.  However I would imagine this might solve most cases.

Yes, and please notice that "e.g." in my description means "I am
just giving you an example, not the exhaustive list for the
final solution but a hint to one possibly acceptable solution".
".local", "@localhost", "@<distroname>" and ".(none)" are all
plausible red-flag raisers.  There may be more, but I think we
should be able to catch most misconfigurations with simple
rules.

> I still don't understand why git generates a default email address
> instead of just giving an error message; do people actually use this
> scenario?

The official party line to defend the existing behaviour is that
there is no need to configure anything, when the host and gecos
is done properly.  But I tend to agree with you that quite a lot
of systems are not "done properly", and users cannot do much
about it in some cases.  I think most of misconfigured systems
are personal boxes they have control over but not all.

Perhaps we could disable the code that reads from hostname and
gecos, and instead always force the users to configure.  But
that kind of change is not something I'd want to be discussing
right now.
