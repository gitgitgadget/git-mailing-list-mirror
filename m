From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-unbundle - unbundle objects and references for
 disconnected transfer.
Date: Wed, 14 Feb 2007 16:18:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702141615570.1757@xanadu.home>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <11714622293142-git-send-email-mdl123@verizon.net>
 <20070214194537.GD28290@spearce.org> <45D377A8.1080404@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRWc-0008Kw-Lh
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbXBNVSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbXBNVSs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:18:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18385 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623AbXBNVSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:18:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDH00B9C1VAPR10@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Feb 2007 16:18:47 -0500 (EST)
In-reply-to: <45D377A8.1080404@verizon.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39751>

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> Shawn O. Pearce wrote:
> > Mark Levedahl <mdl123@verizon.net> wrote:
> >   
> > > +# get the objects
> > > +unzip -p "$bfile" .gitBundlePack | git-unpack-objects
> > >     
> >
> > Since you are transporting a packfile by sneakernet it might
> > be reasonable to assume this transfer happens infrequently.
> > Consequently we might assume its object count exceeds
> > transfer.unpackLimit, which means a standard fetch or push would
> > have kept the packfile rather than unpacking it to loose objects.
> >
> > So maybe use git-index-pack here to index the packfile and
> > retain it as-is, rather than unpacking it?
> >
> >   
> Many of my uses of this result in 10-20 objects being transferred, so I'm not
> sure keeping each pack is a real benefit. In particular, one use is for daily
> updates between two sites via email where we tend to have a lot of extra
> objects in the packs as we assume that not every bundle actually gets applied,
> while the number of real new objects tends to be small. On the other hand,
> given the manual nature of this operation, we could always just follow up with
> repack -a -d, possibly guarded by a git count. Thoughts?

Since this is meant for manual operation and therefore is not meant to 
happen multiple times per minute, I'd suggest you still use index-pack 
unconditionally instead of unpack-objects despite having a small number 
of objects.


Nicolas
