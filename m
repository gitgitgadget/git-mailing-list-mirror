From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) 5/6] gitk: Fixed automatic row selection during load.
Date: Thu, 31 Jul 2008 21:25:31 +1000
Message-ID: <18577.41259.758690.635991@cargo.ozlabs.ibm.com>
References: <200807271017.23272.angavrilov@gmail.com>
	<200807271020.02415.angavrilov@gmail.com>
	<200807271020.53171.angavrilov@gmail.com>
	<200807271021.46661.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:26:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOWIs-0007r4-Qu
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbYGaLZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbYGaLZl
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:25:41 -0400
Received: from ozlabs.org ([203.10.76.45]:36659 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYGaLZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:25:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8770BDDF64; Thu, 31 Jul 2008 21:25:39 +1000 (EST)
In-Reply-To: <200807271021.46661.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90934>

Alexander Gavrilov writes:

> - Switching views now actually preserves the selected commit.
> - Reloading (also Edit View) preserves the currently selected commit.
> - Initial selection does not produce weird scrolling.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

I need a more detailed explanation of the rationale for the specific
changes you have made in the changelog.

As for the patch, it mostly looks good, but I have a few comments
below.

> +proc getcommits {selid} {
>      global canv curview need_redisplay viewactive
>  
>      initlayout
>      if {[start_rev_list $curview]} {
> +	reset_pending_select $selid

Is there any significance to having the call to reset_pending_select
after the start_rev_list call (other than not setting pending_select
if start_rev_list fails)?  I couldn't see any.  If there is then it
should be noted in a comment and/or the patch description.

> @@ -503,7 +511,7 @@ proc updatecommits {} {
>      filerun $fd [list getcommitlines $fd $i $view 1]
>      incr viewactive($view)
>      set viewcomplete($view) 0
> -    set pending_select $mainheadid
> +    reset_pending_select {}

This doesn't actually change anything, right?  If so then I'd prefer
the simple, direct assignment to calling a procedure that does the
assignment.

> @@ -4036,6 +4042,7 @@ proc layoutmore {} {
>      }
>      if {[info exists pending_select] &&
>  	[commitinview $pending_select $curview]} {
> +	update
>  	selectline [rowofcommit $pending_select] 1

What does that update do?  Would update idletasks be better?

Thanks,
Paul.
