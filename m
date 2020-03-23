Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D2EC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6199D2073E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciUGw5nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCWV2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:28:00 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52063 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWV2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:28:00 -0400
Received: by mail-pj1-f66.google.com with SMTP id hg10so463458pjb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xI5FC179tDONoGFjPI38Ubh4jNd1ubBMDoHdV8dN06A=;
        b=ciUGw5nPX4nqd34HIBlS7VmLYvqNHxydPIrB6yknI58jOXyDv1uHKwszuDqszNbQ+V
         88VJKelxIHecqMBF5mUl61oKcDtKJtPbGH+1tBvT7FJUNdA9WGUQXUGZAdvr+taR576Y
         4O+kdhDbg506So92PWzrVpusykYUOvE+zDqURsI7X//5q5l9v88jiVrSbEh0GbOjmKUT
         qeUdfErpnsa6CFJqfLlsgt1SZXwrDoJUAPRSbi5bm7JTgPecYEasH4St/Fhsm8i2WtLP
         Cj49jB3qbpL5wdG6QOMTYfIDo++MYtT9hUspbUMNvpz012evucQRXHdwE5WxcWco4kVz
         LCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xI5FC179tDONoGFjPI38Ubh4jNd1ubBMDoHdV8dN06A=;
        b=GbcEQapudnP3egF5yxAPiKgPn/PUYAgX7Jm1+NNvxSOuuNN3A+vnvNqFOqLz1T3Oil
         tFu6NhdjkNwKnCMe7J/SConWiAUyAyTli7cYjQlx2h6vK1ElzFigbMhP7kwryPVnlQaT
         d8Eyi1MoPGyxGbvkXI+UJrGwbuhjOvOl3RUDCaYtdbIbUSYYWzWaKyaO6h3gK9Nff9gi
         ugQww3MSEQGpte1mkkrgwCWZq03uHEQ5sCbfbin1N/Ni5XYVr9eOJeqHmmprIwxGyreK
         MVfnP2rtH/8edDSHRKy78FX5x3FO7vWzYveZud9/B6JQzm7P5BbSqGrSs6anq02iSsF/
         z9Bw==
X-Gm-Message-State: ANhLgQ1LiX52Wn3Hhoz58KtE3Uv900AmPLsV9nnSe96CBe33Wp2uh/Eo
        SLvJN1bnWijvmuZsEIFfg0LvOVpKMorHiA==
X-Google-Smtp-Source: ADFU+vuVeTPOTzfvtZpdjjgfPIjuGt029m8yKMC4+nhQs6jv85DOp8H4zprsmls3hrLr7jf8w0libg==
X-Received: by 2002:a17:90a:db0e:: with SMTP id g14mr1358831pjv.186.1584998878983;
        Mon, 23 Mar 2020 14:27:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 71sm14640743pfv.8.2020.03.23.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:27:57 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:27:53 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] bugreport: add compiler info
Message-ID: <20200323212753.GE45325@google.com>
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-6-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2003042236060.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003042236060.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 04, 2020 at 10:39:53PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Mon, 2 Mar 2020, Emily Shaffer wrote:
> 
> > diff --git a/compat/compiler.h b/compat/compiler.h
> > new file mode 100644
> > index 0000000000..21f098e6a4
> > --- /dev/null
> > +++ b/compat/compiler.h
> > @@ -0,0 +1,38 @@
> > +#ifndef COMPILER_H
> > +#define COMPILER_H
> > +
> > +#include "git-compat-util.h"
> > +#include "strbuf.h"
> > +
> > +#ifdef __GLIBC__
> > +#include <gnu/libc-version.h>
> > +#endif
> > +
> > +static inline void get_compiler_info(struct strbuf *info)
> > +{
> > +	int len = info->len;
> > +#ifdef __GNUC__
> > +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> > +#endif
> > +
> > +#ifdef _MSC_VER
> > +	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
> 
> I need this to fix a crash in the Visual Studio build's test run:

Hummm, is that not part of the GGG suite? I saw it pass (and then failed
to include the updated patches with v9 with the changes you mentioned
below).

> 
> -- snip --
> Subject: [PATCH] fixup??? bugreport: add compiler info
> 
> As documented at
> https://docs.microsoft.com/en-us/cpp/preprocessor/predefined-macros?view=vs-2019,
> `_MSC_FULL_VER` is an integer, not a string. Therefore this fix is
> needed to prevent a segmentation fault in the test t0091.1.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/compiler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/compiler.h b/compat/compiler.h
> index ce6a7f6de9a..ac90fa051dd 100644
> --- a/compat/compiler.h
> +++ b/compat/compiler.h
> @@ -16,7 +16,8 @@ static inline void get_compiler_info(struct strbuf *info)
>  #endif
> 
>  #ifdef _MSC_VER
> -	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
> +	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
> +		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
>  #endif
> 
>  	if (len == info->len)
> -- snap --
> 
> Could you squash that in, please?
> 
> BTW the two issues I reported in the earlier round are still problems.
> Could you squash my fixes, please? For your convenience, you can pluck all
> four of them right off of
> https://github.com/git-for-windows/git/commits/shears/pu

Yes, I think these two issues earlier I have locally and thumbfingered
running format-patch.

> 
> Just replace the `???` by `!` and you can even use `git rebase
> --autosquash`.
> 
> Ciao,
> Dscho
> 
> 
> > +#endif
> > +
> > +	if (len == info->len)
> > +		strbuf_addf(info, _("no compiler information available\n"));
> > +}
> > +
> > +static inline void get_libc_info(struct strbuf *info)
> > +{
> > +	int len = info->len;
> > +
> > +#ifdef __GLIBC__
> > +	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> > +#endif
> > +
> > +	if (len == info->len)
> > +		strbuf_addf(info, _("no libc information available\n"));
> > +}
> > +
> > +#endif /* COMPILER_H */
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
> >
