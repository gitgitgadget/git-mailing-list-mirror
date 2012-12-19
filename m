From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 13:30:57 -0800
Message-ID: <7vfw3191bi.fsf@alter.siamese.dyndns.org>
References: <20121219203449.GA10001@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:31:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlREa-0002JW-Ld
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab2LSVbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 16:31:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab2LSVbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 16:31:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE63A4A3;
	Wed, 19 Dec 2012 16:31:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Yuy3Ue3LMoxdFINhLDIHvbiDXs=; b=leDIkP
	DSTB5kjsnCkUAbEdjQIv2kvOnjPtMSLIhEi0KixIiljEFInjvAb/kxoxOiyL/37f
	2aj7zQDj0ugJF/BpGNZp2NR26fKB3nCyX402r3F4zE5FiMIMNZebXnkllp47l8Ro
	tT1BmwU0H+cXGKzV3NsS4j/ENNTnLm3BGsbmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWRUi4muEl0+gtlnTsjOlxGz6WcX19Q6
	QLE9TQbp9EjciZvZaSQneZsR/5dTMwgUEJltu80KkNuG+3faj8mhFZH9MZhHZzyF
	a55u7JsBgaPfU6buYVpmzKQ+nPYpVjVXFGua5RNmrSulZ6rqpkpciqV/RwjJeFhv
	8GvCQlH7v74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EC2CA4A2;
	Wed, 19 Dec 2012 16:31:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FA6AA4A0; Wed, 19 Dec 2012
 16:30:59 -0500 (EST)
In-Reply-To: <20121219203449.GA10001@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 15:34:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 618A3E5C-4A23-11E2-AB66-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211849>

Jeff King <peff@peff.net> writes:

> diff --git a/dir.c b/dir.c
> index 5a83aa7..6e81d4f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -126,7 +126,7 @@ static int match_one(const char *match, const char *name, int namelen)
>  		for (;;) {
>  			unsigned char c1 = tolower(*match);
>  			unsigned char c2 = tolower(*name);
> -			if (c1 == '\0' || is_glob_special(c1))
> +			if (c1 == '\0' || (core_pathspec_glob && is_glob_special(c1)))
>  				break;
>  			if (c1 != c2)
>  				return 0;

I think you can also do the same to the common_prefix(); we check
for common leading directory prefix but punt upon seeing a directory
component that has a glob character, and under the "literal" mode,
it is not a special character.
