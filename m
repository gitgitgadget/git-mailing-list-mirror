From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Mark win32's pthread_exit() as NORETURN
Date: Wed, 02 Mar 2016 12:33:15 -0800
Message-ID: <xmqq7fhk4o38.fsf@gitster.mtv.corp.google.com>
References: <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
	<63310f6af16c70870bd620c83d8860421ca02718.1456945703.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 21:33:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDSV-0007HE-EI
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbcCBUdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:33:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754331AbcCBUdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:33:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B377D480AB;
	Wed,  2 Mar 2016 15:33:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fswo5h89PJMK/AFEvsj9sAMDxWU=; b=xL1QhF
	apMvBZU+FMkjeue6AQtWnAyFYPSv5n9zc6/AL7BJIjfLB/Ak47IKVuPyMok+OYg7
	u2l/s/F1m4h5DCs1EXK5399Y5rBxZif4jxCQbWC9/9I41FhAB/fO1Wx6yIkiNH+z
	C9n7IWppBMP17BbbhZA8LDk8SERrglwQ97eIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYZT42/3KKHv57KldmcY/+2IfXFtt/rH
	rWKyF5rjLKk56JZynqg3rkld0C6z+nCVy0zl7gTc6fHulGV2Rq9F6GjV/MzEVwvA
	wtSZ8K1DudlzE1nuw6AYI8qUgp5GgFTvBVkEVD5EAqHEfv0RYYc5bNhQcrwz4sRY
	IQxoazBexDw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA2E8480AA;
	Wed,  2 Mar 2016 15:33:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24787480A8;
	Wed,  2 Mar 2016 15:33:17 -0500 (EST)
In-Reply-To: <63310f6af16c70870bd620c83d8860421ca02718.1456945703.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 2 Mar 2016 20:11:13 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FEB49660-E0B5-11E5-AF0F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288154>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The pthread_exit() function is not expected to return. Ever. On Windows,
> we call ExitThread() whose documentation claims: "Ends the calling
> thread", i.e. there is no condition in which this function simply
> returns: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659
>
> While at it, fix the return type to be void, as per
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_exit.html
>
> Pointed out by Jeff King, helped by Stefan Naewe, Junio Hamano &
> Johannes Sixt.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks, will queue.

>  compat/win32/pthread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> Interdiff vs v2:
>
>  diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
>  index 148db60..b6ed9e7 100644
>  --- a/compat/win32/pthread.h
>  +++ b/compat/win32/pthread.h
>  @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
>   #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
>   extern pthread_t pthread_self(void);
>   
>  -static inline int NORETURN pthread_exit(void *ret)
>  +static inline void NORETURN pthread_exit(void *ret)
>   {
>   	ExitThread((DWORD)(intptr_t)ret);
>   }
>
>
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index 20b35a2..b6ed9e7 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
>  #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
>  extern pthread_t pthread_self(void);
>  
> -static inline int pthread_exit(void *ret)
> +static inline void NORETURN pthread_exit(void *ret)
>  {
>  	ExitThread((DWORD)(intptr_t)ret);
>  }
