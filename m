From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] improved delta support for git
Date: Thu, 12 May 2005 11:18:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505121110490.5426@localhost.localdomain>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
 <7voebhkql5.fsf@assigned-by-dhcp.cox.net> <200505121027.01964.mason@suse.com>
 <2cfc403205051207467755cdf@mail.gmail.com>
 <2cfc403205051207471f6957e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 17:13:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWFMF-0004el-7X
	for gcvg-git@gmane.org; Thu, 12 May 2005 17:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVELPTW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVELPTL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 11:19:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65405 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262016AbVELPSm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 11:18:42 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGD00C19UIHSJ@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 May 2005 11:18:18 -0400 (EDT)
In-reply-to: <2cfc403205051207471f6957e0@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: jon@blackcubes.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 13 May 2005, Jon Seymour wrote:

> On 5/13/05, Chris Mason <mason@suse.com> wrote:
> > On Thursday 12 May 2005 00:36, Junio C Hamano wrote:
> > > It appears to me that changes to the make_sure_we_have_it() ...
> >
> > If we fetch the named object and it is a delta, the delta will either depend
> > on an object we already have or an object that we don't have.  If we don't
> > have it, the pull should find it while pulling other commits we don't have.
> >
> 
> Chris,
> 
> Doesn't that assume that the object referenced by the delta is
> reachable from the commit being pulled. While that may be true in
> practice, I don't think it is a logical certainty.

1) If you happen to already have the referenced object in your local 
   repository then you're done.

2) If not you pull the referenced object from the remote repository, 
   repeat with #1 if it happens to be another delta object.

3) If the remote repository doesn't contain the object referenced by any 
   pulled delta object then that repository is inconsistent just like if 
   a blob object referenced by a tree object was missing.  This 
   therefore should not happen.  git-fsck-cache will flag broken delta 
   links soon.


Nicolas
