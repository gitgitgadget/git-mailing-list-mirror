From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Wed, 31 May 2006 23:34:30 -0400
Message-ID: <20060601033430.GA13485@spearce.org>
References: <20060529085738.GB29500@spearce.org> <7virnp8a30.fsf@assigned-by-dhcp.cox.net> <20060529094605.GB27194@spearce.org> <7vhd373o15.fsf@assigned-by-dhcp.cox.net> <20060531021808.GC21222@spearce.org> <7v64jm2380.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 05:34:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FldxG-0002l4-DE
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 05:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWFADef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 23:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWFADef
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 23:34:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31125 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751697AbWFADee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 23:34:34 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fldwy-0006ix-VQ; Wed, 31 May 2006 23:34:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1ACFC20E445; Wed, 31 May 2006 23:34:30 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64jm2380.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21103>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >
> >> If we supported multiple -m (presumably each becomes a single line?)
> >> with internal fmt, I do not see how it would become less work.
> >> 
> >> 	$ git commit -w60 -m "This is my message." \
> >>         	-m '' \
> >>         	-m 'This is the body.  Etc....'
> >> 
> >> looks more typing to me, even without the second line to force
> >> the empty line between the summary and the body.
> >
> > Actually I was thinking each -m would be its own paragraph so blank
> > lines would split each -m and maybe the -w60 should be a config
> > option in .git/config or .gitrc so it doesn't always need to be
> > supplied on the command line.
> 
> Now that makes the distinction between the current:
> 
> 	$ git commit -m 'This is my message.
> 
> 	This is the body.  Etc....'
> 
> vs. the proposed multi-em:
> 
> 	$ git commit -m 'This is my message.' \
>         -m 'This is the body.  Etc....'
> 
> Presumably Etc.... will be an multiline argument to -m.  The
> distinction is even more blurry to me than before.
> 
> Emacs users would just do "ESC q" and vi users would know how to
> filter the file contents through fmt, so this seems to come from
> aversion against invoking your $EDITOR.  I just do not see why.

Because git-commit currently performs a status update and throws
that data into the editor buffer.  That takes longer than committing
from the command line.  Especially if I've just done a git-diff or
git-status to see what is changed and about to be committed...

On a project the size of GIT on a Unix system this isn't a big deal;
on a 9000 file project on Cygwin this difference is significant
to me.

It is just the way I am used to working.

> Having said that, I do realize that the current behaviour of
> accepting multiple -m without complaining and discarding all but
> the last one silently is far worse than what is being proposed,
> and I do not see downside to the multiple -m patch, so let's
> apply that.  You can have your "fmt -w60" provided if it is made
> into an option.

I'll rework the fmt -w60 patch to instead accept an optional filter
command from .git/config; if the filter command is set then the
command line commit message will get run through the filter before
being piped into git-commit-tree.

-- 
Shawn.
