From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git under Windows should warn or fail on entities differning
 only in case
Date: Sat, 13 Feb 2010 01:05:23 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002130014180.14365@iabervon.org>
References: <1265978433.7519.6.camel@chumley>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Hagood <david.hagood@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 07:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgB97-0005PM-KJ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 07:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab0BMGF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 01:05:28 -0500
Received: from iabervon.org ([66.92.72.58]:49067 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982Ab0BMGF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 01:05:27 -0500
Received: (qmail 25213 invoked by uid 1000); 13 Feb 2010 06:05:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Feb 2010 06:05:23 -0000
In-Reply-To: <1265978433.7519.6.camel@chumley>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139775>

On Fri, 12 Feb 2010, David Hagood wrote:

> I work in a mixed Windows and Linux development team where we have an
> embedded project that we are storing in GIT. However, we got bit by what
> is arguably a bug in Windows, but...
> 
> If you have 2 entities in a directory which have names differing only in
> case, e.g. "foo" and "FOO", under a REAL operating system with case
> sensitive file system semantics, this is no problem. However, under
> Windows and their wonderful "Case preserving but case insensitive"
> semantics, "FOO" and "foo" would be the same file, so when you
> pull/checkout/clone a repo with this condition, Windows will overwrite
> one file, then Git will always see a "change" because one file or the
> other won't be "right".
> 
> I would suggest that git should check for this case, and generate a big
> warning about it when it happens. (Yes, it sucks burdening Git with
> Windows' problems....)

There are several possible paths here (at least one of which is something 
that's been discussed and agreed to in principle, but nobody is interested 
in implementing):

 - Git for Windows could detect that your project isn't going to fit in 
   the Windows filesystem, because it knows the rules for filename 
   comparison on that filesystem and there are overlaps.

 - Git in general could detect that the filesystem thinks multiple names 
   your project uses are for the same file, because when it started "FOO" 
   didn't exist, now it does, and it's got the same stat info as some file 
   that git wrote in this interval.

 - Git in general could see that your project has declared that it's 
   partially developed on a system that conflates filenames in certain 
   patterns and/or treats certain filenames as being octet-wise different 
   filenames, and warn you, regardless of where you're running git, if you 
   create files that will be a problem, either for you or for other 
   people.

I think you'd only really benefit from the third of these; with either of 
the first two, the Windows users will find out in a clear way that they've 
got problems, which is nice, but the Linux users won't get the instant 
feedback necessary to keep them from causing the problems, and the Windows 
users can't do much about the problems at that point, either.

Git does support putting whitespace policy rules in .gitattributes and 
warning about violations of them in some operations. It would not be 
unreasonable for git to support filename policy rules similarly, which 
could be handy not only for Windows users, but for people who people who 
want to refer to filenames over the telephone ("No, xt underscore 
*lowercase* connmark dot c") or can only type some characters (imagine how 
much fun it would be for a project to have subdirectories for different 
economic zones, each named with the currency symbol for that zone; the 
computer has no problem with them, but each developer has a keyboard that 
only has a key for a different one or two of them).

	-Daniel
*This .sig left intentionally blank*
