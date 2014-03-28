From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: link in invalidcontinue.obj for better POSIX compatibility
Date: Fri, 28 Mar 2014 11:27:56 -0700
Message-ID: <xmqqy4zu9o0j.fsf@gitster.dls.corp.google.com>
References: <53354EE3.2050908@viscovery.net>
	<1396005570-948-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTbVj-0007zn-7H
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaC1S2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:28:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbaC1S17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 848C477456;
	Fri, 28 Mar 2014 14:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hp/Mz99a11mvkGmIhJ/1V8k58MQ=; b=MgwNJR
	SVnQQgx1V/pEulX8N+QqOKIoZjT/a1+7DpLAhcVhSBxd+/zbQd/lOqyGzRmkQr+f
	qLVPC0okXlKYQR/HytDY/37wrTNJsW4kR7cfw1lahg9bsAQ1VEz0Z+kI0K0pBTDA
	opGt9YSj76YLKd9wMAswxfZF69dK9njtrtynA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tcTxPRqACPfctZIJctkvThaqyntY1h8X
	Gxo228zsEzWIkVPpNT+zOo9q8XmZKPf3Ivl6NUNUnNySf7Gr85Dd3ha63l4J3HNm
	NRKMtgchRdnNfiPn84t5OHXCWApCb241syfrsAUW1MGRm/uDuQi/cR0shTwc0Yji
	j6f5xPYFQCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B33177455;
	Fri, 28 Mar 2014 14:27:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C35027744F;
	Fri, 28 Mar 2014 14:27:57 -0400 (EDT)
In-Reply-To: <1396005570-948-1-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Fri, 28 Mar 2014 15:19:30 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF994304-B6A6-11E3-8B9E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245409>

Marat Radchenko <marat@slonopotamus.org> writes:

> This patch fixes crashes caused by quitting from PAGER.

Can you elaborate a bit more on the underlying cause, summarizing
what you learned from this discussion, so that those who read "git
log" output two weeks from now do not have to come back to this
thread in the mail archive in order to figure out why we suddenly
needs to link with yet another library?

Thanks.

> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>
>> Please do not cull the Cc list.
>
> That was gmane web interface.
>
>> The correct solution is to link against invalidcontinue.obj in the MSVC
>> build. This is a compiler-provided object file that changes the default
>> behavior to the "expected" kind, i.e., C runtime functions return EINVAL
>> when appropriate instead of crashing the application.
>
> Thanks for a hint.
>
>  config.mak.uname | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 38c60af..8e7ec6e 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -366,7 +366,7 @@ ifeq ($(uname_S),Windows)
>  		compat/win32/dirent.o
>  	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
>  	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
> -	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
> +	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
>  	PTHREAD_LIBS =
>  	lib =
>  ifndef DEBUG
