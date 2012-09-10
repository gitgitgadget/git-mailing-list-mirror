From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Probable bug in file run-command.c function
 clear_child_for_cleanup
Date: Mon, 10 Sep 2012 13:00:35 -0700
Message-ID: <7v8vchodgc.fsf@alter.siamese.dyndns.org>
References: <504CAB66.1050003@optimisefitness.com>
 <20120910134406.GA7496@sigill.intra.peff.net>
 <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com>
 <20120910141027.GA8284@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	David Gould <david@optimisefitness.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:00:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAA3-0004ti-2E
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab2IJUAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:00:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab2IJUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:00:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6115181F8;
	Mon, 10 Sep 2012 16:00:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HPvVarQdgaYq51RCXsj/zFjoDe8=; b=Dd2VF6
	VRx+nSBpW/yKhOcIlqVoqrntP0fsaB1tIlSt6I2FGHNfycU5c+Pjcn2fhi+tjW5D
	3dWFIl3nuuFE2EZp87skUUXHhzy9WINs9M0e1BiRdGZB+n2urhtTMsLtCtkVMuK3
	VxVGIWdsQ+zbvXrBmNrvUdK9S0V4+pRCErYVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FDLKkjhIPpC4Y1A13twO/k9H8aehMw8z
	5vDl8A9fpQmeLUr15PMSjRQSPUKnysVB14uZkLwfgiNrsmg/I6wvvcNl7PV8krbn
	gxIrIPlAdiBvUwHQRMhbmAvlwSjrXtyu+GJdnFhqKY+5f9kJlhg4wXq+GpSzZeLq
	64JIGNm8Kbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E3FC81F7;
	Mon, 10 Sep 2012 16:00:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2A2681F4; Mon, 10 Sep 2012
 16:00:36 -0400 (EDT)
In-Reply-To: <20120910141027.GA8284@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 10:10:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FF531D4-FB82-11E1-94A9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205168>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 10, 2012 at 03:58:40PM +0200, Erik Faye-Lund wrote:
>
>> >> for (... {
>> >>       if (... {
>> >>               ...
>> >>       }
>> >>       last = &p->next;
>> >> }
>> [...]
>> I feel like bikeshedding a bit today!
>> 
>> I tend to either prefer either the latter or something like this:
>> 
>> while (p) {
>> 	...
>> 
>> 	last = p;
>> 	p = p->next;
>> }
>> 
>> because those approaches put all the iteration logic in the same
>> place. The in-body traversal approach is a bit more explicit about the
>> traversal details.
>
> Also fine by me.
>
>> And to conclude my bikeshedding for the day: Shouldn't "last" ideally
>> be called something like "prev" instead? It's the previously visited
>> element, not the last element in the list.
>
> It is the "last" element visited (just as "last week" is not the end of
> the world), but yes, it is ambiguous, and "prev" is not. Either is fine
> by me.

OK, so who's gonna do the honors?
