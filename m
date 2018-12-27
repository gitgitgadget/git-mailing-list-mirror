Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AF8211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 20:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeL0UDV (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 15:03:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42120 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbeL0UDV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 15:03:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id 68so11448310qke.9
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 12:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWmLmDRflzlLFTaAPW0GvIc6wapQwP/0wOFCmv69dCA=;
        b=Ggtwmye3w13NUU9+KkwmH2XeLK1DbqSJxpWLi8w8Tc6FgCnXvnKt1tAuefvc0EB5B5
         hbT3ZFSJCaM81HymrqMYgKQEm/Qb9L6nyxBeLYaQ3wKf84ksNyaVso8pnINi8CRsc6l2
         IcK8MRzcQ73mi0iakKLC2SVsTR6hjMHwj7k0Cs+qpM/dw/dR48wHEqqIEi8b/STTubMl
         z3ZTsi6TLBd9MCzGvcGwgtvlscdO/GT1cKGk8nnktGLbT9BYTMyY8WSUXDXI2o9A/5TN
         +IzJ1w/49i3dZEWrYgilSMpstF0dxKO24mbkOJaIhmsdiDFcSYKQWrPUrVDq0HJkRBiA
         pITw==
X-Gm-Message-State: AJcUukcJ0PLdwBbLF0YprA/TssHHGBqGOb3w8GNbO6lDBL5xWNpNYYgO
        DwWYJqwcmRiZZsIGMpOFV1lL/yMyvm9DTNiCP9M=
X-Google-Smtp-Source: ALg8bN73C7fd6TphpG9CDVW3MKcaaztgUzR2yYre4R9t8ay5NY1v12QHJAcBXb4ez56sDyqjag1ZzGRcYkjxGn7BDtc=
X-Received: by 2002:a37:a315:: with SMTP id m21mr22148923qke.152.1545940999994;
 Thu, 27 Dec 2018 12:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20181227183513.2860-1-randall.s.becker@rogers.com>
In-Reply-To: <20181227183513.2860-1-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Dec 2018 15:03:08 -0500
Message-ID: <CAPig+cSv6CiP0gzdnJgK8jHqibEPoUneUXoO0p9q0fHsvBDj7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] config.mak.uname: support for modern HPE NonStop config.
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 1:35 PM <randall.s.becker@rogers.com> wrote:
> A number of configuration options are not automatically detected by
> configure mechanisms, including the location of Perl and Python.
>
> There was a problem at a specific set of operating system versions
> that caused getopt to have compile errors. Accounted for this by

s/Accounted/Account/

> providing emulation defines for those versions.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/config.mak.uname b/config.mak.uname
> @@ -441,26 +441,45 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>         # Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
> -       PERL_PATH = ${prefix}/bin/perl
> -       PYTHON_PATH = ${prefix}/bin/python
> +       PERL_PATH = /usr/bin/perl
> +       PYTHON_PATH = /usr/bin/python

Referring to your answer[1] to my question about ${prefix}, should the
comment above these lines, which talks about ${prefix}, be removed by
this patch?

[1]: https://public-inbox.org/git/000601d49e0b$e11d7520$a3585f60$@rogers.com/

> +       # The current /usr/coreutils/rm at lowest support level does not work
> +       # with the git test structure. Long paths cause nftw as in
> +       # 'trash directory...' break at OS releases J06.21 and L17.02.

"break" in what fashion? What is the actual incorrect behavior?

I'm not asking for my own edification particularly, but rather to help
the person who comes after you supporting this platform. That person
will need to understand the exact nature of the problem in order to
determine if this work-around is still needed or if it can be retired
or somehow conditionalized. Stated another way, the reason behind this
change still seems like a black-box, mysterious and under-explained.
There is nothing concrete here upon which to grasp to gain an
understanding of the problem.

> +       # Default to the older rm until those two releases are deprecated.
> +       RM = /bin/rm -f
