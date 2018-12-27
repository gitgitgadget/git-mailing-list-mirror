Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8529C211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 17:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeL0RCp (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 12:02:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37840 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeL0RCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 12:02:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so20715352qtt.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 09:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euiZG39qtQ7r2CNHZ1Y1160S14lCFcykrgP41Rj5tqs=;
        b=MZcckpodIg7eMaJnuZUxVcS4mx1opWfAw0uNgKbV3WYrSr0CkzJ6ZFJ/jECFB12BdE
         2nxgVvNfmKghYY40VVnxL+YcXizLbGZDOFtyVwDjIoMRKJDhdCIkyzBnxna6W3Y9caLA
         iyyIX7ttNo8klheYiePmSErWRnDvmCCaoXHVLUbbyEU3LL/mz76Yw52IMjAByLypnA68
         nCGFUllp9gQMucqZR9QRJqJTvdV2UJM3faK5M3g1Dd0CqC0/f1UPeZ/tMatBEu3EFAgR
         lnIJpu6N2U8tLhKZVaRF1Puufj9c4OfuUaYoEIDxzKJUTmgLc2qlpnCV4z9TpluWweFT
         VUAA==
X-Gm-Message-State: AJcUukfsRrLG2pv+O79vkYzByhUNHtmA5RjlwKtvL8isNQ7Q/FjvsjrF
        KMcd4LRfyUW3QRqI3b+JDqhTC1wQLP3wKTdUtq4=
X-Google-Smtp-Source: AFSGD/V5TMeZnQFOFxppBrxYgkJAQJKcop0CSt8DewQKhqmLxq06Jk7lwIxa+iRxMM//DdsUqomChMqOCwYbE26qoQk=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr23160734qti.184.1545930163443;
 Thu, 27 Dec 2018 09:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20181226230523.16572-1-randall.s.becker@rogers.com> <20181226230523.16572-3-randall.s.becker@rogers.com>
In-Reply-To: <20181226230523.16572-3-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Dec 2018 12:02:32 -0500
Message-ID: <CAPig+cQ4p8kgAWji3r6WnudZdT4TOG15s1ip6p5SXmTec25mPw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] config.mak.uname: support for modern HPE NonStop config.
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 26, 2018 at 6:05 PM <randall.s.becker@rogers.com> wrote:
> A number of configuration options are not automatically detected by
> configure mechanisms, including the location of Perl and Python.
> [...]
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/config.mak.uname b/config.mak.uname
> @@ -441,26 +441,45 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>         # Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
> -       PERL_PATH = ${prefix}/bin/perl
> -       PYTHON_PATH = ${prefix}/bin/python
> +       PERL_PATH = /usr/bin/perl
> +       PYTHON_PATH = /usr/bin/python

Is the in-code comment about ${prefix} still applicable after this change?

> +       # The current /usr/coreutils/rm at lowest support level does not work
> +       # with the git test structure. Default to the older rm.
> +       RM = /bin/rm -f

This comment would be far more helpful if it explained in what way
'rm' actually fails with the test suite. Without that information, the
comment is effectively useless.

>         # As detected by './configure'.
>         # Missdetected, hence commented out, see below.
>         #NO_CURL = YesPlease
>         # Added manually, see above.
> +       # Missdetected, hence commented out, see below.
> +       #NO_CURL = YesPlease
> +       # Added manually, see above.

These added lines are just duplicating the existing line immediately above.

> +       # Not detected by ./configure. Add manually.
> +       NEEDS_SSL_WITH_CURL = YesPlease
> +       NEEDS_CRYPTO_WITH_SSL = YesPlease
> +       HAVE_DEV_TTY = YesPlease

I find these comments about 'configure' "misdetecting" or "not
detecting" features confusing. The point of config.mak.uname is to
provide sane defaults for people building without using the
'configure' script, so it feels weird to be talking about 'configure'
here. Also, what does it mean to say that 'configure' "misdetects"?
Does that mean that it fails to write assignments such as "NO_CURL =
YesPlease" to config.autogen or does it mean that it writes incorrect
assignments to that file?

> @@ -470,8 +489,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> +       ifdef NO_PTHREADS
> +       else # WIP, use of Posix User Threads is planned but not working yet
> +               PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
> +               PTHREAD_LIBS = -lput
> +       endif

Why not a simpler 'ifndef'?
