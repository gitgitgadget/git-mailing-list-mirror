From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui i18n status?
Date: Sat, 1 Sep 2007 21:42:42 -0400
Message-ID: <20070902014242.GJ18160@spearce.org>
References: <20070901042924.GE18160@spearce.org> <Pine.LNX.4.64.0709020003480.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Stimming <stimming@tuhh.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Nanako Shiraishi <nanako3@bluebottle.com>,
	Michele Ballabio <barra_cuda@katamail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Xudong Guan <xudong.guan@gmail.com>,
	Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Irina Riesen <irina.riesen@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 03:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IReUr-00044e-OQ
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 03:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423AbXIBBnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 21:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933428AbXIBBnY
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 21:43:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36718 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933407AbXIBBnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 21:43:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IReTx-00065h-NY; Sat, 01 Sep 2007 21:42:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7219320FBAE; Sat,  1 Sep 2007 21:42:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709020003480.28586@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57292>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 1 Sep 2007, Shawn O. Pearce wrote:
> > Looking at the repository on repo.or.cz it looks like it needs to be 
> > merged/rebased onto 0.8.2.  There is a trivial merge conflict, but there 
> > are some more subtle ones caused by the movement of the library 
> > directory initialization down lower in git-gui.sh. For example 
> > translations won't be initialized if we have an issue with the output of 
> > git-version and want to prompt the user.
> 
> Hmm.  I am not enough involved in i18n stuff to form a proper opinion 
> here...  Do you suggest to move the initialisation earlier?

Yea, I think that's what we are going to have to do here.  If we don't
setup the directory for the .msg files early enough than we cannot do
translations through [mc].  Unfortunately that means we have to also
break up the library initialization.

I'll try to work up a patch that does this.
 
> > What is the current plan?  Should I be looking at the master branch of 
> > git://repo.or.cz/git-gui/git-gui-i18n.git for pulling?  Or are folks 
> > expecting that this series will be cleaned up before I pull it?
> 
> My plan is to put out a cleaned up patch series:
...
> All these patches will go through the mailing list, so that people can 
> comment and suggest improvements.

OK, that works well for me.  Nice clean series to apply.
 
> I'll also try to bug Christian into looking through the output of
> 
> 	git grep \" -- \*.sh \*.tcl | grep -vwe mc -e bind | less
> 
> to make sure that we did not forget a string.  ATM the output consists of 
> 300+ lines, so it is a bit boring.  Maybe I can improve that command, 
> too...

Some of these are internal errors that should never be presented to
an end-user, and some are for reflog entries.   Here's a quick run
through of these:

      D == internal error message (developer only)
      R == reflog message
      T == probably should be translated

 D  "Invalid arguments to git-version",
 D  "Last arm of $type $name must be default",
 D  "git-version >= x",
 T  "git-gui: fatal error",
 T  "Cannot move to top of working directory:\n\n$err",
 D  "error: no icon for $w state={$state} $path",
 D  "error: no desc for state={$state} $path",
 T  "Unstaging [short_path $path] from commit",
 T  "Adding [short_path $path]",
 T  "fatal: cannot stat path $path: No such file or directory",
 T  "Possible environment issues exist.[...]",
 T  "Loading$cur_s annotations...",
 T  "Loading annotation...",
 T  "Author:\t",
 T  "Committer:\t",
 T  "Original File:\t",
 T  "Originally By:\n",
 T  "In File: ",
 T  "Copied Or Moved Here By:\n",
 T  "fatal: Cannot resolve $l_trck",
 R  "branch: Created from $new_expr",
 R  "merge $new_expr: Fast-forward",
 T  "Updating working directory to '[_name $this]'...",
 T  "Checked out '$name'.",
 D  "class $class already declared",
 D  "wrong # args: field name value?",
 D  "class $class is sealed (cannot add new fields)",
 D  "field $name already declared",
 D  "wrong # args: method name args body (ifdeleted body)?",
 D  "make_toplevel topvar winvar {options}",
 D  "unsupported option $name",
 T  "Commit $PARENT appears to be corrupt",
 T  "warning: Tcl does not support encoding '$enc'.",
 T  "This repository currently has approximately [...]",
 T  "Loading diff of [escape_path $path]...",
 T  "Unable to display [escape_path $path]",
 T  "* Binary file (not showing content).",
 T  "Unable to display [escape_path $path]",
 D  "error: Unhandled 3 way diff marker: {$op}",
 D  "error: Unhandled 2 way diff marker: {$op}",
 T  "Unstaging [short_path $current_diff_path] from commit",
 T  "Adding [short_path $current_diff_path]", and
 T  "The following branches are not completely merged into [...]",

Messages that I marked as 'D' shouldn't ever be shown to an end-user
as they represent a Tcl error from incorrect usage of an internal
function.  Translating these is fine but since it should never
appear unless there is a serious bug in git-gui its probably not
worth the translation effort.

Messages marked as 'R' appear in the reflog for the corresponding
branch, etc.  These are not currently translated by core Git so I
am not sure if we should translate them in git-gui.

Messages marked as 'T' above are most definately shown to
the end-user and should be translated, or at least offered for
translation.  I realize some terms have been kept in their English
form even after translation as there isn't a good way to translate
them into every language.

-- 
Shawn.
