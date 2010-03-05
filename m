From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 12:47:33 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1003051103490.14365@iabervon.org>
References: <hmp427$d6h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 18:48:43 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnbdj-0007gL-3z
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 18:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab0CERrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 12:47:36 -0500
Received: from iabervon.org ([66.92.72.58]:55106 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323Ab0CERrf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 12:47:35 -0500
Received: (qmail 6072 invoked by uid 1000); 5 Mar 2010 17:47:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2010 17:47:33 -0000
In-Reply-To: <hmp427$d6h$1@dough.gmane.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141592>

On Thu, 4 Mar 2010, walt wrote:

> I just saw this article about the "google hackers" exploiting weaknesses in
> scms,
> Perforce in particular:
> 
> http://www.wired.com/threatlevel/2010/03/source-code-hacks/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+wired%2Findex+%28Wired%3A+Index+3+%28Top+Stories+2%29%29
> 
> I guess google didn't take Linus's advice to dump Perforce :)
> 
> I can't tell from the article if Perforce is any worse than any other scm for
> security holes, in fact it seems to imply that others haven't been tested in
> the same way.
> 
> Just curious if anyone here has any thoughts about how the article may or may
> not have any relevance for git (git being the scm I use most, by far, which is
> the reason I'm interested).

I took a look at the white paper the article links to. I had to ignore a 
lot of the introductory sections (yes, the most secure system would be to
prevent people from doing any work that might be stolen or released after 
it was corrupted), but I assume that the "findings" are the actually 
relevant part. Comparing git and Perforce here:

 - The Perforce server software for Windows installs to run as root. I'm 
   not sure what the norm is for git central repositories on Windows, but 
   it's probably better. I don't know if people actually run Perforce 
   servers on Windows in practice, either.

 - Perforce has built-in authorization and authentication. By default, it 
   allows unauthenticated people to create users without any specific 
   authorization. It transmits passwords in cleartext in some cases. It 
   discloses a lot of information about the authorization and 
   authentication in force to arbitrary people, including users of the 
   internal web site who do not have protocol access at all. It issues 
   login tickets that last a long time. The authorization controls are not 
   applied reliably to operations that modify the authorization and 
   authentication information in some of the server software. The initial 
   configuration with respect to access control is completely 
   unrestrictive. Git does not have built-in authorization or 
   authentication, so avoiding or making these mistakes is outside git's 
   scope.

 - Perforce sends all of content over the network in cleartext. This is 
   essentially true of git as well, but in order to get any sort of access 
   control with git, you need to use some wrapping method, which will 
   generally provide encryption as well.

 - Perforce stores, on the server, the location of the working directory 
   on the client, and this is used by the client to place files. Git does 
   not store this information at all.

In general, they seem to have found numerous flaws due to the fact that 
Perforce includes security-related code while not being designed by 
security specialists. Git is designed not to include security-related 
code, and to have properly developed security code control access to it. 
It is possible to run Perforce in a configuration where access control is 
external to Perforce, but it's not easy or standard.

On the other hand, I don't see any indication that the attack they were 
investigating used any of the problems they found, or any problems of a 
similar class. The actual attack seemed to involve a successful attack on 
the workstation of someone with legitimate priviledges, which the 
attackers then used. It's hard to say if any security measures on the part 
of the SCM could have any effect other than limiting the choice of the 
user to target.

	-Daniel
*This .sig left intentionally blank*
