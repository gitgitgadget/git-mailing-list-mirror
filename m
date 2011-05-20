From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] bisect: refactor sha1_array into a generic sha1 list
Date: Fri, 20 May 2011 10:14:12 -0700
Message-ID: <7vy6212t23.fsf@alter.siamese.dyndns.org>
References: <20110519213231.GA29702@sigill.intra.peff.net>
 <20110519213433.GB29793@sigill.intra.peff.net>
 <BANLkTikYih5hOU=_Q9N_b8VZ_KJeb8zePg@mail.gmail.com>
 <20110520074714.GC3663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 19:14:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNTHP-0003ip-IV
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 19:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089Ab1ETROW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 13:14:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab1ETROV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 13:14:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6082054DC;
	Fri, 20 May 2011 13:16:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pUnTqXNRDe+V7pQnHQdiBTajmiE=; b=i3GWCf
	S0wR6HwN4czSlsBtfYtXdEQMrNMll+XLrfUlcT3gfmHLmVBmwC6jgMnXMUUo4wPp
	RTJrScUAXbUcSfxRefFX5Dg5w64KNwWiwHD9BXpj8CrW1UoGWJ3URH10T4CsDP6T
	QyK1wtaB24QEAkctfR7Hmx3YLAthgjx+oFqUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9KhAVGDSdoBJLoDMQBaPOtuPfvkYoJn
	jZ+4gkzawPSjauUnO2c4EUE7oTMx2yK6mckrOGCfP3a8yNoLlAYUZv0cPivwfCJH
	/RdxTGr8L/tPqNC+DumTnWNzSBexlPKym6FmdQvOS8gJUcRLwtpSHsrjUznkbqfh
	xk6s+ZZ+35E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2ECB954DB;
	Fri, 20 May 2011 13:16:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F316554DA; Fri, 20 May 2011
 13:16:21 -0400 (EDT)
In-Reply-To: <20110520074714.GC3663@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 20 May 2011 03:47:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4B0673A-8304-11E0-82F1-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174068>

Jeff King <peff@peff.net> writes:

> Yeah, they probably should both be unsigned, and the sorted flag should
> be a bit-field (not that it saves any space here, but it makes its purpose
> more clear).
>
> Junio, do you mind squashing this into patch 2/3?

I actually do ;-) If you grep for ALLOC_GROW and look at the structures
they touch, nr/alloc pairs that are integers are the majority in our
codebase, and I do not see much bikeshedding value in adding more unsigned
ones to the mix.

> diff --git a/sha1-array.h b/sha1-array.h
> index 15d3b6b..b602303 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -3,9 +3,9 @@
>  
>  struct sha1_array {
>  	unsigned char (*sha1)[20];
> -	int nr;
> -	int alloc;
> -	int sorted;
> +	unsigned nr;
> +	unsigned alloc;
> +	unsigned sorted:1;
>  };
>  
>  #define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
>
> -Peff
