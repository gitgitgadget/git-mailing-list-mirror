From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH WIP 0/4] Special code path for large blobs
Date: Thu, 28 May 2009 14:03:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905281349320.3906@xanadu.home>
References: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_sd40/m8AgXmTe/yVHQlwbw)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9jxT-0006tp-Up
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 20:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbZE1SDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbZE1SDy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 14:03:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64696 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbZE1SDx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 14:03:53 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKD00HLE8UELR20@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 May 2009 14:03:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1243488550-15357-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120204>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_sd40/m8AgXmTe/yVHQlwbw)
Content-type: TEXT/PLAIN; charset=VISCII
Content-transfer-encoding: 8BIT

On Thu, 28 May 2009, Nguy­n Thái Ng÷c Duy wrote:

> Thread "Problem with large files on different OSes" reminds me this.
> This series is in my repository for quite some time. It addresses
> adding/checking out large blobs as long as:
> 
>  - no conversion will be done
>  - blobs are loose (in checkout case)
> 
> Together with a patch that prevents large blobs from being packed
> (something like Dana How sent long ago), and a modification of "lazy
> clone/remote alternatives" patch to avoid packing large blobs again
> for sending over network, I think it should make git possible for
> large files.
> 
> Just something to play.

I think this is a good start.

However, like I said previously, I'd encapsulate large blobs in a pack 
right away instead of storing them as loose objects.  The reason is that 
you can effortlessly repack/fetch/push them afterwards by simply 
triggering the pack data reuse code path for them.  Extracting large and 
undeltified blobs from a pack is just as easy as from a loose object.

To accomplish that, you only need to copy write_pack_file() from 
builtin-pack-objects.c and strip it to the bone with only one object to 
write.


Nicolas

--Boundary_(ID_sd40/m8AgXmTe/yVHQlwbw)--
