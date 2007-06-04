From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-p4import.py robustness changes
Date: Mon, 4 Jun 2007 02:18:59 -0400
Message-ID: <20070604061859.GG4507@spearce.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net> <200706031511.31157.simon@lst.de> <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org> <20070604055433.GD4507@spearce.org> <56b7f5510706032309w4aee791dnd3bf5d46974bdaba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Lamb <slamb@slamb.org>, Simon Hausmann <simon@lst.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 08:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5uR-0002xn-9Y
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 08:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbXFDGTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 02:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbXFDGTK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 02:19:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45201 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbXFDGTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 02:19:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hv5u9-0004B9-CJ; Mon, 04 Jun 2007 02:19:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 38D2E20FBAE; Mon,  4 Jun 2007 02:19:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <56b7f5510706032309w4aee791dnd3bf5d46974bdaba@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49069>

Dana How <danahow@gmail.com> wrote:
> On 6/3/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >I think writing data to fast-import is much easier than running
> >the raw Git commands, especially when you are talking about an
> >import engine where you need to set all of the special environment
> >variables for git-commit-tree or git-tag to do its job properly.
> >Its a good tool that simply doesn't get enough use, partly because
> >nobody is using it...
> 
> Well,  perhaps they use it *once*,  in that they write a wrapper script for
> it and then forget about it.  At least that's what I did.  And the _only_
> annoyance was the trailing NL requirement on the delimited "data" statement,
> so you don't get much noise/complaints when people use it.

True.  I did try to make fast-import take a simple enough format
that you could write throwaway code against it, run it, and never
look back...

The trailing NL after data was because of cvs2svn.  The SVN dump
file format apparently does something like this, and the version
of cvs2svn that Jon Smirl was working on output that trailing NL.
Accepting it in fast-import was easier than fixing cvs2svn to not
create it.

I'll admit the error handling in fast-import could probably
be easier, and that NL after data probably could be optional.
I don't think the input stream parser needs it to understand what
is going on.  Its just sheer laziness on my part that the code
requires it there.

-- 
Shawn.
