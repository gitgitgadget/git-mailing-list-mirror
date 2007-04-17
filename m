From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then sorting on add
Date: Tue, 17 Apr 2007 15:00:28 -0700
Message-ID: <7vslaymzk3.fsf@assigned-by-dhcp.cox.net>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
	<Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdvj1-0002iH-Sd
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 00:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031267AbXDQWAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031269AbXDQWAa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 18:00:30 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56505 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031267AbXDQWA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 18:00:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417220028.IIDC1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Apr 2007 18:00:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oN0U1W00e1kojtg0000000; Tue, 17 Apr 2007 18:00:29 -0400
In-Reply-To: <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 17 Apr 2007 09:03:44 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44836>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 17 Apr 2007, Julian Phillips wrote:
>>
>> Rather than sorting the refs list while building it, sort in one go
>> after it is built using a merge sort.  This has a large performance
>> boost with large numbers of refs.
>> 
>> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Looks fine. I think that even your new times are a bit high (over two 
> seconds?) but things are clearly better. Have you looked at what takes so 
> long now? 

I wonder why the loss of "we are replacing the same one" case in
the original add_ref() was not compensated for in the new
sort_ref_list().

I think we would not call add_ref() to the same list with
duplicate names, unless (1) filesystem is grossly corrupt, (2)
somebody added a new ref while we are walking (how does
readdir() behave in such a case???), or (3) packed-refs file is
corrupt.
