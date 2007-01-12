From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Thu, 11 Jan 2007 19:55:46 -0500
Message-ID: <20070112005546.GD23864@spearce.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com> <Pine.LNX.4.63.0701091735490.7747@qynat.qvtvafvgr.pbz> <20070110023031.GC30765@spearce.org> <Pine.LNX.4.63.0701101027480.10339@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ai1-0002MC-Eu
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXALAzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbXALAzv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:55:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42618 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXALAzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:55:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5Ahr-0007tG-D8; Thu, 11 Jan 2007 19:55:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE76520FBAE; Thu, 11 Jan 2007 19:55:46 -0500 (EST)
To: David Lang <david.lang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701101027480.10339@qynat.qvtvafvgr.pbz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36647>

David Lang <david.lang@digitalinsight.com> wrote:
> On Tue, 9 Jan 2007, Shawn O. Pearce wrote:
> >If the stat data is current it will leave it as-is.  You can force
> >the index to refresh with `git update-index --refresh` or by running
> >git status.
> 
> I was looking at checkout, not checkin so I'm not understanding how the 
> index is involved here.

During checkout we use the index to help us decide if a file needs
to be updated with new content or can be left as-is.  Its a cache of
what version each file is at, and its based on the file stat data
(dev, inode, modification date, etc.) to tell us if the file has
been modified or was last created by Git.  If Git was the one that
last modified the file and the version stored in the index matches
the version needed during the checkout, the file is left alone.
But if anything differs then the file gets overwritten.
 
> >>does this answer change if there is a trigger on checkout (to change
> >>permissions or otherwise manipulate the file)?
> >
> >Only if the trigger does something in addition, like force overwrite
> >files.  But we don't have a checkout trigger.  So there's no trigger.
> 
> we don't have a checkout trigger?

No.

> I thought that what Linus had suggested 
> for permissions was to have a script triggered on checkin that stored the 
> permissions of the files, and a script triggered on checkout that set the 
> permissions from the stored file.

Yes.  It is what he suggested.

> if there isn't a checkout trigger how would the permissions ever get set?

Someone needs to implement support for a post-checkout trigger.  _Then_
a checkout trigger could perform this action.

> in my particular case I'd like to have the checkin run a script that 
> produces a 'generic' version of each file,

You may be able to do that in the pre-commit hook by updating the index

-- 
Shawn.
