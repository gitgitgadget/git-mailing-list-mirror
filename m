From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Thu, 10 May 2007 00:52:44 -0700
Message-ID: <7vmz0dktdf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
	<7vhcqlma1l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705100328260.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 10 09:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3SE-0001OP-Tv
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbXEJHwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbXEJHwp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:52:45 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37433 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbXEJHwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:52:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510075243.YKGT24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 03:52:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xKsk1W0031kojtg0000000; Thu, 10 May 2007 03:52:44 -0400
In-Reply-To: <Pine.LNX.4.64.0705100328260.18541@iabervon.org> (Daniel
	Barkalow's message of "Thu, 10 May 2007 03:45:33 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46840>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 10 May 2007, Junio C Hamano wrote:
>
>> This seems to break t9400, with "fatal: bad repository 'gitcvs.git",
>> upon "git push".
>> 
>> : gitster t/db/remote; sh t9400-git-cvsserver-server.sh -i -v
>> * expecting success: cvs -Q co -d cvswork master &&
>>    test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"
>> cvs checkout: Updating cvswork
>> U cvswork/empty
>> *   ok 1: basic checkout
>> 
>> * expecting success: echo testfile1 >testfile1 &&
>>    git add testfile1 &&
>>    git commit -q -m "Add testfile1" &&
>>    git push gitcvs.git >/dev/null &&
>
> The man page doesn't think this is valid, since it only claims absolute 
> paths to work for local repositories.

Does it?  I suspect we need to fix the manpage then, as it is
fairly common to do 

	$ git fetch ../next-door-neighbour

and expect the opposite to work as well.

And I think it does today.
