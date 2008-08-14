From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v2 3/3] count-objects: add human-readable size option
Date: Fri, 15 Aug 2008 00:37:40 +0200
Message-ID: <20080814223740.GD10544@machine.or.cz>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us> <1218752308-3173-4-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlSv-0006mH-6c
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYHNWhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbYHNWhm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:37:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50671 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbYHNWhm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:37:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D62993939B56; Fri, 15 Aug 2008 00:37:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1218752308-3173-4-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92426>

On Thu, Aug 14, 2008 at 06:18:28PM -0400, Marcus Griep wrote:
> @@ -21,9 +21,14 @@ OPTIONS
>  --verbose::
>  	In addition to the number of loose objects and disk
>  	space consumed, it reports the number of in-pack
> -	objects, number of packs, and number of objects that can be
> -	removed by running `git prune-packed`.
> -
> +	objects, number of packs, disk space consumed by those packs
> +	and number of objects that can be removed by running
> +	`git prune-packed`.
> +
> +-H::
> +--human-sizes::
> +	Displays sizes reported by `--verbose` in a more
> +	human-readable format. (e.g. 22M or 1.5G)
>  
>  Author
>  ------

Can you guess what would I bug you about? ;-)

> -		printf("size-pack: %lu\n", size_pack / 1024);
> +		printf("size-pack: ");
> +		if (human_readable) {
> +			struct strbuf sb;
> +			strbuf_init(&sb, 0);
> +			strbuf_append_human_readable(&sb, size_pack,
> +							0, 0, "", 0);
> +			printf("%s\n", sb.buf);
> +		}
> +		else
> +			printf("%lu\n", size_pack / 1024);

If it's non-human-readable anyway, why are you dividing this by 1024? At
any rate, it is not obvious at all that the size-pack is not actually
size-pack but size-pack/1024. You should either add the (fixed) unit
string behind or name it size-pack-kb - or just not divide it at all?

This also applies to PATCH1/3 in case it would get applied but the other
two wouldn't.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
