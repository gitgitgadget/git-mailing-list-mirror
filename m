From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 14:42:08 -0800
Message-ID: <7v63zqj6bj.fsf@gitster.siamese.dyndns.org>
References: <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<20071123103003.GB6754@sigill.intra.peff.net>
	<Pine.LNX.4.64.0711231319220.27959@racer.site>
	<20071124113814.GA17861@sigill.intra.peff.net>
	<alpine.LFD.0.99999.0711241042011.9605@xanadu.home>
	<7vtznbqx2w.fsf@gitster.siamese.dyndns.org>
	<20071125215128.GC23820@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:42:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwQBS-0002p5-Vu
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 23:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633AbXKYWmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 17:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757525AbXKYWmT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 17:42:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60834 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420AbXKYWmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 17:42:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 816122F0;
	Sun, 25 Nov 2007 17:42:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D1D9D998FF;
	Sun, 25 Nov 2007 17:42:31 -0500 (EST)
In-Reply-To: <20071125215128.GC23820@fieldses.org> (J. Bruce Fields's message
	of "Sun, 25 Nov 2007 21:51:28 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66022>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Anyway, here's a first draft.
>
> --b.
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 8355cce..7544715 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> ...
> +Normally whenever a branch head in a public repository is modified, it
> +is modified to point to a descendent of the commit that it pointed to
> +before.  By forcing a push in this situation, you break that convention.
> +(See <<problems-with-rewriting-history>>).
> +
> +Nevertheless, this is a common practice for people that need a simple
> +way to publish a work-in-progress patch series, and it is an acceptable
> +compromise as long as you warn other developers that this is how you
> +intend to manage the branch.

Note that modern git allows repository owners to forbid such a forced
non fast forward push at the receiving end.  In such a case, you cannot
even force a push.

Instead, you would need to fetch the current branch tip from the remote
and merge it into the branch you were tring to push, possibly using the
"ours" merge strategy, before pushing it again.  Use of "ours" merge in
such a case:

 - makes the next fetch by other people properly fast-forwarding;

 - records your admission of guilt: "I screwed up the last push and
   this is a replacement --- this is what I really should have pushed
   the last time".

 - makes the resulting tree exactly the same as what you tried to push
   unsuccessfully.  This is a valid substitute to a forced push in that
   it reverts the mistakes _you_ made with the previous push.
