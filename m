From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Sat, 29 Aug 2009 21:46:03 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908292116060.28290@iabervon.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 03:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhZW7-0007dr-DE
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 03:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZH3BqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 21:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbZH3BqB
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 21:46:01 -0400
Received: from iabervon.org ([66.92.72.58]:51398 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbZH3BqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 21:46:01 -0400
Received: (qmail 12963 invoked by uid 1000); 30 Aug 2009 01:46:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Aug 2009 01:46:03 -0000
In-Reply-To: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127391>

On Wed, 26 Aug 2009, Junio C Hamano wrote:

> * db/vcs-helper (2009-08-09) 17 commits
>  - Allow helpers to request marks for fast-import
>  - Allow helpers to report in "list" command that the ref is unchanged
>  - Add support for "import" helper command
>  - transport-helper_init(): fix a memory leak in error path
>  - Add a config option for remotes to specify a foreign vcs
>  - Allow programs to not depend on remotes having urls
>  - Allow fetch to modify refs
>  - Use a function to determine whether a remote is valid
>  - Use a clearer style to issue commands to remote helpers
>   (merged to 'next' on 2009-08-07 at f3533ba)
>  + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
>  + Makefile: do not link three copies of git-remote-* programs
>  + Makefile: git-http-fetch does not need expat
>   (merged to 'next' on 2009-08-06 at 15da79d)
>  + http-fetch: Fix Makefile dependancies
>  + Add transport native helper executables to .gitignore
>   (merged to 'next' on 2009-08-05 at 33d491e)
>  + git-http-fetch: not a builtin
>  + Use an external program to implement fetching with curl
>  + Add support for external programs for handling native fetches
>  (this branch is used by jh/cvs-helper.)
> 
> There was a discussion that suggests that the use of colon ':' before vcs
> helper name needs to be corrected.  Nothing happened since.

I believe the outcome of that discussion was:

 - We want to keep supporting using regular location URLs that are URLs of 
   git repositories (e.g., http://git.savannah.gnu.org/cgit/xboard.git), 
   and we probably want to do it with a helper which runs when 
   run_command() is given "remote-<scheme>". I think installing hardlinks 
   in EXECPATH ended up being the best implementation here. This is 
   currently a special case, because these URLs have push handled 
   internally (or, rather, with internal code calling a different external 
   program), but I think we want to make it no longer special at all, so 
   that people can install the handling for access to native repos via 
   dumb filesystem-like protocols separately. This is in next.

 - We want to support a separate "vcs" option for cases where repositories 
   in the foreign system need to be addressed through the combination of a 
   bunch of options, which will be read from the configuration by the 
   helper. The helper which gets run is "remote-<value of vcs option>". 
   This is in pu.

 - We want to support URLs of some sort leading to using helpers 
   appropriate for foreign systems that use URLs and are most conveniently 
   located this way. We didn't come to any concensus on what this should 
   do, but we also haven't had any helpers proposed yet that would use it, 
   and the series doesn't include any code that would lead to running a 
   helper other than in one of the above two cases. (jh's cvs helper 
   clearly wants "cvsroot" and "cvsmodule" options, and my p4 helper wants 
   "port" and "codeline" options; SVN is the big use cases for URLs, but 
   nobody's tackled that as a helper)

So I think this issue is squarely in "future work" anyway, and the current 
part of the series should be able to move forward, unless I've missed some 
other issue.

Of course, there are a bunch of things that are beyond the present 
contents of the series, but I think there's nothing wrong in the series as 
it is, and it's worthwhile without any further patches.

	-Daniel
*This .sig left intentionally blank*
