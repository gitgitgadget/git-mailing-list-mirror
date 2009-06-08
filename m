From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11 v2] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Mon, 08 Jun 2009 09:50:11 -0700
Message-ID: <7vzlcizn3w.fsf@alter.siamese.dyndns.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
	<1243786525-4493-2-git-send-email-prohaska@zib.de>
	<1243786525-4493-3-git-send-email-prohaska@zib.de>
	<1243786525-4493-4-git-send-email-prohaska@zib.de>
	<1243786525-4493-5-git-send-email-prohaska@zib.de>
	<1243786525-4493-6-git-send-email-prohaska@zib.de>
	<1243786525-4493-7-git-send-email-prohaska@zib.de>
	<1243786525-4493-8-git-send-email-prohaska@zib.de>
	<1243786525-4493-9-git-send-email-prohaska@zib.de>
	<1243786525-4493-10-git-send-email-prohaska@zib.de>
	<1243786525-4493-11-git-send-email-prohaska@zib.de>
	<7vhbz0mmai.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
	<7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302>
	<7viqjefxcv.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302>
	<7vprdl9qon.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDi3A-0005J7-PQ
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 18:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbZFHQuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 12:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZFHQuL
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 12:50:11 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54565 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbZFHQuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 12:50:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608165012.TYTS17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jun 2009 12:50:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1UqC1c0024aMwMQ03UqCJa; Mon, 08 Jun 2009 12:50:12 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=AowHJ8lBr2UA:10 a=bYG_07KaEygA:10
 a=bxSzPNJltzt9sQU1jfYA:9 a=HJQmTTTilmhiXA6W-Ki6J6DJ4dMA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302> (Johannes Schindelin's message of "Mon\, 8 Jun 2009 16\:46\:49 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121087>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Nedmalloc's source code has a cute #define construct to avoid inserting
> an if() statement, because that might interact badly with enclosing if()
> statements.  However, GCC > 4 complains with a "warning: value computed
> is not used".  So we cast the result to "void".
>
> 	Forgot to send.

Thanks.  The description on the pragma is a good thing to add, which you
did.

Is Visual C++ happy with casting discarded result to (void)?  I'd find it
broken if it isn't, but it would not hurt to ask just to make sure.

Steffen, can we move the series, with this patch replaced, to 'next' now?
I think it looks good (thanks!) but again it would not hurt to ask just to
make sure ;-).

>  compat/nedmalloc/malloc.c.h  |    4 +++-
>  compat/nedmalloc/nedmalloc.c |    2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
> index bb0f482..b5b1495 100644
> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -1270,7 +1270,9 @@ int mspace_mallopt(int, int);
>  /*------------------------------ internal #includes ---------------------- */
>  
>  #ifdef WIN32
> +#ifndef __GNUC__
>  #pragma warning( disable : 4146 ) /* no "unsigned" warnings */
> +#endif
>  #endif /* WIN32 */
>  
>  #include <stdio.h>       /* for printing in malloc_stats */
> @@ -2541,7 +2543,7 @@ struct malloc_params {
>  static struct malloc_params mparams;
>  
>  /* Ensure mparams initialized */
> -#define ensure_initialization() (mparams.magic != 0 || init_mparams())
> +#define ensure_initialization() ((void)(mparams.magic == 0 || init_mparams()))
>  
>  #if !ONLY_MSPACES
>  
