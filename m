Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98C9C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FF861132
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhDHWYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhDHWYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:24:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED0C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:23:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so5585710ejj.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GaeDHpzldcSwOEg5RPefsfb/WJdBKN6a4jBx3PogxaE=;
        b=FBFsdvCXego7kUVhnLF1dJk8QvOk79ZYqjvvsCUOteS3NOamgkd3/siuYERxas9K3S
         A01wbbyGgZiPwlujkIXhpU6ziz/e96QT98lknV+1ppWvetIfCYkS1LmCkEyZCO5QHJWY
         xSwGj5yWne8/iwSX8YAWkAwg+C0c2HK2Gn9IkSWcB1GRsTuzqpKdvJHRlxyrnnTZ/5iX
         ECptkAWmzHbNJxDMbUaFQNssfSvdFB3JZFT6GRzV6bZ45czrmuP8C11sfJZldDQZe2qJ
         F9q911f/gtroB1aQVETNQwZTkULJ9Sk3KNVHmlnrhlK03sBOWWzjB6JBk6YsXJx2Lg4y
         gOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GaeDHpzldcSwOEg5RPefsfb/WJdBKN6a4jBx3PogxaE=;
        b=H6M7jHLeCV7oJ0JHxepQn9XxKXG5OZrnQuzn9T0QTmMkIlFV9r7b4FtgzwJMEm3hHL
         SOWhopnNjzrSE3nWnr2Zjyduw7A39x+CV/w1VdWbNVUUPQp19IAJFnS+rqSUI/hG8fjX
         /pSkvRRRHb0+yjZg0F4EoaDS44/+vYWbmAnZj9bLrPi5uGUNIyjuQnARfBM3xQpOrzgD
         v82MJvXc4VKgwHBR2iv48p7xzfyrsn8vBdc3NqNTQsWQqnSHIZyNKr4lirAuChwUGHB4
         /r7KMIqTVz0/L2GwBdZr2PT4GoJaNjDiKPI77v5Hzz4qNhkRuO4HcvQmCwhzNCO52rbN
         8lXg==
X-Gm-Message-State: AOAM531kxp2r44A4Cc/8B0/DHsEaLV6+Lrfez80/dXIEkKkUJH6cH+de
        LRnVQU3ZYf4iU1ark2Ep43M=
X-Google-Smtp-Source: ABdhPJx+Zr/7UIt05jTuYBmPflGm6zd+8nZQeBcNaW8vnF1DKkL37fOBeFGb/5OxFhsarTz47g5giQ==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr13523243ejr.136.1617920633723;
        Thu, 08 Apr 2021 15:23:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bf14sm354970edb.67.2021.04.08.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:23:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v13 5/5] bugreport: add compiler info
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-6-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20200416211807.60811-6-emilyshaffer@google.com>
Date:   Fri, 09 Apr 2021 00:23:52 +0200
Message-ID: <87k0pcifev.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 16 2020, Emily Shaffer wrote:

> To help pinpoint the source of a regression, it is useful to know some
> info about the compiler which the user's Git client was built with. By
> adding a generic get_compiler_info() in 'compat/' we can choose which
> relevant information to share per compiler; to get started, let's
> demonstrate the version of glibc if the user built with 'gcc'.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.c=
om>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     |  6 +++++
>  compat/compiler.h               | 41 +++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 compat/compiler.h
>
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugrepor=
t.txt
> index 17b0d14e8d..643d1b2884 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -27,6 +27,7 @@ The following information is captured automatically:
>=20=20
>   - 'git version --build-options'
>   - uname sysname, release, version, and machine strings
> + - Compiler-specific info string
>=20=20
>  This tool is invoked via the typical Git setup process, which means that=
 in some
>  cases, it might not be able to launch - for example, if a relevant confi=
g file
> diff --git a/bugreport.c b/bugreport.c
> index 1a3172bcec..089b939a87 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -4,6 +4,7 @@
>  #include "strbuf.h"
>  #include "time.h"
>  #include "help.h"
> +#include "compat/compiler.h"
>=20=20
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -25,6 +26,11 @@ static void get_system_info(struct strbuf *sys_info)
>  			    uname_info.release,
>  			    uname_info.version,
>  			    uname_info.machine);
> +
> +	strbuf_addstr(sys_info, _("compiler info: "));
> +	get_compiler_info(sys_info);
> +	strbuf_addstr(sys_info, _("libc info: "));

These are marked with _() but not the "clang" etc. below. I'd think that
for a git-bugreport tool we'd be better off without any i18n.

> +	get_libc_info(sys_info);
>  }
>=20=20
>  static const char * const bugreport_usage[] =3D {
> diff --git a/compat/compiler.h b/compat/compiler.h
> new file mode 100644
> index 0000000000..10dbb65937
> --- /dev/null
> +++ b/compat/compiler.h
> @@ -0,0 +1,41 @@
> +#ifndef COMPILER_H
> +#define COMPILER_H
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +
> +#ifdef __GLIBC__
> +#include <gnu/libc-version.h>
> +#endif
> +
> +static inline void get_compiler_info(struct strbuf *info)
> +{
> +	int len =3D info->len;
> +#ifdef __clang__
> +	strbuf_addf(info, "clang: %s\n", __clang_version__);
> +#elif defined(__GNUC__)
> +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> +#endif
> +
> +#ifdef _MSC_VER
> +	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
> +		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
> +#endif

Why the ifdef/elif/ifdef instead of ifdef/elif/elif? Isn't _MSC_VER
mutually exclusive with __clang__ and __GNUC__?
