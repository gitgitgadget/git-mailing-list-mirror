From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 08 Apr 2009 00:52:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
References: <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com>
 <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
 <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_GdY0ZCnB9Gfp83PrJniGBg)"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 06:54:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrPoH-0000bQ-WE
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 06:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbZDHExE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 00:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbZDHExB
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 00:53:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49705 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZDHExA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 00:53:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHR004XMMW6E0N0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 08 Apr 2009 00:52:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090407202725.GC4413@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116032>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_GdY0ZCnB9Gfp83PrJniGBg)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 7 Apr 2009, Björn Steinbrink wrote:

> On 2009.04.07 14:56:41 -0400, Nicolas Pitre wrote:
> > On Tue, 7 Apr 2009, Björn Steinbrink wrote:
> > 
> > > On 2009.04.07 13:48:02 -0400, Nicolas Pitre wrote:
> > > > The first low hanging fruit to help this case is to make upload-pack use 
> > > > the --revs argument with pack-object to let it do the object enumeration 
> > > > itself directly, instead of relying on the rev-list output through a 
> > > > pipe.  This is what 'git repack' does already.  pack-objects has to 
> > > > access the pack anyway, so this would eliminate an extra access from a 
> > > > different process.
> > > 
> > > Hm, for an initial clone that would end up as:
> > > git pack-objects --stdout --all
> > > right?
> > > 
> > > If so, that doesn't look it it's going to work out as easily as one
> > > would hope. Robin said that both processes, git-upload-pack (which does
> > > the rev-list) and pack-objects peaked at ~2GB of RSS (which probably
> > > includes the mmapped packs). But the above pack-objects with --all peaks
> > > at 3.1G here, so it basically seems to keep all the stuff in memory that
> > > the individual processes had. But this way, it's all at once, not 2G
> > > first and then 2G in a second process, after the first one exitted.
> > 
> > Right, and it is probably faster too.
> > 
> > Can I get a copy of that repository somewhere?
> 
> http://git.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary
> 
> At least that's what I cloned ;-) I hope it's the right one, but it fits
> the description...

OK.  FWIW, I repacked it with --window=250 --depth=250 and obtained a 
725MB pack file.  So that's about half the originally reported size.


Nicolas

--Boundary_(ID_GdY0ZCnB9Gfp83PrJniGBg)--
