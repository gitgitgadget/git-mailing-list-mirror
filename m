Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21807C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACFB208CD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j9iftDip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgBTUXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:23:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51618 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBTUXU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:23:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9725850C91;
        Thu, 20 Feb 2020 15:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZFIuTX63FXJ0gEQrEeEB1JOh85c=; b=j9iftD
        ipr50etLNSOC23kywykRQ0pCG+TA4SbvzJxiYmc18fu+Ykxwlm3IEhOaCwPXM38W
        ogueXtXTlQIc6ra3dj1ehTQaXHha3Z7j27dfp4VvaLnfse4vO5q5U4hu0gNauYrF
        T+Q9xv6mL9iXdyJQvFId9x1GzgfmIzG3QBMXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T/HEQv/N5V1XqqOtX1qrLZzcILX1zzpt
        vULkOKnJKq7ocVDgOfhUXRxWxOFp4sFEMGfKPxUWv4DXMJjuUN+/xv2cKZi6ABaP
        Vqt49JqJycl9PHGegVvbK0TswxT4Kwn1nk++mbVD0L8HkEHOqtlp0PfgkfQQpfZP
        XTdLz8qNytA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E73250C90;
        Thu, 20 Feb 2020 15:23:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2E5D50C8F;
        Thu, 20 Feb 2020 15:23:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 06/15] bugreport: add compiler info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-7-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 12:23:16 -0800
In-Reply-To: <20200220015858.181086-7-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:49 -0800")
Message-ID: <xmqqv9o19fez.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4858CEC-541E-11EA-A081-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -24,6 +25,10 @@ static void get_system_info(struct strbuf *sys_info)
>  			    uname_info.release,
>  			    uname_info.version,
>  			    uname_info.machine);
> +
> +	strbuf_addstr(sys_info, "compiler info: ");
> +	get_compiler_info(sys_info);
> +	strbuf_complete_line(sys_info);
>  }
>  
>  static const char * const bugreport_usage[] = {
> diff --git a/compat/compiler.h b/compat/compiler.h
> new file mode 100644
> index 0000000000..ef41177233
> --- /dev/null
> +++ b/compat/compiler.h
> @@ -0,0 +1,27 @@
> +#ifndef COMPILER_H
> +#define COMPILER_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#ifdef __GLIBC__
> +#include <gnu/libc-version.h>
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> +#ifdef __GNUC__
> +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> +#endif
> +}
> +
> +#else
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	strbuf_addstr(info, "get_compiler_info() not implemented");

i18n/l10n?  Also don't deliberately leave the buffer end with an
incomplete line like so---doing so _requires_ the caller above to
have strbuf_complete_line() call, but there is no reason to do so.

strbuf_complete_line() does make sense if you insert something that
is not controlled by us (e.g. "Please type whatever other comments
you may have" to let the user give us free-form text, which may or
may not end with a complete line), but otherwise it probably is a
sign of being unnecessary sloppy.

> +}

OK, so the idea is to insert "#elif ..." and definition of
get_compiler_info() for non GLIBC systems?

I am not sure why you want to make this a header with static inline
implementations.  Is it expected for this to be included from
multiple source files?  It would be more understandable if these
were in the same file as where get_system_info() is, perhaps
immediately before that function.

Also, it would probably be easier to manage if you have two separate
helpers, one for what compiler is in use, and the other for what
libc is in use.

> +
> +#endif
> +
> +#endif /* COMPILER_H */

Thanks.
