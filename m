From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use macro HANDLER_WRAPPER in sigchain to wrap clean
 function of sigchain
Date: Tue, 13 Mar 2012 14:17:03 -0700
Message-ID: <7vlin4td4g.fsf@alter.siamese.dyndns.org>
References: <CAMocUqRsEvwnoV32Cr05dJeUj7iNDj1cLP5kAzgyMNEo1O0kCw@mail.gmail.com>
 <7vmx7kweus.fsf@alter.siamese.dyndns.org>
 <20120313205501.GB27436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCPXltbBsoQg==?= <xudifsd@gmail.com>,
	Git =?utf-8?B?6YKu5Lu25YiX6KGo?= <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 22:17:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Z5l-0002kk-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 22:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab2CMVRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 17:17:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab2CMVRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 17:17:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB3D69B9;
	Tue, 13 Mar 2012 17:17:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58lQzDJlnNM7KlW+712CDZeRRPY=; b=Zkb9SX
	8HkFU89uOgCFWONofVIpAjF6z0fZi0YdpBYfscvfUWFXfOd4NPVLvZuDcPU2g7VQ
	CzdZysgq7Vl0PDKJ7PAELv3402Lgwh/BVVTaTV07Yc4TsAMEZemojyuv74EVsRao
	caolFrAp556vYJdLhoevRTK8lKTCjD3zY0Za0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hv7tCndFUGknVv3SO90K1wrsFPufnvrb
	8U7Z0+WlDRfwdjuiDMCmSKDqkJQKRA8z8aUbi3vd7vmDFrQQqBEYcK1VZ62tSAIh
	I6jsvaGCbl1gyQ7JjSLsRgoj2zLqJGnXkfCd4cNtEomQ1mCRc1Ee6iw+OWTfxkzA
	mQqHodEUMEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CE069B8;
	Tue, 13 Mar 2012 17:17:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04E3869B6; Tue, 13 Mar 2012
 17:17:04 -0400 (EDT)
In-Reply-To: <20120313205501.GB27436@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Mar 2012 16:55:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2102096-6D51-11E1-8F96-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193069>

Jeff King <peff@peff.net> writes:

> So I don't like boilerplate or repetition, but this may be one of those
> times where it is simply more clear to just be verbose.

Yes, I agree with you 100% re: these particular repetitions.

>> *1* Yes, I know, this casts between a data pointer and a function pointer
>> that is not portable, but the purpose of this pseudo-code is primarily to
>> illustrate the high level view of the idea.  We would probably want to be
>> able to pass callback value to the clean_foo() function and at that point,
>> we would likely to be passing a pointer to a struct, and we could declare
>> the first element of such a struct is a pointer to a sigchain_fn, or
>> something.
>
> That is the correct way to do it, but where does the struct memory come
> from?

Probably somewhere near "struct sigchain_signal" are kept.
