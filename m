From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 22:09:35 -0700
Message-ID: <7v4pkmt6nk.fsf@assigned-by-dhcp.cox.net>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46896C3B.1050406@jaeger.mine.nu>
	<20070703041241.GA4007@coredump.intra.peff.net>
	<7vhcomt7oa.fsf@assigned-by-dhcp.cox.net>
	<20070703045948.GE4007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Yann Dirson <ydirson@altern.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 07:09:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5adw-0004aV-Mt
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 07:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbXGCFJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 01:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbXGCFJi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 01:09:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48652 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXGCFJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 01:09:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703050935.QNOP22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Jul 2007 01:09:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jt9b1X00P1kojtg0000000; Tue, 03 Jul 2007 01:09:36 -0400
In-Reply-To: <20070703045948.GE4007@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 3 Jul 2007 00:59:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51457>

Jeff King <peff@peff.net> writes:

> OTOH, clearly git-add can "lose" data in this way as well, since a
> "modify, git-add, modify, git-add" will "lose" any reference to the
> index state after the first add. So maybe that is not worth worrying
> about at all (in which case our safety valve is too strict in many
> places).

Exactly.  And not considering that lossage helps us keep our
sanity.  I think "git rm --cached" falls into the same
category.  If the user wants to discard what is in the index
without losing a copy in the working tree, I think we should let
him do without fuss.

>   git-add foo
>   echo changes >>foo
>   # oops, I don't want to commit foo just yet
>   git-rm --cached foo
>
> but in that case, maybe the user doesn't actually _care_ about that
> intermediate state of 'foo'.

Yes, that is (at least, "used to be") exactly the use case "rm
--cached" is supposed to help.  Added something prematurely to
the index, not ready to commit that part of the changes yet.
Of course you could do partial commits with "add --interactive"
these days, so there is not as much need for this as it used to
be anymore.
