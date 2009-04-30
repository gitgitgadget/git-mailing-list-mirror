From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit standalone client on OpenVMS works (somewhat)
Date: Thu, 30 Apr 2009 12:26:07 -0700
Message-ID: <20090430192607.GS23604@spearce.org>
References: <3f1ae6620904300839n48e88143y2ae1694472f712a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Armstrong <BArmstrong@dymaxion.ca>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzbti-0007e9-Ni
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 21:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZD3T0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 15:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbZD3T0I
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 15:26:08 -0400
Received: from george.spearce.org ([209.20.77.23]:37959 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZD3T0H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 15:26:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8A6743806F; Thu, 30 Apr 2009 19:26:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3f1ae6620904300839n48e88143y2ae1694472f712a4@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118039>

Ben Armstrong <BArmstrong@dymaxion.ca> wrote:
> I am happy to report that the jgit standalone client works (somewhat) on
> OpenVMS/Alpha, a non-POSIX platform for which no C git port exists.  I
> understand that not all functionality of the C client is supported yet, but
> for limited use, and supplemented by using the C client on a PC, I may be
> able to get away with this.  At least being able to do a 'git clone' is
> encouraging.

Wow.

I'm talking to some folks who are trying to put JGit into Maven.
They want to move a lot of egit.core down into JGit, which should
make it easier to add more commands to the jgit wrapper, making a
more functional command line tool.
 
> The only problem I have found so far is that if a tag has dots in it and the
> last dotted expression looks like a VMS file version number, it is
> interpreted as such instead of part of the filepath used to represent it
> under .git/refs/tags
...
> $ HELP EXT_FILE_SPECS Using File_Specification_Differences
> ODS-5_Syntax Interpretation_of_Period
> ...
> Uggh.  I don't know if I'm going to be able to solve this one.
> I guess I just have to avoid multiple periods in tags.

Can you write a subclass of our FS class that can identify a
VMS host and use that VMS specific subclass? 

If so, we could add a method, e.g.:

  boolean canBeLooseRef(String name)

and on VMS when the name falls into that "ODS-5_Syntax
Interpretation_of_Period" rule set above, we could return false.
This would then permit a simple change in RefDatabase where we always
store such refs in the packed-refs file, instead of as a loose file.

It also means we'd have to forgo the ref log, or mangle the reflog
name.

But it seems to me we could reasonably work around this without
too much trouble.

-- 
Shawn.
