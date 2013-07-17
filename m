From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add the NO_SENTINEL build variable
Date: Wed, 17 Jul 2013 09:06:58 -0700
Message-ID: <7v38rd8925.fsf@alter.siamese.dyndns.org>
References: <51E4338E.4090003@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 18:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzUFz-0003jj-0S
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 18:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375Ab3GQQHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 12:07:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263Ab3GQQHC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 12:07:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 672C83178E;
	Wed, 17 Jul 2013 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kBCCtx+iipS959LcQqP/OkAv6FY=; b=xOPtco
	S2QKMFt5iSsKW62FqiqJZCV4f7hEp/bEFY9kCMHOzTFsWIkygWXldBMJxl/3emET
	IZelSt7L2rvkPIO2h61BFBGl9/9w2NaruXtudibJm8u0twaHA50AIypIT5pPKwEt
	W5VptJFKHAotb+nBjdWCe4GXbDYhYlygyF1zg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ba1i9NTkTHI2+aAQ8/Ej/gXnY8ZSachL
	VX1hBjIdNAdlCNK0lbzsidHbiff8IHGTMVNAIvkZ+lo+FhgJi3v/DOiUy7RosoIO
	5cfoohRaCj+Hslfx5N1mZmqy1el7yQ8Zt8sc0iKPe3puwB/Nh/SG7bU/Vb9ouBoq
	Cgqp3l8XN0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B7303178D;
	Wed, 17 Jul 2013 16:07:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEF7431785;
	Wed, 17 Jul 2013 16:06:59 +0000 (UTC)
In-Reply-To: <51E4338E.4090003@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 15 Jul 2013 18:38:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E957247C-EEFA-11E2-874A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230628>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9f1eaca..e846e01 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -300,6 +300,12 @@ extern char *gitbasename(char *);
>  #endif
>  #endif
>  
> +#if defined(__GNUC__) && !defined(NO_SENTINEL)
> +#define SENTINEL(n) __attribute__((sentinel(n)))
> +#else
> +#define SENTINEL(n)
> +#endif

Allowing callers to use __attribute__((sentinel(1)), while it may be
a good enhancement, does not belong to "some versions of GCC do not
know what to do with the sentinel attribute".  Making this change in
a separate patch on top would be cleaner.

Also do we know what version of GCC started supporting this
attribute?  http://gcc.gnu.org/gcc-4.0/changes.html mentions it in
"New Languages and Language specific improvements" section, but the
page also says "The latest release in the 4.0 release series is GCC
4.0.4", so it is not clear if 4.0 had it, or it was added somewhere
between 4.0 and 4.0.4 to me.
