From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Fri, 4 Nov 2005 19:38:34 +0100
Message-ID: <200511041938.34299.Josef.Weidendorfer@gmx.de>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de> <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 19:39:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY6SW-0002k2-Is
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 19:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKDSii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 13:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVKDSii
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 13:38:38 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:29583 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750823AbVKDSih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 13:38:37 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id D1D80233E;
	Fri,  4 Nov 2005 19:38:35 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11150>

On Friday 04 November 2005 18:43, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > ... One difference of cloning with GIT vs. with
> > Cogito is that Git always clones all remote branches. This can
> > be limiting if you want to work with multiple repositories,
> > but allows you to immediatly work with all the branches.
> 
> Three points, and two footnotes.
> 
> . After a git clone, you can still fetch from non-origin
>   repository; you can also set up .git/remotes/somewhere-else if
>   you pull from the non-origin repository regularly, so it is
>   not really "limiting".

With "limiting" I only meant the fact that all the refs/heads names are
copied over, thus polluting your local namespace. Additionally, it can
be some transfer burden to copy all the objects instead only the objects
needed for one head.

Cogito does not have an issue with pollution of refs/heads namespace
as it only clones one head to the special "origin" head [*1*].
But as I said, the Git way can be more convenient. I think that the
proposed "implicit remote branches" are a way between: make it convenient
for Cogito users to fast access branches from the origin repository, but
pollute the name space only "a little".

[*1*] Still, it would be nice to specify the name of the branch tracking
the origin repository via on option in cg-clone (defaulting to "origin"),
and to also be able to specify the head which is branched off and you
are put on after cloning (defaulting to "master"); but I do not think
there is much use to such flexibility.

>   It is just being slightly less 
>   convenient, in that setting up for the origin is done for you
>   by clone [*1*] while you have to arrange for non-origin
>   repository yourself afterwards.

I do not think there is much difference in editing files under
.git/remotes, or using cg-branch-add.

> . The namespace under refs/heads is and always will be an issue.
>   It is a local matter and how remote branches are named should
>   not dictate what local branch names you can use in your
>   repository, but that essentially is what happens after
>   git-clone to users who do not rename those branches from the
>   initial cloning.

Yes, and that is nice about Cogito.

>   I once considered to give an option to clone to map the origin
>   heads to .git/refs/heads/origin/{master,maint,pu,...}.  In
>   hindsight that might have been cleaner.  Instead I just followed
>   what Cogito already established, and mapped remote "master" to
>   "origin".

That is a nice idea. What is the exact compatiblity problem with Cogito
here? Either a repository is cloned with Git or with Cogito, and
afterwards, both should be able to cope with any naming scheme.

Both Git and Cogito do setup local "master" for local work after cloning.
To still be able to track a remote "master", this is mapped to local
"origin". Am I right here?
What happens if the remote side itself has an "origin" head?

> [Footnotes]
> 
> *1* Actually, even the setting up for the origin is done only
> halfway -- it only arranges 'git fetch/pull' to fetch from the
> master branch, and other branches are not tracked unless you
> explicitly arrange them to be.  This is somewhat deliberate; the
> refs/ namespace management is a local matter and you do not
> necessarily want to keep tracking all the branches from origin.

Yes. I do not see any problem here with explicitly specifying a
head you want to track in "git fetch origin <head>". Still, I would
not call this syntax 'porcelainish'.

But we have Cogito for this.

> *2* This becomes somewhat problematic when the tool
> automatically follows/fetches tags, and that is why git-core
> barebone Porcelainish requires an explicit 'git fetch --tags'.

Ah, ok.

Josef
