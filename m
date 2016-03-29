From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] MSVC: VS2013 comes with inttypes.h
Date: Tue, 29 Mar 2016 09:47:05 -0700
Message-ID: <xmqqegatz0xi.fsf@gitster.mtv.corp.google.com>
References: <56FAACD4.9080504@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>, blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 18:47:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akwnS-0008FA-7f
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 18:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586AbcC2QrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 12:47:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752704AbcC2QrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 12:47:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 488F249E7B;
	Tue, 29 Mar 2016 12:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uw+BZZSNaY7toTWq966K/Rk7HOU=; b=UfDUDr
	Vtgz/BjmiBYs2fwkEwqpOgzB8iW3jqSjFE8BfIXO6zBwrR7tEvNPiA8Z9aZCOyuj
	vD/xvyVPZGAs4kHtH/IZCAru+pXMKb1UhNSKMlGPIA/mxlJU0nR6oTPrrJrGFQ9o
	q/T3IhxdUvQuk160AR97poC3oWkYi7kQXnfiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNPLX07Zs5oCIDNFj3g1gLkC2eedfbbu
	mnHgjbbaE3dYy3nvr2TCIR8zWg3clrjohnfORgcsB7Lf+EY+LwHyvIPwUMNs9O8Y
	Kbgii76Vu8NltFA1WpeU+z6H8ArUP71CTdWBcLc68gV5tZDLxNgCdUDfSxI03hyh
	DzYT5eE2ft0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FCE249E7A;
	Tue, 29 Mar 2016 12:47:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A9C8C49E79;
	Tue, 29 Mar 2016 12:47:06 -0400 (EDT)
In-Reply-To: <56FAACD4.9080504@cs-ware.de> (Sven Strickroth's message of "Tue,
	29 Mar 2016 18:27:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF3CEF58-F5CD-11E5-A3A6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290146>

Sven Strickroth <sven@cs-ware.de> writes:

> Reduce the number of defines which need to be managed within vanilal git.

Hmph.

>
> Signed-off-by: Sven Strickroth <sven@cs-ware.de>
> ---

I am not qualified to judge the correctness of the assertions this
change makes:

 * MSVC at or newer than version 1800 have PRIuMAX and PRId64
 * MSVC at or newer than version 1800 have {UINT,INT}MAX_{MIN,MAX}

and will wait for Windows folks to Ack.

Thanks.

>  compat/mingw.h                  | 2 +-
>  compat/vcbuild/include/unistd.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 6b6d695..5d7f0dd 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -415,7 +415,7 @@ int mingw_offset_1st_component(const char *path);
>  extern void build_libgit_environment(void);
>  extern const char *program_data_config(void);
>  #define git_program_data_config program_data_config
> -#ifndef __MINGW64_VERSION_MAJOR
> +#if !defined(__MINGW64_VERSION_MAJOR) || !defined(_MSC_VER) || _MSC_VER < 1800
>  #define PRIuMAX "I64u"
>  #define PRId64 "I64d"
>  #else
> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
> index c65c2cd..b4b7b7c 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -45,11 +45,13 @@ typedef unsigned long long uintmax_t;
>  
>  typedef int64_t off64_t;
>  
> +#if !defined(_MSC_VER) || _MSC_VER < 1800
>  #define INTMAX_MIN  _I64_MIN
>  #define INTMAX_MAX  _I64_MAX
>  #define UINTMAX_MAX _UI64_MAX
>  
>  #define UINT32_MAX 0xffffffff  /* 4294967295U */
> +#endif
>  
>  #define STDIN_FILENO  0
>  #define STDOUT_FILENO 1
