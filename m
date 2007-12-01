From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] use typechange as rename source
Date: Fri, 30 Nov 2007 22:13:13 -0800
Message-ID: <7v8x4f6iyu.fsf@gitster.siamese.dyndns.org>
References: <20071121171235.GA32233@sigill.intra.peff.net>
	<7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
	<20071129141452.GA32670@coredump.intra.peff.net>
	<7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
	<20071130015716.GA15224@coredump.intra.peff.net>
	<7vsl2n87jr.fsf@gitster.siamese.dyndns.org>
	<20071201043407.GD30725@coredump.intra.peff.net>
	<7vhcj36j6e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 01 07:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyLbm-0001s8-Q0
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 07:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXLAGN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 01:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbXLAGN0
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 01:13:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44759 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXLAGN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 01:13:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2BA5A2EF;
	Sat,  1 Dec 2007 01:13:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F884989F0;
	Sat,  1 Dec 2007 01:13:41 -0500 (EST)
In-Reply-To: <7vhcj36j6e.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 30 Nov 2007 22:08:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66700>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/diffcore-break.c b/diffcore-break.c
> index c71a226..69afc07 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -52,8 +52,8 @@ static int should_break(struct diff_filespec *src,
>  			     * is the default.
>  			     */
>  
> -	if (!S_ISREG(src->mode) || !S_ISREG(dst->mode))
> -		return 0; /* leave symlink rename alone */
> +	if (object_type(src->mode) != object_type(dst->mode))
> +		return 1; /* even their types are different */

Oops, this part is wrong.  It should be checking ISREG and stuff.
