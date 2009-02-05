From: Theodore Tso <tytso@mit.edu>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Thu, 5 Feb 2009 08:16:11 -0500
Message-ID: <20090205131611.GJ8945@mit.edu>
References: <200902021948.54700.jnareb@gmail.com> <200902040304.05028.jnareb@gmail.com> <20090204235436.GA8945@mit.edu> <200902051223.38992.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV471-0004Zs-Ry
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbZBENQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 08:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754869AbZBENQO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:16:14 -0500
Received: from thunk.org ([69.25.196.29]:42727 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbZBENQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 08:16:14 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LV45U-0007Z9-64; Thu, 05 Feb 2009 08:16:12 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LV45T-0005W3-Be; Thu, 05 Feb 2009 08:16:11 -0500
Content-Disposition: inline
In-Reply-To: <200902051223.38992.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108557>

On Thu, Feb 05, 2009 at 12:23:37PM +0100, Jakub Narebski wrote:
> > 
> > 2) And does the right thing happen if the situation is as described
> >    above, but in, branch C, which is descended from branch B, a new
> >    directory, src/plugin/innodb-experimental is created, such that
> >    src/plugin/innodb and src/plugin/innodb-experimental both exist.
> >    Now the same commit from branch A is pulled into branch C.  Will
> >    the correct thing happen in that the correct files in
> >    src/plugin/innodb are modified and created, even though there is a
> >    new directory containing a completely unrelated plugin that happens
> >    to have the name, "innodb-experimental"?
> 
> Errr... I think that you confused branch 'B' (with innodb-experimental)
> with branch 'A' (with innodb only) here.
> 

No, I didn't.   Let me try again.

At time T:	Project grows a plugin in directory src/plugins/foo-new

At time T+1:	Project releases a stable release, and branches off "maint"

At time T+2:	Project renames the plugin to be src/plugins/foo, using
		"scm mvdir src/plugins/foo-new src/plugins/foo" on the 
		devel branch:

At time T+3:	A developer wants to implement a new experimental
		'foo-new' plug in so she creates a completely new
		src/plugins/foo-new directory.  At this point the
		devel branch has 'src/plugins/foo' and
		'src/plugins/foo-new', where src/plugins/foo contains
		the plugin which is in the directory
		src/plugins/foo-new on the maint branch (since the
		maint branch branched off
   		before the directory renames started happening.

At time T+4:	A fix goes into the maint branch that modifies
   		src/plugins/foo-new/interface.c.    The fix needs to be
   		pulled into the devel branch.    Does the right thing
   		happen?   (Suppose "interface.c" is a commonly used 
		filename in all plugins and exists in both the 'foo'
   		and 'foo-new' directories on the devel branch.   Does
   		the SCM figure out what is the correct file to
   		modify?)

At Time T+5:	A commit goes into the maint branch which creates a
   		new file, src/plugins/foo-new/table.c, and modifies
		src/plugins/foo-new/Makefile to compile table.c.
   		Which directory does the SCM drop table.c into?

Thie point is if the project is organized around plugins, which are
considered bundles of code written in a modular way, and there is a
desire to rename directories which are the top-level modules, an SCM
that can easily deal with directory renames is important.  In practice
this doesn't come up in the Linux kernel, and many other OSS projects,
and if the project's developent style doesn't do directory
reorganizations often, then this isn't an issue.  If an OSS project
does do this type of reorganization more frequently, then the argument
"don't do that", would seem to be an unnecessary restriction.

		      		     	     	  - Ted
