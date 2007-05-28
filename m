From: Petr Baudis <pasky@suse.cz>
Subject: Re: GitWeb: Adding fork visualization based on objects/info/alternates
Date: Mon, 28 May 2007 15:00:38 +0200
Message-ID: <20070528130038.GR4489@pasky.or.cz>
References: <46587CE5.1030501@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon May 28 15:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HseqE-0006i5-Ea
	for gcvg-git@gmane.org; Mon, 28 May 2007 15:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbXE1NAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 09:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbXE1NAm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 09:00:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56077 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743AbXE1NAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 09:00:41 -0400
Received: (qmail 18609 invoked by uid 2001); 28 May 2007 15:00:38 +0200
Content-Disposition: inline
In-Reply-To: <46587CE5.1030501@trolltech.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48615>

  Hi,

On Sat, May 26, 2007 at 08:31:01PM CEST, Marius Storm-Olsen wrote:
> In an effort to tidy up the project list, and given that the
> current fork support in GitWeb doesn't exactly fit my
> structure (where forks are in subdirs of parent repo, and has
> to be first level down; alas no seek unlike when not showing
> forks), I set out to add fork support based on
>     objects/info/alternates
> of each repo. The result can be seen here:
>     http://chaos.troll.no/~marius/git/forks_collapsed.png
>     http://chaos.troll.no/~marius/git/forks_expanded.png
> 
> I doubt you'd want it in the mainline, as you can't turn the
> feature off; it's just like another column which you can sort
> by. If you do not sort by the 'fork' column, the forks will
> still be colored with the first level color, but not ordered
> under it's parent repo.
> 
> Just wanted to feed back what I did so others can get
> inspiration, tweak it, and add it to their own gitwebs.
> 
> It cleans up the project list real nicely though.

  I think this patch is quite an interesting idea, and I kind of like
the possibility to show forks in the summary project list, if it's
optional (I actually don't think if I would enable this say at
repo.or.cz - some projects have quite a lot of forks and it would
clutter it up a lot e.g. for text-mode browsers that don't grok
enough javascript). OTOH, taking fork info from alternates is more
controversial; I don't want to force the repo.or.cz forks model on
everyone but having $proj in alternates may not mean it is a fork... but
if more people think it's a reasonable heuristic, we might optionally
support it too.

  If you would be willing to split this patch to two and make both
features optional (and sign off the patch), I think at least the
forks-in-summary part might be quite a worthy addition.

> @@ -1909,8 +1919,9 @@ EOF
>  		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
>  	}
> 
> +	print "<script src=\"gitweb_scripts.js\" type=\"text/javascript\"></script>\n";
>  	print "</head>\n" .
> -	      "<body>\n";
> +	      "<body onload=\"collapseAllRows();\">\n";
> 
>  	if (-f $site_header) {
>  		open (my $fd, $site_header);

Would it be more reasonable to just set the style for these rows by
default to display: none?

> --- /dev/null
> +++ b/gitweb/gitweb_scripts.js

We have other patch introducing blame.js, so maybe call this forks.js?
Or do we have a strong reason to prefer a single .js file with all the
lot?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
