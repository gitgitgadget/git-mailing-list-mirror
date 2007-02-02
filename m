From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 16:11:03 +0000
Message-ID: <200702021611.06029.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <200702021302.10567.andyparkins@gmail.com> <Pine.LNX.4.64.0702020955540.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 17:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD10O-00050h-UD
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945961AbXBBQLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbXBBQLN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:11:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:38794 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945961AbXBBQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:11:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so799067uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 08:11:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LVOzdDVnKA+/qiXuxIEy6wAwLCp1pNTWwLlVErhfLj9jyR7+wXwDDiLmXDCBwa0sC0ylv3qaVmttw/0fyQTuSm/hiN6p9k7im855vbfHvBA4xVojnQeqym3RWogj1WbRqlVTcONd+koI2EkTdOYHUgHe4U01iW3SJCMLXA2lBr0=
Received: by 10.66.216.20 with SMTP id o20mr4593438ugg.1170432671011;
        Fri, 02 Feb 2007 08:11:11 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id j34sm4526555ugc.2007.02.02.08.11.08;
        Fri, 02 Feb 2007 08:11:08 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0702020955540.3021@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38509>

On Friday 2007 February 02 15:13, Nicolas Pitre wrote:
> On Fri, 2 Feb 2007, Andy Parkins wrote:
> > Forgetting about detached heads for the moment,
>
> That is not the way to go about it.  You cannot start forgetting about
> detached heads and come back to it afterwards like an afterthought.

I don't agree.  To avoid confusing people the key thing should be consistency.  
What holds true for HEAD in the non-detached case should hold true for the 
detached case.  Otherwise it's just another variable for the user to 
remember.

> The exact same argument could be said if you did 1300 operations on a
> single branch, say master.  What would master@{yesterday} tell you?
> What will it tell you one minute from now?  Now suppose that you have

It doesn't matter - it will be on the same head, as time ticks by I will at 
least find that master@{yesterday} ticks by linearly too.  That is not the 
case if HEAD@{yesterday} means "whatever HEAD pointed to yesterday".  How am 
I supposed to remember what it pointed to?  Therefore what use is 
HEAD@{yesterday}?

> only one branch and therefore HEAD reflog would be a duplicate of master
> reflog.

You misunderstand, I'm suggesting that reflogging HEAD is not the right thing 
to do.  Asking for HEAD's reflog should be the same as asking for the 
pointed-to-branch's reflog.

Instead, the reflog should be kept for the "unnamed branch", which would jump 
around each time you detached HEAD.

> Answer: it would carry the same kind of confusion as your example above.

I don't agree.  HEAD is always "the branch I'm on now", even when it's 
detached it's pointing at the branch I'm working on.  It just happens that 
that branch has no name.

> Then simply use @{15 minutes ago}.  You'll even save yourself some
> typing!  It is not like if you have to type HEAD for most operations

I'm not worried about the typing, or about the functionality.  I think that 
the functionality will be there in either of the proposed cases.  I am 
arguing which is the least confusing.  The amount of typing should certainly 
not be a factor in this case.

> anyway since HEAD is the likely default in most cases.  So you may even
> forget that the HEAD entity exists and be just fine.

Yep; in my scenario that's true.  One could completely forget about HEAD.  In 
your scenario that isn't the case, because I need to remember that when I'm 
detached HEAD suddenly gets special powers to tell me about the detached 
movements.

> But HEAD is still a moving pointer and we might want to know that it
> switched from one branch to another at some point.  And the only way for
> that to be sensible is by having a separate reflog for HEAD that is the
> exact log of every operations you perform regardless of the actual
> branch you might be on.

I agree.  I am arguing about nomenclature.  There is no dispute that /that/ 
reflog (or equivalent) should exist.  However, I don't believe it should 
be "the log of HEAD" it should be "the log of the unnamed branch".


> HEAD _does_ get detached.  It becomes loose in the air.  It doesn't drag

Well, we're talking semantics now.  HEAD becomes detached from a branch, but 
it certainly isn't floating.  It points at a particular point in the 
repository.

HEAD is always a symref (despite what you say); it's just that when HEAD is 
detached from all branches, there is no ref for it to point at, so we store 
the ref in the file called HEAD.  It's analogous to pointers in C:

  HashType hash;
  HashType *ref;
  HashType **HEAD;

By sometimes treating HEAD as a ref, you break the model.

> pointer with it.  And everything you do on top of a detached HEAD will
> be forgotten as soon as you leave it (and the eventual reflog for HEAD
> expires) if you don't attach it somehow with a tag or a new branch.
> There is no notion of a virtual branch at all, not technically, not
> conceptually either.

I disagree that there is no virtual branch.  That is what HEAD is when it is 
in detached mode.  It looks just like a ref - HEAD holds a hash, refs hold a 
hash - how is that not a virtual branch?  I used the word "virtual" only 
because it is not stored in refs/ and vanishes when you move back to a real 
branch.  Just because the virtual branch is stored in HEAD, I think it is 
dangerous to thing of HEAD as being the thing that is logged - it is this 
virtual branch that should be logged because that branch is always there and 
can be tracked through time as a discrete entity.  If you track HEAD itself, 
then sometimes it will hold the same as a branch reflog, sometimes it will 
hold unique data.

Perhaps this is just a product of my warped mental model of git.  Obviously 
you chaps who do the actual work get final say.  Take the above with my usual 
two cents of "I can't be sure of what I'm talking about" :-)




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
