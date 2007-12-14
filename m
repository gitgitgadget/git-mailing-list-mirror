From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui blame utf-8 bugs
Date: Fri, 14 Dec 2007 01:47:09 -0500
Message-ID: <20071214064709.GH14735@spearce.org>
References: <20071212091744.GA5377@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J34Kf-0006pz-0F
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbXLNGrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 01:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbXLNGrO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:47:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38385 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbXLNGrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:47:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J34KE-0005RB-93; Fri, 14 Dec 2007 01:47:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DBF720FBAE; Fri, 14 Dec 2007 01:47:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071212091744.GA5377@pvv.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68250>

Finn Arne Gangstad <finnag@pvv.org> wrote:
> git gui has some utf-8 bugs:

It has several.  :-)
 
> If you do git gui blame <file>, and the file contains utf-8 text,
> the lines are not parsed as utf-8, but seemingly as iso-8859-1 instead.

Right.  git-gui is keying off the environment setting for LANG, so I
guess its set to iso-8859-1 on your system but you are working with a
utf-8 file.  We've talked about using something like .gitattributes
to store encoding hints, or to just put a global gui setting in
~/.gitconfig but neither has had any patches written for it.

UTF-8 is seemingly the most common encoding that git-gui is mangling
so maybe we should be defaulting to utf-8 until someone codes a
more intelligent patch.

> Also, the hovering comment is INITIALLY shown garbled (both Author and
> commit message), but if you click on a line, so that the commit
> message is shown in the bottom window, the hovering message is
> magically corrected to utf-8.
> 
> The text in the lower window (showing specific commits) seems to
> always be handled correctly.

That's a "feature".  :-)

What's happening here is the initial hovering message is obtained
from the machine formatted output from `git blame --incremental`
and in that format there is no encoding header so I'm just ignoring
any encoding problems.

Later when you click on a line it does `git cat-file commit $sha1`
and gets the proper encoding, and corrects the strings it originally
had gotten from git-blame.  So the hovering message "fixes" itself
later on.

Maybe here too we should be defaulting to utf-8 instead of the
native encoding.

-- 
Shawn.
