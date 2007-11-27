From: Nicolas Pitre <nico@cam.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 23:58:55 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711262346410.9605@xanadu.home>
References: <200711252248.27904.jnareb@gmail.com>
 <20071127014804.GJ14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 06:00:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwsXy-0007wM-K5
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 05:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbXK0E70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 23:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757139AbXK0E7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 23:59:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20763 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683AbXK0E7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 23:59:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS500KV3F678QD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Nov 2007 23:58:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071127014804.GJ14735@spearce.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66165>

On Mon, 26 Nov 2007, Shawn O. Pearce wrote:

> - Loose objects storage is difficult to work with
> 
>   The standard loose object format of DEFLATE("$type $size\0$data")
>   makes it harder to work with as you need to inflate at least
>   part of the object just to see what the hell it is or how big
>   its final output buffer needs to be.

It is a bit cumbersome indeed, but I'm afraid we're really stuck with it 
since every object SHA1 depends on that format.

>   It also makes it very hard to stream into a packfile if you have
>   determined its not worth creating a delta for the object (or no
>   suitable delta base is available).
> 
>   The new (now deprecated) loose object format that was based on
>   the packfile header format simplified this and made it much
>   easier to work with.

Not really.  Since separate zlib compression levels for loose objects 
and packed objects were introduced, there was a bunch of correctness 
issues.  What do you do when both compression levels are different? 
Sometimes ignore them, sometimes not? Because the default loose object 
compression level is about speed and the default pack compression level 
is about good space reduction, the correct thing to do by default would 
have been to always decompress and recompress anyway when copying an 
otherwise unmodified loose object into a pack.


Nicolas
