From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 12:16:56 -0800
Message-ID: <7v4p011w3r.fsf@gitster.siamese.dyndns.org>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
 <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
 <496D9572.2090303@viscovery.net>
 <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
 <496DA3B2.1070807@viscovery.net>
 <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 21:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNCC5-0004YJ-Ai
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbZANURI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755015AbZANURH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:17:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbZANURG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 15:17:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CAE51C878;
	Wed, 14 Jan 2009 15:17:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 488EB1C840; Wed,
 14 Jan 2009 15:16:57 -0500 (EST)
In-Reply-To: <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
 (skillzero@gmail.com's message of "Wed, 14 Jan 2009 10:33:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D7D09B0-E278-11DD-9AFF-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105697>

skillzero@gmail.com writes:

> Related to this, is there a way to easily find the common merge base
> given a bunch of a branches? When I want to fix a bug, I want to say
> "Given branches A, B, C, D, and E, where should I fork my bug fix
> branch from so that I can merge this branch into all those branches
> without getting duplicate commits?".

You do not necessarily have to fork from, nor merge into, any of them.

If you fixed a bug, you would hopefully know where the bug was injected at
into your history.  You may have bisected it down to one commit $BAD.  You
can fork your fix on top of that $BAD commit:

	$ git checkout -b fix-bug-foo $BAD

All of the branches that share the commit have the bug, so your fix could
be merged to all of them if you really wanted to, and you should do so if
these A...E branches are meant to be consumed on their own.

But if the branches A...E you are about are for developing independent
topics, and if their theme won't get affected by the bug, it is much
better not to merge the fix in.  You will have the merge for the fix in
your integration branch anyway.  It is preferable not to contaminate an
independent topic branch whose purpose is to cook its own theme with an
unrelated bugfix, even if it is brought in as a merge.
