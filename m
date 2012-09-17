From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/4] make poll available for other platforms lacking
 it
Date: Mon, 17 Sep 2012 15:41:38 -0700
Message-ID: <7vmx0oqner.fsf@alter.siamese.dyndns.org>
References: <004b01cd9519$ba991cd0$2fcb5670$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDk4Z-0001zO-Va
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436Ab2IQWpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:45:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374Ab2IQWpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 18:45:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50DFA8350;
	Mon, 17 Sep 2012 18:45:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=k01JUg45sd6maggvIE+xRYxWCxQ=; b=QA5Yruugr7R0l/1aj5hB
	u+2qGPmLzmfVuLYB9RQPAxn5DlYKzvBq8IKZJ/Kc7/zJqtbWVzcCumEOpH1Bwi8f
	IccgyuL2PIhcrzUu0UufeJh5eXTeSClhR2cwO7jtvOZDeEetNVnRhQQIwOezFVLn
	HBxNKSo/8+haS27DlqFC48Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KSlSUC4sn2Unbj7xnVz23VBHkedaYF9ToM11crnNKOT/kK
	zokpeZggx2DkvxtX8X2T0AtxhJijS7dIJpJip0XO7Hd8v7LPD9MZ0IGvPaCVdh5f
	e9aBLp0BRESGJjXri5nfla/ZjHpe4ieWzPB73w0JJz4J78k9wGhv2nEFXtDo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DC3F834E;
	Mon, 17 Sep 2012 18:45:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90075834D; Mon, 17 Sep 2012
 18:45:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A56AB00-0119-11E2-87C1-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205764>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> move poll.[ch] out of compat/win32/ into compat/poll/ and adjust
> Makefile with the changed paths. Adding comments to Makefile about
> how/when to enable it and add logic for this
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  Makefile                      | 20 +++++++++++++++-----
>  compat/{win32 => poll}/poll.c |  0
>  compat/{win32 => poll}/poll.h |  0
>  3 files changed, 15 insertions(+), 5 deletions(-)
>  rename compat/{win32 => poll}/poll.c (100%)
>  rename compat/{win32 => poll}/poll.h (100%)
>
> diff --git a/Makefile b/Makefile
> index ac49320..7893297 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -152,6 +152,11 @@ all::
>  #
>  # Define NO_MMAP if you want to avoid mmap.
>  #
> +# Define NO_SYS_POLL_H if you don't have sys/poll.h.
> +#
> +# Define NO_POLL if you do not have or don't want to use poll().
> +# This also implies NO_SYS_POLL_H.

Sensible.

> @@ -1220,7 +1225,7 @@ ifeq ($(uname_S),Windows)
>  	NO_PREAD = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
> -	NO_SYS_POLL_H = YesPlease
> +	NO_POLL_H = YesPlease

Should this be NO_POLL, not NO_POLL_H?

> -DSTRIP_EXTENSION=\".exe\"
>  	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
>  	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
> @@ -1316,7 +1321,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_PREAD = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
> -	NO_SYS_POLL_H = YesPlease
> +	NO_POLL_H = YesPlease

Likewise.

> @@ -1605,6 +1610,11 @@ ifdef NO_GETTEXT
>  	BASIC_CFLAGS += -DNO_GETTEXT
>  	USE_GETTEXT_SCHEME ?= fallthrough
>  endif
> +ifdef NO_POLL
> +	NO_SYS_POLL_H = YesPlease
> +	COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
> +	COMPAT_OBJS += compat/poll/poll.o
> +endif

I think my guesses above are correct, so will queue with the trivial
and obvious fixup.

Thanks.
