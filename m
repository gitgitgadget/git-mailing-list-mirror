From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable and world-readable
Date: Sat, 12 Apr 2008 06:00:21 +0300
Message-ID: <20080412030021.GB31039@zakalwe.fi>
References: <20080411140916.GA30667@zakalwe.fi> <7vfxtrnban.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 05:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkVzH-00075c-FO
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 05:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbYDLDAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 23:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756446AbYDLDAX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 23:00:23 -0400
Received: from zakalwe.fi ([80.83.5.154]:33268 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756087AbYDLDAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 23:00:23 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id E9A812C331; Sat, 12 Apr 2008 06:00:21 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vfxtrnban.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79323>

On Fri, Apr 11, 2008 at 05:53:36PM -0700, Junio C Hamano wrote:
> That's not a "Warning" (which tends to mean "you can violate this if you
> know what you are doing"), but should be stronger than that.  Something
> like (also notice the multi-line comment style --- the first line ends
> with "/*\n"):
> 
> /*
>  * NOTE NOTE NOTE!!
>  *
>  * Do not reorder this list; numerically written core.sharedrepository
>  * in config files have always been valid, and you would break existing
>  * repositories if you move these around.
>  */

OK

> >  enum sharedrepo {
> >  	PERM_UMASK = 0,
> >  	PERM_GROUP,
> > -	PERM_EVERYBODY
> > +	PERM_EVERYBODY,
> > +	PERM_GROUP_READABLE,
> > +	PERM_WORLD_READABLE,
> >  };
> 
> But I have to wonder if this patch is necessary.

It is necessary for us, and I suspect it will be useful in some
organizations. The situation is this:

* multiple groups on the same machine
* users may want to keep umask 0077 as the default

> Neither am I convinced if this set is sufficient.

It will be easy to add new groups if the need arises, but I can't see 
many other useful combinations..

> For example, you may want to enforce "ug+rw,o=" in a repository.  How
> would you do that?

Isn't that PERM_GROUP? The user always keeps u+rw for oneself.

> Perhaps if you really wanted to have such a fine grained control, you
> would be better off defining core.sharedrepository as a set/unset pair?
> 
> 	core.sharedrepository = 0660,007 ;# ug+rw,o-rwx
> 
> Or even stronger "set to this bit pattern"?
> 
> 	core.sharedrepository = 0660 ;# ug=rw,o=

The latter approach is simpler and probably more understandable.

> (I think you would need to flip executable bit for directories if you go
> this route).

I can put x flag mode checking.

Do you accept these proposals? I can submit another patch.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
