From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Thu, 25 Jan 2007 13:26:29 -0800
Message-ID: <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
References: <20070125173954.GA13276@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 22:26:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAC79-0000qX-UZ
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbXAYV0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030580AbXAYV0c
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:26:32 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50403 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030579AbXAYV0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:26:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125212630.ZETE2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 16:26:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FZRZ1W00A1kojtg0000000; Thu, 25 Jan 2007 16:25:33 -0500
In-Reply-To: <20070125173954.GA13276@spearce.org> (Shawn O. Pearce's message
	of "Thu, 25 Jan 2007 12:39:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37758>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Yes, its very useful.  If you get two different describes at different
> times from a non-rewinding branch and they both come up with the same
> tag name, you can tell which is the 'newer' one by distance.  This is
> rather common in practice, so its incredibly useful.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  builtin-describe.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-describe.c b/builtin-describe.c
> index e7b8f95..d8ff621 100644
> --- a/builtin-describe.c
> +++ b/builtin-describe.c
> @@ -189,7 +189,8 @@ static void describe(const char *arg, int last_one)
>  				sha1_to_hex(gave_up_on->object.sha1));
>  		}
>  	}
> -	printf("%s-g%s\n", all_matches[0].name->path,
> +	printf("%s-%i-g%s\n", all_matches[0].name->path,
> +		   all_matches[0].depth,
>  		   find_unique_abbrev(cmit->object.sha1, abbrev));
>  
>  	if (!last_one)

Two comments.

 - This is purely style, but we seem to prefer %d instead of %i
   elsewhere in the code (three existing offenders are
   builtin-describe.c, receive-pack.c and sha1_file which we may
   want to clean up for consistency).

 - How much damage are we talking about with this patch to
   People's existing scripts?  I expect they all extract the
   hash from last -g (because they cannot rely on particular
   convention in tagnames), but I am also worried if people are
   expecting everything that comes before the last -g is the
   whole tag.
