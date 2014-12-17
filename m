From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: suppress unavoidable Apple-specific deprecation warnings
Date: Wed, 17 Dec 2014 14:33:46 -0800
Message-ID: <xmqqmw6l9a9h.fsf@gitster.dls.corp.google.com>
References: <1418771976-15060-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	David Aguilar <davvid@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:33:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1NAH-0007BW-FB
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 23:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaLQWdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 17:33:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750905AbaLQWds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 17:33:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3BE128C55;
	Wed, 17 Dec 2014 17:33:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJg8mGWlGRaZmetfiGmux8lPuWw=; b=WStRwg
	f6z0lvGaFY4Q9KP1rLDwUxq0kyav3HQgA8FHbHQFoGFgfd72hiZnhrQU/QXppG3H
	oXkXNVpftp3Kup0ZUkZ0vtY3LvfVdG3HyhPRehAxBKDXUJVyGOZ23Mjuk0dVemnS
	CYJD41yhl7aZuE+vLPeprUj84z3EW6ocXDEk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GmEXyMxAkaup8xrBLeYY2lKVolzUU7AN
	DTGKTpMkkgHaFvsu4J0IQMITqp1/UW1dZLv/iGg7k0i+FlynW12C/573i7wZ5Liq
	llK1hqCsIvrRs76rAfgfaSku/lzSXZs28Mi2gd6kq8cmJf84VEW+qHaXqFmdRojv
	0mA6jYuu/8U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E878C28C54;
	Wed, 17 Dec 2014 17:33:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69FCA28C53;
	Wed, 17 Dec 2014 17:33:49 -0500 (EST)
In-Reply-To: <1418771976-15060-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 16 Dec 2014 18:19:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C54FB172-863C-11E4-9A87-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261502>

Eric Sunshine <sunshine@sunshineco.com> writes:

> These Apple-specific warnings are pure noise: they don't tell us
> anything useful and we have no control over them, nor is Apple likely to
> provide replacements any time soon. Such noise may obscure other
> legitimate warnings, therefore silence them.

Sad but it appears to me that it is the best we could do...

Will queue.  Thanks.

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> Related discussion:
> http://thread.gmane.org/gmane.comp.version-control.git/260463/
>
>  git-compat-util.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 400e921..433b8f2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -211,8 +211,12 @@ extern char *gitbasename(char *);
>  #endif
>  
>  #ifndef NO_OPENSSL
> +#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
> +#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
>  #include <openssl/ssl.h>
>  #include <openssl/err.h>
> +#undef MAC_OS_X_VERSION_MIN_REQUIRED
> +#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
>  #endif
>  
>  /* On most systems <netdb.h> would have given us this, but
