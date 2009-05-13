From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Wed, 13 May 2009 12:14:18 -0700
Message-ID: <7v4ovo4xyt.fsf@alter.siamese.dyndns.org>
References: <20090513094448.GC2106@bug.science-computing.de>
	<fabb9a1e0905130353u416086b8i5b685e750ec4b5a5@mail.gmail.com>
	<20090513112535.GD2106@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
X-From: git-owner@vger.kernel.org Wed May 13 21:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JuQ-0002tb-5a
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760511AbZEMTOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759944AbZEMTOT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:14:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55334 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791AbZEMTOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:14:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513191419.RWWQ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 May 2009 15:14:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id r7EJ1b00g4aMwMQ047EK3v; Wed, 13 May 2009 15:14:19 -0400
X-Authority-Analysis: v=1.0 c=1 a=IHhOjfFVpNkA:10 a=oqDeMcJphqMA:10
 a=vz9goz1ngCdi56dfkbAA:9 a=eyYtxUBPg7c-JdbDccbLQsFFrYQA:4 a=plMbz_m26q8A:10
X-CM-Score: 0.00
In-Reply-To: <20090513112535.GD2106@bug.science-computing.de> (Daniel Trstenjak's message of "Wed\, 13 May 2009 13\:25\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119089>

Daniel Trstenjak <Daniel.Trstenjak@science-computing.de> writes:

> Showing stash state in bash prompt.

That's what you already said in the "Subject:" ;-)

Here in the proposed commit message, you describe what the code after
applying your patch does in a bit more detail, defend why such a new
behaviour is desirable, and defend why your implementation is superior
than possible alternative solutions to achieve that goal.

Going back to the "Subject: ", we typically put the name of the affected
area and colon to the message, and use imperative mood, as if you are
giving an order to the code to "do this (instead of what you currently
do)".

E.g.

	Subject: [PATCH] completion: show presense of stashed changes

	Users often forget that there are stashed changes that want to be
	unstashed.  Add a '$' in the prompt string to remind them.

	Signed-off-by: ...

Note that I do not necessarily agree with the above justification; I am
just illustrating the established style around here.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1683e6d..86e39a5 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -117,6 +117,7 @@ __git_ps1 ()
>  
>  		local w
>  		local i
> +		local s
>  		local c
>  
>  		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then

Ok.

> @@ -136,15 +137,19 @@ __git_ps1 ()
>  					else
>  						i="#"
>  					fi
> +					stash_list=`git stash list`

Don't you want to localize this variable to avoid contaminating the
namespace?

> +					if [ -n "$stash_list" ]; then
> +					        s="$"

Is the presense the only thing that matters?  Notice that I reworded your
"stash state" to "presense of" to clarify that you are giving only one bit
of information in the counter-proposed "Subject:" above.

I personally prefer your "only one bit" patch over a possible alternative
to count the stash entries with "git stash list | wc -l" that would be way
more costly, and if you thought about such an alternative and discarded
it, it would save other people's time if you say so in your proposed
commit message.  So...

	Subject: [PATCH] completion: show presense of stashed changes

	Users often forget that there are stashed changes that want to be
	unstashed.  Add a '$' in the prompt string to remind them when
	there is a stashed state.

	We could count and show the number of stash entries instead, but
        that would be more costly at runtime than it is worth.

	Signed-off-by: ...

and with localization of stash_list variable I think the patch becomes
better.

Thanks.
