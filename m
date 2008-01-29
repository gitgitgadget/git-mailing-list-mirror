From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Tue, 29 Jan 2008 15:22:16 -0200
Message-ID: <20080129172216.GA17875@c3sl.ufpr.br>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <m3lk6898kg.fsf@localhost.localdomain> <20080129142550.GA25312@c3sl.ufpr.br> <200801291628.21026.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 18:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJuAe-0002oC-Go
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 18:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYA2RWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 12:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYA2RWU
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 12:22:20 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:49193 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYA2RWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 12:22:19 -0500
Received: from dalmore (dalmore.c3sl.ufpr.br [200.17.202.56])
	by urquell.c3sl.ufpr.br (Postfix) with SMTP id 5276370000090;
	Tue, 29 Jan 2008 15:22:16 -0200 (BRST)
Received: by dalmore (sSMTP sendmail emulation); Tue, 29 Jan 2008 15:22:16 -0200
Content-Disposition: inline
In-Reply-To: <200801291628.21026.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71983>

On Tue, Jan 29, 2008 at 04:28:19PM +0100, Jakub Narebski wrote:
> On Tue, 29 Jan 2008, Bruno Cesar Ribas wrote:
> > On Tue, Jan 29, 2008 at 03:26:31AM -0800, Jakub Narebski wrote:
> >> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> >> 
> >>> This file ($projectroot/$project/owner) is good to have when we don't want to
> >>> maintain a project  list AND when we share same SSH account for all projects,
> >>> using ssh_acl for example.
> >>>
> >>> Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
> >> 
> >> This explanation is a bit too complicated; it explains farther
> >> reasons, instead of immediate ones: you don't want to maintain project
> >> list file, and all repository directories have to have the same owner
> >> (for example when the same SSH account is shared for all projects,
> >> using ssh_acl to control access instead).
> > 
> > I'm sorry about this complicated explanation.
> 
> It is not [that] bad description, but it could be better. Also, 80 columns
> word wrap is good, but 72-76 would be even better :-)
> 
> >> Besides with new faster config reader we probably would want to allow
> >> to use config file to set owner, instead of adding yet another file to
> >> the repo area; see commit 0e121a2cd42d28bc4034feedf8a13c5a91f85bd3
> >>   "gitweb: Use config file for repository description and URLs"
> >> This would have the advantage that you could use system config
> >> (/etc/gitconfig) to set fallback owner instead of relying on
> >> filesystem.  I'm not sure what should be the preference, though:
> >> gitweb.owner, then $GIT_DIR/owner, or vice versa?  I guess that
> >> reading $GIT_DIR/owner should take preference, as it is needed also
> >> for projects list page, where ordinary we didn't read individual
> >> repositories configuration.
> > 
> > Reading $GIT_DIR/owner would be the preference, Maybe it can generate project
> > list page faster when machine have high IO waits (WA).
> 
> Yes, I also think so. Two file reads (description + owner) should be
> still faster than one running git-config, and parsing its output.
> 
> But I think if IO matters it is better to generate projects list; you
> can even use gitweb for that, or you can simply add a line with URL
> escaped project name (project path) relative to $projectroot, separated
> by space from the URL escaped (URI-encoded) project owner.  See also
> "Gitweb repositories" section in gitweb/INSTALL.  Adding projects is
> rare event.
>  
> > Having gitweb.owner is good too, but as you said I don't need to read
> > individual repositories configuration.
> > 
> > Having another file at the repo area is not a problem (my say). Sometimes
> > having files appears to be more organized than having everything in one file
> > (my say again).
> 
> By the way, I have forgot to ask you to add description of new 'owner'
> file to "Per-repository gitweb configuration" section in gitweb/README

I'm on the way to add description of 'owner' file, before commint should I
implement gitweb.owner too? then that README comes with two way of seting
owner. Or let only owner file for now?

> 
> > I even made another patch about cloneURL, instead of looking for inside files
> > and stuff, i made gitweb.conf a variable that says:
> > - If i have a prefix path for HTTP,SSH,GIT[protocol]
> > Then if this variable is set gitweb only mounts... like
> > HTTPPREFIX="http://git.c3sl.ufpr.br/pub/scm"
> > and gitweb sets it to $HTTPREFIX/$project
> > 
> > I made this because I don't want to set each project it's clone URL, so this 
> > makes thing easier! What do you think?
> 
> I hope that this hack predates latest improvements to gitweb/README,
> as you have just reimplemented GITWEB_BASE_URL build configuration
> variable (only single base URL), and @git_base_url_list, which you
> can set in gitweb config file (by default gitweb_config.perl).

Ok, I'll check recent version of gitweb and i'll send this commit if relevant
=)

>  
> If you have read current code carefully, you should notice that
> currently gitweb generates URLs for repository in the following way:
> 
>  1. Per repository configuration:
>     a. $projectroot/$project/cloneurl (one line perl URL)
>     b. multivalued gitweb.url configuration variable in project config
>  2. Global gitweb configuration
>     a. $prefix/$project for each $prefix element in @git_base_url_list,
>        which is set in gitweb_config.perl
>  3. Build time defaults
>     a. Single value in @git_base_url_list set using GITWEB_BASE_URL
>        build configuration variable
>  4. Otherwise it is not set (it is empty).
> 
> -- 
> Jakub Narebski
> Poland

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
