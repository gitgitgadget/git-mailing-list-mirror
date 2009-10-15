From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 12:52:55 -0700
Message-ID: <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyWQz-0004p1-U0
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 21:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935267AbZJOTxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758769AbZJOTxy
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 15:53:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZJOTxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 15:53:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 029765ABFA;
	Thu, 15 Oct 2009 15:53:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lL01MobBWbWWvnY7ANhtJngCnbY=; b=TWQcs2
	PppESlO0F0i2da8yo7+d95VG4tsFlbnhrwmlNkQ3aYCMnoSa63Ep5KA53q32FrW8
	NAy2LCLiLUZA9/+iSgM202gRLicODN/M3vwz+D7vv+JBkeck9dFwV3hET5IUD+0y
	qwvNqb+bLO5EU07n+D3FKqh9b4QJ9qJm0nFfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b5T8ZyBPoFIdNQ7yCjyt9K6JtqqoHV7V
	RcaGSMNwxm3hnKB+q8AynVWtWP1Gsv/40sPevymMhS/iiRm2+GxJcwZ17tW6u8Vy
	VexyRbnKc9bFxSWKF410EH9ZZ4mXGIAR1KUxWpS0uBbLCLvGSB4tiTaL2hfoye3b
	38HmUi2yZmM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EDE65ABF9;
	Thu, 15 Oct 2009 15:53:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89D435ABF8; Thu, 15 Oct
 2009 15:52:57 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910151436180.20122@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 15 Oct 2009 14\:51\:00 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A3AE324-B9C4-11DE-9F9F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130416>

Nicolas Pitre <nico@fluxnic.net> writes:

> It is indeed simpler.  It makes the checkout command less verbose as 
> well.  Only the commit command would need to warn the user and only if a 
> forbidden operation is attempted (like committing on a non 
> refs/heads/*). I think I like this.

I like James's suggestion to allow us to store refs other than refs/heads/
in HEAD to denote this state, and keep commit and reset from updating such
a ref through updating HEAD.

We have code to prevent HEAD from pointing at anywhere outside refs/heads/
and that may even be an isolated single codepath we need to tweak.  But I
am reasonably sure that the layers above these core-level routines have
their own checks to make sure HEAD is either detached or points at
refs/heads/ somewhere; we would need to identify and change them as well.
Also things like "git branch" need to be told that HEAD may point outside
of refs/heads/ now to adjust their output style accordingly.  They may
probably strip refs/heads/ (or 11 bytes) assuming that attached HEAD will
never point outside the local branch hierarchy.

So I expect there will be tons of tiny fallouts from a change like that,
but still it is conceptually simpler, and it would reduce the scope of
detached HEAD to a temporary state that is not even worth being named with
a branch name, which is exactly what it is.
