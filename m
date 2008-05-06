From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 22:12:02 -0400
Message-ID: <20080506021202.GN29038@spearce.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org> <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com> <20080506014636.GM29038@spearce.org> <32541b130805051858u7b8f1cd7qd34fdf50c1f849d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 04:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtCfu-0007Xj-C4
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 04:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbYEFCMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 22:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbYEFCMN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 22:12:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55237 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbYEFCMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 22:12:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JtCen-0007Ky-QD; Mon, 05 May 2008 22:11:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F73720FBAE; Mon,  5 May 2008 22:12:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <32541b130805051858u7b8f1cd7qd34fdf50c1f849d0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81322>

Avery Pennarun <apenwarr@gmail.com> wrote:
> On 5/5/08, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > `git pull -s subtree mylib` ?
> 
> First, I thought: wow!  How can that possibly work?  These guys are geniuses!
> 
> Then I found out that git-merge-subtree is a git builtin, and git.c says this:
> 
>   { "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
>   { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
> 
> And then my head exploded. :)
> 
> Still scraping the pieces of my brain back off the floor... but does
> this mean the subtree merge strategy would fail exactly like
> merge-recursive when new files are created?

Nope.  If you go look at cmd_merge_recursive you will see it has
different behavior based upon the name it was invoked as, even
though it is the same C function and has the same implementation.

If it is started with the name "merge-subtree" it tries to find
a matching subtree prefix to insert in front of all names, or
to remove from all names, such that a merge will correctly fully
include a set of files in a subdirectory, or full pull out a set
of files from a subdirectory.

Junio is the genius that implemented this.  Works quite well for
this library->application merge case that I think you were trying
to describe.

-- 
Shawn.
