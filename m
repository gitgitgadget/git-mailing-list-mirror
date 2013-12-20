From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option parsing
Date: Fri, 20 Dec 2013 13:31:37 -0800
Message-ID: <xmqq38lndxae.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<1387378437-20646-3-git-send-email-pclouds@gmail.com>
	<52B3E8D4.1030805@viscovery.net>
	<20131220070449.GA29717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 20 22:31:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu7fe-00020T-RP
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 22:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab3LTVbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 16:31:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730Ab3LTVbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 16:31:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB2E5B2FD;
	Fri, 20 Dec 2013 16:31:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ExLZaoNC9stzyJ+qxSK7GZ+8BN4=; b=l0fDTg
	Kh3/AtoA+q+XRPTy5K6T/yYCYQ11OKmzLLuZXXa3hoPyY9QPGtuLbD3+3chmjhUz
	HXdQlkHnDAQvCF4+V2g1FO/C5WvTi+bDXyGAQ1E6LvYzDuZ7LIVxyiIbgiGq9RGA
	gKb/deOLz2yM9MsLODdNO7t9wA/fxuUExrZ3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOT+aKEdcudXHnWy0KlEvfxugXDcVYIa
	F/YIjJQ+EialGDIh9qYvh8NeVSdpJRAh+NaclV25VlgSj8JwixVD04sQpFRu+IsR
	9qDxhb42sWS0K1ICh9bdjs44tC8Xpf6aR8fNNYBl4qVfJ7IdNRbebe1RTptS6t7I
	1H7ldRW2UCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C1535B2FA;
	Fri, 20 Dec 2013 16:31:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 669575B2F9;
	Fri, 20 Dec 2013 16:31:40 -0500 (EST)
In-Reply-To: <20131220070449.GA29717@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Dec 2013 02:04:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D1B6FB4-69BE-11E3-B01F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239582>

Jeff King <peff@peff.net> writes:

>   /* here we care if we saw the prefix, as above */
>   if (parse_prefix(foo, prefix, &the_rest))
>       ...
>
>   /*
>    * and here we do not care, and just want to optionally strip the
>    * prefix, and take the full value otherwise; we just have to ignore
>    * the return value in this case.
>    */
>   parse_prefix(foo, prefix, &foo);

Sounds fine.  I recall earlier somebody wanting to have a good name
for this thing, and I think foo_gently is *not* it (the name is
about adding a variant that does not die outright to foo that checks
and dies if condition is not right).  

	starts_with(foo, prefix);
        strip_prefix(foo, prefix, &foo);

perhaps?
