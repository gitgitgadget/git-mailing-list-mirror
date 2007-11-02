From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make the pack index version configurable
Date: Fri, 02 Nov 2007 00:01:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711012345220.21255@xanadu.home>
References: <alpine.LFD.0.9999.0711012312480.21255@xanadu.home>
 <ee77f5c20711012042r39c6303em2a8140e8348051d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 05:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Innj6-0002j7-IN
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 05:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbXKBEB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 00:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbXKBEB1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 00:01:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47206 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXKBEB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 00:01:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQV004XD1UDF370@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Nov 2007 00:01:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <ee77f5c20711012042r39c6303em2a8140e8348051d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63060>

On Fri, 2 Nov 2007, David Symonds wrote:

> On 11/2/07, Nicolas Pitre <nico@cam.org> wrote:
> >
> > +pack.indexVersion::
> > +       Specify the default pack index version.  Valid values are 1 for
> > +       legacy pack index used by Git versions prior to 1.5.2, and 2 for
> > +       the new pack index with capabilities for packs larger than 4 GB
> > +       as well as proper protection against the repacking of corrupted
> > +       packs.  Version 2 is selected and this config option ignored
> > +       whenever the corresponding pack is larger than 2 GB.  Otherwise
> > +       the default is 1.
> 
> If you're trying to force a previous pack version for some reason
> (backward compatibility, or whatever), this "feature" of automatic
> forcing version 2 for 2 GB packs might come as a nasty suprise.
> Wouldn't it be better to fail with an error?

No.  The fact is that you don't know in advance what the pack size will 
be, and reaching that limit might take a long while already if 
repacking, or even more so if the pack is fetched over a network 
connection.  That would be wasteful to simply throw away all the whole 
repack/download with an error which would be an even nastier surprise at 
that point just because you specified index v1.

And such a pack would be impossible to work with using an old Git 
version anyway, so the old Git version will happily give you the error, 
suggesting that you upgrade to a later version.

And this has been the implemented behavior for the last 7 months 
already.

And the idea is to switch the default to version 2 eventually.

Etc.


Nicolas
