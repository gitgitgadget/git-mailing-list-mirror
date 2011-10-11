From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Symmetric of rebase / more intelligent cherry-pick
Date: Tue, 11 Oct 2011 12:36:13 -0700
Message-ID: <7v8vorfhhu.fsf@alter.siamese.dyndns.org>
References: <20111011155444.GB14417@capsaicin.mamane.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lionel Elie Mamane <lionel@mamane.lu>
X-From: git-owner@vger.kernel.org Tue Oct 11 21:36:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDi7h-0001Xp-VE
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab1JKTgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 15:36:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab1JKTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 15:36:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E1FE5233;
	Tue, 11 Oct 2011 15:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3TaVBymYa5d3yg5CPDRsFbfrNVo=; b=GH6gTH
	ElxRNxpTnSgsEBxAkorov7jDuY4UuobQd97mQE3nAny+/aF1tWwfFSNPq5I6k9Ul
	F0muMQicpZpAwR8bM2PtXvnO+fiQBdOoPAHG6ZKR7xBBciAaX/jLbAUtMJiw2kx/
	RJta/r61IUIF9huj5+tGNjXA9XUnW8UKVYBY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eOyYjAKguSJsiHtxu2I+/DPAzgaj9PsK
	4TnNnlBCH1OuHvFWI3ftS+Vg/lX/2L6rMWiWISdK9Q3Zhz4WbeLgwWwcWheLVhqT
	A1ma6+G/zIoMZP+Cu83DkS5u57a9fVteXZRpACEIBoZiaYJ90fBJCommKULnxEOi
	Kc51ObPeVjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 152E75232;
	Tue, 11 Oct 2011 15:36:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 843AC5231; Tue, 11 Oct 2011
 15:36:14 -0400 (EDT)
In-Reply-To: <20111011155444.GB14417@capsaicin.mamane.lu> (Lionel Elie
 Mamane's message of "Tue, 11 Oct 2011 17:54:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4814D1D8-F440-11E0-B7EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183321>

Lionel Elie Mamane <lionel@mamane.lu> writes:

> git cherry-pick ..UPSTREAM
> *nearly* does what I want, except that it lacks rebase's intelligence
> of skipping commits that do the same textual changes as a commit
> already in the current branch.

I think in the longer term "--ignore-if-in-upstream" that is known only to
format-patch, which is the true source the intelligence of rebase you
observed comes from, should be factored out into a helper function that
can be used to filter output from get_revision() in other commands, or
perhaps get_revision() itself might want to learn it.

I say "or perhaps might" above, because I do not think the general
revision traversal machinery used by the log family (which cherry-pick's
multi-pick option relies on) has enough information to decide what the
caller means by "upstream" at the point setup_revisions() is called.
