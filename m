From: Andreas Gal <gal@uci.edu>
Subject: Re: [PATH] fix segfault in fsck-cache
Date: Sat, 23 Apr 2005 22:24:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232223570.8755@sam.ics.uci.edu>
References: <1114280570.5068.5.camel@mulgrave>  <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
  <1114292680.4799.4.camel@mulgrave>  <20050423230238.GD13222@pasky.ji.cz> 
 <1114298490.5264.10.camel@mulgrave>  <Pine.LNX.4.58.0504231759010.2344@ppc970.osdl.org>
 <1114317771.4980.7.camel@mulgrave> <Pine.LNX.4.58.0504232153500.15879@ppc970.osdl.org>
 <Pine.LNX.4.58.0504232202380.7195@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 07:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZXF-0000ae-LB
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVDXFYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVDXFYr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:24:47 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:49559 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262266AbVDXFYb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:24:31 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3O5OTYM008760;
	Sat, 23 Apr 2005 22:24:29 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3O5OTWM008756;
	Sat, 23 Apr 2005 22:24:29 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504232202380.7195@sam.ics.uci.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This isn't working right either, depending on your ZLIB version. Do not 
apply. 

Andreas

On Sat, 23 Apr 2005, Andreas Gal wrote:

> 
> I somehow got some corrupted object files in my repository that zlib 
> refuses to decompress. This patch makes sure we abort early before the 
> memcpy a few lines downtream segfaults (due to total_out == 0).
> 
> Andreas
> 
> Signed-off-by: Andreas Gal <gal@uci.edu>
> 
> --- 66308ede85c2dad6b184fb74a7215b06a173d8f7/sha1_file.c
> +++ sha1_file.c
> @@ -155,6 +155,8 @@
>  
>  	inflateInit(&stream);
>  	ret = inflate(&stream, 0);
> +	if (ret != Z_OK)
> +		return NULL;
>  	if (sscanf(buffer, "%10s %lu", type, size) != 2)
>  		return NULL;
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
