From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 08 May 2005 13:48:54 +0400
Organization: Telecom Service, JSC
Message-ID: <427DE086.40307@tls.msk.ru>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 11:42:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUiIo-0007KJ-Gg
	for gcvg-git@gmane.org; Sun, 08 May 2005 11:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVEHJtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 05:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVEHJtG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 05:49:06 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:55388 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262834AbVEHJs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 05:48:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by hobbit.corpit.ru (Postfix) with ESMTP id C9D2D295EA;
	Sun,  8 May 2005 13:48:56 +0400 (MSD)
	(envelope-from mjt@tls.msk.ru)
Received: from [192.168.1.200] (mjt.ppp.tls.msk.ru [192.168.1.200])
	by hobbit.corpit.ru (Postfix) with ESMTP;
	Sun,  8 May 2005 13:48:55 +0400 (MSD)
	(envelope-from mjt@tls.msk.ru)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Glanzmann wrote:
> [PATCH] Really *do* nothing in while loop
> 
> Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> 
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -335,7 +335,7 @@
>  	stream.next_in = hdr;
>  	stream.avail_in = hdrlen;
>  	while (deflate(&stream, 0) == Z_OK)
> -		/* nothing */
> +		/* nothing */;
>  
>  	/* Then the data itself.. */
>  	stream.next_in = buf;

Well, the lack of semicolon is wrong really (and funny).

But is the whole while loop needed at all?  deflate()
consumes as much input as it can, producing as much output
as it can.  So without the loop, and without updating the
buffer pointers ({next,avail}_{in,out}) it will do just
fine without the loop, and will return something != Z_OK
on next iteration.  If this is to mean to flush output,
it should be deflate(&stream, Z_FLUSH) or something.

/mjt

P.S.  What's git@vger.kernel.org for ?
