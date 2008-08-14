From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Wed, 13 Aug 2008 21:38:17 -0700
Message-ID: <20080814043817.GC11232@spearce.org>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 06:39:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTUcM-0007nA-B1
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 06:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbYHNEiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 00:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbYHNEiS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 00:38:18 -0400
Received: from george.spearce.org ([209.20.77.23]:56272 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYHNEiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 00:38:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD74238375; Thu, 14 Aug 2008 04:38:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218687684-11671-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92313>

Marcus Griep <marcus@griep.us> wrote:
> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
> index 75a8da1..291bc5e 100644
> --- a/Documentation/git-count-objects.txt
> +++ b/Documentation/git-count-objects.txt
> +++ b/builtin-count-objects.c
...
> +void human_readable_size(char *buf, int buf_size, double size /* in bytes */)

Hmm.  This probably should be static.  Or if it really is meant
to be a utility for use elsewhere in Git, moved to someplace where
string handling is done.  Its not strbuf related, but maybe strbuf.c
is a better location for this sort of library function.

If you do move this to strbuf.c, how about having it take a strbuf
in and appending the formatted text onto it?  You'll neer have to
worry about the buffer being too small and it fits into the whole
strbuf.c module thing.

If you keep this static here in builtin-count-objects.c, how about
making the char *buf static scoped to the function, so you don't
need to pass the buffer, its size, nor check its size?

> +{
> +	char human_readable_prefixes[10] = "BKMGTPEZY";
> +	if (buf_size < 5)
> +		die("insufficient buffer size");
> +	int i = 0;

We don't declare variables after statements.  Please declare all
variables at the start of the block as not all compilers we support
support this C99 syntax.

Oh, and welcome to Git.  I saw your SVN patches.  Glad to see
you hacking.  ;-)

> +	for (; i < 8 && size >= 1000 ; ++i, size = size / 1024)
> +		;
> +	if (size >= 1000)
> +		die("size greater than 999Y");
> +	sprintf(buf, "%.*f%c",
> +		size < 10 ? 1 : 0,
> +		size,
> +		human_readable_prefixes[i]
> +		);
> +}
> +

-- 
Shawn.
