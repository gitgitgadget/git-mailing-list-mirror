From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] use typechange as rename source
Date: Sun, 02 Dec 2007 11:15:40 -0800
Message-ID: <7v8x4cykkj.fsf@gitster.siamese.dyndns.org>
References: <20071121171235.GA32233@sigill.intra.peff.net>
	<7vir3l2a1i.fsf@gitster.siamese.dyndns.org>
	<20071129141452.GA32670@coredump.intra.peff.net>
	<7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
	<20071130015716.GA15224@coredump.intra.peff.net>
	<7vsl2n87jr.fsf@gitster.siamese.dyndns.org>
	<20071201043407.GD30725@coredump.intra.peff.net>
	<7vhcj36j6e.fsf@gitster.siamese.dyndns.org>
	<7v8x4f6iyu.fsf@gitster.siamese.dyndns.org>
	<7vy7ce6hyb.fsf@gitster.siamese.dyndns.org>
	<20071201064916.GA7431@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyuIQ-0004Dp-6S
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 20:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbXLBTPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXLBTPq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 14:15:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47756 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbXLBTPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 14:15:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 566E02FB;
	Sun,  2 Dec 2007 14:16:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D77659C254;
	Sun,  2 Dec 2007 14:16:03 -0500 (EST)
In-Reply-To: <20071201064916.GA7431@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 1 Dec 2007 01:49:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66811>

Jeff King <peff@peff.net> writes:

> And maybe something like this on top for git-status?
>
> diff --git a/wt-status.c b/wt-status.c
> index 0e0439f..e77120d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -250,6 +250,7 @@ static void wt_status_print_updated(struct wt_status *s)
>  	rev.diffopt.format_callback_data = s;
>  	rev.diffopt.detect_rename = 1;
>  	rev.diffopt.rename_limit = 100;
> +	rev.diffopt.break_opt = 0;
>  	wt_read_cache(s);
>  	run_diff_index(&rev, 1);
>  }

I have to wonder how much this is going to make things worse in the real
world, although I agree in the "as we already spend cycles for
detect_rename why not" sense.

With the recent change from Alex not to run status when not interactive,
it probably does not matter.  If we are going to spawn an editor, we are
dealing with human interaction and even -B -M should not be too bad.
