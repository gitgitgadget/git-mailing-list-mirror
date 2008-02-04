From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's
	name.
Date: Mon, 4 Feb 2008 11:35:42 -0200
Message-ID: <20080204133542.GA8197@c3sl.ufpr.br>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <m3bq728y4o.fsf@localhost.localdomain> <alpine.LSU.1.00.0801311110280.23907@racer.site> <200802010117.08295.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 14:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM1Us-00058o-Ly
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 14:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYBDNf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 08:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbYBDNf5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 08:35:57 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:44599 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbYBDNf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 08:35:56 -0500
Received: from localhost (unknown [189.1.131.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 33022700003C3;
	Mon,  4 Feb 2008 11:35:54 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <200802010117.08295.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72503>

On Fri, Feb 01, 2008 at 01:17:07AM +0100, Jakub Narebski wrote:
><snip> 
> Note that some of info is needed for 'projects_list' view, and some only
> for the 'summary' view.  For the 'projects_view' page we would want to
> avoid, I think, calling "git config -z -l" per repository (or opening
> $git_dir/config file and [limited] parsing it inside gitweb in Perl,
> like git-cvsserver does).  For 'summary' view we want usually to read
> repo config file for features nevertheless, and is only once per
> web-page, so we don't avoid it then.
> 
> Currently for 'projects_list' view we have, when $projects_list is
> a directory (this includes situation when it is undef, and fallbacks
> to $projectroot):
>  1. Call git-for-each-ref to get last modification time
>  2. Read $git_dir/description file for description (which is generated
>     by default template, so is usualy present, if in useless form),
>     fallback to git-config / reading $git_dir/config, gitweb.description
>  3. Check owner of $git_dir (stat + getpwuid)
> 
> With the addition of $git_dir/owner and gitweb.owner we would have
>  3'. Read $git_dir/owner file, usually not present,
>      fallback to gitweb.owner (which means reading and parsing
>      repo config!),
>      fallback to $git_dir owner (stat + getpwuid)
> so after consideration I think that adding gitweb.owner is a bit of
> a stupid idea from performance point of view, at least till we have
> 'projects_list' caching. Only $git_dir/owner would be better.

Unless we parse config only once for each project. We can create a small
cache with all gitweb conf. Then each time we ask
git_get_project_config('bla') we check if we alread had parsed it, if parsed
get in a small hash table.
We could even check if we are generating project list then we can store only
description and owner. (this sounds ugly)
>  
> BTW. what about filesystems where file / directory does not have
> an owner?

Does GIT runs on a system like this?! I only remembers FAT having such
"problem". 8^)
> 
> 
> Another solution would be using $projectroot/.gitconfig, with simplified
> syntax easy parseable by Perl, with gitweb.<repo path>.<config>, where
> <config> is limited to 'description', 'owner' and 'url', and 
> gitweb.description for fallback description, gitweb.owner for fallback
> owner and owner for set of repositories, gitweb.baseurl for base URLs
> (gitweb.<repo>.url = gitweb.baseurl/<repo>).

This sounds good.  Having this small, simple file would make things better.
But we will have another file inside repository, having all in config would
be cleaner [i guess]. If we parse config file only once per project might be
good.


> 
> This would limit repo paths to not have embedded newlines in them, but
> this is not I think serious limitation :-)
> 
> -- 
> Jakub Narebski
> Poland

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
