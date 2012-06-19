From: Ryan Lortie <desrt@desrt.ca>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 13:06:41 -0400
Message-ID: <4FE0B1A1.9030509@desrt.ca>
References: <4FE091FB.7020202@desrt.ca> <20120619200648.2cc8a861.kostix@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 19:06:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh1tA-000498-5U
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 19:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab2FSRGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 13:06:43 -0400
Received: from manic.desrt.ca ([207.192.74.61]:45195 "EHLO mail.desrt.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2FSRGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 13:06:42 -0400
Received: from [172.16.0.159] (173-230-190-244.cable.teksavvy.com [173.230.190.244])
	by manic.desrt.ca (Postfix) with ESMTPSA id D13C012CD21;
	Tue, 19 Jun 2012 12:06:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120619200648.2cc8a861.kostix@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200213>

hi,

On 12-06-19 12:06 PM, Konstantin Khomoutov wrote:
> How bad this state really is?
> The user is free to do
> $ git branch -m gtk-3-4 mygtk-3-4
> at any time after the error was detected.

The user that makes the mistake to type 'git branch' instead of 'git 
checkout' in the first place is unlikely to know about this.

> This would not protect from the obvious case when a branch has been
> created on the remote (by someone else) but has not been fetched yet
> and so the local repo does not know a branch with "conflicting"
> name do exist.

I consider this to be a far less likely case: more of a race condition, 
really, and nothing we can do about it.  This is no reason that we 
should not try to fix the easier case (which is also the far more likely 
case).

> Your intention is good but I think a safety net of the kind you
> propose would be slightly over the top.
> Basically you're trying to compensate for the user error who
> thinks the "branch" command should take her to an already existing
> branch while it does something completely different.
> Hence preventing the `git branch gtk-3-4` command from completion
> should there be a remote-tracking branch of the same name is just wrong
> IMO.  On the other hand, posting a hint might be OK.  I'm talking about
> something like this:

I'll say again: it would still be possible with an appropriate 'force' 
parameter.

> Anyway, this will make each call to git-branch to perform a crawl over
> the refs/heads hierarchy which, I think, is not worth the result.

I know branching is lightweight with git, but I don't understand that 
the operation is so performance-critical that a enumerating a directory 
and doing a few stats would be a huge issue...

If it is decided to only check the 'origin' remote then we're talking 
about one single stat() syscall.

Cheers
