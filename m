From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Wed, 05 Dec 2012 08:12:21 -0800
Message-ID: <7vehj4lbq2.fsf@alter.siamese.dyndns.org>
References: <201212021417.25525.tboegi@web.de>
 <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
 <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com>
 <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
 <CACsJy8BtX9fMkGDoVGKzgz7SSinbt0561B1ZKHu6fs+n8ewKGg@mail.gmail.com>
 <20121205073055.GA5776@sigill.intra.peff.net>
 <20121205075401.GB5776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6ge?= =?utf-8?Q?rshausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:12:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgHae-0004lU-O3
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 17:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab2LEQM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 11:12:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab2LEQMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 11:12:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E231F9C93;
	Wed,  5 Dec 2012 11:12:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQi5eyWzdnk44yUeUEJbTGjIlhg=; b=MN/91R
	kHscxbLCWXKKxkS+ILJQevLx00DaQcJRSCPpzMeq4ej9Q2ldi9JtbAJaIdRUI7bX
	66hGHjCNVfk6r5mnOJAp8Ls/vMI1TnGiG78vvbl8cC2IcnoxwuiMaYriC3Ru0ROF
	9gLXt9j021HBC+rkVW1ChYryM/wbm12xdkDj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jH1F0RV2XVLNNdwaLx2ortmBvVM1fBe0
	HhaIdR5hjAtt3+EBo6XJFgeVnRVLSRktORgMsSY6af/dqjCu8UYakhGqVfWndT5D
	KnCf/JMSb68ZngKjShV1gVoTkPejICyk7GUZGYnXky7PpsmM9xhxxKlgSPs1RjBR
	1NmjbGUWI3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF0239C92;
	Wed,  5 Dec 2012 11:12:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 431A49C85; Wed,  5 Dec 2012
 11:12:23 -0500 (EST)
In-Reply-To: <20121205075401.GB5776@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 5 Dec 2012 02:54:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D96199A-3EF6-11E2-AF42-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211129>

Jeff King <peff@peff.net> writes:

> You would want a "check shell script portability" script, and you would
> probably want to run it:
>
>   - on the regular built scripts; possibly during build time (I have done
>     this before with "perl -c" for perl scripts and it is reasonably
>     successful). Or in a test script, as added in his patch (though I
>     note it does not seem to pass as posted, getting confused by trying
>     to grep "git-gui").
>
>   - on the test scripts themselves via test-lint
>
> I think as long as such a script erred on the side of false negatives,
> it would be OK (because false positives are a giant headache, and
> ultimately the real test is people exercising the code itself on their
> shells; this is just an early check to help contributors who do not have
> such shells).

Yeah, you have a good point that we should cover the scripts outside tests
and test-lint is not a good match for them.
