Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4384CC636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 13:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjBJNO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 08:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjBJNOz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 08:14:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4708186A
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:14:41 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gr7so15745455ejb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cecuc22M3Dnmd3n46LvDLlGgWLkTwXsN5ZAzktoVv0Q=;
        b=h4OM2q6a3WCdTOxEW0ahyuCwo9nRHz4VvQbF6KFsgZdLj4JMsehAGspym59Hkvu6lA
         woGWJu6b0/Xowk5OcZX73gRGJNnOYjIVwtGMHTGPus+8YGbYsprPYvvfuXa6i2doQDOi
         miQIoQwLdOk+CJObtHJpGaFNp8JijYL0cBTItCgtJZA36jcPSDcbt372nF1XOA9dNsQm
         jm9HxuLvzCCdK1YY6+pKV7srUQtcoWJDXg8GPiRvZboSaWf1/7pLX9hRmSSbq5BdjZHE
         j6jb2Pt/cNO9ovVZyeFNrI5vQdq1nqm4XpCbQCX5qti4aqbL8oUlT6DpKcol8EkqQ08t
         ZF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cecuc22M3Dnmd3n46LvDLlGgWLkTwXsN5ZAzktoVv0Q=;
        b=NxVJtzQINsIQ9XGHrpcLRmSOyyzPkZdDARsg2HPFmHFYMjxT370JNbY9JXwumMC4ZN
         meCRFkyBWPzdEL9xMbZbaMlHUi2s457jZJpgKH2x8A28xfCiuGnlSg6GSzVjUChfP9Ka
         zbw0RU4MHclQk3hcHXGZDF/bUKbK+NU4HpWjY62CCR/+JrrQ8ECgOFpn4IQYh5oXEKQi
         xvCLg02giqj1EojODj5vQefzP3KQVouU//QlMlZt3qFx+xi9sfKvdkQyZzlAlaho5C9Z
         Zj+AGaDFfB/P3evwNqaa/FzhUEnQZzCib2DwKqmJ4JE4b0UJH3fNWFLyd6A+EKcLkKmO
         rFqg==
X-Gm-Message-State: AO0yUKV5tDh/i9bpkJJsJL2qIjsLQXFI+zFa7ZYt45Yza4/JDTFy9187
        6i6wexoz7m/Cabxb7ls/3Sk=
X-Google-Smtp-Source: AK7set8H4P64O4RuzdS+xhJv1JzYjoTTGORSa0FoxOB39TLINdPEFT9gErGkkp+JO+QHtxoFlG/wMA==
X-Received: by 2002:a17:907:96a2:b0:89f:1a76:e2dc with SMTP id hd34-20020a17090796a200b0089f1a76e2dcmr21026275ejc.0.1676034879590;
        Fri, 10 Feb 2023 05:14:39 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id ci4-20020a170906c34400b0087873afb1b4sm2360492ejb.41.2023.02.10.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:14:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQTEc-001vZf-1Q;
        Fri, 10 Feb 2023 14:14:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] wildmatch: remove NEGATE_CLASS and NEGATE_CLASS2
 macros
Date:   Fri, 10 Feb 2023 14:11:36 +0100
References: <20230210075939.44949-1-masahiroy@kernel.org>
 <20230210075939.44949-4-masahiroy@kernel.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230210075939.44949-4-masahiroy@kernel.org>
Message-ID: <230210.865yc9wtkx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 10 2023, Masahiro Yamada wrote:

> The other glob patterns are hard-coded in dowild(). Do likewise.
> [...]
> diff --git a/wildmatch.c b/wildmatch.c
> index a510b3fd23..93800b8eac 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -14,10 +14,6 @@
>  
>  typedef unsigned char uchar;
>  
> -/* What character marks an inverted character class? */
> -#define NEGATE_CLASS	'!'
> -#define NEGATE_CLASS2	'^'

Thanks, maybe these made sense in rsync's codebase, but...

>  #define CC_EQ(class, len, litmatch) ((len) == sizeof (litmatch)-1 \
>  				    && *(class) == *(litmatch) \
>  				    && strncmp((char*)class, litmatch, len) == 0)
> @@ -137,12 +133,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  			return WM_ABORT_ALL;
>  		case '[':
>  			p_ch = *++p;

...as the context shows we hardcode most of these tokens.

> -#ifdef NEGATE_CLASS2
> -			if (p_ch == NEGATE_CLASS2)
> -				p_ch = NEGATE_CLASS;
> -#endif

Hrm, but isn't this a logic error? No it's not, because...

>  			/* Assign literal 1/0 because of "matched" comparison. */
> -			negated = p_ch == NEGATE_CLASS ? 1 : 0;
> +			negated = p_ch == '!' || p_ch == '^' ? 1 : 0;

...you're refcatoring thise while at it.

Personally I'd prefer to just see this change without this, and it came
as a surprise given the commit message.

I find the pre-image easier to read (sans the macro check, which you
should be removing).

