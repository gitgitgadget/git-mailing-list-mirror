From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 01/11] Documentation: document post-rewrite hook
Date: Tue, 16 Feb 2010 15:59:51 -0800
Message-ID: <7vd404zq88.fsf@alter.siamese.dyndns.org>
References: <cover.1266361759.git.trast@student.ethz.ch>
 <8ee58b83a10dcb302a33136768039729fbebae53.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXKy-0000kb-NX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933571Ab0BQAAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:00:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117Ab0BQAAC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:00:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C969A005;
	Tue, 16 Feb 2010 19:00:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/VkUGrC1XCAtCjdTwZiupzMLsbY=; b=XxllfO/dksvpGO40fUbInMy
	c06AJgWBrVro60YJ1/ivj8xvHYbLFeloLZLnvH4TrDay6PiwR/a9lsFX6Jh8xyaS
	7sFfMbUbnLSAFgbnFXUb/vOKdvxPE/EhEYTANiK1LJ0a/s77xRq1JEUd2RkpJdMr
	h1VUTT77HignT/TuP4lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lFUsIcm7qwrRzNk7XoFfXcj48Nb88tEib8TUeD/TocnHdeQPx
	Fj0Xo8H3T3fq4SRcIchDjvdcaqMjUhvkTmQOySehQVYBceVPNqS4MGlcm3owSw8n
	x94odjldJP5qWfDbqqlSp+pScYdip+iUXfj9nUlHdeXZnLBkoTGk3pYbAE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9201C9A003;
	Tue, 16 Feb 2010 18:59:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96BBC9AFFF; Tue, 16 Feb
 2010 18:59:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62A7459E-1B57-11DF-9589-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140185>

Thomas Rast <trast@student.ethz.ch> writes:

> +rebase::
> +	For the 'squash' and 'fixup' operation, all commits that were
> +	squashed are listed as being rewritten to the squashed commit.
> +	This means that there will be several lines sharing the same
> +	'new-sha1'.

Similar to filter-branch being silent on dropped commits, I presume
"rebase -i" will stay silent if a pick is removed, or rebase --skip is
given.

I wondered if squash/fixup case wants to distinguish the "primary" commit
and "follow-up" fixup commits (not a complaint, but thinking-aloud), but I
think the rebase command itself and this hook have the same amount of
information needed to guess which one is the primary and which ones are
the follow ups, so it probably is Ok.

Is the order of input lines guaranteed in some way?  For example, if I run
rebase to make A B C into A' and B+C, do we get these three lines:

	A -> A'
        B -> B+C
        C -> B+C

in some known order?  If so, should we document that order?
