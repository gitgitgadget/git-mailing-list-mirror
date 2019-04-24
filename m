Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73861F453
	for <e@80x24.org>; Wed, 24 Apr 2019 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfDXNjT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 09:39:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50624 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbfDXNjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 09:39:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 474C858951;
        Wed, 24 Apr 2019 09:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ppBFkMFdpqHh
        M0hMLvOChxzdxC0=; b=qqXjF6Ie+lDeK7YF0TjoqlMpDhwTaCzJLynAgrIxKmbw
        H/jWO1e15sFRBoxs1p6JcoWn+a1xuzPgRUsQygHGk5n9rS0YmdZ7rgYlKFgoOMGo
        Ghf9E5zFtUfivwLLkD6p23y2XM4wtAFP5ZG2zG6G8pTyNU6eli6SLCaMyx4UMBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rA9pMN
        eZXPvB+1eJJuCp5wo+KUAcRTLUjYrqGJwqIPX2uJfzGeGbV4uHuW72VugXEnXCvw
        hblHv7mZGKFMcFza58CdZknvDeEDD9eUQ8uCYEs/yqFWYpOMv29UXNGKMsWayYKf
        3Ci9gvL0icWdxXFHga9slVCOxIfgYwxOVg62M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DC1B58950;
        Wed, 24 Apr 2019 09:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 549805894E;
        Wed, 24 Apr 2019 09:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "CHIGOT\, CLEMENT" <clement.chigot@atos.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] git-compat-util: work around for access(X_OK) under root
References: <AM6PR02MB4950ED66291B16F35BE61A26EA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>
Date:   Wed, 24 Apr 2019 22:39:09 +0900
In-Reply-To: <AM6PR02MB4950ED66291B16F35BE61A26EA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>
        (CLEMENT CHIGOT's message of "Wed, 24 Apr 2019 12:00:22 +0000")
Message-ID: <xmqqa7gf1q0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 584594B8-6696-11E9-8220-D01F9763A999-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"CHIGOT, CLEMENT" <clement.chigot@atos.net> writes:

> On AIX, access(X_OK) may success when run under root even if the

s/success/succeed/;=20

Also perhaps s/under/as/.

> execution isn't possible. This comes from the POSIX specifications

s/comes from/behaviour is allowed by/;  I agree with you that AIX
behaviour is suboptimal and I do not think we want to give an
impression that POSIX encourages such an illogical behaviour.  It
merely is permitted.

> which say:
> "... for a process with appropriate privileges, an implementation
>  may indicate success for X_OK even if execute permission is not
>  granted to any user."
>
> This behavior can lead hook programs to have their execution refused:

OK.

>  "git commit -m content
>   fatal: cannot exec '.git/hooks/pre-commit': Permission denied"

I am not sure what the double-quotes around these two lines are
about.  Perhaps drop them, and if you want to clarify which part is
your word and which part is quoted material, have blank lines to
delineate instead, perhap like:

        ... POSIX says:

            ... for a process with appropriate ...
            ... to any user.

        This behaviour can fail the execution of hooks, like so:

            $ git commit
            fatal: cannot exec '.git/hooks/pre-commit': Permission denied

        Add NEED_ACCESS_ROOT_HANDLER in order to...

> is root.
>
> Signed-off-by: Cl=C3=A9ment Chigot <clement.chigot@atos.net>
> Message-ID: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurpr=
d02.prod.outlook.com>

Drop "Message-Id:" from the footer.

> ---
> ...
> diff --git a/compat/access.c b/compat/access.c
> new file mode 100644
> index 0000000000..fcfaefb0c0
> --- /dev/null
> +++ b/compat/access.c
> @@ -0,0 +1,30 @@
> +#define COMPAT_CODE_ACCESS

I am torn between just using COMPAT_CODE like the other one does, or
introducing the new symbol like this.  If we were to do the latter,
perhaps we should give the original one a more specific name as well
(e.g. COMPAT_CODE_FILENO or something like that).

> +#include "../git-compat-util.h"
> +
> +/* Do the same thing access(2) does, but use the effective uid,
> + * and don't make the mistake of telling root that any file is
> + * executable.  This version uses stat(2).
> + */
> +int git_access(const char *path, int mode)
> +{
> +	struct stat st;
> +
> +	/* do not interfere a normal user */
> +	if (geteuid())
> +		return access(path, mode);

OK.

> +	if (stat(path, &st) < 0)
> +		return -1;
> +
> +	/* Root can read or write any file. */
> +	if (!(mode & X_OK))
> +		return 0;
> +
> +	/* Root can execute any file that has any one of the execute
> +	   bits set. */

	/*
	 * Our multi-line comment looks like this,
	 * with opening slash-asterisk and closing
	 * asterisk-slash on their own lines.
	 */

> +	if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
> +		return 0;
> +
> +	errno =3D EACCES;
> +	return -1;
> +}

OK.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 31b47932bd..d0cb380522 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1242,6 +1242,13 @@ int git_fileno(FILE *stream);
>  # endif
>  #endif
> =20
> +#ifdef NEED_ACCESS_ROOT_HANDLER
> +int git_access(const char *path, int mode);
> +# ifndef COMPAT_CODE_ACCESS

Notice that the fileno thing we are trying to mimick protects us
from a system header that defines the macro we are about to define,
which is a good practice to prevent compilers from complaining
against redefinition.  We should imitate it like this here:

   #  ifdef access
   #  undef access
   #  endif

> +#  define access(path, mode) git_access(path, mode)
> +# endif
> +#endif
> +

Other than that, looks good to me.
