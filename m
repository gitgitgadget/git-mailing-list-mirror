From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] send-email: extract_valid_address use qr// regexes
 and /o
Date: Thu, 30 Sep 2010 10:25:54 -0700
Message-ID: <7vocbfjg7x.fsf@alter.siamese.dyndns.org>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
 <1285854189-10240-14-git-send-email-avarab@gmail.com>
 <20100930161912.GA8707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 19:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1MuO-0007xh-2a
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 19:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab0I3R0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 13:26:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab0I3R0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 13:26:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3377DA888;
	Thu, 30 Sep 2010 13:26:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45mzOND5uS8ZqvgQHMG2AMneqrA=; b=MVvV/+
	UzxAlwEPeqlaqyDIyxqaQF+Ci9+rcH4CP1bnuBy9JZznW2agmGCDQPz/sNavKQHu
	LDaJbsuPbGZql/0tU9yb30lfzbD5BKgbJSKFXaolv4KOX4bPLFPlrPRTPPbomr35
	J0+PJ/QMaWQpOK1ttQorudwQInRFCgvPvnhfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dMwwU6W13afIuOvYdVb4PEjCO1wwk//t
	B8DgAwjLx2R8HGsaXgMiJKXIeQsVGi7tE7OoGdNkYlFClDKTsCtdntjZpjL8+XiH
	nnyfji/iXqcXHFTBWzMizzclT53b1pvwhE8l1kQXWAMReA9c5zvRxOQNO5Fh4Ki0
	fRI7cXqUcZg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54328DA87C;
	Thu, 30 Sep 2010 13:26:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48CA8DA863; Thu, 30 Sep
 2010 13:25:56 -0400 (EDT)
In-Reply-To: <20100930161912.GA8707@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 30 Sep 2010 12\:19\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCE6562C-CCB7-11DF-ABF2-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157695>

Jeff King <peff@peff.net> writes:

> ...
> But we are unnecessarily compiling the sub-regexes each time. Not that
> this is probably a performance critical piece of code, but your "/o" is
> doing very little, and this is exactly the sort perl wankery that I find
> interesting.

Well, isn't the _sole_ point of using qr// to optimize by avoiding
recompilation?  If this is not a performance critical section of the code,
what is the point of this change?

This [PATCH 13/16] and also [PATCH 12/16] rewrite strings using qr// but
the patterns thus compiled are used exactly once before the control leaves
the scope of the variables, so...

It is a different story if the patch instead introduced module-level
global variables to hold a pre-compiled regexp objects, but that is not
what we are seeing here.
