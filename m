From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging using only fast-forward
Date: Fri, 18 Jan 2008 13:25:34 -0800
Message-ID: <7vodbibzch.fsf@gitster.siamese.dyndns.org>
References: <loom.20080116T151930-575@post.gmane.org>
	<863asxivlj.fsf@blue.stonehenge.com>
	<7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	<402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
	<402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFyjB-0004aq-Nk
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 22:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759642AbYARVZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 16:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbYARVZr
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 16:25:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757886AbYARVZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 16:25:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A0CC63056;
	Fri, 18 Jan 2008 16:25:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 213DD3051;
	Fri, 18 Jan 2008 16:25:40 -0500 (EST)
In-Reply-To: <402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Thu, 17 Jan 2008 22:58:50
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71066>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> I have been testing octopus merges and figured it is not very smart with
> respect to fast forward.

Octopus is designed to be simple and stupid.  Its sole purpose
is to bind more than two _independent_ development tracks, and
by definition if they are totally independent, like A and B and
C all forked from the current tip of our HEAD, it should make a
new commit that is children of A and B and C.  If B and C are
not independent (e.g. C is a descendant of B), you should not be
using Octopus to begin with.

The thing is, Octopus makes the bisection (not the internal
processing of "git bisect", but the whole experience with "git
bisect" which is measured by the number of commits you may have
to test to find the one bad commit) less efficient, especially
when the branches that are merged are not independent topics.

So keep it simple, and do not use Octopus if there is no
justification other than "it looks cool" you can come up with.

I do not mind a patch to git-merge-octopus to discurage its use
even more by detecting the casen where some of the merged
branches are not independent and refusing to work, but that is
a post 1.5.4 topic.
