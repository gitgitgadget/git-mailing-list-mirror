From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes
 'limit' arg
Date: Sun, 08 Apr 2007 20:40:05 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704082034060.28181@xanadu.home>
References: <46197994.70009@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 09 02:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hahvv-0006ol-Vm
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 02:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbXDIAkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 20:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXDIAkH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 20:40:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10771 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbXDIAkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 20:40:06 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG70025EGITXMD3@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Apr 2007 20:40:05 -0400 (EDT)
In-reply-to: <46197994.70009@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44024>

On Sun, 8 Apr 2007, Dana How wrote:

> 
> Accept new 'limit' argument and check against it
> before each group of writes.  Update delta usability rules
> for possibility of delta base being in a previously-
> written pack. Inline sha1write_compressed() so we know
> the exact size of the written data when it needs to be compressed.

It would be cleaner if the compression code was made into a function of 
its own I think.

> @@ -448,6 +480,12 @@ static off_t write_object(struct sha1file *f,
>  			header[pos] = ofs & 127;
>  			while (ofs >>= 7)
>  				header[--pos] = 128 | (--ofs & 127);
> +			if ( limit && hdrlen + sizeof(header) - pos + datalen + 20 >= limit ) {
> +				free(out);
> +				free(buf);
> +				return 0;
> +			}
> +			sha1write(f, header, hdrlen);
>  			sha1write(f, header + pos, sizeof(header) - pos);

The above looks rather buggy to me.


Nicolas
