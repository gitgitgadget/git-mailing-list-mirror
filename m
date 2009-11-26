From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Thu, 26 Nov 2009 11:57:11 -0800
Message-ID: <7vd4355aaw.fsf@alter.siamese.dyndns.org>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 20:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDkT0-0008IL-3Y
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbZKZT5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZKZT5M
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:57:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZKZT5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:57:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8425683D55;
	Thu, 26 Nov 2009 14:57:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2kPGklyf4fEbBq4TB3WpQB/GqvU=; b=sQyAWK
	BIm+7RuoHmSxi4ua5zzGQeeIPhVZMwHkXBs83MWfEZGoUvmqClwQQyAuMvDrZ9gk
	4/GUYaDiXh0SsF5C9avHvjTgz/KO6V58k7UYBJX8pelvbW5vuoYsrDUd3YTfSKw+
	dV2/pU2TdDgp5lE6fZKUxkHw8hbvhmq16Uox0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CxgHHITztI457uwpJUZrDvBlUyIM7Af5
	7NZevUeMLOwHE1bHB5ZC1vP47+DpAcKGK1ObVrvi8qCvnJJUtfPedhA6bPuR4KOZ
	qHs0/caDJmexQyxOQvfY5YfiM39G8LrTe3iF+gcu64eBjv7Zr7tO6lqdDdsz1Jk5
	S+73bjWy0Jc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F6FD83D54;
	Thu, 26 Nov 2009 14:57:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFBBD83D51; Thu, 26 Nov
 2009 14:57:12 -0500 (EST)
In-Reply-To: <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu\, 26 Nov 2009 21\:11\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E507A114-DAC5-11DE-9FEC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133827>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Otherwise 'git format-patch <committish> -- <non-existent-path>' doesn't
> work.

Instead of "doesn't work", I really wished you wrote something like:

    $ git format-patch <commit> -- <path>

    complains that <path> does not exist in the current work tree and the
    user needs to explicitly specify "--", even though the user _did_ give
    a "--".  This is because it incorrectly removes "--" from the command
    line arguments that is later passed to setup_revisions().

Remember that you are trying to help somebody who has to write Release
Notes out of "git log" output.

I actually have a bigger question, though.  Does it even make sense to
allow pathspecs to format-patch?  We sure are currently loose and take
them, but I doubt it is by design.

The patch itself looks good and is a candidate 'maint' material, if the
answer to the above question is a convincing "yes, because ...".
