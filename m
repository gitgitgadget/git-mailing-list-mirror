From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 00:09:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904060006410.6741@xanadu.home>
References: <20090404220743.GA869@curie-int>
 <20090405195714.GA4716@coredump.intra.peff.net>
 <20090405T230552Z@curie.orbis-terrarum.net>
 <fcaeb9bf0904052010p34e3246bwd7e1f5297acf37e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_BtwwBzFM0wdJ5m5p5Wx6ow)"
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:11:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqgAl-0000i7-FO
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 06:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbZDFEJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 00:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbZDFEJZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 00:09:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29755 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbZDFEJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 00:09:24 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHN0048UVJHQ3G0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 00:09:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <fcaeb9bf0904052010p34e3246bwd7e1f5297acf37e2@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115761>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_BtwwBzFM0wdJ5m5p5Wx6ow)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Mon, 6 Apr 2009, Nguyen Thai Ngoc Duy wrote:

> On Mon, Apr 6, 2009 at 9:38 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > Looking at the source, I agree that it should be buffering, however top and ps
> > seem to disagree. 3GiB VSZ and 2.5GiB RSS here now.
> >
> > %CPU %MEM     VSZ     RSS STAT START   TIME COMMAND
> >  0.0  0.0  140932    1040 Ss   16:09   0:00 \_ git-upload-pack /code/gentoo/gentoo-git/gentoo-x86.git
> > 32.2  0.0       0       0 Z    16:09   1:50     \_ [git-upload-pack] <defunct>
> > 80.8 44.2 3018484 2545700 Sl   16:09   4:36     \_ git pack-objects --stdout --progress --delta-base-offset
> >
> > Also, I did another trace, using some other hardware, in a LAN setting, and
> > noticed that git-upload-pack/pack-objects only seems to start output to the
> > network after it reaches 100% in 'remote: Compressing objects:'.
> >
> > Relatedly, throwing more RAM (6GiB total, vs. the previous 2GiB) at the server
> > in this case cut the 200 wallclock minutes before any sending too place down to
> > 5 minutes.
> 
> Searching back the archive, there was memory fragmentation issue with
> gcc repo. I wonder if it happens again. Maybe you should try Google
> allocator. BTW, did you try to turn off THREADED_DELTA_SEARCH?

That was for a _full_ repack, i.e. 'git repack -a -f'.  This is never 
the case on a fetch/clone, like in this case, unless you have all your 
objects in loose form.


Nicolas

--Boundary_(ID_BtwwBzFM0wdJ5m5p5Wx6ow)--
