From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Mon, 18 Sep 2006 11:43:44 -0700
Message-ID: <7vodtdow0v.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<Pine.LNX.4.64.0609180926590.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 18 20:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPO5u-0005k3-EO
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 20:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWIRSnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 14:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIRSnq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 14:43:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39157 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750927AbWIRSnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 14:43:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918184344.UJVS6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 14:43:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PujX1V00S1kojtg0000000
	Mon, 18 Sep 2006 14:43:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609180926590.4388@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 18 Sep 2006 09:31:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27257>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 18 Sep 2006, Christian Couder wrote:
>>
>> With the new packed ref file format from Linus, this should be
>> the new way to remove a branch.
>
> Well, it's not really sufficient.
>
> Somebody should add this test-case
>
> 	git branch test
> 	git branch -d test
> 	git branch test/first
>
> which should work.

Also this test-case needs to be added

	git branch test
        git pack-refs
        rm .git/refs/heads/test
        git branch test/second

which should barf.  Otherwise it would allow both test and
test/second branches to exist, and trying to clone from such a
repository would fail, at least by the existing tools (it might
have been even nicer if we from day one allowed both test and
test/second to exist, though, but it is too late now, or too
early before we upgrade everybody).

> It's entirely possible that the proper way to do branch deletion with 
> packed branches is to simply re-pack without the old branch, rather than 
> the negative branch model. I couldn't really decide.

Or mkdir there ,-).
