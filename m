From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make xdiff_outf_{init,release} interface
Date: Wed, 13 Aug 2008 19:13:23 -0700
Message-ID: <7viqu4gx8c.fsf@gitster.siamese.dyndns.org>
References: <20080813070508.GB4396@lavos.net>
 <7vljz0iftm.fsf@gitster.siamese.dyndns.org> <20080814020614.GD4396@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Thu Aug 14 04:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTSME-0003aH-Ef
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 04:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYHNCNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 22:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbYHNCNa
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 22:13:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYHNCNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 22:13:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E7255823D;
	Wed, 13 Aug 2008 22:13:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A5F4158235; Wed, 13 Aug 2008 22:13:25 -0400 (EDT)
In-Reply-To: <20080814020614.GD4396@lavos.net> (Brian Downing's message of
 "Wed, 13 Aug 2008 21:06:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 958F83C2-69A6-11DD-802E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92308>

bdowning@lavos.net (Brian Downing) writes:

>> Although I wish xdi_diff() could do the necessary clean-up immediately
>> before it returns (so that the caller did not have to do anything
>> special), it is not possible to do so cleanly, because there are
>> "outf" implementations other than xdiff_outf that do not even use
>> "struct xdiff_emit_state" in their callbacks.  So I think your patch
>> makes sense.
>
> Well, I could do something like:
>
> 	if (xecb->outf == xdiff_outf)
> 		/* xdiff_outf cleanup */
>
> at the end of xdi_diff, but that's... kind of horrible I think.

Yeah, that is ugly, and that is why I said I think your patch makes sense.

> For that matter, I could just make an xdi_outf_diff function that would
> take the state in addition to the other xdi_diff arguments and go ahead
> and set it up, do the diff, and tear it down in one step.  Maybe that
> would be better if it works for everywhere this style of diff needs to
> be called.

Yeah, most of the xdi_diff() callers do use the stock outf so it would
make sense.
