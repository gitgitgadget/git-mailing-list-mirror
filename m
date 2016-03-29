From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need SNPRINTF_SIZE_CORR any more
Date: Tue, 29 Mar 2016 09:43:53 -0700
Message-ID: <xmqqio05z12u.fsf@gitster.mtv.corp.google.com>
References: <56FAAC78.2040304@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>, blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 18:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akwkM-0006rY-9I
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 18:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbcC2Qn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 12:43:57 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932182AbcC2Qn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 12:43:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9154249D92;
	Tue, 29 Mar 2016 12:43:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oy20bG98/dSMuAUfVIJVF+0gzJg=; b=deZV10
	mC8drraq81F1fEC2JrwP/s6hOXzqtClU5w1qVrZ2uhGzDb9HcpNU0Vm2uw6LYefX
	jJs63psp+pHdqVro+lxrnSopWiF/30GA8IMzyEF+GhCJSQ3/J3q13ItDBQnGop21
	N/PJK1kIu0XS9kckdeZHZpcGYoEuH6sY4wyr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GC3HTaUxnxKZXK26R5sAcLUvID4vVQWH
	6GgYR+8CFlBIqgRqEi2zfVd7RvZao55j7CEuF9UMgw2EPt0iPGlft0wDFEeT/j+m
	8CslbHy/1ZeNtNiX8vv1yzkeqHqQ389J+l6wLyO2BZ/uAmjQx4r3RVIM8q0HLaHr
	ohQZE5ynFTo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8078B49D91;
	Tue, 29 Mar 2016 12:43:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C089949D90;
	Tue, 29 Mar 2016 12:43:54 -0400 (EDT)
In-Reply-To: <56FAAC78.2040304@cs-ware.de> (Sven Strickroth's message of "Tue,
	29 Mar 2016 18:25:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6CDACA52-F5CD-11E5-B94C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290145>

Sven Strickroth <sven@cs-ware.de> writes:

> In MSVC2015 the behavior of vsnprintf was changed.
> W/o this fix there is one character missing at the end.
>
> Signed-off-by: Sven Strickroth <sven@cs-ware.de>
> ---

Thanks.

I am not qualified to judge the correctness of the assertion that
MSVC at or more recent than version 1900 does not need the
correction and will wait for Windows folks to Ack.

Thanks.

>  compat/snprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index 42ea1ac..0b11688 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -9,7 +9,7 @@
>   * always have room for a trailing NUL byte.
>   */
>  #ifndef SNPRINTF_SIZE_CORR
> -#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
> +#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4) && (!defined(_MSC_VER) || _MSC_VER < 1900)
>  #define SNPRINTF_SIZE_CORR 1
>  #else
>  #define SNPRINTF_SIZE_CORR 0
