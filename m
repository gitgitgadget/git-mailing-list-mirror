From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 14:59:03 -0700
Message-ID: <7vaazvt0pk.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <200910131051.47117.trast@student.ethz.ch>
 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxpX7-0001jO-M1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761490AbZJMWAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 18:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761485AbZJMWAP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 18:00:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761457AbZJMWAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 18:00:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A89F57CA0;
	Tue, 13 Oct 2009 17:59:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QlghfaUyPc1R/r8jObf1tyb3FTw=; b=XEuJsu
	G7njC1/M2MynHjb/+s/LpT8PE/GWf0dHIkAGCXEd3/SObRKes5nML7x1ahmUDs3/
	NqtpwgZWxowJDxc+HQzg9b7j6qDBXvkN6YgkeN5J50V7W0zsW1I1jvX101wY+dYb
	IT6Y0O5aA494/rEOMWqh2c35ct8jTCUSOqyCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AqzxQK4HnBdeoasooNJUtzCD9pM7ZZWt
	DdFq5/WnHP/CeuTP23VSf3sj9KOIR5D6O+XWb4aJV5cHnjQd3Cu9g4yMkDwvZ/s8
	gYMfORKS115sFANHRpIBdvRJmO1NWh6Y378BWWiYRJidM+zv/JcVMuig0Tef/3yI
	NYFNotZSQLM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C7C757C98;
	Tue, 13 Oct 2009 17:59:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CBAB57C91; Tue, 13 Oct
 2009 17:59:05 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue\, 13 Oct 2009 23\:20\:28 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6111D90-B843-11DE-877B-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130222>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So in my opinion, we should DWIM "git checkout $X" to mean "git checkout 
> -b $X refs/remotes/$REMOTE/$X" when there is no ref $X, refs/heads/$X and 
> no other refs/remotes/$OTHER/$X.
>
> Likewise "git checkout $REMOTE/$X".
>
> But, in my opinion, if there is refs/heads/$X and refs/remotes/origin/$X, 
> and the user says "git checkout origin/$X", we should tell the user that 
> there are the options to checkout $X and origin/$X^0 (the latter only if 
> the user really intended to detach her HEAD), but not try to DWIM 
> anything.

I am somewhat unhappy with that kind of inconsistent DWIMery.

Naively I would agree that it would be nice if "git checkout origin/next"
(or "next" when no other remotes/*/next exists) were DWIMmed as "git
checkout -t -b next origin/next".  But the way we _define_ that particular
DWIMmery and the way it appears to an uninitiated would be different.

We define this DWIMmery as s|^(.*)/([^/]*)$|-t -b $2 $1/$2|; iow, when the
user types "origin/next" and other coniditions hold, we pretend as if the
user typed "-b next origin/next".  But it would give an incorrect
impression to an end user "Ah, when my upstream project has next branch, I
can check it out with origin/next (or next)."  But when the user wants to
work further on 'next' by running "git checkout origin/next" the next day,
we say "Uh oh, that is ambiguous and we won't DWIM," which is technically
and implementation wise correct, but breaks the misconception the user
formed with your earlier DWIMmery.  I suspect that the user will be better
off if we do not give a wrong impression in the first place.  If any
DWIMmery gave a conception different from the following four points, that
DWIMmery is actively hurting the users:

 * You clone and get copies of where the other end has its branches;

 * You do all your work on your local branches;

 * You may incorporate what the other end further did by merging from the
   tracking branch from it;

 * You update the other end by pushing what you did on your local branches.

Now, the conclusion of the above embodied in the _current_ UI is:

 * To start your branch to build on what the other end did, you fork your
   local branch at the commit the other end left off, and make sure it builds
   on that tracking branch, with

        git checkout -t -b next origin/next

 * Since "-t -b $2 $1/$2" often appears as a pattern, you can say "-t $1/$2"
   and we DWIM as if you said "-t -b $2 $1/$2".

I do not think loosening the DWIMmery so that "$1/$2" is DWIMmed to the
above would help users.  If the current DWIM is not helping the users
understand the first four points and instead encouraging an incorrect
picture of how the world works, the new DWIMmery would be just as bad, if
not worse.

> IMHO it is obvious that Hannes' suggestion to fast-forward $X and check it 
> out in said scenario has some benefits in certain situations, but dramatic 
> downsides in others.

Yes.

> But I need to drive some very important point home in this thread: 1.7.0 
> was announced to break some old-time habits in favor of a better 
> user-interface.  We _need_ to use this opportunity fully.
>
> Even if that means that a few fingers have to be retrained.  Because 
> retraining a few for the benefit of an easier time with the many others 
> is Just Worth It.

Absolutely.  My point is that this particular DWIMmery would _NOT_ be a
better user interface.  Not for 1.7.0, not for any other release.  It
would not help the users to form a clear world model git offers and that
actively hurts them.
