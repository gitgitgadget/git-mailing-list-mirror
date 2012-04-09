From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rs/commit-list-sort-in-batch
Date: Mon, 09 Apr 2012 12:46:50 -0700
Message-ID: <7vty0svgb9.fsf@alter.siamese.dyndns.org>
References: <7vwr5szi7z.fsf@alter.siamese.dyndns.org>
 <20120407072724.GA818@sigill.intra.peff.net>
 <20120407073232.GA13076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 21:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHKYN-0005VU-SF
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 21:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754447Ab2DITqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 15:46:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab2DITqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 15:46:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 044CD6A47;
	Mon,  9 Apr 2012 15:46:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/X+QV8Pm4SmIltV7sq4J4Pv2s0=; b=xuIMAc
	KmlpzBOmrj/7ikV/eAbsuG8tkJrskF1JYzFRdx/tJdfUjAUwN9Z8a1ZqQICjj6lX
	6eGCswpiBVAUu8SSnSQ+6upQVEalm6t22ydB8tnnmD3bbb0taDDxrfVcA29VRENL
	bqBQk1iSsXhyPCtJY4iGCPanjmO+QAdP90XqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ArHsk/zWPVB6PO/8GKS18bqTZxZ7Yu5T
	/enLQvI56r+0kyPbj8x3wOIbH4jB0k6AdyycDe3ilSJv1pAdB9cboB9HdZn+BFl8
	/NIzJEMCtyZItOQGLra1FcPbbff479ly3PQoL4Aq0cBNh8d27C4tVJ9WiazsPFIx
	7K2VKikoaNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFDCD6A45;
	Mon,  9 Apr 2012 15:46:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 854916A44; Mon,  9 Apr 2012
 15:46:51 -0400 (EDT)
In-Reply-To: <20120407073232.GA13076@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 7 Apr 2012 03:32:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C088A9E4-827C-11E1-A255-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195033>

Jeff King <peff@peff.net> writes:

> I'm not sure if that vindicates the patches, or implies that these
> things are lurking everywhere and that we should really move to a better
> data structure so we don't have to fix them all manually. :)

;-).

I do not know offhand how widespread the assumption of "list"-ness of the
commit_list is in the codebase.  The last time I looked at it was when I
was wondering if we could give a custom allocator to "struct commit_list",
as we seemed to liberally malloc()/free() quite many of them, with the
hope to reduce memory footprint, but I didn't finish it, so...

But at least inside revision walking machinery, your earlier heap based
implementation to optimize for time based priority queue access pattern
looked a very sensible approach to me.
