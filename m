From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Mon, 27 Feb 2006 10:46:41 -0800
Message-ID: <20060227184641.GA21684@hand.yhbt.net>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 19:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnOQ-0000Vb-To
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWB0Sqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWB0Sqm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:46:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:45744 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751527AbWB0Sqm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 13:46:42 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id B7BF52DC01A; Mon, 27 Feb 2006 10:46:41 -0800 (PST)
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16874>

Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
> hi everyone,
> 
> as i mentioned, i do experimental work with git and svn... and i
> experienced some problems with git when pulling much data from svn.
> 
> Actually that happens after i commit a revision with many and big files.
> After that i cannot do a git-svn fetch anymore because git-svn
> complains...
> 
> fatal: Ref refs/heads/svn-git-HEAD is at
> 504721bf4b2702d3e56cef69950f42a43568e846 but expected
> 504721bf4b2702d3e56cef69950f42a43568e846

Those messages are from git-update-ref.  What were some of the messages
from git-svn leading up to that point?

> now i am a little confused about that... oh, i actually modified the
> svn-git directly instead of a private working branch... perhaps that was
> not intended.

You should never, ever modify the git-svn-HEAD branch yourself.
Interface branches should never be modified.  It's the golden rule of
interfacing between different SCM interfaces.  Sorry, I've been doing
things like this this for a while now I guess I didn't make it
abundantly clear in the documentation.

> now i am still on rev 2 on this branch but i updated it to rev 5 on the
> svn-side...
> 
> any hints?

Save your current work in git-svn-HEAD to a private branch

	git branch -b private git-svn-HEAD

then reset git-svn-HEAD to the last revision where it was managed by
git-svn fetch:

	git-checkout git-svn-HEAD
	git-log (look for the last commit with 'git-svn-id:' in it)
	git-reset --hard <last commit with 'git-svn-id:' in it>

Now go to your private branch:

	git checkout private

And continue working on your private branch as usual.

-- 
Eric Wong
