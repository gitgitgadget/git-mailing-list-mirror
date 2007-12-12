From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Wed, 12 Dec 2007 02:38:28 +0100
Message-ID: <20071212013828.GC19857@steel.home>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home> <alpine.LFD.0.99999.0712111703380.555@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 02:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2GZG-0003GS-Gg
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 02:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXLLBic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 20:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbXLLBic
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 20:38:32 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:34159 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbXLLBib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 20:38:31 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a7Bs=
Received: from tigra.home (Fc89d.f.strato-dslnet.de [195.4.200.157])
	by post.webmailer.de (mrclete mo9) (RZmta 14.6)
	with ESMTP id m06a7ajBBLsk6K ; Wed, 12 Dec 2007 02:38:29 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5F9C3277AE;
	Wed, 12 Dec 2007 02:38:29 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 12B4756D22; Wed, 12 Dec 2007 02:38:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712111703380.555@xanadu.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67981>

Nicolas Pitre, Tue, Dec 11, 2007 23:06:42 +0100:
> 
> Well, ignore the above.  It seems that most of stdio doesn't set errno 
> so the above is crap.
> 

Well, it had no reason to in this case. It's not an error.
It does not even have to do a syscall.

> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 2136aad..c32a124 100755
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -103,7 +103,7 @@ static void handle_object(const unsigned char *sha1)
>  	mark_object(object);
>  
>  	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
> -	if (fwrite(buf, size, 1, stdout) != 1)
> +	if (fwrite(buf, 1, size, stdout) != size)

That's a probable syscall which could be spared
