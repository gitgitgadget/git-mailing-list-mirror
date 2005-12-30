From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Fri, 30 Dec 2005 15:10:17 -0800
Message-ID: <20051230231017.GB7165@mail.yhbt.net>
References: <20051224122016.GD3963@mail.yhbt.net> <7virtes6zd.fsf@assigned-by-dhcp.cox.net> <20051224195033.GE3963@mail.yhbt.net> <7vu0cyqk5d.fsf@assigned-by-dhcp.cox.net> <20051224211925.GH3963@mail.yhbt.net> <Pine.LNX.4.63.0512261730170.7716@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 31 00:10:34 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsTOE-0000gJ-P6
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 00:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVL3XKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 18:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVL3XKT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 18:10:19 -0500
Received: from hand.yhbt.net ([66.150.188.102]:22412 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S964934AbVL3XKS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 18:10:18 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 48B6E7DC005; Fri, 30 Dec 2005 15:10:18 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512261730170.7716@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14120>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Sat, 24 Dec 2005, Eric Wong wrote:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> > > Eric Wong <normalperson@yhbt.net> writes:
> > > 
> > > > My home directories have different names on different machines I'm
> > > > on, and I want to avoid having to recompile git for each one.
> > > > I don't have root access to some of them, so installing globally in /usr
> > > > or /usr/local isn't an option, either.
> > > 
> > > Then you probably need to use GIT_EXEC_PATH environment
> > > variable.
> > 
> > That works with git.c but not init-db.  But then again I don't use
> > git-init-db that often.  I'll just write a shell script wrapper for the
> > latter if I do.
> 
> How about something like this?

Sure, seems reasonable, but I don't feel that strongly towards
making my env getting bigger and bigger all the time.

I've also been comtemplating just using my own wrapper instead of the
default 'git' wrapper (which being in C, is more difficult to customize
on-the-fly than sh or perl).  Or have git read a config file from a
user's home directory.

> ---
> [PATCH] Introduce environment variable for the path to the templates
> 
> The environment variable GIT_TEMPLATE_PATH can override the compiled-in
> setting, and can be overridden with the '--template=' argument to init-db.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> ---
> 
> 	Eric said that GIT_EXEC_PATH is enough for most things, but not for
> 	init-db. I guess he wanted something like this.
> 
>  init-db.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 5d95ce750b09a14bcb86e07ba23077ab0825089c
> diff --git a/init-db.c b/init-db.c
> index 863ec1a..774a91f 100644
> --- a/init-db.c
> +++ b/init-db.c
> @@ -238,7 +238,7 @@ int main(int argc, char **argv)
>  {
>  	const char *git_dir;
>  	const char *sha1_dir;
> -	char *path, *template_dir = NULL;
> +	char *path, *template_dir = getenv("GIT_TEMPLATE_PATH");
>  	int len, i;
>  
>  	for (i = 1; i < argc; i++, argv++) {

-- 
Eric Wong
