From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] pre-push hook support
Date: Fri, 28 Dec 2012 18:01:45 -0800
Message-ID: <7v1ue9hb06.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 03:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TolkZ-0008UN-0R
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 03:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab2L2CBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 21:01:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab2L2CBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 21:01:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86601A8A5;
	Fri, 28 Dec 2012 21:01:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LhIf1KW+u54b9CWxc2aI4RYbgyg=; b=eUTIdQ
	jPTSdc2cEw3r0wBsBnfF7yaKRezdnegXvi3a2LuDaP4nZcGvUHZ/S9ARVdO3yzE8
	2mT9qa2dQmh8g8jNKP3h18/SNEP+cpqfgKEbomLO5RNOZyokNobaNT6qGWKEF+N/
	llBwYrHOhlfSxBZmvChKJjJFJiUpRiRJom/bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kjQPXYFqDc8au3WZmhlfa2PFyL/zmwOm
	RYCx/HojFyJheRpVUznCa110eo6yKc5bw2ivONwQmAtyXDX5KdFbXZc0EEdnuA5p
	O8DIhV/aTruUwaaEIKdSGbd+NrPT7dYMdqsreq+R+t8/J8/5XN/EZ4COAW9QF3EC
	w1IxbnvlKbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B14A8A4;
	Fri, 28 Dec 2012 21:01:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC70BA8A2; Fri, 28 Dec 2012
 21:01:47 -0500 (EST)
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Fri, 28 Dec 2012 17:57:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3EE4294-515B-11E2-ABB7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212283>

Aaron Schrab <aaron@schrab.com> writes:

> There have been at least a couple of submissions to add support for a
> pre-push hook, which were rejected at least partially because they didn't
> provide enough information to a hook script for it to determine what was
> to be pushed any better than a separate wrapper around the 'git push'
> command would be able to do.  In this series I attempt to address that
> problem.
>
> The first two patches in this series do a little bit of refactoring in
> order to make it easier to call hooks with a variable number of arguments.
>
> The third patch actually adds support for calling a pre-push hook.  If it
> exists, it will be called with the name and URL of the destination remote
> (if a named remote isn't being used, the URL will be supplied for both)
> followed by another argument for each ref being pushed; these arguments
> take the form:
>
>   <local ref>:<local sha1>:<remote ref>:<remote sha1>

One lesson we learned long time ago while doing hooks is to avoid
unbound number of command line arguments and instead feed them from
the standard input.  I think this should do the same.

> This should provide enough information for a script to easily determine
> the set of commits that is being pushed, and thus make a decision if that
> should be allowed.

How does the hook communicate its decision to the calling Git?

Will it be "all-or-none", or "I'll allow these but not those"?
