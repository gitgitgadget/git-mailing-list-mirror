From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: fix for merge.conflictstyle
Date: Wed, 30 Apr 2014 07:04:58 -0700
Message-ID: <xmqqy4ymhq0l.fsf@gitster.dls.corp.google.com>
References: <1398830909-24680-1-git-send-email-felipe.contreras@gmail.com>
	<20140430060835.GA21698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:05:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfV8N-00019N-0g
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759129AbaD3OFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 10:05:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbaD3OFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 10:05:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4101A7FABE;
	Wed, 30 Apr 2014 10:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SfUhidBRQL8FN4nEcLYkSY8Qnu8=; b=ugZ04c
	zXHVwEeLRqirlXctsGKmwshXqra88ifkV5X2pkiqzKKKYSUQJo+xX8Eg7PBHRYXY
	BzKQyz5Qoe15yEOYzpU+l9dBSGguYrbaupE/NZD1HX5Kr445e6HN4+0W/OTZTP0G
	BjkjaS6iO7A7MxAV7gkgLbJWXnzGgjrN6KYDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aBhs9ZkS2z7n4QsFF9Wkt7jrWO3oiAHo
	VGmL6735V5htK5oYfvQ48txABLntZ3+MY0ydfNyGTbU4F7+iJ94r7x05SZNXCKW0
	OtvEhqmaDfpMe+2gBIW7WkFG5v2cZlmwnjVeFbXfiF4beZR9CxweNUyY9/parqzM
	tMKp9e64hKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25E867FABC;
	Wed, 30 Apr 2014 10:05:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78CDC7FAB8;
	Wed, 30 Apr 2014 10:05:00 -0400 (EDT)
In-Reply-To: <20140430060835.GA21698@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 30 Apr 2014 02:08:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6B3FA336-D070-11E3-96D2-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247713>

Jeff King <peff@peff.net> writes:

> I could not reproduce the problem with a trivial case, and rerere
> specifically tries to handle the differences between "merge" and "diff3"
> styles by throwing away the base content between "|" and "=" lines.
> However, I wonder if it could still miss a match in some cases because
> the "merge" style uses XDL_MERGE_ZEALOUS, whereas diff3 bumps it
> down to XDL_MERGE_EAGER, which could lead to a slightly different
> preimage.
>
> If so, I think this points to a slightly more pervasive problem in
> "rerere", then: data recorded under one merge level might not be usable
> later (whether for "rerere forget" or for actually applying a
> resolution).
> ...
>
> So given all of the "hopefully rare" statements above and the complexity
> of the complete solution, it's probably not worth pursuing. In which
> case your patch seems like the best we can do. At least it covers the
> more common case when you have set merge.conflictstyle but _didn't_
> change it since the postimage was recorded.

Thanks for a fix, Felipe, and thanks for a more detailed discussion,
Peff.  I think I saw the exact same symptom in "forget" the other
day, but was too busy to pursue it at that moment.
