From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 V2] MSVC: VS2013 comes with inttypes.h
Date: Tue, 29 Mar 2016 10:35:20 -0700
Message-ID: <xmqq4mbpyyp3.fsf@gitster.mtv.corp.google.com>
References: <56FAACD4.9080504@cs-ware.de> <56FAB9FD.7080409@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>, blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akxY9-0004JI-In
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 19:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbcC2RfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 13:35:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753188AbcC2RfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 13:35:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D2B04FC52;
	Tue, 29 Mar 2016 13:35:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/VHJ97G1Pfrj/vndx60fhMPs8Q0=; b=ULxiRy
	SCipjbystK2ccS0WeA624+q3xHcOoTuQwagiotO1assTn/ctXAZUheLL7i6i+Ka6
	+h2mnaw20xT1fJujDOGlyEbrCY8gfTenf1Oo5orCHthjTUf8GTRqXdcXSG/fq9dj
	iiXW00JOaiNQZD7Ckk/J860uvSgy2y/JziYq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pWQojyOTaX3NS2SS6ktJR+W0FzMvtpjk
	ChOIAe35Lg8NVKvsQBLjvt5RKKn97h3rmbFQ4DzAsUxwSKaONfvmAL/oWXTlp6Dq
	v+lnfye8bER0UZzTSsX2QxKT3ies5OkqrER2uYMv3jfkJO+9LNkF9K3dkg+F3LU4
	jWlWOm6zpes=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F39074FC51;
	Tue, 29 Mar 2016 13:35:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5784C4FC50;
	Tue, 29 Mar 2016 13:35:22 -0400 (EDT)
In-Reply-To: <56FAB9FD.7080409@cs-ware.de> (Sven Strickroth's message of "Tue,
	29 Mar 2016 19:23:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D30F3AA-F5D4-11E5-836B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290150>

Sven Strickroth <sven@cs-ware.de> writes:

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

Ah, I didn't finish the comment I started to write here for the
first round.  My "Hmph" was meant to be followed by something like
"Compared to 1/2 which clearly described what got changed, this does
not say much to summarize what it did to help readers".

Re-reading the patch text, I tend to agree with you that the title
"comes with inttypes.h" may be sufficient for readers to reason
about the change, and it would not be necessary to explain that we
can lose fallback definitions by including it.

>  compat/mingw.h                  | 2 +-
>  compat/vcbuild/include/unistd.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 6b6d695..137f42e 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -415,7 +415,7 @@ int mingw_offset_1st_component(const char *path);
>  extern void build_libgit_environment(void);
>  extern const char *program_data_config(void);
>  #define git_program_data_config program_data_config
> -#ifndef __MINGW64_VERSION_MAJOR
> +#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
>  #define PRIuMAX "I64u"
>  #define PRId64 "I64d"
>  #else
> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
> index c65c2cd..b7cc48c 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -45,11 +45,15 @@ typedef unsigned long long uintmax_t;
>  
>  typedef int64_t off64_t;
>  
> +#if !defined(_MSC_VER) || _MSC_VER < 1800
>  #define INTMAX_MIN  _I64_MIN
>  #define INTMAX_MAX  _I64_MAX
>  #define UINTMAX_MAX _UI64_MAX
>  
>  #define UINT32_MAX 0xffffffff  /* 4294967295U */
> +#else
> +#include<inttypes.h>

Somebody lost a SP here, it seems.

> +#endif
>  
>  #define STDIN_FILENO  0
>  #define STDOUT_FILENO 1
