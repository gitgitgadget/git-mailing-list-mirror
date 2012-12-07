From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sh-setup: work around "unset IFS" bug in some shells
Date: Fri, 07 Dec 2012 14:58:05 -0800
Message-ID: <7v624dfp1e.fsf@alter.siamese.dyndns.org>
References: <50C22B15.1030607@xiplink.com>
 <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com>
 <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
 <7vsj7hfw6q.fsf@alter.siamese.dyndns.org> <50C25539.9010206@xiplink.com>
 <7vobi5fu3c.fsf@alter.siamese.dyndns.org>
 <7va9tpfq46.fsf_-_@alter.siamese.dyndns.org> <m2fw3h8oja.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:58:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th6sE-0006is-E3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 23:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab2LGW6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 17:58:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab2LGW6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 17:58:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DF799341;
	Fri,  7 Dec 2012 17:58:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TK/cxSSs0zgLgW3wDgCaRTxzuSA=; b=YBuInw
	4MRvslLAadGtdZwd7IofnaX/IxOFN+QuAOaI+wCbd2RFG3raMF1k6nkZ/GuzfW9p
	hjjQmSh/t8pdtPrGhg/1lW8zUWxHBWcHGNc5pbj5IDQCMZ4T73fUrDkvBsHLfg6f
	ExX6XFPqlWRoFJVpKVODiCjJjxe6El6r62geE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VbnLyvqwIAgUeYL1b0gfyLjPi5NY3UB+
	zxvKCCCG6P31cZ0n7C7kLGq3gnIQHK/5SOMR0cfM6N1U4yaMmcUGHoX68Kt8joTH
	8E21LGcsoW1l1EemznIyRI9EK8LWb+NVv1eGZMIMY81a/PeEfmZYNpTYphjtHpw8
	g+hoR1xhFxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B34F9340;
	Fri,  7 Dec 2012 17:58:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 727BF933D; Fri,  7 Dec 2012
 17:58:07 -0500 (EST)
In-Reply-To: <m2fw3h8oja.fsf@igel.home> (Andreas Schwab's message of "Fri, 07
 Dec 2012 23:50:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90AEBACA-40C1-11E2-8C08-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211203>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +# Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
>> +# do not equate an unset IFS with IFS with the default, so here is
>> +# an explicit SP HT LF.
>> +IFS=' 	
>> +'
>
> Trailing whitespace can easily get lost

The comment above the assingment spell the character names out for
that exact reason.  Honestly, I think

> IFS=' ''	''
> '

is a lot harder to read.  If we were writing in bash, we would
probably use $' \t\n' but because we aren't, the best you can do
with your approach is what you wrote, but it would make the reader
wonder what these empty '' are there for and how many spaces are in
between the ''<string here>'' pair.

In other words, I agree with your concerns, but I do not think your
rewrite helps very much.
