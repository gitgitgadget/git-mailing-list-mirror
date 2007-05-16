From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Opinions on bug fix organisation
Date: Wed, 16 May 2007 22:20:13 +0100
Message-ID: <200705162220.15417.andyparkins@gmail.com>
References: <200705161138.30134.andyparkins@gmail.com> <7v1whgfybe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 23:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoQv5-0005sN-KN
	for gcvg-git@gmane.org; Wed, 16 May 2007 23:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637AbXEPVUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756943AbXEPVUV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 17:20:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:10259 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbXEPVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 17:20:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so334121wxd
        for <git@vger.kernel.org>; Wed, 16 May 2007 14:20:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I4E7OxVkvibeWt6JE7UQIplFTsUKm1wIGbZ5hyaRaxOHi3c7qilBb2BtXsDnBHLz4oReG9ZGyXlEab4cTbXebCYieA/kjAwSmzCUnWCVhDFCKdeFJOO+ak3qMz/rQyl7yjaAqqoy8cgO+gxEovdUrJzeXkePRtiqQggn3NQ2u7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kq9mvDwme22RtNjAbr9wiJrCemseWVnatWcINYcJq6udLDKbtRBP1tHJsRz7y31p288kl4swXb4Yzp7PVooYMLuGzgNdqpLYxB/+SjTNoVh8DG1Mdl7ku1xr6sZ1MJLN7+kM6Y81N2MA+rsRNzWqfMbQ0mC5Ohf/dtfURKZLkZM=
Received: by 10.70.84.6 with SMTP id h6mr14317565wxb.1179350419433;
        Wed, 16 May 2007 14:20:19 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id i20sm3395487wxd.2007.05.16.14.20.18;
        Wed, 16 May 2007 14:20:18 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v1whgfybe.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47456>

On Wednesday 2007, May 16, Junio C Hamano wrote:

> I think that largely depends on your taste and what other things
> you have between B and the tip when you contemplate on the fix.

As always, thank you for the detailed response.  I appreciate the 
thought that goes into answering these questions that flit into my 
mind :-)

> is fixed as close to the introduction of bug as practical (so I
> would _not_ fork a fix on top of B itself, but apply fix to the
> tip of 'maint'), and then all newer development track that
> contain breakage B merges the fix from that branch (i.e. 'maint'
> is then merged into 'master' to propagate the fix forward).

The above method is almost a necessity when using git.  If the bug fix 
is committed to master, there is no way to apply that same commit to 
the maint branch without also grabbing commits you don't want in maint.

> The way 'next' and 'master' works in git.git looks a bit
> different from it, but you will realize that the idea is the
> same if you look at individual topic branches.  Each topic is
> forked from 'master', gain its own commits and merged to 'next'.

I've noticed flows like that when looking at git history.  I always 
think that it demonstrates the power of git's strong-on-branches stance 
because you can almost feel the story of the development without having 
to read any of the commits themselves.  I wonder if other DVCSs 
encourage creation of such a strong narrative?

> Its bugs may be discovered later while it still hasn't been
> merged to 'master'.  I'd _never_ commit a fix to 'next'
> directly, but a fix goes to the tip of the topic branch that
> introduces the bug, and then merged to 'next'.  When the topic
> is reasonably bug-free, it then is merged to 'master' -- at that
> point, the history of the topic has all the relevant fixes.

What is your preference when, for example, you have already merged a 
topic to next but then a bug fix appears?

 * -- * -- * -- M -- F         * -- * -- * -- M -- m (next)
               /        or                   /    /
    B -- * -- *                   B -- * -- * -- F (topic)

F is certainly most appropriate to be on the topic branch, but we create 
a perhaps excessively verbose extra merge, m.

> just a random set of development), I think your latter approach
> to have only the fix as a separate (temporary) topic and merge
> that to the tip is inconsistent with your current practice to
> begin with, and I do not see much merit in it by itself.  If you
> prefer the latter solution (and I obviously do, as that is the

I'm not sure I've understood what you mean here.  Which "latter" are you 
talking about - you've said that you find the latter inconsistent but 
also that you prefer the latter solution.  I'm lost :-)

> way git.git repository is maintained), you would also want to
> have topic branches, where all the enhancements, advances _and_
> fixes related to a single theme go to and then merged to the
> mainline.  That's the history of a theme.  Having branch and
> merge only for fixes but not for advancement may be "the history
> of a bug", but it probably would not buy you much by itself.

It's not so much a matter of it buying you something, it is more that 
when you find that bug fix commit in history you can see, by following 
the fix-branch back to its source, all the revisions that contained 
that bug at a glance; if you just commit on the end, you have to do the 
digging yourself, and hope that someone mentioned in the commit message 
which commit introduced the bug that that commit fixes.

The fact that git makes it so easy to branch and merge from a previous 
point is the thing that even makes this a possibility.  Perhaps I'm 
spoilt now :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
