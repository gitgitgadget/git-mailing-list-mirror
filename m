From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then sorting on add
Date: Wed, 18 Apr 2007 12:36:20 -0700
Message-ID: <7vodllfpaj.fsf@assigned-by-dhcp.cox.net>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
	<Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
	<7vslaymzk3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704172304380.16435@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeFx5-0003k1-0t
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 21:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993082AbXDRTgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 15:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993092AbXDRTgX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 15:36:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58268 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993082AbXDRTgW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 15:36:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418193621.GQRO1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 15:36:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ojcM1W00A1kojtg0000000; Wed, 18 Apr 2007 15:36:22 -0400
In-Reply-To: <Pine.LNX.4.64.0704172304380.16435@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Tue, 17 Apr 2007 23:43:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44934>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Tue, 17 Apr 2007, Junio C Hamano wrote:
> ...
>> I think we would not call add_ref() to the same list with
>> duplicate names, unless (1) filesystem is grossly corrupt, (2)
>> somebody added a new ref while we are walking (how does
>> readdir() behave in such a case???), or (3) packed-refs file is
>> corrupt.
>
> This combined with the fact that the old code didn't check that the
> sha1 was the same suggests to me that this behaviour may actually have
> been a subtle bug?  Perhaps the best thing to do is die if we find two
> entries with the same name when sorting?

I am not sure what readdir() does if somebody adds a new ref
while we are walking the directory; I am hoping we would not get
the same thing in duplicates, but I dunno.

I think the most sensible thing to do is to check for
duplicates, discarding if the SHA-1 match and otherwise dying.
