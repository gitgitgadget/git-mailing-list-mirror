From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Run hooks with a cleaner environment
Date: Wed, 7 Dec 2005 12:47:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512071236260.25300@iabervon.org>
References: <Pine.LNX.4.64.0512061716030.25300@iabervon.org>
 <7voe3tzqn8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 18:55:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek3Nt-0002LD-SI
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 18:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVLGRq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVLGRq5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 12:46:57 -0500
Received: from iabervon.org ([66.92.72.58]:54791 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751464AbVLGRq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 12:46:56 -0500
Received: (qmail 14653 invoked by uid 1000); 7 Dec 2005 12:47:39 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Dec 2005 12:47:39 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe3tzqn8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13334>

On Tue, 6 Dec 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > GIT_DIR is set to the repository that got the push,
> 
> That is done by receive-pack; it chdir()s into the repository
> and does its thing, and the hooks are called from there; I'd
> expect cwd to be the repository ('.git'), GIT_DIR to be dot
> ('.').

I thought I was seeing the full path of the repository as GIT_DIR and I 
didn't check the cwd.

> I think doing the "unset GIT_DIR" to be the first thing if you
> want to access some other repository is documented somewhere but
> if not please send a patch to document it.

I didn't see it in the place "grep post-update Documentation/*" returned, 
so we need something. (Actually, the main thing is to specify that nothing 
else special is set, because the GIT_DIR thing was pretty obvious, but I 
then didn't know if my problems were due to something else undocumented.)

> As to file descriptors, I think duping the output to original
> stderr might make sense, but I do not know what breaks, so
> interested parties may want to test it out and submit a tested
> patch for inclusion.

I'll send a patch tonight which works for me, but it should probably be 
checked over by people who are good at this sort of stuff. I've got a 
"/dev/null" patch; I'll look into a version that tries to find a 
controlling tty (which could be really interesting, since you could then 
have the hook get input from the user), or at least copy stderr if 
possible.

For reference, the error I was getting was a broken pipe writing to stdout 
(as git merge does somewhere) when I've pushed locally.

	-Daniel
*This .sig left intentionally blank*
