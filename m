From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain
 an empty line
Date: Fri, 8 Jun 2007 06:30:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080621420.4059@racer.site>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
 <7vmyzbm3cx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 07:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwX6G-0000G0-BF
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbXFHFdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762149AbXFHFdX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:33:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:55372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756521AbXFHFdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:33:22 -0400
Received: (qmail invoked by alias); 08 Jun 2007 05:33:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 08 Jun 2007 07:33:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/B7BdsfzDBzHk3EtSLB2/Gv6w09oh3Q4JhOnMe1E
	JA3OEIueDnqAUx
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyzbm3cx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49435>

Hi,

On Thu, 7 Jun 2007, Junio C Hamano wrote:

> Recent git-tag does this
> 
>     ( printf 'object %s\ntype %s\ntag %s\ntagger %s\n\n' \
> 	"$object" "$type" "$name" "$tagger";
>       cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP
> 
> so even if TAG_FINALMSG (which is -m or edited message after
> filtering out the comments and git-stripspace) is empty, you
> would have the two LFs at the end of the header.

I could imagine that there is still a git-stripspace after that. Undoing 
the last LF.

> Did this tag come from cvsimport (or svnimport) perhaps?

Yep. cvsimport.

But nevertheless, I know the convention of "LFLF" being the end of the 
header from several places: HTTP, mail, proxies.

_None_ of them fail as badly as what I experienced. Heck, Git used to be 
the _most_ stable software I ever used, _including_ the Linux kernel. And 
all of a sudden, when I really needed it just to work properly, and did 
not bother to install a "stable" version, but just took "next", it failed 
on me.

I don't like this at all.

And I have to say, even if I was responsible for my share of 
not-quite-perfect patches, this patch _series_ is bad IMHO.

Not only does already the _first_ patch contain a serious error. I did not 
even bother to read it in total, because it was _huge_, contained 
_white-space_ fixes in combination with some dubious comment changes, did 
not clean up _obvious_ errors (like lookup_object(sha1)->object!!), but at 
the same time _changed_ behaviour.

And it is totally unreadable, with 120+ characters per line.

Frankly, I am angry at myself that I did not have a look and shot that 
patch down on the merits of its _line size_ alone.

I have come to expect bad code from bad style and I would have been right 
again, had I read the patch in time.

> I agree with you that if something does not have body, we should not 
> require an empty trailing line after the header.

It is just _one_ issue about it.

We should not fail to process a fetch _at all_, just because a single 
_tag_ is not really conforming to some obscure convention.

Ciao,
Dscho "still somewhat upset"
