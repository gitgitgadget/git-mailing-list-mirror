From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Sat, 12 Dec 2009 13:45:50 -0800
Message-ID: <7vtyvvn9wx.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.98779.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdGW-0005De-BL
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933441AbZLMB2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933424AbZLMB2q
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:28:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33252 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933423AbZLMB2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:28:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE33A87218;
	Sat, 12 Dec 2009 16:46:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jfltyYAqvwJ/DMqZZacIaHakdjQ=; b=rxrDcGFOrNodg0bz7lDGLSX
	jv4K65g1NuHDjC/XCCXNrVN4Vxlp48991yT2jZH04Fxcjgt+jAtC5KJOyygQwdnk
	e2zxRw0FeXIoTKzXpD47jKdBt7ydLo6xrzXjEMrdn3lOMFUD46c1rXmySn4qvvAP
	hBPbcA+a9b5CqJNCRU4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=R4DlXhjm1BSndUcqTrKamDwKDI6uhfP6Y+upMKIIut19Oh8lD
	cs5YFhvul+7ArfmwV7Md9ms4mAgWlLx20h2jNetOMUn0pPWRqutqE9pZqfXwIheB
	JHT8NXU6imrv8NiLSA7gx53H94h6JnueQx52eQwDxgjVpSuZOkQUuGSBck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 267D087215;
	Sat, 12 Dec 2009 16:46:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7050387211; Sat, 12 Dec
 2009 16:45:51 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF16A99C-E767-11DE-8F76-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135140>

Christian Couder <chriscool@tuxfamily.org> writes:

> It is strange and fragile that a mixed reset is disallowed in a bare
> repo but is allowed in a .git dir. So this patch simplifies things
> by only allowing soft resets when not in a working tree.

I would not mind what you said were "I find the difference strange", as it
is a fairly subjective word.  But if you say "fragile", you would need to
defend the use of the word better.  What kind of misuse does it invite,
and what grave consequences such misuses would cause?  I do not see any
fragility and I would want to understand it better so that I can write
about it in the Release Note to warn people and encourage them to upgrade.

More importantly, I think the difference between the two actually makes
sense.  A bare repository by definition does _not_ have any work tree so
there is no point in having the index file in there.  On the other hand,
even though it is not necessary to "cd .git && git reset HEAD^", I don't
see a strong reason why it needs to be disallowed.

On the other hand, I don't see a strong reason why such a use needs to be
supported, other than "we've allowed it for a long time, and people may
have hooks (they typically start in $GIT_DIR) that rely on it", which by
itself is not something strong enough to veto the change.  It is only a
minor incompatibility and I can be persuaded to listen to a pros-and-cons
argument.

An honest justification might have been "This change to disallow a mixed
reset in $GIT_DIR of a repository with a work tree will break existing
scripts, but I think it is not widely used _for such and such reasons_,
and can easily be worked around.  On the other hand, this change vastly
simplifies the reimplementation of 'reset' _because X and Y and Z_".

> This patch is also needed to speed up "git reset" by using
> unpack_tree() directly (instead of execing "git read-tree").

It is very unclear _why_ it is "needed" from this description.
