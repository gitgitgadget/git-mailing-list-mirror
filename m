From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Mon, 14 Sep 2009 22:50:23 -0700
Message-ID: <7v1vm892ow.fsf@alter.siamese.dyndns.org>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
 <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
 <1252895719.11581.53.camel@localhost.localdomain>
 <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
 <1252970294.11581.71.camel@localhost.localdomain>
 <7v7hw19gr5.fsf@alter.siamese.dyndns.org>
 <1252982329.11581.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 07:50:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnQwF-0007gj-Gu
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 07:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbZIOFub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 01:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbZIOFua
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 01:50:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZIOFu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 01:50:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C706251052;
	Tue, 15 Sep 2009 01:50:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l0PNnGzf9mkPD6N7Qf2lS1qgl6U=; b=TjCVrA
	wMvCF8vUPl9nvaw1wnSH+3GsHIziKJ3HpohPWmpxtK/yK2xkIRphw2cL2aC80r9g
	sYWjjvkUc47V2nuOPTBaC5aui9aoFyThxRg5RheKm2xbEvNxfSrQhFdNMWu6KFfp
	XXM5Wlcq1EfMfvwWf/i30k7z1RhJHr8vIv3D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkXm2aAmDMD3q7U11D3E3la2Ce8FC0An
	/ugTbToJ2duRGKLo3ZOYcxPnf/woxDy0p0Oank3qY99s75IEADZ16aKkPDkYopEw
	iHnMHbEfj8mG+1JF6bchkgALsv1hV+te8A10gmlMRojFb4nxBy0iMWOUaciFcoW8
	9eLA2SA0K5k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9604951051;
	Tue, 15 Sep 2009 01:50:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DECD51050; Tue, 15 Sep 2009
 01:50:24 -0400 (EDT)
In-Reply-To: <1252982329.11581.111.camel@localhost.localdomain> (Owen
 Taylor's message of "Mon\, 14 Sep 2009 22\:38\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACAA1952-A1BB-11DE-A8F9-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128511>

Owen Taylor <otaylor@redhat.com> writes:

> On Mon, 2009-09-14 at 17:46 -0700, Junio C Hamano wrote:
>> Owen Taylor <otaylor@redhat.com> writes:
>> 
>> > If I can figure out the rest of it, I'll look at adding a hook on top as
>> > a sweetener :-)
>> 
>> Please don't.
>> 
>> I seriously suggest you start from, and stick to, nothing but a hook.
>> 
>> The pre-push codepath is conceptually very simple --- something needs to
>> inspect a list of <ref, old, new> and say yes or no.  But what the users
>> want needs great customizability (e.g. Daniel's sign-off validation
>> example).  It's the prime example of codepath that should have a hook and
>> no built-in policy logic.
>
> Let me back up on this a little bit.
>
> Is confirmation a general need?

If you limit it to the confirmation alone, the answer is probably "not
necessarily".  But a mechanism to allow validation logic to be plugged in
probably is.

You might not see a "policy" in your approach, but it makes some troubling
hardcoded policy decisions.  Here are a few examples of what your patch
decides, and makes it harder for other people to build on (rather, "around):

 - We support only interactive validation (confirmation).  If you want to
   have an unattended validation scheme, there is no way to enhance the
   mechanism this patch adds to do so.  You instead need to add yet
   another command line option and hook into the same place as this patch
   touches.

 - We assume "git push" is run from terminal, and the only kind of
   interactive validation we support is via typed confirmation from a line
   terminal "[Y/n]?"  If you want to run "git push" from a GUI frontend
   and have the user interact with a dialog window popped up separately,
   you are also out of luck.

 - We assume it is good enough to have various built-in presentations of
   supporting information while asking for confirmations; there is no way
   for casual end users to customize and enhance it.

I honestly do not want to be a part of "We" in the above bullet points.

I do not object to having a good default presentation and default
interaction (assuming for a while that we limit ourselves only to
"interactive confirmation").  But that is a very different matter from
closing the door for other possibilities, which is essentially what the
approach to use built-in policy logic that is configurable with unbounded
number of future command line options to "git push" is.

> Providing a gnome-contributor-git-setup.sh is generally an approach of
> last resort.

No question about that.  We do not have any complex built-in policy code
that is triggered at post-receive time at all, but many people use the
sample post-receive-email hook we ship unmodified in their repositories,
because the script is written in a highly configurable way.  I do not see
why pre-push has to be any different.

In any case, this topic won't be part of 1.6.5, and we have plenty of time
to prototype and polish it before it goes to the end user.
