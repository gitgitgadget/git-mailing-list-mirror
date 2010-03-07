From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/7] revert: add --ff option to allow fast forward
 when cherry-picking
Date: Sat, 06 Mar 2010 19:55:23 -0800
Message-ID: <7v6358dbv8.fsf@alter.siamese.dyndns.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
 <20100306203447.2960.42019.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 04:56:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No7ax-0005rZ-Bt
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 04:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab0CGDzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 22:55:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0CGDzn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 22:55:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A2559FCED;
	Sat,  6 Mar 2010 22:55:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kz4pPn6KK+wh5rl4yJVg6HnxYpY=; b=iX7JGf
	AyJANW1QYvv/RDqdwk8xBukZmhEH90rWMQXWAoJafGIigVrsVeXJn0HKvOhVkpaN
	0uIOdn9NPMDUrxpeSetTKYClWUKK8zndOVYe/TLm/nqwIY3gbClIs25XZaAff4EL
	ceq5DI1YYLW3LkIHyYIo6Q+XfewB8drC96YS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxrFUTfNEiOnvLpjyDagA7H2OClzSSwf
	XDhDVsGIX39z8OJlZp+cclX5OcXwlh7m/Nq43tqGn24RMbzoKKBflCv6G0V15Ya5
	7NKzx46Ws67s2NL8XFnLFdaNI+wmR7f6PBs5d8RQfOeQZml/hQYgz6aOwaZmP2fc
	BOCnkJCtTM4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6679FCEC;
	Sat,  6 Mar 2010 22:55:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 536D29FCEB; Sat,  6 Mar
 2010 22:55:24 -0500 (EST)
In-Reply-To: <20100306203447.2960.42019.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat\, 06 Mar 2010 21\:34\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47C265C0-299D-11DF-B19B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141644>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> As "git merge" fast forwards if possible, it seems sensible to
> have such a feature for "git cherry-pick" too, especially as it
> could be used in git-rebase--interactive.sh.
>
> Maybe this option could be made the default in the long run,

I never said that.

For scripted use, like we can see in your [PATCH 7/7], "cherry-pick --ff"
could be a good ingredient (but even then the calling Porcelain script may
already know that what is being picked is a direct descendent (rebase -i
certainly should, as the last commit it processed from the todo file is at
the HEAD), but for manual use case it just feels silly to assume that the
end user is so stupid that s/he doesn't know the commit being picked might
be a direct descendant, which would be the only reason why making --ff the
default might make sense.

And adding --no-ff and sprinkling that to scripts, only to support that
default change as a future possibility, feels doubly silly.

What was the real motive/use case of "cherry-pick --ff"?
