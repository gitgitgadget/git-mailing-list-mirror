From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Use nonrelative paths instead of absolute paths for
 cloned repositories
Date: Thu, 5 Jun 2008 23:47:13 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806052327160.19665@iabervon.org>
References: <alpine.LNX.1.00.0806052244300.19665@iabervon.org> <alpine.DEB.1.00.0806060422310.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 05:48:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Svw-0001ww-2N
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 05:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbYFFDrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 23:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbYFFDrP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 23:47:15 -0400
Received: from iabervon.org ([66.92.72.58]:46643 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbYFFDrO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 23:47:14 -0400
Received: (qmail 27299 invoked by uid 1000); 6 Jun 2008 03:47:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2008 03:47:13 -0000
In-Reply-To: <alpine.DEB.1.00.0806060422310.21190@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84016>

On Fri, 6 Jun 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 5 Jun 2008, Daniel Barkalow wrote:
> 
> > Particularly for the "alternates" file, if one will be created, we want 
> > a path that doesn't depend on the current directory, but we want to 
> > retain any symlinks in the path as given and any in the user's view of 
> > the current directory when the path was given.
> 
> I have to say that I do not follow why the symlinks should be trusted any 
> more than the absolute paths.

It's not so much a case of trusting symlinks more, but trusting the 
version of the path that the user used more.

This came up because kernel.org has HTTP service arranged such that 
/pub/... is served at http://kernel.org/pub/..., but /pub is a symlink to 
/home/ftp/pub/, and http://kernel.org/home/ftp/pub/... doesn't work. 
Clever people like Greg use "git clone -s /pub/.../linux-2.6.git" in order 
to share Linus's object storage, and this generated an HTTP-clonable repo 
with git-clone.sh, because it didn't expand symlinks, but the builtin 
version, without this patch, would expand them into the thing that doesn't 
work.

If there's a difference between using the symlink and using the thing it 
links to, probably the user picked the right thing, or wouldn't be too 
surprised that git doesn't come up with something better.

	-Daniel
*This .sig left intentionally blank*
