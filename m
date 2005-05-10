From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Renaming environment variables.
Date: Tue, 10 May 2005 02:25:48 +0200
Message-ID: <20050510002548.GI15712@pasky.ji.cz>
References: <7vis1vc27f.fsf@assigned-by-dhcp.cox.net> <2721.10.10.10.24.1115425962.squirrel@linux1> <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net> <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com> <7vll6oz755.fsf@assigned-by-dhcp.cox.net> <3087.10.10.10.24.1115656919.squirrel@linux1> <427FA5FD.1050000@zytor.com> <7vfywwz11t.fsf@assigned-by-dhcp.cox.net> <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:18:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVISV-0002Yh-Nz
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEJA0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVEJA0B
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:26:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28814 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261441AbVEJAZt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:25:49 -0400
Received: (qmail 4409 invoked by uid 2001); 10 May 2005 00:25:48 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 10:05:00PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
>  - Renames the following environment variables:
> 
>     New name                Old Name
> 
>     GIT_AUTHOR_DATE         AUTHOR_DATE
>     GIT_AUTHOR_EMAIL        AUTHOR_EMAIL
>     GIT_AUTHOR_NAME         AUTHOR_NAME
>     GIT_COMMIT_AUTHOR_EMAIL COMMIT_AUTHOR_EMAIL
>     GIT_COMMIT_AUTHOR_NAME  COMMIT_AUTHOR_NAME
>     GIT_ALTERNATE_OBJECTS   SHA1_FILE_DIRECTORIES
>     GIT_OBJECTS             SHA1_FILE_DIRECTORY

Could I please have s/COMMIT_AUTHOR/COMMITTER/ and
s/OBJECTS/(OBJDIR|OBJECT_DIR)/?

> The transition plan is as follows:
> 
>  - We will keep the backward compatibility list used by gitenv()
>    for now, so the current scripts and user environments
>    continue to work as before.  The users will get warnings when
>    they have old name but not new name in their environment to
>    the stderr.
> 
>  - The Porcelain layers should start using new names.  However,
>    just in case it ends up calling old Plumbing layer
>    implementation, they should also export old names, taking
>    values from the corresponding new names, during the
>    transition period.

(Cogito needs its own git-merge-cache so that the merge goes properly
anyway, and it already (or still) carries its Git around, so I think
it's not applicable to it. Yes, I want and plan to start publishing the
Git changes, I'm already making some steps for that and I hope I have
something to show by tomorrow.)

>  - After a couple of weeks or so, we would drop the
>    compatibility support and drop gitenv().  Revert the callers
>    to directly call getenv() but keep using the new names.
> 
>    The last part is probably optional and the transition
>    duration needs to be set to a reasonable value.

Yes, I think couple of weeks is too long. :-) I'd say one or two
releases is enough.

> --- /dev/null
> +++ b/gitenv.c

Pretty please, add copyright notices at the top of files.

> +char *gitenv_bc(const char *e)
> +{
> +	int first, last;
> +	char *val = getenv(e);
> +	if (val)
> +		/* inefficient.  caller should use gitenv() not gitenv_bc() */
> +		return val;

Can this ever happen? If doing it at all, I'd expect gitenv_bc() to
rather freak out and die(), the caller is broken.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
