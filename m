From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 17:26:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101301716400.8580@xanadu.home>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com>
 <7vk4hmbyuo.fsf@alter.siamese.dyndns.org>
 <AANLkTi=mbeBsR5tr4J7kQCL6YqiGfttK01VUN016aapC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_3o99RNtp8QVGOEogz3FWtQ)"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 23:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjfjR-00045I-5h
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 23:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab1A3W0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 17:26:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46351 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab1A3W0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 17:26:44 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFU00ESGWZX1C70@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 30 Jan 2011 17:26:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTi=mbeBsR5tr4J7kQCL6YqiGfttK01VUN016aapC@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165707>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_3o99RNtp8QVGOEogz3FWtQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Sun, 30 Jan 2011, Shawn Pearce wrote:

> On Sun, Jan 30, 2011 at 00:05, Junio C Hamano <gitster@pobox.com> wrote:
> > Shawn Pearce <spearce@spearce.org> writes:
> >
> >> Using this for object enumeration shaves almost 1 minute off server
> >> packing time; the clone dropped from 3m28s to 2m29s.  That is close to
> >> what I was getting with the cached pack idea, but the network transfer
> >> stayed the small 376 MiB.
> >
> > I like this result.
> 
> I'm really leaning towards putting this cached object list into JGit.
> 
> I need to shave that 1 minute off server CPU time. I can afford the 41
> MiB disk (and kernel buffer cache), but I cannot really continue to
> pay the 1 minute of CPU on each clone request for large repositories.
> The object list of what is reachable from commit X isn't ever going to
> change, and the path hash function is reasonably stable.  With a
> version code in the file we can desupport old files if the path hash
> function changes.  10% more disk/kernel memory is cheap for some of my
> servers compared to 1 minute of CPU, and some explicit cache
> management by the server administrator to construct the file.

Yep, I think this is probably the best short term solution.  Just walk 
the commit graph as usual, and whenever the commit tip from the cache is 
matched then just shove the entire cache content in the object list.

And let's hope that eventually some future developments will make this 
cache redundant and obsolete.


Nicolas

--Boundary_(ID_3o99RNtp8QVGOEogz3FWtQ)--
