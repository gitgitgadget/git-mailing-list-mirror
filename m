From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC] git integrated bugtracking
Date: Mon, 04 Jun 2007 11:32:06 +0200
Message-ID: <4663DC16.8080309@dawes.za.net>
References: <20070603114843.GA14336@artemis> <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org> <20070603201632.GF30347@artemis> <20070603230702.GC16637@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 11:33:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv8wQ-00026I-Hj
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 11:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXFDJd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 05:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbXFDJd1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 05:33:27 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:42883 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXFDJd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 05:33:26 -0400
Received: from spunkymail-a17.g.dreamhost.com (sd-green-bigip-177.dreamhost.com [208.97.132.177])
	by sumo.dreamhost.com (Postfix) with ESMTP id 5781F17D46C
	for <git@vger.kernel.org>; Mon,  4 Jun 2007 02:33:26 -0700 (PDT)
Received: from [192.168.201.100] (dsl-146-26-199.telkomadsl.co.za [165.146.26.199])
	by spunkymail-a17.g.dreamhost.com (Postfix) with ESMTP id B308C74C54;
	Mon,  4 Jun 2007 02:32:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070603230702.GC16637@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49090>

Martin Waitz wrote:
> hoi :)
> 
> On Sun, Jun 03, 2007 at 10:16:32PM +0200, Pierre Habouzit wrote:
>>   Well I went that way, but we loose the quite cool "if I branch my
>> repository I branch the bugs coming with them too"-feature. And I'd be
>> sad to give that up. But maybe it's an error to want to use git to
>> encode that relation.
> 
> Just store the commit which introduced the bug (or where the bug
> was first found) and you will get that, too.  You only have to check
> if this commit is reachable by a given branch to see if it is affected.
> When you fix the bug you store the commit id that fixed it and then
> you can check every branch if it points into bad..good.
> 
> You can also do this for released versions.
> If you have the bug database inside the repository you can't report
> any bugs for a released version, because it is, well already released.
> 

Ok, that seems reasonable.

Now, how do you store updates to a bug? i.e. followup questions and answers?

As suggested in another message, I think that the bug id would have to 
be the hash of the initial report (incl whatever metadata is considered 
interesting).

I think that the individual reports might be stored by their id, perhaps 
via a fan out dir, like the .git/objects directory. Attachments can be 
stored by their hash in a separate directory structure. Modifications to 
a report would simply be appended to the original report. Simultaneous 
modifications could be dealt with by merging the two files, probably 
using a custom merge driver.

Obviously the format of a bug report and follow up message would need to 
be quite strictly defined and adhered to, for the merge driver to be 
able to do its work with the minimum/zero user interaction.

Closed bugs would be deleted from the filesystem, but would obviously be 
available via the history.

Indexes or categories could be implemented by means of symlinks/symrefs 
in a different set of "index directories". e.g.

/categories/drivers/deadbeef -> ../../bugs/de/adbeef
/assignedto/joe@example.org/deadbeef -> ../../bugs/de/adbeef

or similar. These might not be strictly necessary, since all that 
information will be in the report anyway. Perhaps the indexes would be 
stored simply as cached data, and rebuilt if out of date.

The porcelain would then take care of presenting the bugs to the user in 
the preferred format, much like we have gitk, gitweb, qgit, tig, etc.

Does any of this make sense?

Rogan
