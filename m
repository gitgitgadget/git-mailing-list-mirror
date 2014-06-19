From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] alloc.c: remove alloc_raw_commit_node() function
Date: Thu, 19 Jun 2014 05:19:24 -0400
Message-ID: <20140619091924.GA29478@sigill.intra.peff.net>
References: <53A1EE0E.6040000@ramsay1.demon.co.uk>
 <20140618200854.GA23098@sigill.intra.peff.net>
 <53A2131A.30900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 19 11:19:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxYVG-0008Uf-Sw
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 11:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628AbaFSJT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 05:19:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:47357 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755362AbaFSJT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 05:19:26 -0400
Received: (qmail 11736 invoked by uid 102); 19 Jun 2014 09:19:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 04:19:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 05:19:24 -0400
Content-Disposition: inline
In-Reply-To: <53A2131A.30900@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252105>

On Wed, Jun 18, 2014 at 11:30:50PM +0100, Ramsay Jones wrote:

> So, the patch below is a slight variation on the original patch.
> I'm still slightly concerned about portability, but given that it
> has been at least a decade since I last used a (pre-ANSI) compiler
> which had a problem with this ...

For a while some people were compiling git with pretty antique
compilers, but I do not know if that is the case any more (Junio noted
recently that we have had trailing commas on arrays and enums in
builtin/clean.c for the past year, and nobody has complained).

Maybe those systems have all died off, or maybe those people only
upgrade every few years, and we are due for an onslaught of portability
fixes soon. :)

> [I have several versions of the C standard that I can use to check
> up on the legalise, but I'm not sure I can be bothered! ;-) ]

It was actually pretty easy to find. I only have C99, but "empty macro
arguments" are listed as one of the changes since C89 in the foreward.

> diff --git a/alloc.c b/alloc.c
> index eb22a45..5392d13 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -18,9 +18,12 @@
>  
>  #define BLOCKING 1024
>  
> -#define DEFINE_ALLOCATOR(name, type)				\
> +#define PUBLIC
> +#define PRIVATE static
> +
> +#define DEFINE_ALLOCATOR(scope, name, type)			\

I am not sure offhand whether this is more portable or not (it would
depend on order of macro expansion, and I am not brave enough to read
through the preprocessor section of the standard carefully). Quick
reading online suggests that it's OK, but that an extra level of macro
expansion would not be. And of course the Internet is never wrong. :)

I'm inclined to go with it, and deal with it later if we get a
portability complaint (at which point we are no worse off than we are
right now).

-Peff
