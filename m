From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 15:48:45 -0700
Message-ID: <xmqq7g5eoiia.fsf@gitster.dls.corp.google.com>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
	<1400634170-18266-2-git-send-email-jmmahler@gmail.com>
	<xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
	<20140521215059.GB13956@hudson.localdomain>
	<xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
	<20140521220250.GA11970@sigill.intra.peff.net>
	<xmqqfvk2ok10.fsf@gitster.dls.corp.google.com>
	<20140521222701.GA24537@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:48:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnFJh-00031k-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbaEUWsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:48:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52783 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbaEUWsv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:48:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A50DD1A05B;
	Wed, 21 May 2014 18:48:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=thyiqDe22w2vmq3yTENOJzbQ+Rc=; b=WWezjn
	nO3rsBeZltCOpXdnx9FIt5guU14duHQMz+W1o3ftqvU4SJ06YZyIF3Iy9MB3yJaS
	1L/KxNNT97mbZ/+vn8/Z2U+EnoTUk9WjscbZmzk4gEB+mMKUv1F2DbuA88uv80wz
	sU3YdZ7aeSTJ+KeZQ0PPyJxQZAAvHnXKB6ufs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQu34BvFFY4XBtAKKI8e+rdXt8hjI5li
	kxkBIZJ2u9L2ZQW0MztI4kDNgtXeWnTfhIPsV+bMSMIax9dtYZUZh13fwUxLIoc1
	JBw33Tsf77TXZqP/aHceiEOQ5Vl2wvE3NEu0wzwbkUKX6rPpenpGXtyTREuh5SeY
	dAAH0S1qLKA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CC6F1A05A;
	Wed, 21 May 2014 18:48:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6912F1A058;
	Wed, 21 May 2014 18:48:47 -0400 (EDT)
In-Reply-To: <20140521222701.GA24537@hudson.localdomain> (Jeremiah Mahler's
	message of "Wed, 21 May 2014 15:27:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11CF58C0-E13A-11E3-BD34-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249856>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> On Wed, May 21, 2014 at 03:15:55PM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> Yeah, placing it in its own setup may be the best.  There are quite
>> a many set-ups outside the tests in this script from the olden days,
>> so I am OK if left it as-is and have a separate clean-up patch after
>> this topic settles.  I am also OK to add a new one "the new right way"
>> so that a later clean-up patch does not have to change what is added
>> in this step.
>
> I like the idea of limiting the scope of this data so it couldn't
> inadvertently impact later tests.
>
> But placing the same data inside multiple test cases creates duplication.
>
> Is there a way to define data once for a limited set of tests?

That is what Jeff ment by "used across many tests. ... it could go
in its own setup".

In other words,

	test_expect_success 'prepare mail-signature input' '
        	cat >mail-signature <<-\EOF
                ...
                EOF
	'

	test_expect_success 'one test that uses mail-signature' '
        	use mail-signature &&
                test the output
	'

	test_expect_success 'another test that uses mail-signature' '
        	use mail-signature in a different way &&
                test the output
	'
