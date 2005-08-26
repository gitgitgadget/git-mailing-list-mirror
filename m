From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merges without bases
Date: Fri, 26 Aug 2005 12:37:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508261150320.23242@iabervon.org>
References: <1125004228.4110.20.camel@localhost.localdomain> 
 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net> <46a038f905082602176f9eef5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 18:36:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8h9q-0006jW-1W
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 18:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVHZQeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 12:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVHZQeT
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 12:34:19 -0400
Received: from iabervon.org ([66.92.72.58]:63762 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965101AbVHZQeT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 12:34:19 -0400
Received: (qmail 24255 invoked by uid 1000); 26 Aug 2005 12:37:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2005 12:37:56 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905082602176f9eef5d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7816>

On Fri, 26 Aug 2005, Martin Langhoff wrote:

> On 8/26/05, Junio C Hamano <junkio@cox.net> wrote:
> > their core GIT tools come from.  But how would _I_ pull from
> > that "My Project", if I did not want to pull unrelated stuff in?
>
> and then...
>
> > What I think _might_ deserve a bit more support would be a merge
> > of a foreign project as a subdirectory of a project.  Linus
>
> tla has an interesting implementation (and horrible name) for
> something like this. In Arch-speak, they are called 'configurations',
> a versioned control file that describes that in subdirectory foo we
> import from this other repo#branch.
>
> In cvs, you just do nested checkouts, and trust a `cvs update` done at
> the top will do the right thing;  and in fact recent cvs versions do.

The problem with both of these (and doing it in the build system) is that,
when a project includes another project, you generally don't want whatever
revision of the included project happens to be the latest; you want the
revision of the included project that the revision of the including
project you're looking at matches. That is, if App includes Lib, and
you're looking at an App commit, you want to have the version of Lib that
the commit was made with, not the latest version of Lib, which may not be
backwards compatible across non-release commits, or, in any case, won't
help in reconstructing a earlier state. I think a primary function of a
SCM is to be able to say, "It worked last Friday, and it's broken now.
What's different?" If the answer is, "On Saturday, we updated the
included Lib to their version from Thursday, which is broken", it'll be
really hard to track down without special tracking.

I think it's the lack of the special tracking, therefore, that makes this
not a good feature in most SCMs, and makes them not better than having the
build system do it (and potentially worse, if you've got your build system
checking out a version specified in a version-controlled file). But I
think that git can do better, including support for the required version
sometimes being a locally modified one and sometimes being the official
one when the local modifications have been accepted upstream.

	-Daniel
*This .sig left intentionally blank*
