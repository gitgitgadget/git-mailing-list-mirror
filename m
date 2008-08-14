From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 17:14:51 +0200
Message-ID: <20080814151451.GA10544@machine.or.cz>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 17:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTebX-0003Fa-V8
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 17:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbYHNPSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYHNPSE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 11:18:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41364 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbYHNPSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 11:18:03 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 94AAF3939B47; Thu, 14 Aug 2008 17:14:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218687684-11671-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92365>

On Thu, Aug 14, 2008 at 12:21:24AM -0400, Marcus Griep wrote:
> +void human_readable_size(char *buf, int buf_size, double size /* in bytes */)
> +{
> +	char human_readable_prefixes[10] = "BKMGTPEZY";
> +	if (buf_size < 5)
> +		die("insufficient buffer size");
> +	int i = 0;
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

Are you aware of progress.c:throughput_string()? It would make sense to
use the same code in both instances.

I'd prefer you to keep using binary units instead of the ambiguous
prefixes, since we should keep our output consistent and I believe they
usually end up to be the least confusing choice. (Otherwise, don't you
want to use "bkM" instead of "BKM"? I never really know.)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
