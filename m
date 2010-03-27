From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Sat, 27 Mar 2010 14:59:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003271035360.694@xanadu.home>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Isz54uRnTNeqYcWrSESJfg)"
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:00:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvbEl-0007Zj-8N
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 19:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab0C0S7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 14:59:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15658 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab0C0S7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 14:59:42 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZY007NRFFH5OD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Mar 2010 14:59:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1003271035290.694@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143342>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Isz54uRnTNeqYcWrSESJfg)
Content-id: <alpine.LFD.2.00.1003271035291.694@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Sat, 27 Mar 2010, Fredrik Kuivinen wrote:

> On Wed, Mar 24, 2010 at 21:22, Nicolas Pitre <nico@fluxnic.net> wrote:
> > +static void try_to_free_from_threads(size_t size)
> > +{
> > +       read_lock();
> > +       release_pack_memory(size, -1);
> > +       read_unlock();
> > +}
> > +
> 
> Will this really work in all cases? In the find_deltas -> try_delta ->
> read_sha1_file -> ... -> xmalloc call path, the mutex is already
> locked when we get to xmalloc.

You're right.  Damn.


Nicolas

--Boundary_(ID_Isz54uRnTNeqYcWrSESJfg)--
