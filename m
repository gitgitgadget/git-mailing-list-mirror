From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: FEATURE suggestion git commit --amend <ref>
Date: Fri, 27 Feb 2009 15:49:37 +0100
Message-ID: <49A7FD81.9070808@drmicha.warpmail.net>
References: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com> <alpine.DEB.1.00.0902271121590.6600@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 15:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld43Y-0007DF-4g
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 15:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbZB0Otr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 09:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbZB0Otr
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 09:49:47 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50777 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754350AbZB0Otq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 09:49:46 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id DF6EB2A4107;
	Fri, 27 Feb 2009 09:49:44 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 Feb 2009 09:49:44 -0500
X-Sasl-enc: DTS3LxlTRwcWXkNdzs4ZIoi4xjLHq0prERgnaFM/cDEd 1235746184
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FF742CAB7;
	Fri, 27 Feb 2009 09:49:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090227 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0902271121590.6600@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111674>

Johannes Schindelin venit, vidit, dixit 27.02.2009 11:30:
> Hi,
> 
> On Fri, 27 Feb 2009, Caleb Cushing wrote:
> 
>> git rebase -i seems a little more tedious/unfriendly than I'd like if 
>> all I want to do is edit HEAD~2 (assuming no merges) it's a bit of a 
>> pain to do a rebase -i and then pick which patches to edit. might be 
>> nice to be able to do stuff like git commit --amend <ref> and have that 
>> call rebase (as I think not rebasing is impossible?) with edit only on 
>> the ref I picked.
>>
>> hopefully I've explained well enough.
> 
> Yes, but IMHO you did not consider the undesired side effects well enough.
> 
> For example: What about merges?
> 
> To be clear: amending a merge is not just a matter of "rebase -i 
> <commit>^" with a custom script, and even worse, there could be merges 
> between the commit you want to amend and the current HEAD.  That is a 
> complete Pandora box right there.
> 
> Also, your amended changes could break reapplication of the later commits.  
> So "git commit --amend <ref-other-than-HEAD>" is _semantically_ different 
> from "git commit --amend".
> 
> Of course, there is also the problem that <ref> might not be an ancestor 
> of HEAD to begin with.
> 
> And that the specified commit could be part of more than one branch, 
> adding to user's confusion when it is only rewritten in the current 
> branch.
> 
> But more fundamental: is this operation something we want to make _that_ 
> easy?  After all, it is _not_ the common case, and it bears such a bunch 
> of problems that the user should be made well aware of what she is doing.
> 
> All in all, as with many feature requests, I have to say that I see what 
> you want, but the side effects are too horrible -- and you did not 
> consider them, obviously, otherwise you would have put forward arguments 
> as to why the side effects would not matter that much.
> 
> Ciao,
> Dscho
> 

FWIW I share all your caveats, especially the fact that - as you point
out - we're really talking rebase here, not commit--amend.

In the end I think Caleb is asking for something like

git rebase --single $COMMIT

to mean

sha=$(git rev-parse --short $COMMIT)
GIT_EDITOR='sed -i -e"/'$sha'/s/pick/edit/"' git rebase -i $COMMIT^

which, again, is easy in shell, and left as an exercise regarding the
implementation as a git alias "rebase-one"...

Michael
