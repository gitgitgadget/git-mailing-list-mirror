From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 22:22:02 +0200
Message-ID: <20080907202202.GC8765@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <20080907172807.GA25233@coredump.intra.peff.net> <20080907195626.GA8765@cuci.nl> <20080907200441.GA26705@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQmv-00033h-6x
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbYIGUWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbYIGUWF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:22:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42572 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571AbYIGUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:22:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id E87625465; Sun,  7 Sep 2008 22:22:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080907200441.GA26705@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95173>

Jeff King wrote:
>On Sun, Sep 07, 2008 at 09:56:26PM +0200, Stephen R. van den Berg wrote:
>> That implication is not a technical one, but merely a convention in the
>> mind of the git-user.  Relevant, of course, but maybe we can accomodate
>> both uses.

>I'm not sure I agree. I believe that property is part of the definition
>of the commit DAG as originally conceived (but somebody like Linus could
>say more). Obviously there is no formal definition, but I already
>pointed out one thing that will break in that instance. I don't know if
>there are others.

Yes, of course.  But even then, it's merely a formal definition, the
thing I'm after now is if there is any code that actually relies on that
formal definition.  That would be the code to review and perhaps adapt
in order to make it support the sideport-parents without hurting the old
definition.

>> What if the merge-base determination code is modified to behave as
>> if --first-parent is specified while searching for the merge-base?
>> In that case it *will* find A as the merge-base, even in the presence of
>> "sideportlinks".

>But then it will fail to find legitimate merge bases. So yes, you _can_

Will it?  Can you give me one example where it would find the wrong one?

>come up with a merge algorithm that handles this situation. But is it
>then up to the user to say "Oh, this parent link means something else.
>Use this other algorithm"?

That, of course, is unacceptable.  It either is seemless and supports
both uses transparently, or it has to be done (if at all) using a separate
link (not one of the normal parents) indeed.

> In that case, it really seems we are abusing
>the "parent" link and it would be more appropriate to have some _other_
>type of link.

Quite.

>Though I think if you look through the archives, people have argued
>against having any git-level link to cherry-picked commits. The history
>leading up to that cherry-pick is not necessarily of interest (though I
>think you are proposing that it be optional to create such a link via
>-x).

Optional, indeed, and sometimes quite useful.

>> Does that resolve all technical issues?

>I really don't know. I think you are proposing changing a core
>assumption of the data structure, so I wouldn't be too surprised if
>there is other code that relies on it.

>You can use the script I posted in my last email as a basis for a
>cherry-pick that does what you want (cherry-pick -n, write-tree,
>commit-tree, update-ref). You might try a few experiments with that.

I will, thanks.
-- 
Sincerely,
           Stephen R. van den Berg.

"The future is here, it's just not widely distributed yet." -- William Gibson
