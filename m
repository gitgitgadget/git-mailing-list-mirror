From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 07:55:43 -0700
Message-ID: <7vtxnvwp3k.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <20130328140510.GB12898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 15:56:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEFT-00061v-GY
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 15:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192Ab3C1Ozq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 10:55:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386Ab3C1Ozp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 10:55:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5229AA78A;
	Thu, 28 Mar 2013 10:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DZC0i66ci4AHXL8DjVjOdMCNnmo=; b=rI1sw9
	ixUPUAtuQ5dKnu+WFxCbF1gjIok/zAA3dtWpx30hmI80Pz++ZwTV+JY5a2JqHbJp
	NZIItf8avubkv5iRWz+03q2W3pTV6aWZP/7swiy1u0YuGVIT+hxLkZXLw8QQrGT4
	9rwFrFhaBCxNl34b8EX0nJeNlrbAAAzOzFVkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b8jbnubeJXCkUf3KyvQv7KC2zPRP5wco
	lxsQcU/syp64L6CETzCx8S0+l7ndX+jmFVklkx6dXIMcFM4suE0BMRwmHIa2im+y
	brm+/IFFoHxeLw4dsJqgX+ZBZI8I/shf4RBIXVpmOyTefpsxDz1Jq0RZ7ckxXbYv
	K0Aw7ObP4j8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4685FA789;
	Thu, 28 Mar 2013 10:55:45 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFB4BA787; Thu, 28 Mar 2013
 10:55:44 -0400 (EDT)
In-Reply-To: <20130328140510.GB12898@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 28 Mar 2013 10:05:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9159DC50-97B7-11E2-98D8-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219403>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 28, 2013 at 02:04:27PM +0100, Michael Haggerty wrote:
>
>> $ git rev-parse --verify 1111111111111111111111111111111111111111
>> 1111111111111111111111111111111111111111
>> $ echo $?
>> 0
>>
>> [...]
>>
>> I believe that "git rev-parse --verify" is meant to verify that the
>> argument is an actual object, and that it should reject fictional SHA1s.
>>  (If not then the documentation should be clarified.)  The same problem
>> also exists in 1.8.2 but I haven't checked how much older it is.
>
> I think it is only about verifying the name of the object. I.e., that
> you can resolve the argument to an object. It has always behaved this
> way; I even just tested with git v0.99.

Correct.  It is about "is it well formed and something we can turn
into 20-byte object name?" and nothing more.  It certainly does not
mean "do we have it?", as the function needs to be able to validate
something we do not yet have.
