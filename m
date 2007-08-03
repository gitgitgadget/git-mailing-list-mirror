From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Fri, 03 Aug 2007 16:36:56 -0700
Message-ID: <7vlkcskx5z.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708031121000.14781@racer.site>
	<7vir7wmk84.fsf@assigned-by-dhcp.cox.net>
	<vpqps24i9sx.fsf@bauges.imag.fr>
	<7v1wekmgo8.fsf@assigned-by-dhcp.cox.net>
	<vpqir7wi5oc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6hv-00040V-Dx
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbXHCXg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbXHCXg6
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:36:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:47021 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbXHCXg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 19:36:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803233656.RKGS7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 19:36:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xbcw1X0011kojtg0000000; Fri, 03 Aug 2007 19:36:56 -0400
cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <vpqir7wi5oc.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sat,
	04 Aug 2007 01:01:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54770>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> "git-status $args" on the other hand is a preview of "what would
>> happen if I say 'git-commit $args'", and in order to compute
>> that, you would fundamentally need to be able to write into the
>> object store.  In a special case of giving empty $args it can be
>> read-only.
>
> Can you give an example where it _could_ not be read-only?

Think of what "git commit -a" would have to do.  It needs to
hash and deposit a new object for blobs that have been
modified.  Where do those new blob object go?

> In the same way, I expect git-status to be read-only for the user. You
> say "what _would_ happen _if_ I say commit $args". But you don't
> commit, the sentence is conditionnal. I don't expect any tool to have
> visible side-effects when I say "what would happen if ...".

By running git-status the user is asking to get the overall
picture, discarding the "touched but not modified" information.
Once you _HAVE TO_ refresh the index for whatever reason, it is
better to keep the result of the effort and cycles spent for
that refresh operation for obvious performance reasons in
practice, and that is what we have now in git-status.  IOW, we
are practical bunch.

Maybe in a theoretical ideal world, you might prefer to
reverting back to the stat-dirty original index to make
git-status appear a read-only operation, with continued degraded
performance.  You are welcome to reimplement it that way, and
the patch should be trivial (while git-commit.sh is still a
script, at least) but that is not what we did.
