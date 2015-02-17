From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Tue, 17 Feb 2015 08:03:00 -0800
Message-ID: <xmqq1tlo4jbf.fsf@gitster.dls.corp.google.com>
References: <20141203050217.GJ6527@google.com>
	<20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141204030133.GA16345@google.com>
	<xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
	<20141204234147.GF16345@google.com> <20141204234432.GA29953@peff.net>
	<CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
	<20141205000128.GA30048@peff.net>
	<xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
	<20141207100755.GB22230@peff.net>
	<xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
	<xmqqd25epw24.fsf@gitster.dls.corp.google.com>
	<54E3632F.20907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:03:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNkcB-0002Wo-AX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 17:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbbBQQDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 11:03:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbbBQQDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 11:03:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1EF0374F5;
	Tue, 17 Feb 2015 11:03:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5yeHCMCr+hMr/i0h2VEIh9Jqlz8=; b=RHITbz
	+T0rGjaeLJfqgXPF/lVQCOk/NOZYzw2LdF9rgN4Nd+I1JiWI1Qk7g4thR5LjxKyd
	pLHWKNHo3BtgLNO/e3Ed8mIbs6Ik729UQcIj+GUJHLdA6Iae7L8K/rfAVuOFZX4D
	2UUHy9ssjHP0lCHiyFMQxFW0EYirUfPjpbJQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MK7xF0vKhe0l4pH6suj6t4f6U5rRadFs
	PJzIBTavDPM1YnuLJmGtFdRlrGFYHNVb9EKKlqitdq0aP0M973H9tvu4uyIlQu+3
	Cr4o/QqhtP+asVv/rG0urbp/cXApNOqxe0tLy0EG+a3/LXHsGTmY8gwHphpd7wKm
	5ZCuMvDESsM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C82DB374F4;
	Tue, 17 Feb 2015 11:03:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DA16374F3;
	Tue, 17 Feb 2015 11:03:02 -0500 (EST)
In-Reply-To: <54E3632F.20907@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 17 Feb 2015 16:50:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 733D7CB8-B6BE-11E4-937C-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263950>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> I think we all agree that the early part of the new documentation
>> text is good, but the last section that proposes to store more
>> detailed errors in caller supplied strbuf in textual form was
>> controversial (and I have not convinced myself it is a good idea
>> yet).
>> 
>> I could chuck the last section and then start merging the remainder
>> to 'next' to salvage the "obviously good bits".  Or do people want
>> to hash its last section a bit more?
>
> Whether or not we decide on a different error-handling convention in the
> future, it is a fact of life that a good bit of code already uses the
> "strbuf" convention documented by Jonathan's patch. So I think it is OK
> to merge it as is. If we change the preferred convention in the future,
> one part of the change will be to update this file.

I wasn't sure about "a good bit of code already", but that settles
it.  Let's take it as-is and see how the code evolves.

Thanks.
