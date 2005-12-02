From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [Question] Fetching a new branch from remote
Date: Fri, 2 Dec 2005 08:50:47 -0700
Organization: Hewlett Packard
Message-ID: <20051202155047.GA14547@hpsvcnb.fc.hp.com>
References: <20051128163356.GA8300@hpsvcnb.fc.hp.com> <7vk6eoinqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 16:54:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiDCM-0000U1-Aq
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVLBPuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 10:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVLBPuu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 10:50:50 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:35008 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750799AbVLBPut (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 10:50:49 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel9.hp.com (Postfix) with ESMTP id AF7223642A;
	Fri,  2 Dec 2005 10:50:48 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id AACEF3836F; Fri,  2 Dec 2005 15:50:47 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 931C644F9; Fri,  2 Dec 2005 08:50:47 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vk6eoinqa.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13118>

The documentation below does make this more clear.  Now that you've
explained it I can see it useful to fetch a remote head without creating
a local one.  I simply hadn't thought of this scenerio.

Thank you for the explanation.

Cheers,
Carl

On Thu, Dec 01, 2005 at 12:09:01PM -0800, Junio C Hamano wrote:
> Carl Baldwin <cnb@fc.hp.com> writes:
> 
> > I would expect this to do it:
> >
> > % git fetch -f <url> new-branch
> >
> > But, it doesn't.
> >
> > Actually, I just noticed that this accomplishes the desired result...
> >
> > % git fetch <url> new-branch:new-branch
> 
> First, '-f' means "allow overriding the fast-forward check when
> updating an existing branch".  This can be done per refspec by
> saying "+rbranch:lbranch" but if you are fetching more than one
> remote branches at once (especially through "remotes" shorthand)
> the option can be used to allow override of all of them.
> 
> A single token <refspec> defaults to "<refspec>:" (meaning,
> "fetch but do not muck with our branches") is deliberate.  When
> I get a pull request "please pull from git://u/r/l/ send2junio branch",
> I do not "git pull git://u/r/l/ send2junio" right away, but do
> "git fetch git://u/r/l/ send2junio" and inspect FETCH_HEAD with
> various combinations of "git diff master..FETCH_HEAD" and
> friends.  I do _not_ want it to create send2junio branch in my
> repository with that.  Also "git pull git://u/r/l/ send2junio"
> would internally run "git fetch git://u/r/l/ send2junio" and
> then runs merge, and I do not want that to create send2junio
> branch in my repository either.  The latter could be prevented by
> adding an extra flag to git-fetch to tell it not to default
> a single token <refspec> to "<refspec>:<refspec>" and pass that
> flag from git-pull, though.
> 
> I just found out that the documentation for '-f' flag is simply
> missing.  I'd propose to add the following.  Thanks for noticing.
> 
> -- >8 --
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index a25d04a..200c9b2 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -4,6 +4,11 @@
>  	option old data in `.git/FETCH_HEAD` will be overwritten.
>  
>  -f, \--force::
> +	When `git-fetch` is used with `<rbranch>:<lbranch>`
> +	refspec, it refuses to update the local branch
> +	`<lbranch>` unless the remote branch `<rbranch>` it
> +	fetches is a descendant of `<lbranch>`.  This option
> +	overrides that check.
>  
>  -t, \--tags::
>  	By default, the git core utilities will not fetch and store
> 
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
