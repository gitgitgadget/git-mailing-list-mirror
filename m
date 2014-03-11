From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: link with -liconv for locale_charset()
Date: Tue, 11 Mar 2014 13:35:41 -0700
Message-ID: <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
References: <20140311183529.GA73693@hades.panopticon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, wxs@FreeBSD.org,
	Dmitry Marakasov <amdmi3@amdmi3.ru>
To: =?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTP0-0007UO-Ts
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbaCKUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 16:35:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35205 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbaCKUft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:35:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91C2F70181;
	Tue, 11 Mar 2014 16:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KOc9Sh9Dr2UTUhhEk0n2Ywvwt/0=; b=oz/26X
	U6XPuKFQYtc7HGPYVOZEiy1BeVh6ZG8J2DoGm3jSK9tXIznfgsFj1UG0GpZ/XEek
	fweivLprAQqEtcgUi8+Z6f0Ou6JoJ+BF2lgarwJhqUDV2Y6t5GZ4/I9E44bree59
	f2rwkHAQ0CnUpLXOenQ6guuCX7diZmXYGfISo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IiVlmkojyf6MtiL0g3a2YtAQkDP6SpQY
	7SDcPquydcqlz1UwPJH3/tsf2rfgROgVCyFmAd+mlrFEfqJ4eViCisWKl6OEJ/rc
	HK3miR3eL/zqDO+HpxH5AKH184/U/7r13qY5TyNv+BoN3U2+L4wsW90XAwDY+35N
	zclpWxMVTbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B6DE7017D;
	Tue, 11 Mar 2014 16:35:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA93E70179;
	Tue, 11 Mar 2014 16:35:47 -0400 (EDT)
In-Reply-To: <20140311183529.GA73693@hades.panopticon> (Dmitry Marakasov's
	message of "Tue, 11 Mar 2014 22:35:29 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BA3A962A-A95C-11E3-BE25-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243895>

Dmitry Marakasov <amdmi3@amdmi3.ru> writes:

> On e.g. FreeBSD 10.x, the following situation is common:
> - there's iconv implementation in libc, which has no locale_charset()
>   function
> - there's GNU libiconv installed from Ports Collection
>
> Git build process
> - detects that iconv is in libc and thus -liconv is not needed for it
> - detects locale_charset in -liconv, but for some reason doesn't add it
>   to CHARSET_LIB (as it would do with -lcharset if locale_charset() was
>   found there instead of -liconv)
> - git doesn't build due to unresolved external locale_charset()
>
> Fix this by adding -liconv to CHARSET_LIB if locale_charset() is
> detected in this library.
>
> Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
> ---

Looks sensible; Dilyan, any comments?

>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git configure.ac configure.ac
> index 2f43393..3f5c644 100644
> --- configure.ac
> +++ configure.ac
> @@ -890,7 +890,7 @@ GIT_CONF_SUBST([HAVE_STRINGS_H])
>  # and libcharset does
>  CHARSET_LIB=
>  AC_CHECK_LIB([iconv], [locale_charset],
> -       [],
> +       [CHARSET_LIB=-liconv],
>         [AC_CHECK_LIB([charset], [locale_charset],
>                       [CHARSET_LIB=-lcharset])])
>  GIT_CONF_SUBST([CHARSET_LIB])
