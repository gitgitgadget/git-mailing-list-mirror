From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 12:35:38 +0100
Message-ID: <43EB290A.6060407@op5.se>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>	<BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>	<43EB05B5.20307@op5.se> <7vk6c4etzy.fsf@assigned-by-dhcp.cox.net>	<43EB1984.3040602@op5.se> <7vr76cby2v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 12:35:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7A5S-00074N-1R
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 12:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWBILfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 06:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbWBILfk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 06:35:40 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:49829 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1422881AbWBILfj
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 06:35:39 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7FD2D6BCBE; Thu,  9 Feb 2006 12:35:38 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr76cby2v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15808>

Junio C Hamano wrote:
> 
> The problem is exactly why you need the plus sign when you fetch,
> i.e. "+pu:pu".  My "pu" rebases.
> 
> Suppose I had this:
> 
>              o--o--o
>             /      "pu"
> 	o--o
>            "master"     
> 
> You do fetch +pu:pu, branch my-pu, and build on top of it:
> 
>                      o--o--o--o--o--o--o
>                     /                  "my-pu"
>              o--o--o
>             /      "pu"
> 	o--o
>            "master"
> 
> I add some to my "master" and rebuild "pu", maybe while adding
> another commit on "pu".  You fetch +pu:pu again:
> 
>                      o--o--o--o--o--o--o
>                     /                  "my-pu"
>              o--o--o        o--o--o--o
>             /              /         "pu" 
> 	o--o--o--o--o--o--o
>                           "master"
> 

But wouldn't rebase detect the commits as being the same, unless you've 
made changes to them? If it doesn't, can we teach it to discard parent 
info and re-hash the commits if they conflict? That should solve most 
such merge-conflicts, really.


> Now, what happens when you merge "pu" into "my-pu"?  The three
> commits I had on my previous "pu" are not part of the history of
> the updated "pu" anymore, but is considered to be part of your
> development trail.  If these had an addition of a file, and if
> your development on top of the previous "pu" modified it, the
> merge would result in:
> 
>  * originally the file did not exist.
>  * "pu" adds it one way.
>  * "my-pu" adds it in another way.
> 
> This requires a hand merge.  What should be done is for me to
> instead of rebasing "pu", merge the updated master to "pu".
> 
>                      o--o--o--o--o--o--o
>                     /                  "my-pu"
>              o--o--o--------*--o
>             /              /   "pu" 
> 	o--o--o--o--o--o--o
>                           "master"
> 
> Then merge between "my-pu" and "pu" become easier.  You do not
> have to worry about the earlier three commits, because the point
> you forked from the previous "pu" becomes the merge base.
> 
> The reason I have not done it that way so far is primarily I am
> lazy and also I do not like to see too many merges in the log.
> Also "pu" tends to have really wacky stuff, so separating out
> only usable bits, excluding wacky ones is slightly easier if I
> rebuild it from scratch.
> 
> The new "next" aka "not too close to bleeding or broken edge"
> branch will be managed like the last picture above, in order to
> make working with it easier to manage.  This is only usable if I
> do not include too bleeding-edge topic branch in it.
> 
> 

Good thinking. You're a marvel at explaining things.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
