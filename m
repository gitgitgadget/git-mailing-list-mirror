From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Wed, 5 Apr 2006 16:14:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604051612200.25304@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com> 
 <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0604030730040.3781@g5.osdl.org>  <Pine.LNX.4.64.0604030734440.3781@g5.osdl.org>
 <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 16:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR8mn-0004q5-Lh
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 16:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDEOOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 10:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDEOOX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 10:14:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6359 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750812AbWDEOOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 10:14:22 -0400
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id AC0F722B6;
	Wed,  5 Apr 2006 16:14:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9E76BC81;
	Wed,  5 Apr 2006 16:14:20 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7B7D822B6;
	Wed,  5 Apr 2006 16:14:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>
In-Reply-To: <fa0b6e200604050624h13ebd8deg241ae98cef1f5a74@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18433>

Hi,

On Wed, 5 Apr 2006, Kees-Jan Dijkzeul wrote:

> On 4/3/06, Linus Torvalds <torvalds@osdl.org> wrote:
> [...]
> > That's not hugely fundamental, but I didn't expect people to hit it this
> > quickly. What kind of project has a 1.5GB pack-file _already_? I hope it's
> > fifteen years of history (so that we'll have another fifteen years before
> > we'll have to worry about 4GB pack-files ;)
> 
> I'm trying to get Git to manage my companies source tree. We're
> writing software for digital TV sets. Anyway, the archive is about 5Gb
> in size and contains binaries, zip files, excel sheets meeting minutes
> and whatnot. So it doesn't compress very well. The 1.5Gb pack file
> hardly contains any history at all (five commits or so). On the flip
> side, for now I'll be the only one adding to the archive, so at least
> it will not grow that fast ;-)
> 
> Anyway, to reconstitute the tree, I need very nearly the entire pack,
> so limiting the pack size won't do much good, as git will still try to
> allocate a total of 1.5Gb memory (which, unfortunately, isn't there
> :-)
> 
> Inspired by a patch of Alex Riesen (thanks, Alex), I tried to use the
> regular mmap for mapping pack files, only to discover that I compile
> without defining "NO_MMAP", so I've been using the stock mmap all
> along. So now I'm thinking that the cygwin mmap also does a
> malloc-and-read, just like git does with NO_MMAP. So I'll continue to
> investigate in that direction.

I think cygwin's mmap() is based on the Win32 API equivalent, which could 
mean that it *is* memory mapped, but in a special area (which is smaller 
than 1.5 gigabyte). In this case, it would make sense to limit the pack 
size, thereby having several packs, and mmap() them as they are needed.

Hth,
Dscho
