From: Steven Grimm <koreth@midwinter.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 02:07:08 -0700
Message-ID: <46DE71BC.5040008@midwinter.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>	<20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com> <86ps0xcwxo.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqqt-00015N-R2
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbXIEJHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbXIEJHH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:07:07 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:59778 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1755970AbXIEJHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:07:06 -0400
Received: (qmail 24671 invoked from network); 5 Sep 2007 09:07:06 -0000
Received: from c-76-21-16-80.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.16.80)
  by tater.midwinter.com with SMTP; 5 Sep 2007 09:07:06 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <86ps0xcwxo.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57696>

David Kastrup wrote:
> You'll potentially get accumulating unfinished files from
> aborted/killed repack processes.

Which can get cleaned up when the next repack starts. This is no 
different from unfinished files accumulating from aborted/killed manual 
repacks.

> If communication fails, you'll get a
> new repack session for every command you start.

Git handles this already:

$ git-gc
fatal: unable to create '.git/packed-refs.lock': File exists
error: failed to run pack-refs

Presumably in that case you would simply not fire up a new repack.

>   If a repository is used by multiple people...
>   

Then the first one will kick off the repack, and subsequent ones won't.

> And so on.  The multiuser aspect makes it a bad idea to do any
> janitorial tasks automatically.  You don't really want every user to
> start a repack at the same time.
>   

Quite true, but that's already impossible, so not a problem.

One other thing: The heuristics for this can be such that users who are 
already regularly running git-gc by hand will see no change in behavior. 
Their repos will never get to a bad enough state that the automatic 
git-gc is invoked. Old-timers who run git-gc might, in theory, never 
even notice a change like this.

-Steve
