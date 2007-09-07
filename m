From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PATCH to add a button to perform a meld on the current file
Date: Fri, 7 Sep 2007 12:25:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071214330.28586@racer.site>
References: <46E0D79E.3080606@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbxv-0006DU-P7
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbXIGLZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 07:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbXIGLZa
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:25:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:32988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965160AbXIGLZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 07:25:29 -0400
Received: (qmail invoked by alias); 07 Sep 2007 11:25:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 07 Sep 2007 13:25:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Si/NzcmBSm+LdnQI3ui9r7kO3fliixr7I6nvh2O
	dQ2vcLGodFZLcW
X-X-Sender: gene099@racer.site
In-Reply-To: <46E0D79E.3080606@adelaide.edu.au>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58026>

Hi,

On Fri, 7 Sep 2007, Pierre Marc Dumuid wrote:

> Here's a dodgy [not that good] patch to perform a GUI comparison on a 
> file. It is dodgy because it assumes cogito is installed, and you want 
> to use meld, and it doesn't remove the temporary files.

cogito is phased out.

> Not expecting this to go into main branch, but I find it handy for my 
> own purposes nether-the-less.

Just in case you want to get it in, here are some comments (made harder by 
the fact that you did not follow Documentation/SubmittingPatches)...

> --- /usr/bin/gitk	2007-08-06 07:55:41.000000000 +0930
> +++ /home/pmdumuid/bin/gitkpmd	2007-09-07 14:09:28.000000000 +0930

You might want to consider using format-patch next time ;-)

> @@ -4564,6 +4566,19 @@
>      }
>  }
>  
> +proc doguidiff {} {
> +    global cflist sha1string
> +
> +    set taglist [$cflist tag ranges highlight]
> +    set from [lindex $taglist 0]
> +    set to [lindex $taglist 1]
> +
> +    set fname [$cflist get $from $to]
> +    exec cg-admin-cat -r $sha1string^ $fname > .gitk_diffolder
> +    exec cg-admin-cat -r $sha1string $fname > .gitk_diffnewer

This can be be achieved by "git cat-file -t blob $sha1string^:$fname", and 
likewise for $sha1string.

+    exec meld .gitk_diffolder .gitk_diffnewer &
+}

Hmm.  If you allow it to block, you might have more chances to clean up 
the temporary files...

Also, it would be nice to have it configurable which tool you use, a la 
git-mergetool.

Ciao,
Dscho
 
