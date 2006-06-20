From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Restore SIGCHLD to SIG_DFL where we care about waitpid().
Date: Tue, 20 Jun 2006 14:59:38 +0200
Message-ID: <20060620125936.GQ2609@pasky.or.cz>
References: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606191654590.5498@g5.osdl.org> <7vfyi07jf2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606191742470.5498@g5.osdl.org> <7vslm04j2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 14:59:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsfpT-00076s-B6
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 14:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFTM7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 08:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWFTM7f
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 08:59:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53173 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750732AbWFTM7f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 08:59:35 -0400
Received: (qmail 7966 invoked by uid 2001); 20 Jun 2006 14:59:38 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslm04j2r.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22200>

Dear diary, on Tue, Jun 20, 2006 at 05:11:40AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> diff --git a/connect.c b/connect.c
> index 52d709e..db7342e 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -581,6 +581,11 @@ int git_connect(int fd[2], char *url, co
>  	enum protocol protocol = PROTO_LOCAL;
>  	int free_path = 0;
>  
> +	/* Without this we cannot rely on waitpid() to tell
> +	 * what happened to our children.
> +	 */
> +	signal(SIGCHLD, SIG_DFL);
> +
>  	host = strstr(url, "://");
>  	if(host) {
>  		*host = '\0';

It would be nice if at this point of Git development we could already
think about libification when doing things like this (I'd like to do
Git.pm as my little summer project this year). I'd make it part of the
API that the calling application must not defer SIGCHLD, and conversely
put the handler to all the main()s that reach git_connect().

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
