From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am -3: allow nonstandard -p<num> option
Date: Tue, 28 Feb 2012 19:36:03 -0800
Message-ID: <7vvcmqwbto.fsf@alter.siamese.dyndns.org>
References: <1330471495-12013-1-git-send-email-gitster@pobox.com>
 <1330471495-12013-2-git-send-email-gitster@pobox.com>
 <20120229025842.GA3585@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 04:36:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2aKs-0004F3-2S
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 04:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671Ab2B2DgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 22:36:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192Ab2B2DgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 22:36:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE7FD6898;
	Tue, 28 Feb 2012 22:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qMvnLXFbgJH980kAokjXsUgC9lI=; b=c/nc9W
	ilGFsdYwkEWOo6eyIRB9p/j2B3NRPk0pFaK5Fz8iJt6wksbK+T5oiZ+zAmh8yOeM
	BqwnFIieGqWhkxChmUpzWZFuzt9FTsRsvyU0Qmr1UuZrQ+Q94weFSBVLgA+c4Q7E
	80WFmA/3Bu6JLzqgjso6iYnJ3dFvcp3pD6Gik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iPtngdDr9dNnMoKEQxnt2uehL3SAY6UP
	jRQhvGEyElgfmrL30GdY3pd2BGPp6kQUHzksF5Bj/ASU5MsF/AOFodxZ83zUWh7K
	J9azG9ImXwZuzLBttncf6RBODzyz2vGstvsdAzCFcUkrtt1oTaJgo4/rMCpJ/dNW
	YfBZEiCn7TU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B58BF6897;
	Tue, 28 Feb 2012 22:36:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A67C6896; Tue, 28 Feb 2012
 22:36:05 -0500 (EST)
In-Reply-To: <20120229025842.GA3585@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 28 Feb 2012 21:58:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 828BB534-6286-11E1-B11E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191804>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 28, 2012 at 03:24:54PM -0800, Junio C Hamano wrote:
>
>> When falling back to 3-way merge, we run "git apply" to synthesize the
>> fake ancestor tree by parsing the incoming patch, and another "git apply"
>> to apply the patch to the fake ancestor tree.  Both invocation need to
>> be aware of the custom -p<num> setting to parse patches that were prepared
>> with non-standard src/dst prefix.
>
> Makes sense. One question:
> ...
> $git_apply_opt can have other stuff in it, too (from my cursory reading,
> it looks like --whitespace, --directory, --exclude, -C, --reject,
> --ignore-whitespace, and --ignore-space-change).  Those options are now
> passed, too.
>
> Naively, I don't think it should be a problem. Many of them will do
> nothing (because the patch _should_ apply cleanly to the blobs it
> mentions). Some seem like an obvious improvement (e.g., "--directory"
> should be just as necessary as "-p", I would think). For something like
> "--whitespace=error", I would think we would have errored out already
> when we first tried to apply the patch. Or maybe not. I didn't test.

An honest answer is that I didn't think deeply if they matter ;-).

Certainly we would want to honor the original settings for whitespace
errors by propagating the option, so that we would reject or adjust when
synthesizing the fake ancestor tree the same way as we deal with them when
apply the patch for real.
