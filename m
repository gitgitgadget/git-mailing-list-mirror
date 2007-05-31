From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Thu, 31 May 2007 16:43:41 -0700
Message-ID: <7vodk01rv6.fsf@assigned-by-dhcp.cox.net>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	<8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 01:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtuJ5-0001Hn-EH
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 01:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXEaXnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 19:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbXEaXnn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 19:43:43 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38168 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXEaXnn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 19:43:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070531234341.IIMD15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 31 May 2007 19:43:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5zjg1X00i1kojtg0000000; Thu, 31 May 2007 19:43:41 -0400
In-Reply-To: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	(Lars Hjemli's message of "Thu, 31 May 2007 02:17:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48830>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 5/28/07, Lars Hjemli <hjemli@gmail.com> wrote:
>> This changes git-submodule in a few ways:
>
> Please don't apply the "Let .git/config specify the url for
> submodules" patch, I'm having second thoughts ;-)
>
> Your design outline in
> http://article.gmane.org/gmane.comp.version-control.git/48287 is
> obviously superior, and I'd like to take a stab at it with something
> like this:
>
> 1. 'git-submodule init' saves submodule name and suggested url from
> .gitmodules into .git/config (submodule.$name.url)
>
> 2. 'git-submodule update' keeps the work tree updated for submodules
> with five separate (and optional) operations:
>  a) git-clone --bare $url .git/submodules/$name.git
>  b) git-clone -l -s .git/submodules/$name.git $path
>  c) cd .git/submodules/$name.git && git-fetch
>  d) cd $path && git-fetch
>  e) cd $path && git-checkout $sha1
>
> 3) 'git-submodule push' runs something like 'cd $path && git push
> origin $branch', where $branch is found in .gitmodules
> (path.$path.branch).
>
> A remaining issue is how to detect if step 2b is necessary if a
> submodule is already checked out at the submodule path, but I guess
> remote.origin.url in the checked out submodule would be the thing to
> peek into.
>
> Also, step 2c/2d should obviously only be performed if the requested
> sha1 isn't available, which should be trivial to detect with
> 'git-cat-file -e'.
>
> Could this turn out to be an acceptable solution?

Sounds sane to me, although I have to admit that I cannot really
claim that I have thought things through in that strawman you
quoted.
