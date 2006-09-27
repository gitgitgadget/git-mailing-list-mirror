From: Junio C Hamano <junkio@cox.net>
Subject: Re: PATCH/RFC] allow delta data reuse even if base object is a preferred base
Date: Wed, 27 Sep 2006 12:53:37 -0700
Message-ID: <7vlko59jcu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609271536470.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:53:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSfTT-0000S0-3g
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030727AbWI0Txj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030728AbWI0Txj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:53:39 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34276 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030727AbWI0Txi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:53:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927195337.UXGG21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 15:53:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TXtf1V01G1kojtg0000000
	Wed, 27 Sep 2006 15:53:40 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609271536470.9349@xanadu.home> (Nicolas Pitre's
	message of "Wed, 27 Sep 2006 15:42:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27928>

Nicolas Pitre <nico@cam.org> writes:

> Signed-off-by: Nicolas Pitre <nico@cam.org>
>
> ---
>
> Any reason why this couldn't be done?
>
> When I reworked that code I preserved the existing logic wrt preferred 
> base.  However I could not find a reason why it was that way.  Hence 
> this patch.
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 6db97b6..ee5f031 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -989,7 +988,7 @@ static void check_object(struct object_e
>  		unuse_packed_git(p);
>  		entry->in_pack_header_size = used;
>  
> -		if (base_entry && !base_entry->preferred_base) {
> +		if (base_entry) {
>  
>  			/* Depth value does not matter - find_deltas()
>  			 * will never consider reused delta as the

I was wondering about it myself the other day because I do not
remember the reasoning why I thought we do not want to reuse the
delta when the base object is not part of the resulting pack.
We would recompute and create the delta ourselves anyway if we
do not take this branch, so it is not about avoiding to delta
it.

I really do not see the reason now; I think it is safe and
reasonable to remove the check.
