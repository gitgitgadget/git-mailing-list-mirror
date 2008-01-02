From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 11:18:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801021058030.13593@iabervon.org>
References: <477B39B5.5010107@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1092218702-1199290700=:13593"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:18:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA6Iw-0002OO-LF
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 17:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYABQSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 11:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYABQSW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 11:18:22 -0500
Received: from iabervon.org ([66.92.72.58]:36291 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbYABQSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 11:18:22 -0500
Received: (qmail 384 invoked by uid 1000); 2 Jan 2008 16:18:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jan 2008 16:18:20 -0000
In-Reply-To: <477B39B5.5010107@advancedsl.com.ar>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69476>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1092218702-1199290700=:13593
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 2 Jan 2008, Gonzalo Garramuño wrote:

> I've been using git for some time and love it.  For open source projects
> there's clearly nothing currently better.
> 
> However, I am now using git for proprietary elements, which in the future I
> may need or want to partially restrict access to.  The idea being that at my
> company some (junior) developers should not be given access to some elements.
> That means either that some full git repository should be password protected
> or even portions of the same repository.
> 
> Another desirable way to protect elements might be only giving clone/pull
> access to a repository (or portion of it) but not permissions to push in
> changes.

In order to understand the security model, you have to remember that git 
is designed as a distributed system. Authorization is fundamentally not at 
a project level, but rather at a repository level, and clones are all 
different repositories. This makes portability of the mechanism less 
important, because a particular set of authorization rules only applies to 
a particular repository, which is going to be on some single system.

For that matter, git doesn't run with any special privileges in general; 
if a user can affect the repository with git operations, that user can 
affect the repository by hand, so git-specific rules aren't helpful. 
(Although I suppose it would be theoretically useful to make git-shell, 
the shell that only runs git programs, able to apply restrictions, since 
it is used in a context where the user doesn't have any other access to 
the filesystem.)

For read access restrictions, you want to use submodules (or entirely 
separate projects); git is fundamentally unhappy running with less than 
all of the project accessible, except for when a project references 
another project with submodules. And, of course, if the code base is such 
that users can do useful work without any access to some of the files, 
those files must be optional and somewhat separate from the necessary 
portions, and it makes sense to handle them separately anyway.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1092218702-1199290700=:13593--
