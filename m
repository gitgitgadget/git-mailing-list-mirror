From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/3] compat: add a mkstemps() compatibility function
Date: Sun, 31 May 2009 19:03:55 -0700
Message-ID: <7vr5y4ogl0.fsf@alter.siamese.dyndns.org>
References: <1243758952-28972-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	markus.heidelberg@web.de, jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 04:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAwsr-0003aE-3F
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 04:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbZFACDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 22:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbZFACDy
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 22:03:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63092 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbZFACDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 22:03:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601020354.DQYF17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 May 2009 22:03:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id yS3v1b0044aMwMQ03S3v6U; Sun, 31 May 2009 22:03:55 -0400
X-Authority-Analysis: v=1.0 c=1 a=jY1Cl1Ud0EMA:10 a=092h3wPtyvEA:10
 a=pGLkceISAAAA:8 a=BaA1szcqYqpR45BfG1oA:9 a=0w-P9Z52zNNc6jzQnyYH742LaLcA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120441>

David Aguilar <davvid@gmail.com> writes:

> mkstemps() is a BSD extension so provide an implementation
> for cross-platform use.
> ...
> diff --git a/git-compat-util.h b/git-compat-util.h
> index c7cf2d5..5a2d4e7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -113,6 +113,10 @@
>  #define PATH_MAX 4096
>  #endif
>  
> +#ifndef TMP_MAX
> +#define TMP_MAX 16384
> +#endif

Giving fallback definition to PATH_MAX and PRIuMAX (as seen in the context
of the hunk) makes perfect sense.  TMP_MAX on the other hand is being
obsoleted in POSIX.1, and more importantly, we do not use it in our
program anywhere other than the compatibility implementation of
mkstemps().

I'll move this to the file that is used, which is compat/mkstemps.c.  I'll
further change the constant not to inherit from whatever the platform
happens to define TMP_MAX to be.  POSIX.1 says "at least 25", but the
fallback implementation does not need to be constrained to such a low
number.

Thanks.
