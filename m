From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 15:33:38 -0800
Message-ID: <7v636lls8d.fsf@alter.siamese.dyndns.org>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nads6-0000y8-QE
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 00:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab0A1Xdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873Ab0A1Xdr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 18:33:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab0A1Xdq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 18:33:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C19795962;
	Thu, 28 Jan 2010 18:33:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OmH67m6vOtB1GJxYGU/Z/ssY3QQ=; b=Y7fqAj
	0DxIa+FD7EYPJdHNmMJpxv55jyNiA3G5Dr+oPeJTXCq0JkDs11dzRZE6wHxO+St8
	KhcLt5RkUvrMRiKofpsMk8QFyHEPwnWWYclxoH0CRnLi/W5KWuwMreNev3hIlMy8
	7UQNSNQ4/bOoFqSVQZaE+W8pEq25cC5GywgL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvaspNzHjgquK6lmu+PYxtEH6PtlStbf
	ybiR+TQFzFB1zW0iqPG7GDjvK+lVxBder+QQke67M3MuX26T+fvINxcrIIaXiYVa
	QezlfO/OBk0n0GoFoMhEeQdklQh0WHM40joOgN5/7BR639GrD1zUvP7g0lLjqpYy
	9X0kSD925gs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A90D95960;
	Thu, 28 Jan 2010 18:33:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3A629595B; Thu, 28 Jan
 2010 18:33:39 -0500 (EST)
In-Reply-To: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
 (Mike Linck's message of "Thu\, 28 Jan 2010 11\:44\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91E5F84C-0C65-11DF-9720-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138285>

Mike Linck <mgl@absolute-performance.com> writes:

> I understand that there are mechanism kind of available to address
> this problem.  If we (all developers in my company) remember always to
> rebase -i before they merge their topic branches back in, then it
> could be squashed making it easier to identify and cherry pick onto
> other branches, or *if* we always remember to rebase before we merge
> and then create a patch set and store that on the topic branch, we
> could kind of organize our change sets that way.

On the quite contrary, probably an easier way is to pick a the oldest
commit that a fix or enhancement would apply, build a topic that deals
with only the fix or enhancement in question without doing anything else
on top of it, and merge the resulting topic.  The choice of the fork point
needs to be made wisely in such a way that the resulting topic would not
cause too much undue conflicts when merged to a modern mainline but old
enough that you _could_ merge the result to any older maintenance branch
if you choose to.

One implication is that you do _not_ rebase the series to newer codebase
because doing so would make the result unmergeable to older releases even
if you later realize that the fix/enhancement would be suitable to them.

And if you fork from older commit than tip, you will automatically get a
non-ff merge when you merge it back to the mainline, which would delineate
the history of the side branch from the integration branches rather
nicely.
