From: Daniel Barkalow <barkalow@iabervon.iabervon.org>
Subject: Re: refspecs with '*' as part of pattern
Date: Mon, 6 Jul 2015 22:20:24 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com> <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 04:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCIN6-0004xJ-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 04:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbbGGCM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 22:12:29 -0400
Received: from iabervon.org ([66.92.72.58]:39514 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbGGCM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 22:12:27 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2015 22:12:27 EDT
Received: from localhost (localhost [127.0.0.1])
  (IDENT: uid 1000)
  by iabervon.org with ESMTP; Mon, 06 Jul 2015 22:20:24 -0400
  id 00000000001A4016.559B3768.00004E38
In-Reply-To: <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273473>

On Mon, 6 Jul 2015, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > I've been looking at the refspecs for git fetch, and noticed that
> > globs are partially supported. I wanted to use something like:
> >
> > refs/tags/some-prefix-*:refs/tags/some-prefix-*
> >
> > as a refspec, so that I can fetch only tags which have a specific
> > prefix. I know that I could use namespaces to separate tags, but
> > unfortunately, I am unable to fix the tag format. The specific
> > repository in question is also generating several tags which are not
> > relevant to me, in formats that are not really useful for human
> > consumption. I am also not able to fix this less than useful practice.
> >
> > However, I noticed that refspecs only support * as a single component.
> > The match algorithm works perfectly fine, as documented in
> > abd2bde78bd9 ("Support '*' in the middle of a refspec")
> >
> > What is the reason for not allowing slightly more arbitrary
> > expressions? Obviously no more than one *...
> 
> I cannot seem to be able to find related discussions around that
> patch, so this is only my guess, but I suspect that this is to
> discourage people from doing something like:
> 
> 	refs/tags/*:refs/tags/foo-*
> 
> which would open can of worms (e.g. imagine you fetch with that
> pathspec and then push with refs/tags/*:refs/tags/* back there;
> would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
> tag?) we'd prefer not having to worry about.

That wouldn't be it, since refs/tags/*:refs/tags/foo/* would have the same 
problem, assuming you didn't set up the push refspec carefully.

I think it was mostly that it would be too easy to accidentally do 
something you don't want by having some other character instead of a 
slash, like refs/heads/*:refs/heads-*.

Aside from the increased risk of hard-to-spot typos leading to very weird 
behavior, nothing actually goes wrong; in fact, I've been using git with 
that check removed for ages because I wanted a refspec like 
refs/heads/something-*:refs/heads/*. And it works fine as a local patch, 
since you don't need your refspec handling to interoperate with other 
repositories.

	-Daniel
*This .sig left intentionally blank*
