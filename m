From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 03 Jul 2012 13:21:36 -0700
Message-ID: <7vtxxotx2n.fsf@alter.siamese.dyndns.org>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <20120703071940.GB16679@sigill.intra.peff.net>
 <7v3958wvtx.fsf@alter.siamese.dyndns.org>
 <20120703183839.GA5765@sigill.intra.peff.net>
 <7vy5n0vg9l.fsf@alter.siamese.dyndns.org>
 <20120703193410.GA20503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 22:21:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm9bU-0002wq-9T
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 22:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab2GCUVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 16:21:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab2GCUVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 16:21:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54CF7954C;
	Tue,  3 Jul 2012 16:21:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxuaWMUSR9tvh2ZQjprYeOIDiic=; b=G5vB/D
	d/2ttUqRTUWhHSg8duQgTt3zgnoTJfPmkkDehRo+CTcQ2CjaMvHvZNVzRVTZqk3R
	YPYbgOSpv9VQVlJKz4OJKrjLo/FxXEKbtp6XhwylP0wTVA2gQw9KaKd4/nmV9F7G
	esy4rH2WqjBw1LATCHHo5093OGHT7xWif6+TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jfiHXEWkCU7C6AeMbmWPicstvGZjJ/Mx
	eQ3mtJ1xeYgsak6b3gjKSy+ZNsephiOIjgs68NVz/FISXNLKbXuRPVO7RXZQVaqM
	Ki2g1qZkie3TmsG7Sca8bkHy+9UhjzveyV6ttW+XYLN6RjBrpCQPpIBUjXqwzDyX
	wHkP/zc3Fvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A609954B;
	Tue,  3 Jul 2012 16:21:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3236954A; Tue,  3 Jul 2012
 16:21:37 -0400 (EDT)
In-Reply-To: <20120703193410.GA20503@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Jul 2012 15:34:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B130EE58-C54C-11E1-9CFC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200942>

Jeff King <peff@peff.net> writes:

> What happens if I set multiple flags? One or more of them will be
> ignored (you _could_ try to establish a hierarchy, for example that
> TREEISH is a superset of COMMITISH, but that could not handle the *_only
> cases, which really are mutually exclusive). IOW, I think these are not
> really flags but rather enum elements.

Yes, I was aware of that.  I counted five useful ones (see the new
ones near the tip of 'pu') but there may be others, so you cannot
fit in 2 bits and would need 3 bits.

> It is probably an OK trade-off since we are also stuffing true flags
> like GET_SHA1_QUIETLY in the same field, and we don't want to make the
> parameter list too unwieldy by splitting out the enum. But it might be
> worth throwing a comment into cache.h that a certain set of the flags
> are mutually exclusive. Or I guess you could mask off that part and make
> sure only one bit was set, which would catch the error at run-time. But
> I think a comment is probably sufficient.

I actually am thinking to move these bit assignments backto
sha1_name.c and make them private, as get_sha1_tree() and friends
are easier to understand public interface functions than
get_sha1_typish(... I_WANT_COMMIT|I_WANT_COMMITTISH|...).
