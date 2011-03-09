From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Wed, 09 Mar 2011 13:06:17 -0800
Message-ID: <7v39mw9f7a.fsf@alter.siamese.dyndns.org>
References: <20110305195020.GA3089@sigill.intra.peff.net>
 <20110305200010.GB32095@sigill.intra.peff.net>
 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
 <20110307161758.GB11934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:06:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQac-0002YL-0z
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597Ab1CIVGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:06:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1CIVGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:06:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB28A42CE;
	Wed,  9 Mar 2011 16:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eGhIFuQ70uMI0AOZRFH1R381QNg=; b=Pyo5o4
	Uxn6dNK0lvUV9VzIx41yhmnKg32xKaqzBUfWphhVLRcJFL1cVJq0IwE27MgGNPnZ
	A8HUBob3uH9vfed2qhw6eHiJTrXVdeXb38Q0PXNNvVEnz5+Uowa+wMJLYpdxz+U5
	dvW7Ot3CVLDVnG1DbIzb7r5lWWZJRpXh/ZxUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RF8keFufa3tFfHFrYFWcDBt4ZyVrGtIQ
	k+omZqGQ2cvGgC3opfEzlXZzTwsij7+YZS1T3lEf8gctApCtz0/1BGAHptc61EAV
	hGWhHhdIcW3PxhUtm6rf4neqDkIettjiKEg4ouGWzKGKGIGwTATejaEEoRx+21m8
	Toy9vOdfys8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA14642CD;
	Wed,  9 Mar 2011 16:07:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 929C442CC; Wed,  9 Mar 2011
 16:07:47 -0500 (EST)
In-Reply-To: <20110307161758.GB11934@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 Mar 2011 11:17:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B663BE6-4A91-11E0-8D2D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168760>

Jeff King <peff@peff.net> writes:

> So I think the whole thing needs to be factored into two phases: a
> parsing phase where we build some internal parse tree, and then an
> expansion phase where we walk the parse tree for each commit (or ref, or
> whatever is being expanded).

You are right.  I think for-each-ref expander has an attempt for
optimization of this exact kind.

>> Point is: we're going to keep having more and more format options,
>> I think that's a given. At some point, these short mnemonics will just
>> stop making sense, and it makes sense to have an escape plan when
>> that happens.
>
> Agreed. And I think it is possible to do it in a backwards-compatible
> way; support %(longname:options) for everything, and keep short-hands
> like %h and %ad for existing elements without options.

Yes, I think %( is not taken in the pretty-format language, so we should
be able to do this.

I wanted to take your earlier "'%ad' or '%ad(format)'" patch but refrained
from doing so.  The above line of reasoning is much better for the long
term health of the project.
