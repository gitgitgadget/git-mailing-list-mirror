From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Fix a race condition when reading loose refs
Date: Wed, 19 Jun 2013 10:24:38 -0700
Message-ID: <7vd2ri10a1.fsf@alter.siamese.dyndns.org>
References: <1371623788-7227-1-git-send-email-mhagger@alum.mit.edu>
	<20130619160150.GA19139@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 19:24:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpM7h-0006KJ-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 19:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab3FSRYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 13:24:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab3FSRYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 13:24:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F5229A4D;
	Wed, 19 Jun 2013 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+6yUCcujfjrXwI43R5tr9ooKQHs=; b=gk7eqE
	33xm7H1LALVeCnfV3dqtRibEp8uXKP386xWALwcdDDN5bfMQflQqwZ+o2dvQPzhu
	XL63aF9bQW4KygyOcDzZgSvsMZ9num9E4E8yOtRe2/k0VzTEWzL3fsxDH61EyE/L
	xPGACGfhcCh2NJH+Pc+aI5+VoI7g3QCPP7Sj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXa0JHJFSUHdHkBCxxy/oBde0IeejTb6
	K3BaBdKU4ovvjJuWosdiSBxRvdlX//vMZeQCl5XB25xub3RcgSqBv3iP7pi6etmn
	1znk2THQa2wA4N6hozyE48tXyFnFKKTfcM7yNz07yul9GwvrNDbp+pjvG/7QZQf4
	xZq1BNaHbLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C96829A4C;
	Wed, 19 Jun 2013 17:24:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ED3C29A47;
	Wed, 19 Jun 2013 17:24:39 +0000 (UTC)
In-Reply-To: <20130619160150.GA19139@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 19 Jun 2013 12:01:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F27C02C-D905-11E2-85AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228404>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 19, 2013 at 08:36:25AM +0200, Michael Haggerty wrote:
>
>> I took Peff's suggestion to use gotos rather than an infinite loop in
>> the last patch, which means that there is no need for the old patch
>> 03/04.
>
> Thanks, this version looks good to me.
>
> I'm sure the Pascal programmers of the world collectively sighed in
> disgust at a code review requesting a for loop turn into a goto, but I
> think it is more readable than the first version. :)
>
> -Peff

Thanks, both.  Essentially the first two are the same from the
previous round, and the third one gives us "oops, unexpected
state---let's retry" in a more straight-forward way.

Looks very sensible; will queue.
