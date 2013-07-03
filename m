From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by using string_list
Date: Wed, 03 Jul 2013 11:40:12 -0700
Message-ID: <7vhagbfpwz.fsf@alter.siamese.dyndns.org>
References: <1372809228-2963-1-git-send-email-bcasey@nvidia.com>
	<20130703062332.GA16090@sigill.intra.peff.net>
	<CA+sFfMeDC=hc7QZhfSuQYsdBPzig5WANeTBhMxFZk=Pusq0QpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <bcasey@nvidia.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@codeaurora.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRyZ-0004Xb-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab3GCSkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:40:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366Ab3GCSkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:40:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938082DAAC;
	Wed,  3 Jul 2013 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pn2T/3DaJP5wy+LOlfEXF0JLi0Y=; b=Z8MCca
	PucvxWld2FMLXxCyUqCDizagTr9AkfMYzbh36DPSt/8kVtIDZSMed4lam1XfpRFV
	YoBOCuCMMlukE6NCanEfqZRi1un3kvUmC25Mbd0lu4u/ifIZ/S3LiB+yeAMYV7+c
	SPuhymbnTuxwIbYQjW1ly1Csm0gxqMf3m7z3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sf0/bkKiTJfot13DTG1+6lNUsbcNGnSy
	1P0lXvdnrQdsnEvgVj8bv31ZUsBS5q/w9UtOhb4BxnwbDEroWJvnC+OzyprgUUJF
	4OUXXG0edCyKVuPGIthqrBKsgnhg7oLR8fE5ct/D+PaSgRtY27UEYGbDx1xvlHaO
	4omE17DwxY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B0B2DAAA;
	Wed,  3 Jul 2013 18:40:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C84C2DAA1;
	Wed,  3 Jul 2013 18:40:14 +0000 (UTC)
In-Reply-To: <CA+sFfMeDC=hc7QZhfSuQYsdBPzig5WANeTBhMxFZk=Pusq0QpA@mail.gmail.com>
	(Brandon Casey's message of "Wed, 3 Jul 2013 11:12:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 002ED5F0-E410-11E2-9E86-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229509>

Brandon Casey <drafnel@gmail.com> writes:

> Right.  For repos with few refs on either side, I don't think there
> will be any measurable difference.  When pushing a single ref to a
> repo with a very large number of refs, we will see a very small net
> loss for the time required to prepare the string list (which grows
> linearly with the number of remote refs).  After 2 or 3 refs, we
> should see a net gain.
>
> So we're really just improving our worst case performance here.

... by penalizing the common case by how much?  If it is not too
much, then this obviously would be a good change.

> ...  But, I don't see a down side to doing the lazy prepare in
> the other loop too, and in fact, it looks like we may be able to avoid
> building the string list when only explicit refspecs are used.  So,
> yeah, we should lazy build in both loops.

OK, so will see a reroll sometime?
