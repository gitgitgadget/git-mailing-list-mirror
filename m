From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix for incorrect index update
Date: Sat, 09 May 2009 21:22:10 -0700
Message-ID: <7vskjd4mfh.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0905091356070.21000@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 06:22:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M30YN-0003qp-Iv
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 06:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbZEJEWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 00:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbZEJEWM
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 00:22:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53466 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbZEJEWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 00:22:11 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510042211.XYGR20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Sun, 10 May 2009 00:22:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id pgNA1b00B4aMwMQ04gNAUu; Sun, 10 May 2009 00:22:11 -0400
X-Authority-Analysis: v=1.0 c=1 a=L2YQtgExF0IA:10 a=uItpqqHCuNUA:10
 a=ybZZDoGAAAAA:8 a=EYTpEeRGZ6yX4NujuaIA:9 a=8Q2MZsF4KkKXyXC512tATm_3_bAA:4
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118701>

Dave O <cxreg@pobox.com> writes:

> call_depth > 0 requires trees to be constructed from the files with
> conflicts, therefore the stages thusly must not be updated
>
> Signed-off-by: Dave Olszewski <cxreg@pobox.com>
> ---

Thanks.  I'd add:

	From: Dave Olszewski <cxreg@pobox.com>

at the beginning, so you would not be shown as "Dave O" in "git shortlog"
and friends.

>  merge-recursive.c          |   11 +++--
>  t/t3031-merge-criscross.sh |   95 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 5 deletions(-)
>  create mode 100644 t/t3031-merge-criscross.sh

> diff --git a/t/t3031-merge-criscross.sh b/t/t3031-merge-criscross.sh
> new file mode 100644

That should have been 100755 (I'll fix-up myself; no need to resend).

> index 0000000..cbfd95b
> --- /dev/null
> +++ b/t/t3031-merge-criscross.sh
> @@ -0,0 +1,95 @@
> +#!/bin/sh
> +
> +test_description='merge-recursive backend test'
> +
> +. ./test-lib.sh
> +
> +#         A      <- create some files
> +#        / \
> +#       B   C    <- cause rename/delete conflicts between B and C
> +#      /     \
> +#     |\     /|
> +#     | D   E |
> +#     |  \ /  |
> +#     |   X   |
> +#     |  / \  |
> +#     | /   \ |
> +#     |/     \|
> +#     F       G  <- merge E into B, D into C
> +#      \     /
> +#       \   /
> +#        \ /
> +#         H      <- recursive merge crashes
> +#

Much nicer than Dscho's ;-)

> +# initialize
> +test_expect_success 'setup repo with criss-cross history' '
> +	mkdir data &&
> +
> +	test_debug create a bunch of files &&

You inherited a bug from Dscho's patch, it seems.  Have you tried running
the test with debug option?

This could have been

	test_debug "echo create a bunch of files" &&

but I'd say we just make them into comments.
