Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB3C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74A620663
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qxi453Tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLMVSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:18:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61592 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLMVSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:18:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B937A84A8;
        Fri, 13 Dec 2019 16:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BcX1m2YptenONzJuBElJTn4gmt4=; b=Qxi453
        TvqQX3EmE1IAmQvewzBrXk9ADstGvx56mrtZB/Q3Dd7aIjNRdJqu50myUWDFF7sW
        qLhZ0zCKyqiLt6n9P/DBKhQ1wOGgm21JsoIavKJw/DSc1HD4TiarrWs3jgU233Gv
        G7APchZOxKkjT+jo7Fii/3cD0OfOYmc4ZIhe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X02UU/bWSGqjq0LsHnRb0EL71OYU7UKe
        M+tCl8404Seve797jRUTiWeMIVn8k4iQhr9JYjDBPqJ25SL9tn00EF3Fta0wZe29
        +M5kMuJ7kJLTLGEgDYdmIHVesNaqlJs63Wx2bsdBj7+fdToAZf+29LEn7dfayoM1
        6upTeAGl0Zc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0430AA84A7;
        Fri, 13 Dec 2019 16:18:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2AF39A84A4;
        Fri, 13 Dec 2019 16:18:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 06/15] bugreport: add glibc version
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-7-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:18:44 -0800
In-Reply-To: <20191213004312.169753-7-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:03 -0800")
Message-ID: <xmqqimmjj557.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2666C5C4-1DEE-11EA-8EB4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> To help pinpoint the source of a regression, it is useful to know the
> version of libc which the user's Git client was built with. Let's
> include it alongside the other versioning information, which is used to
> identify how the client was built.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c | 5 +++++
>  1 file changed, 5 insertions(+)

This is the first iffy one in the series.  It is unreasonable to
assume that we can dictate that Git can be built only on glibc
systems, no?

Making this conditional, perhaps make "bugreport.c" depend on
"extern void get_compiler_info(struct strbuf *sys_info)" and require
the function to be defined in compat/; the glibc variant that uses
gnu_get_libc_version() would become just one of them.

> diff --git a/bugreport.c b/bugreport.c
> index 9c69e3fa34..af715dc157 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -4,6 +4,7 @@
>  #include "strbuf.h"
>  #include "time.h"
>  #include "help.h"
> +#include <gnu/libc-version.h>
>  
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -27,6 +28,10 @@ static void get_system_info(struct strbuf *sys_info)
>  			    uname_info.release,
>  			    uname_info.version,
>  			    uname_info.machine);
> +
> +	strbuf_addstr(sys_info, "glibc version: ");
> +	strbuf_addstr(sys_info, gnu_get_libc_version());
> +	strbuf_complete_line(sys_info);
>  }
>  
>  static const char * const bugreport_usage[] = {
