From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 09:07:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> 
 <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com> 
 <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
 <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbIt5-0003ro-Tn
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030991AbXDJQIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 12:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030997AbXDJQIE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 12:08:04 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34019 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030991AbXDJQIC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 12:08:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AG7oVZ002151
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 09:07:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AG7nsG011463;
	Tue, 10 Apr 2007 09:07:50 -0700
In-Reply-To: <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44137>



On Tue, 10 Apr 2007, Alex Riesen wrote:
> 
> It is already "merged somewhere": as soon as the patches left landed
> on vger, it is not possible to loose (and even destroy) them.
> The feature is just too much sought after.

Well, unless it hits something like Junios 'pu' (or 'next') branch, or 
somebody (like you?) ends up maintaining a repo with this, it's just 
unnecessarily hard to have lots of people working together on it..

I'm obviously interested in working on it, but at the same time, I don't 
expect to be a primary *user* of it, so I'm hoping others will come in and 
start looking at it.

It looks promising that you're getting involved, but I suspect you may be 
a bit too optimistic when you say "just too much sought after". We've been 
*talking* about subprojects for a long long time, and we've had other 
patches fail. So...

> > For example, with just two smallish updates:
> >  - teach "git upload-pack" not to try to follow gitlinks
> >  - teach "git read-tree" to check out a git-link as just an empty
> >    subdirectory
> 
> which also should fix switching between the branches with subprojects.

Yes. It would require either git-read-tree or the git-checkout script 
around it knowing to then also check out the subproject branches.

It's actually not *entirely* obvious what you should do when you switch 
branches (or even just do a "git reset --hard") in the superproject. The 
branches in the subprojects are likely to be totally different from the 
superproject, so as far as I can see, you end up having two choices when 
you reset a subproject:

 - either basically create a "disconnected HEAD" in the subproject(s) when 
   you switch them around as a consequence of resetting/switching the 
   branch in the superproject.

 - or you'd stay on the same branch in the subproject, and just reset that 
   branch..

 - or you describe the branch name in the ".gitmodules" file in the
   superproject, and use whatever branch in the submodule that is 
   described in the supermodule that you reset/check-out.

 - or possibly other policies.

So there is bound to be various "policy" issues like this worth sorting 
out. I don't think they matter that deeply.

I would _personally_ tend to like the notion of using ".gitmodules" in the 
supermodule to describe things like this, exactly because it's a policy 
decision - not something that git itself should really decide about, but 
that the supermodule maintainers can just decide to agree on.

But I haven't really even thought about all the things I'd want to have in 
the .gitmodules. We'd obviously need to list the default URL's for the 
submodules some way etc, but I haven't really sat down and thought about 
what all the higher-level porcelain really would need to know.

I suspect that somebody who has used and set up CVS "modules" setups 
should be thinking about that. I've been a "stupid user" for CVS modules 
setups, but I've never actually needed to really know how they *work*.

		Linus
