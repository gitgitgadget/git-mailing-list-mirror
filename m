From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: why not preserve file permissions?
Date: Fri, 5 Dec 2008 19:05:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812051815240.19665@iabervon.org>
References: <87tz9igzbr.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Dec 06 01:07:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8kh6-0003yB-5l
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 01:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbYLFAFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 19:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYLFAFW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 19:05:22 -0500
Received: from iabervon.org ([66.92.72.58]:36048 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbYLFAFW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 19:05:22 -0500
Received: (qmail 2008 invoked by uid 1000); 6 Dec 2008 00:05:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Dec 2008 00:05:20 -0000
In-Reply-To: <87tz9igzbr.fsf@jidanni.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102423>

On Sat, 6 Dec 2008, jidanni@jidanni.org wrote:

> Why not preserve permissions the way you find them, instead of just
> using 644 and 755? It certainly couldn't be more complicated than what
> you are doing now, and that way one could do things like use git to
> update system administration files across a sneakernet containing e.g.,
> # dlocate -lsconf exim4-config|sed 's/ .*//'|sort -u
> -rw-r-----
> -rw-r--r--
> -rwxr-xr-x
> 
> > git was made for tracking source code, not 640 files.
> 
> On the sneakernet no public patches would be sent, and the
> administrator would remember to make the sensitive .git directories
> 700. And sure, git should enforce umask or no set-uid or whatever when
> doing a checkout etc. The deluxe edition of git could even print a
> warning: "you are trying to track a 640 file but your .git permissions
> are less restrictive." However I recommend no premium or deluxe
> editions for now.

The fundamental issue is that git is intended to support development, 
which is to say that users have to be able to create trees that reflect 
the content that they intend the project to have, rather than only content 
that they can represent directly in their working tree. In order to do 
development on an exim configuration, you may want to be able to set 
permissions and ownership that will only make sense in the production 
environment. So it's actually better to have some setup where you've got a 
metadata file (that you can make arbitrary changes to without any 
particular hassle) in addition to the content files, and a script for 
putting the files in place with the metadata applied on the live server.

That is, preserving metadata would allow you to use git as a really 
complicated version of tar, but wouldn't give you the advantages of using 
git.

	-Daniel
*This .sig left intentionally blank*
