From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Tue, 17 May 2005 22:35:00 +0200
Message-ID: <20050517203500.GH7136@pasky.ji.cz>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net> <20050517190355.GA7136@pasky.ji.cz> <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 22:36:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY8mH-0002ik-MM
	for gcvg-git@gmane.org; Tue, 17 May 2005 22:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVEQUfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVEQUfS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 16:35:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34275 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261937AbVEQUfC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 16:35:02 -0400
Received: (qmail 20546 invoked by uid 2001); 17 May 2005 20:35:00 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 17, 2005 at 09:27:03PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> >> +int path_ignored(const char *path)
> >> +{
> >> +	if (!verify_path(path))
> >> +		return 1;
> >> +
> >> +	/* Put the Porcelain layer ignore logic here.
> >> +	 * Return non-zero if path is to be ignored.
> >> +	 */
> >> +	return 0;
> >> +}
> 
> PB> I actually think you shouldn't. All the Porcelain layers should
> PB> hopefully use the same git toolkit layer, not each one shipping own due
> PB> to differences in things like this.
> 
> What you said above _is_ exactly my intention.  I phrased that
> comment very badly.  It should have said:
> 
>     /* We _will_ put the "ignore logic Porcelain layers agree upon"
>      * here, once we have a concensus.
>      *
>      * The code should return non-zero if path is to be ignored.
>      */
> 
> I did not put any implementation there because I do not think we
> have agreed upon anything yet.  This patch is to establish
> the framework.  

Ok, so this just bad comment. :-) No problem then.


Regarding having the code in the library, well, I'm thinking about why
not to just put this logic into all the git commands. Unfortunately I
can't find the email with Linus' argumentation against that right now.
:-(

> git-run-with-user-path is useful both in implementing
> porcelain-add if the porcelain's policy is to take filesystem
> paths not GIT paths, like this:

Actually, my doubts about general usefulness of this wrapper are
growing. Cogito is unlikely to ever make use of it since it has to
figure out the .git location anyway for own use (it keeps plenty of own
files there). But that's likely what any other porcelain layer would
have to do as well, isn't it? The wrapper could still be useful for the
standalone users, though.

Another thing is, I don't think git-run-with-user-path is the right name.
I think it doesn't make much sense on its own, and the wrapper is
actually doing more anyway, applying the ignore rules. What about
calling it just git-run-wrapper?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
