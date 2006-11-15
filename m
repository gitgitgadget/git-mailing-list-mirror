X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 09:55:26 -0800
Message-ID: <7vk61woar5.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>
	<200611150917.23756.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 17:56:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611150917.23756.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 15 Nov 2006 10:17:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31453>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkOzL-0006eV-Vd for gcvg-git@gmane.org; Wed, 15 Nov
 2006 18:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030778AbWKORz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 12:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030781AbWKORz2
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 12:55:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44279 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1030774AbWKORz1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 12:55:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115175527.TVEM18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 12:55:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n5vZ1V0011kojtg0000000; Wed, 15 Nov 2006
 12:55:33 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

>> 3) remote branch handling should become more straight forward.
>
> I was completely confused by this origin/master/clone stuff when I started 
> with git.  In hindsight, now I understand git a bit more, this is what I 
> would have liked:
>
>  * Don't use the name "origin" twice.  In fact, don't use it at all.  In a 
> distributed system there is no such thing as a true origin.
>
>  * .git/remotes/origin should be ".git/remotes/default".   "origin" is only 
> special because it is the default to push and pull - it's very nice to have a 
> default, but it should therefore be /called/ "default".

I think the naming is just a minor detail and can be overridden
with "clone --origin" already.  Renaming it to default is just
like making separate-remote the default to me -- it is fine as
long as it does not break people's expectations.

>  * If clone really wants to have a non-read-only master, then that should 
> be .git/refs/heads/master and will initialise 
> to .git/refs/remotes/$name/master after cloning.  Personally I think this is 
> dangerous because it assumes there is a "master" upstream - which git doesn't 
> mandate at all.  Maybe it would be better to take the upstream HEAD and 
> create a local branch for /that/ branch rather than require that it is 
> called "master".

I think the latter is what clone has done always; take remote's
HEAD and use that to initialize local master (there is no
confusion coming from multiple peer repositories because you
clone from only one place to initialize the repository -- that
one _is_ the origin), and we even keep the HEAD pointing at the
remote's master or whatever it points at at the remote.  Using
"$name" as an object name uses .git/refs/remotes/$name/HEAD.

>  * git-clone should really just be a small wrapper around
>...
> If git-clone does anything that can't be done with settings in the config 
> and the remotes/default file then it's wrong.  The reason I say this is that 
> as soon as git-clone has special capabilities (like --shared, --local 
> and --reference) then you are prevented from doing magic with existing 
> repositories.

That is not entirely true.  clone has convenience because people
asked.  It does not have to mean you are not allowed to give
similar convenience to other commands.  Patches?

> branches from two other local repositories that have the objects hard linked?

fetch by second local repository with git-local-fetch perhaps.

> There have been lots of "wishlist" posts lately; would it be
> useful if I tried to collect all these suggestions from
> various people into one place to try and get a picture of any
> consensus?

A list of common things wished by people certainly is a handy
thing to have.

A consensus would not write code and it generally does not take
technology into account to tell what is realistic and what is
not, so the result needs to be take with a grain of salt,
though.
