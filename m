From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/10] pack v4 UI support
Date: Thu, 26 Sep 2013 00:51:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309260031290.312@syhkavp.arg>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_l7kOfZxj4sQjzsCoKmnXqw)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 06:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP3YM-0007n2-Es
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 06:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab3IZEvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 00:51:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18417 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab3IZEvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 00:51:35 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTP0000QUTZ3U90@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 26 Sep 2013 00:51:35 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id CB3732DA045F; Thu, 26 Sep 2013 00:51:34 -0400 (EDT)
In-reply-to: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235399>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_l7kOfZxj4sQjzsCoKmnXqw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Thu, 26 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> About the "packv4" capability in git protocol. I considered a more
> generic cap "packver=ver[,ver[,ver...]]" that represents all supported
> versions, with the order of preference from the first ver (most preferred)
> to the last (least preferred). But it adds more parsing code
> and frankly I don't think we'll have pack v5 in the next five years.
> So I dropped it.

Agreed.  In fact the receiver should only indicate the highest pack 
version it is ready to accept.  We'll have to support the sending and 
receiving of any previous pack versions forever anyway.

> Multi-base tree support is not part of "packv4" capability. Let's see
> if such support comes before the series is merged to master. If so we
> can drop that line from protocol-capabilities.txt. Otherwise a new
> capability can be added for multi-base trees.

What is that for?  Multi-base trees are not created yet, but the code to 
parse them is already there.  So I don't see the point of having a 
capability in the protocol for this.

> Another capability could be added for sending the actual number of
> objects in a thin pack for more accurate display in index-pack. Low
> priority in my opinion.

That just cannot be communicated during capability exchange.  This 
number is known only after object enumeration.  Hence my suggestion of a 
['T', 'H', 'I', 'N', htonl(<number_of_sent_objects>)] special header 
prepended to the actual pack on the wire.  And that has to be decided 
before formalizing the pack v4 capability.  That makes it a somewhat 
higher priority.

> There's also the pack conversion issue. Suppose the client requests v4
> but, for performance purposes, the server sends v2. Should index-pack
> convert the received pack to v4? My answer is no because there's no
> way we can do it without saving v2 first. And if we have to save v2
> anyway, pack-objects (or repack) will do the conversion better. We can
> adjust git-gc to maybe repack more often when the number of v2 packs
> is over a limit, or just repack v2 packs into one v4 pack.

Yeah... those are questions that certainly can wait.  Only 
experimentation will tell what is best, and that won't be conclusive 
until the core git code learns to parse pack v4 data natively.

I'll try to review your patches soon.


Nicolas

--Boundary_(ID_l7kOfZxj4sQjzsCoKmnXqw)--
