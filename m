From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] index-pack: Disable threading on cygwin
Date: Tue, 26 Jun 2012 12:56:27 -0700
Message-ID: <7vk3ytc0es.fsf@alter.siamese.dyndns.org>
References: <4FE9FD34.5020406@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjbsM-000730-6G
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2FZT4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:56:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab2FZT4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 15:56:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 346009CB0;
	Tue, 26 Jun 2012 15:56:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AcXSxOSX3VCm6gRoR+AVcNpWe6U=; b=ahCWJG
	Z2JKh8L3JSQByVzujBCYpg8Y7WzRCcQpAt4OsP3v+HwUfrvsV8R8mw1N20L244Sc
	rFrDEOP2D9QKjIapDFjL9ERu3to5/faII+wmBw4wkSHmpTxDYiUOcI6wNgGjZmOq
	cLJVs8C7Bbihnh8r6aKaSWH/nP6x/L3Yr2ayI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YNEUwk8aDv1r5JKgpqSH5x/8PDWRZQh5
	S7fHzf4w4niPJGA9x7TusfBsG9YmwyoZ3issFQor7xeviU8SulJmLPdGU5I5nh3V
	TOVfuz3H1PbK0Yh6U+GnFNgWSueefDS1mHAtkcWNywMFPOV+mxTYTUOkvE/BYnho
	EDcV+TGRO18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B3459CAF;
	Tue, 26 Jun 2012 15:56:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 145749CA3; Tue, 26 Jun 2012
 15:56:28 -0400 (EDT)
In-Reply-To: <4FE9FD34.5020406@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 26 Jun 2012 19:19:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04FE82FE-BFC9-11E1-A2C6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200677>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>    - renamed FAKE_PREAD_NOT_THREAD_SAFE to NO_THREAD_SAFE_PREAD

Sensible.

>    - when NO_PREAD, set NO_THREAD_SAFE_PREAD in the Makefile, rather
>      than in git-compat-util.h

I think it is a bad change.  When compat/ pread gets improved to be
thread-safe, this will surely be missed.

>    - set NO_THREAD_SAFE_PREAD in the non-conditional part of the
>      cygwin config section (ie not just versions before 1.7.x)

Sorry that I missed it, and thanks for fixing it.

> I can only test this by using it (all relevant tests pass with or without
> this patch, after all), so I have installed it for day-to-day use. I don't
> anticipate any problems, but I guess this patch has not actually been
> tested yet ... :-D
>
> HTH
>
> ATB,
> Ramsay Jones
>
>  Makefile             | 8 ++++++++
>  builtin/index-pack.c | 4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4592f1f..67d761e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -158,6 +158,9 @@ all::
>  # Define NO_PREAD if you have a problem with pread() system call (e.g.
>  # cygwin1.dll before v1.5.22).
>  #
> +# Define NO_THREAD_SAFE_PREAD if your pread() implementation is not
> +# thread-safe. (e.g. compat/pread.c or cygwin)
> +#
>  # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
>  # generally faster on your platform than accessing the working directory.
>  #
> @@ -1051,6 +1054,7 @@ ifeq ($(uname_O),Cygwin)
>  		NO_IPV6 = YesPlease
>  		OLD_ICONV = UnfortunatelyYes
>  	endif
> +	NO_THREAD_SAFE_PREAD = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
>  	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
> @@ -1659,6 +1663,10 @@ endif
>  ifdef NO_PREAD
>  	COMPAT_CFLAGS += -DNO_PREAD
>  	COMPAT_OBJS += compat/pread.o
> +	NO_THREAD_SAFE_PREAD = YesPlease
> +endif
> +ifdef NO_THREAD_SAFE_PREAD
> +	BASIC_CFLAGS += -DNO_THREAD_SAFE_PREAD
>  endif
>  ifdef NO_FAST_WORKING_DIRECTORY
>  	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index dc2cfe6..4705478 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -39,8 +39,8 @@ struct base_data {
>  	int ofs_first, ofs_last;
>  };
>  
> -#if !defined(NO_PTHREADS) && defined(NO_PREAD)
> -/* NO_PREAD uses compat/pread.c, which is not thread-safe. Disable threading. */
> +#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
> +/* pread() emulation is not thread-safe. Disable threading. */
>  #define NO_PTHREADS
>  #endif
