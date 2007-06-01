From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Unify write_index_file functions
Date: Fri, 01 Jun 2007 16:54:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706011638250.12885@xanadu.home>
References: <20070601194856.66DFB4D7206@potomac.gnat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@gnat.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuE9h-0007wq-7x
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 22:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765014AbXFAUym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 16:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765010AbXFAUym
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 16:54:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50825 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765004AbXFAUyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 16:54:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIZ0074X632L290@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 Jun 2007 16:54:39 -0400 (EDT)
In-reply-to: <20070601194856.66DFB4D7206@potomac.gnat.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48885>

On Fri, 1 Jun 2007, Geert Bosch wrote:

> This patch creates a new pack-idx.c file containing a unified version of
> the write_index_file functions in builtin-pack-objects.c and index-pack.c.
> As the name "index" is overloaded in git, move in the direction
> of using "idx" and "pack idx" when refering to the pack index.
> There should be no change in functionality.

I intended to do exactly that (I even mentioned it in 81a216a5d6) but 
I'm glad you beat me to it.

A few comments.

Please use   pack-write.c rather than a new file.  This   pack-write.c 
was created exactly to gather common pack writing tasks.

Please also consider removing the pack index writing code from 
fast-import.c as well.

> @@ -24,9 +24,10 @@ git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
>  
>  struct object_entry {
>  	unsigned char sha1[20];
> -	uint32_t crc32;		/* crc of raw pack data for this object */
>  	off_t offset;		/* offset into the final pack file */
>  	unsigned long size;	/* uncompressed size */
> +	uint32_t crc32;		/* crc of raw pack data for this object */

Don't do this.  The crc32 field was carefully placed so the offset field 
is 64-bit aligned with no need for any padding.

In fact, those 3 fields should probably be defined in a structure of 
their own rather than hoping that no one will fail to change the 
ordering in all places.

Other than that it looks pretty good.


Nicolas


Nicolas
