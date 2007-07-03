From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 21:47:33 -0700
Message-ID: <7vhcomt7oa.fsf@assigned-by-dhcp.cox.net>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46896C3B.1050406@jaeger.mine.nu>
	<20070703041241.GA4007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Yann Dirson <ydirson@altern.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:47:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5aIc-0001gV-4N
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbXGCErf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbXGCErf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:47:35 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43324 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbXGCEre (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:47:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703044734.HWDB11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Jul 2007 00:47:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JsnY1X00V1kojtg0000000; Tue, 03 Jul 2007 00:47:33 -0400
In-Reply-To: <20070703041241.GA4007@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 3 Jul 2007 00:12:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51454>

Jeff King <peff@peff.net> writes:

> H I W | ok? | why?
> ---------------------------------------------------
> N A N | ?   | currently ok, but 'A' recoverable only through fsck
> A B N | ?   | currently ok, but 'B' recoverable only through fsck

These were explicitly done per request from git-rm users (myself
not one of them) who wanted to:

	rm the-file
        git rm the-file

sequence not to barf.  I suspect they were from CVS background
who are used to the SCM that complains if you still have the
file in the working tree when you say "scm rm".

I would not mind requiring -f for these cases.

> With --cached on, it is a little different:
>
> H I W | ok? | why?
> ---------------------------------------------------
> N A N |  ?  | currently ok, but 'A' recoverable only through fsck
> N A A |  ?  | currently not ok, but 'A' still available in W
> A A B |  ?  | currently not ok, but 'A' still available in H
> A B N |  ?  | currently ok, but 'B' recoverable only through fsck
> A B B |  ?  | currently not ok, but 'B' still available in W

I personally do not think we would need any safety check for
"git rm --cached", as it does not touch the working tree.  If
one cares about the differences among three states, one would
not issue "rm --cached" anyway.  The only reason "rm --cached"
is used is because one _knows_ that any blob should not exist at
that path in the index.
