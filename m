From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict resolution.
Date: Mon, 11 Aug 2008 11:47:01 -0700
Message-ID: <7vmyjjxuca.fsf@gitster.siamese.dyndns.org>
References: <1218368935-31124-1-git-send-email-ams@toroid.org>
 <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080811023053.GA9144@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScRe-0004nA-Js
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbYHKSrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756229AbYHKSrK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:47:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbYHKSrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:47:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C9DB55B56;
	Mon, 11 Aug 2008 14:47:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EDB7255B54; Mon, 11 Aug 2008 14:47:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E5B35734-67D5-11DD-9BFA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91971>

Abhijit Menon-Sen <ams@toroid.org> writes:

> It was a dark and stormy night. Sam struggled to keep his eyelids open
> as he integrated yet another gigantic patch series. Ever the optimist,
> he'd pulled in the changes, only to discover several merge conflicts.
> But the night was young then, and he'd fixed them all by hand.
>
> It was only later that he noticed many lousy, one-line commit messages.
> Undaunted, he reset his branch and began to cherry-pick patches, giving
> them a once-over, writing a comment here, squashing the odd grotesque
> hack there, and writing sensible commit messages more often than not.
>
> But even that was hours ago, and each new but oh-so-familiar conflict
> ate into his determination like maggots through decaying meat; and Sam
> was beginning to question the wisdom of staying in this fruit business.
> His whiskey was running low, and time was running out.
>
> "If only", thought Sam, "If only cherry-pick would..."

That's cute, but I do not think that story is a good example.

By "pulled in the changes" do you mean "he merged somebody else's work"?
If so, the cherry-pick would be doing rebase of the series manually, and
as you already may know, you are not supposed to be rebasing other
people's work.  And if you are indeed rebasing, that would not be a good
example of cherry-pick, either.

Do you mean instead "he applied many patches, but there were conflicts and
he wiggled them in?"  If so, at the resolution time rerere() wouldn't have
recorded them in the first place, and more importantly, what you would be
cherry-picking won't have conflicts.  What the second paragraph describes
is what he would do with "git rebase -i" on top of the same base, so there
won't be merge conflicts, and even if there were, the use case is again
about rebase and not cherry-pick.

A better example would be if you have two (or more) maintenance tracks
from similarly old vintage and a far more advanced development track, and
cherry-picking from that development track to backport a fix down to one
of the maintenance track would have conflicts you need to fix.  Then you
would face the same conflict while propagating the same fix to another
maintenance track.  But even then, you would most likely cherry-pick the
cherry-picked fix from the maintenance track, which would be conflict
free, instead of cherry-picking it from the development track.
