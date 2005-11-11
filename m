From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Fri, 11 Nov 2005 14:53:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511111437410.3228@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 23:55:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eahmb-0000sT-F1
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 23:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVKKWyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 17:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVKKWyF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 17:54:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751303AbVKKWyD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 17:54:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jABMrvnO031126
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 11 Nov 2005 14:53:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jABMruuX000589;
	Fri, 11 Nov 2005 14:53:57 -0800
To: Junio C Hamano <junkio@cox.net>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11642>



On Fri, 11 Nov 2005, Junio C Hamano wrote:
> 
> Some observations.
> 
>  - Trivial Merges count is surprisingly high.  About 1/3 of
>    merges are pure in-index merges.

I actually don't think that is surprisingly high, and would actually have 
expected it to be closer to 50%.

On the other hand, the merges that end up being pure fast-forwards aren't 
counted as merges at all (since they don't show up as commits), so maybe 
that's what skews my preception of a big percentage of merges as being 
really trivial.

>  - Most of the commits (developer commits, not merges) are
>    small and touches only a couple of paths.

This is something where I think the kernel is perhaps unusual, especially 
for a big project. We really do encourage people to make lots of small and 
well-defined changes, and the whole flow of development has been geared 
towards it. 

>  - Nobody does octopus ;-).

I do think octopus is really cool, and still think seeing that five-way 
octopus-merge in gitk in the git history was really really cool.

It doesn't look as good any more, btw: do "gitk" on the current git tree, 
and search for "Octopus merge", and you'll see some of the history lines 
crossing each other. Paul?

But yeah, it's a pretty special thing. I think its coolness factor way 
outweighs its usefullness factor ;^p

>  - We did not have multi-base merge case during the period
>    looked at (but the sample count is very low).

Again, this is possibly because the kernel has already had a few years of 
distributed SCM usage under its belt, and we've tried to not only merge 
in a timely manner, but also try to keep history reasonably clean and not 
have a lot of cross-merging back and forth. That cuts down on multi-base 
possibilities.

>  - merge-one-file was called for only a handful (median 8)
>    files, which is negligibly small compared to the total 17K
>    files in the kernel tree, and fairly small compared to the
>    number of changed paths from the first parent (meaning,
>    read-tree trivial collapsing helped majorly).  Among them,
>    the number of paths that needed real file-level 3-way merges
>    were even smaller (avg 1.96).

I definitely think this is true for any big project.

Small projects will inevitably have changes that modify large portions of 
the source base. But with small projects, it doesn't really matter _what_ 
you do, you can do it fast.

Big projects (at least the sane kind) will never have lots of changes that 
modify a very big percentage of the source-tree. It's just too painful 
(and I'm not talking from a SCM angle, just from a developer angle).

>    All three of these points together is a fine demonstration
>    that you designed git really right.

Well, it's self-re-inforcing. It was designed for the kernel usage 
patterns, so using the kernel to confirm that it's the "right design" is a 
bit self-serving. Sure, it's a good sign that my mental model of what the 
usage patters are does actually match reality, but at the same time it 
might be more interesting to see if other projects that use git end up 
using it the same way and/or have different statistics.

I do expect that the size of the project will impact the statistics a lot. 

		Linus
