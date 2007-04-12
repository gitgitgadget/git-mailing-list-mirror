From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: sha1 of the repo excluding history ?
Date: Thu, 12 Apr 2007 19:40:32 -0400
Message-ID: <20070412234032.GE12979@spearce.org>
References: <f36b08ee0704121626i6a27dcecp8b0b10e0f7db2ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc8u9-00068s-JG
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 01:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030795AbXDLXki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 19:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030799AbXDLXki
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 19:40:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59406 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030795AbXDLXkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 19:40:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hc8ts-0005eO-OC; Thu, 12 Apr 2007 19:40:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8281820FBAE; Thu, 12 Apr 2007 19:40:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f36b08ee0704121626i6a27dcecp8b0b10e0f7db2ef7@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44368>

Yakov Lerner <iler.ml@gmail.com> wrote:
>    Can I obtain from git the sha1 of the total last state of the
> repo excluding history ? This is a state that covers contents and
> names of all files and dirs, and x perm of files;
> but excludes history, timestamps, ownerhisp, and inode numbers.
> 
> That would be approximately like the slow method:
>          'find | egrep -v '/\.git(/|$)' | sort | Xcpio -o | sha1sum -'
> (imagining Xcpio that does not archive any ownership, timestamps,
> and inode numbers). Can I obtain this result immediately from git ?

	git rev-parse HEAD^{tree}

The trick here is ^{tree}; this operator takes a commit-ish (commit
or tag) and returns the SHA-1 of the tree that the commit-ish
points at.  That SHA-1 is the SHA-1 of the file contents, names,
and executable bits, but nothing else.  No history.

I use it sometimes after a rebase when I reorganize history:

	old=`git rev-parse HEAD^{tree}`
	.... do rebasing magick ...
	test $old = `git rev-parse HEAD^{tree}` && echo GOOD

If I don't get back GOOD then I know I somehow changed the files in
a way that isn't what I had before, and that wasn't what I wanted
if all I was doing was cleaning up commit messages.

-- 
Shawn.
