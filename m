From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 14:59:29 -0700
Message-ID: <7v3934qbwe.fsf@alter.siamese.dyndns.org>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
 <7v3934tkle.fsf@alter.siamese.dyndns.org>
 <20120830213105.GA18636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Cmo-0003Qx-5E
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2H3V7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 17:59:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab2H3V7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 17:59:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B974973F;
	Thu, 30 Aug 2012 17:59:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fi/vBhR7cXUvwN/l0nlGWRCbiE4=; b=GEMtzK
	3W4+kYVEGH788pvfnfwRaBkMMJudrGviuQ/G6vn+iXwGg4e9iX5lkVLNdQcp9PDJ
	lGVCQZ8K97onxyEg295gHxEgnnrC0wf/ExaN097JksqziFgJG6kq6J7Ih3dt+7p/
	ztksophOU41LW8QkVi1zF9108TyEHmGyjQVhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KQoniOqxCoFWC0FD38bL/ObKD+s/8gby
	j38J2ACIgwjNx0Ip4tU82Hyn3bp3MRGMwXWqOBQLmjYjOYiLadBwaAPJMkpPkSAE
	4hicHuVjqwMYncfd6UJr9eHiGHuanvR/psPUe0Ith2sOzFaN/8uMviV7GColdMcD
	7n31c9mdoHw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294B8973D;
	Thu, 30 Aug 2012 17:59:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A76D973C; Thu, 30 Aug 2012
 17:59:30 -0400 (EDT)
In-Reply-To: <20120830213105.GA18636@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 30 Aug 2012 17:31:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F996BDD4-F2ED-11E1-A5FB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204569>

Jeff King <peff@peff.net> writes:

> Compared to dropping an O(n^2) operation to O(lg n), that's
> probably not even going to be noticeable.

Yeah, that is something we would want to use when we eventually
update the main revision traverser, not this codepath localized to
the merge-base.

Thanks.  I like (and agree with) everything you wrote in this
message.
