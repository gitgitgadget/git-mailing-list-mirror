From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cleanly redefine (v)snprintf when needed.
Date: Fri, 31 Jan 2014 09:28:50 -0800
Message-ID: <xmqqy51wgiwd.fsf@gitster.dls.corp.google.com>
References: <1391149512-8705-1-git-send-email-tsunanet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 31 18:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Hti-0003be-PF
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbaAaR2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 12:28:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbaAaR2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 12:28:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9117666A03;
	Fri, 31 Jan 2014 12:28:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JBly45NL7nqF2C/K9sj7SfV/x00=; b=UxTX27
	1xCimaWJkOLh8vBhm5ghJAbd/45c343UqkRwZgXgg+K9bk8aLuBDBM3eRk3xPOLc
	+2wkgMqZHSYNuVw8PXGRS3F5/BaJkRd4HuyySIjcH06+ner9/Vdnm0KRhwTYl4+g
	ElHGKnLLQdiMK2sUSo2bzjM+c3YjEWjbpCAio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P0Fe8Yih7hXthcOcEcvldRS/8Lo7JSkT
	FlS+AMiNJVMa6LMO0+WlG/BdrhrAk6VzGoTzIXvoVXhFxUQi+9sTr8kb7EYoMCQK
	raxNKDyq7jyIA7Xm4OlpoGCpN1rgDin1NkaGr97RJ5A6k5pSakUmQgeQKYuNhdZ5
	B78OtFv/kFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7479D66A00;
	Fri, 31 Jan 2014 12:28:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97CED669FE;
	Fri, 31 Jan 2014 12:28:52 -0500 (EST)
In-Reply-To: <1391149512-8705-1-git-send-email-tsunanet@gmail.com> (Benoit
	Sigoure's message of "Thu, 30 Jan 2014 22:25:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 275F24DE-8A9D-11E3-9400-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241308>

Benoit Sigoure <tsunanet@gmail.com> writes:

> When we detect that vsnprintf / snprintf are broken, we #define them to
> an alternative implementation.  On OS X, stdio.h already #define's them,
> which causes a warning to be issued at the point we re-define them in
> `git-compat-util.h'.
> ---

Makes perfect sense.  Please sign-off your patch (see
Documentation/SubmittingPatches).

Thanks.

>  git-compat-util.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cbd86c3..614a5e9 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -480,9 +480,15 @@ extern FILE *git_fopen(const char*, const char*);
>  #endif
>  
>  #ifdef SNPRINTF_RETURNS_BOGUS
> +#ifdef snprintf
> +#undef snprintf
> +#endif
>  #define snprintf git_snprintf
>  extern int git_snprintf(char *str, size_t maxsize,
>  			const char *format, ...);
> +#ifdef vsnprintf
> +#undef vsnprintf
> +#endif
>  #define vsnprintf git_vsnprintf
>  extern int git_vsnprintf(char *str, size_t maxsize,
>  			 const char *format, va_list ap);
