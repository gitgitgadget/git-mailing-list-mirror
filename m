From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [3/5] Add http-pull
Date: Fri, 22 Apr 2005 15:46:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504221532120.30848-100000@iabervon.org>
References: <200504212205.j3LM5J005103@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brad Roberts <braddr@puremagic.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:43:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP42R-0002I4-9F
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 21:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVDVTqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 15:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVDVTqk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 15:46:40 -0400
Received: from iabervon.org ([66.92.72.58]:2310 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262118AbVDVTqi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 15:46:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DP46m-0005xs-00; Fri, 22 Apr 2005 15:46:36 -0400
To: tony.luck@intel.com
In-Reply-To: <200504212205.j3LM5J005103@unix-os.sc.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Apr 2005 tony.luck@intel.com wrote:

> On Wed, 20 Apr 2005, Brad Roberts wrote:
> > How about fetching in the inverse order.  Ie, deepest parents up towards
> > current.  With that method the repository is always self consistent, even
> > if not yet current.
> 
> Daniel Barkalow replied:
> > You don't know the deepest parents to fetch until you've read everything
> > more recent, since the history you'd have to walk is the history you're
> > downloading.
> 
> You "just" need to defer adding tree/commit objects to the repository until
> after you have inserted all objects on which they depend.  That's what my
> "wget" based version does ... it's very crude, in that it loads all tree
> & commit objects into a temporary repository (.gittmp) ... since you can
> only use "cat-file" and "ls-tree" on things if they live in objects/xx/xxx..xxx
> The blobs can go directly into the real repo (but to be really safe you'd
> have to ensure that the whole blob had been pulled from the network before
> inserting it ... it's probably a good move to validate everything that you
> pull from the outside world too).

The problem with this general scheme is that it means that you have to
start over if something goes wrong, rather than resuming from where you
left off (and being able to use what you got until then). I think a better
solution is to track what things you mean to have and what things you
expect you could get from where.

As for validation, I now have my programs (which I haven't gotten a chance
to send out recently) checking everything as it is downloaded to make sure
it is complete (zlib likes it) and has the correct hash.

	-Daniel
*This .sig left intentionally blank*

