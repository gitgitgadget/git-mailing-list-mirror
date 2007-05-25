From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 15:59:53 +0200
Message-ID: <200705251559.53846.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> <200705251427.46903.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251343550.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HraKt-0006da-He
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718AbXEYOAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758663AbXEYOAB
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:00:01 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:37345 "EHLO
	tuminfo2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757718AbXEYOAA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 10:00:00 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id 2C7B328DC;
	Fri, 25 May 2007 15:59:59 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705251343550.4648@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48377>

On Friday 25 May 2007, Johannes Schindelin wrote:
> > I assume you talk about a versioned .gitmodules file tied to the
> > superproject history, and any fetch/pull would look into this
> > file from the current working directory to lookup the default URL.
> > 
> > Wouldn't this have the problem that when you check out an old
> > revision of the superproject you get out-of-date URLs, so that
> > a fetch does not work (without local overrides)?
> 
> If you check out an old revision, wouldn't you have that _already_, so it 
> does not matter what URL is given in .gitmodules?

Not necessary.
* Submodules can appear/disappear any time in the superproject.
Therefore, going back in time can make it necessary to have to clone
a submodule you did not have before.
* Not every submodule is interesting for every developer; therefore,
an important design-decision for submodules is to allow at git-clone time
to not clone some submodules at all. However, you can change your mind and
want to follow a given submodule later.

Above points make it necessary for the submodule feature to implement
lazy clones. You want be able to clone a submodule without error independent
of the superproject HEAD. IMHO it would be really bad porcelain design
to break out with an error each time and expect the USER to manually
override submodule URLs.

Another difference between in-tree .gitmodules and out-of-tree submodule
config is that for in-tree you any want to see configuration for submodules
which happen to be part of the superproject at this point in history.
For out-of-tree config, there has to be information for every submodule which
was referenced in the whole history of the superproject.

Josef
