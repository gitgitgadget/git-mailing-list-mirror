From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Wed, 11 Apr 2007 14:36:10 -0700
Message-ID: <7v1wiqoaph.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
	<11763238991005-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkUD-0004FF-Hm
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbXDKVgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965320AbXDKVgN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:36:13 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41123 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965292AbXDKVgM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:36:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411213610.GWGP1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 17:36:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lxcB1W0051kojtg0000000; Wed, 11 Apr 2007 17:36:11 -0400
In-Reply-To: <11763238991005-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Wed, 11 Apr 2007 22:38:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44258>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Only send a modified response if the client sent a
> "Modified" entry. This fixes the case where the
> file was locally deleted on the client without
> being removed from CVS. In this case the client
> will only have sent the Entry for the file but nothing
> else.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  git-cvsserver.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
>  We really, really need a test suite for cvsserver...
>  I've tested this as good for regressions as I could
>  think of but am still unsure about it.
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 68aa752..25816c5 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -843,6 +843,7 @@ sub req_update
>          if ( defined ( $wrev )
>               and defined($meta->{revision})
>               and $wrev == $meta->{revision}
> +             and defined($state->{entries}{$filename}{modified_hash})
>               and not exists ( $state->{opt}{C} ) )
>          {
>              $log->info("Tell the client the file is modified");
> -- 
> 1.5.1

This would make the modified response go away, but would it
cause a fresh re-checkout to happen?
