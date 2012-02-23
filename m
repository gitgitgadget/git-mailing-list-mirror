From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/5] refs: add match_pattern()
Date: Wed, 22 Feb 2012 16:17:22 -0800
Message-ID: <7v62ey8ktp.fsf@alter.siamese.dyndns.org>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-2-git-send-email-tmgrennan@gmail.com>
 <7vobsrbcny.fsf@alter.siamese.dyndns.org>
 <20120222234733.GD2410@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net, jasampler@gmail.com, pclouds@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 01:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0MNG-0003WI-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 01:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab2BWARZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 19:17:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab2BWARY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 19:17:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 239787ECB;
	Wed, 22 Feb 2012 19:17:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NAYl6uCssxIopnjub/xsgh/9tJc=; b=PQ7HoZ
	W0updTAYZax6rVsembfTMsluSZlZtn862ZK/oulM1J6LNs3EXPuyRKobf8zSlabc
	s59O51pR+RRAnVsIAxdtcy/UERk6vu1ef8Ee+57Cl7thqO+jrB5rJBqWAB92vYc1
	PAW9zWV6BUANilkODTa+6VaOCdN3psq0KY/JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mDEe0+NjHscSAW5GKBYkQpM/EvqTKBaz
	mUFdEUNxwctMHJzg6dPJw0UBYCxST18nQ+dyztheZgJxBKN2apnpOmjyCIZFNaXf
	KYiW1qHkcgvTDMDy5indgSVZGBdIJXLdzWV0FUDFLXRmejIBH9HOZOLjPnGZWt1p
	BjBJD+peW1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BC827EC9;
	Wed, 22 Feb 2012 19:17:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0EFE7EBB; Wed, 22 Feb 2012
 19:17:23 -0500 (EST)
In-Reply-To: <20120222234733.GD2410@tgrennan-laptop> (Tom Grennan's message
 of "Wed, 22 Feb 2012 15:47:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C23B13E6-5DB3-11E1-94A5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191313>

Tom Grennan <tmgrennan@gmail.com> writes:

> Yes, I tried to minimize change but the conversion of argv's to
> string_list's won't add that much.

How about _not_ using string_list?  After all, string_list is not just a
collection of strings, but is a table to hold strings with attributes.  I
thought argv_array is more appropriate abstraction for the purpose of your
patch.
>>	ref_match_pattern("refs/heads/master",
>>        		  ["maste?", NULL],
>>                          ["refs/heads/", NULL],
>>                          (REF_MATCH_FNM_PATH|REF_MATCH_LEADING));
>>
>>Note that the above "ref_match_pattern()" gives the same "flags" for the
>>call to match_one() for elements in both positive and negative array and
>>it is very deliberate.  See review comment to [3/5] for the reasoning.
>
> OK, I think that I understand, but please confirm, you'd expect no output in
> the above example, right?

"maste?" would match with FNM_PATHNAME with "refs/heads/master" but
the negative "refs/heads/" matches with it, so yeah, I expect that the
function would return false.
