From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 7 Sep 2008 21:56:26 +0200
Message-ID: <20080907195626.GA8765@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <20080907172807.GA25233@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQOx-0006A0-Bh
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 21:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528AbYIGT42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 15:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbYIGT41
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 15:56:27 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:40986 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322AbYIGT41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 15:56:27 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 624245465; Sun,  7 Sep 2008 21:56:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080907172807.GA25233@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95167>

Jeff King wrote:
>On Sun, Sep 07, 2008 at 12:34:15PM +0200, Stephen R. van den Berg wrote:

>> The questions now are:
>> - Would there be good reason not to record the backport/forwardport
>>   relationship in the additional parents of a commit?

>Parents mean something different than just a link. If A is a parent of
>B, then that implies that at point B, we considered all of the history
>leading up to B (including A), and arrived at a certain tree state.

That implication is not a technical one, but merely a convention in the
mind of the git-user.  Relevant, of course, but maybe we can accomodate
both uses.

>But cherry-picking means we looked at just A and used it to find a
>certain tree-state. It says nothing about anything that came _before_ A.

Correct.

>Now let's say we want to cherry-pick E. If we mark the cherry-picked
>commit as a parent, we get:

>A--B--C--E' <-- master
> \      /
>  D----E--F <-- side branch

>Now let's say we want to merge the branches. What's our merge base?
>Without your proposal, it is A, but now it is actually E. So doing a
>three-way merge between E' and F with base E, it will look like our
>master branch _removed_ the change from D which is still present in F.
>And in a 3-way merge if one side removes something but the other side
>leaves it untouched, then the result removes it.

>So the merge result is bogus, as it is missing D.

True.  However...

What if the merge-base determination code is modified to behave as
if --first-parent is specified while searching for the merge-base?
In that case it *will* find A as the merge-base, even in the presence of
"sideportlinks".

Does that resolve all technical issues?
-- 
Sincerely,
           Stephen R. van den Berg.

"The future is here, it's just not widely distributed yet." -- William Gibson
