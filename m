From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Strbuf documentation: document most functions
Date: Tue, 3 Jun 2008 01:00:33 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806030048010.13507@racer.site.net>
References: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:02:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Jz8-0000Gv-BO
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbYFCABs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 20:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbYFCABs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:01:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:41549 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753716AbYFCABr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:01:47 -0400
Received: (qmail invoked by alias); 03 Jun 2008 00:01:45 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 03 Jun 2008 02:01:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Fg5kmnMWF6xdhJSpOpJhUdH+gYxUli7UDxxlJVD
	9u4M+gIKxsk7S7
X-X-Sender: gene099@racer.site.net
In-Reply-To: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83598>

Hi,

I am no author of strbuf, but hey, I thought I'd just give you a few 
comments...

In general, I'd rather leave the "->" from the members, since you have 
many instances where you access them with ".".

On Tue, 3 Jun 2008, Miklos Vajna wrote:

> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index a52e4f3..3879e0e 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -1,6 +1,175 @@
>  strbuf API
>  ==========
>  
> -Talk about <strbuf.h>
> +strbuf's can be use in many ways: as a byte array, or to store arbitrary
> +long, overflow safe strings.

I think that you should not suggest using strbufs as byte array, even if 
that is certainly possible.  Rather, you should say something like:

	An strbuf is NUL terminated for convenience, but no function in 
	the strbuf API actually relies on the string being free of NULs.

> +strbufs has some invariants that are very important to keep in mind:
> +
> +. The `->buf` member is always malloc-ed, hence strbuf's can be used to
> +  build complex strings/buffers whose final size isn't easily known.

Is this true?  I thought the initial string is empty, but not alloc'ed.

So I'd rather have something like

	The "buf" member is never NULL, so you can safely strcmp() it.

I'd like to see a comment that strbuf's _have_ to be initialized either by 
strbuf_init() or by "= STRBUF_INIT" before the invariants, though.

> +`strbuf_attach`::
> +
> +	Attaches a string to a buffer. You should specify the string to attach,
> +	the current length of the string and the amount of allocated memory.

... This string _must_ be malloc()ed, and after attaching, the pointer 
cannot be relied upon anymore, and neither be free()d directly.

> +`strbuf_read`::
> +
> +	Read the contents of a given file descriptor. The third argument can be
> +	used to give a hint about the file, to avoid reallocs.

s/about the file/& size/

> +`strbuf_read_file`::
> +
> +	Read the contents of a file, specified by its path. The third argument
> +	can be used to give a hint about the file, to avoid reallocs.

Ditto.

> +`strbuf_getline`::
> +
> +	Read a line from a FILE* pointer. The second argument specifies the line
> +	terminator character, like `'\n'`.

s/like/typically/

Thanks,
Dscho
