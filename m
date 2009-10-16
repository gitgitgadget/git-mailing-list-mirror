From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 20:00:13 -0700
Message-ID: <7voco8xcua.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910160245310.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 05:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myd5o-0000gz-OG
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 05:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZJPDBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 23:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbZJPDBN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 23:01:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbZJPDBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 23:01:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C2D5A442;
	Thu, 15 Oct 2009 23:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7tJjYDlLFbgmRn03CRiMd4QlCZw=; b=pGgShkjqXlSPaKt4QMPEXMd
	is4w+ARSxLp6hvH+9PwpdQTNIb+v62GS/hGjtPWAAbK9icrPY9y/yZ1g8Q1mAniR
	XhsnA3A7sRfCQkxKmKFNlRAFwdjLggsViTjm4Uw0qFshF38273p09Ppuc9G22utY
	ywvtZFSLaIrZo3vsyEv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wEnWQNb7TJb0JY8HMOwBdwm85MXb8ECQZKKcRA30T2vWCNlvR
	49UZnh7ZLDN3ewKFMRSNfYhvqNbf7o8bE648Fb5a/0EjYm86whkswCZ1g3cWAuCp
	r+anSKrNj07Zv+q/qNX1mE5pOoHaIvVnwzawntAbi75m4VXBV6uRFnZC6I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 248435A440;
	Thu, 15 Oct 2009 23:00:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C40C95A43A; Thu, 15 Oct
 2009 23:00:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D285918-BA00-11DE-A7B7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130448>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In this particular case, I cannot help but notice that commits performed 
> on a detached HEAD will get lost _unless_ they are somehow put onto a 
> named branch eventually.  So the only question is whether you restrict 
> flexibility by requiring to name the branch first before committing, 
> instead of committing and then naming the branch.

You are forgetting another important case.  You may not even want to keep
what you will be committing to the throw-away temporary state.

That is why I liked the proposal by James to introduce a third state
(i.e. not on local branch, but cannot commit) at the conceptual level,
even though as Daniel pointed out and Nico and I concurred later, the
implementation may need to be based on the detached HEAD to avoid "git
fetch" surprises.

You can of course fix it in different ways.  The third state could be
implemented by pointing at a non local branch ref with HEAD, and then by
making fetch refuse to update, just like we refuse a push from side to
make the working tree state inconsistent.

Either way, confusion arising from accidental (or unintended) detaching
would be removed for new users, and that won't have to harm people who
need to (because they _are_ used to) be able to work on detached HEAD, no?
