From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] When generating manpages, delete outdated targets first.
Date: Wed, 01 Aug 2007 17:53:31 -0700
Message-ID: <7vlkcu3gfo.fsf@assigned-by-dhcp.cox.net>
References: <S1753674AbXHBABb/20070802000131Z+363@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 02:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGOwa-0001Fa-53
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 02:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbXHBAxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 20:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbXHBAxd
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 20:53:33 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52338 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbXHBAxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 20:53:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802005332.BSRH14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 20:53:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WotX1X00f1kojtg0000000; Wed, 01 Aug 2007 20:53:32 -0400
In-Reply-To: <S1753674AbXHBABb/20070802000131Z+363@vger.kernel.org> (David
	Kastrup's message of "Thu, 2 Aug 2007 01:48:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54507>

David Kastrup <dak@gnu.org> writes:

> This makes "make doc" work even if you made "sudo make doc" previously
> by mistake.  Apparently an oversight: the other targets did this already.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  Documentation/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3bc5357..a186843 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -120,6 +120,7 @@ clean:
>  	mv $@+ $@
>  
>  %.1 %.5 %.7 : %.xml
> +	$(RM) $@+ $@
>  	xmlto -m callouts.xsl man $<
>  
>  %.xml : %.txt

I think "rm" makes sense; the call to xmlto in this Makefile has
been this way from day one, it seems ;-).

The build rule for this target does not use "generate to
temporary $@+ and after that is successful mv to the final $@"
pattern, so we do not have to remove $@+ in this target, though.

Thanks.
