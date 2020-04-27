Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BA2C81857
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D8F2078C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFnZg25t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD0V4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgD0V4Y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 17:56:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A60C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 14:56:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so5941920pfx.7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=McM7CnPbgdkmLZh6VG7qDEjT1SEephByc+qb6l6lSYc=;
        b=LFnZg25t2dwGhSkv8c5mhraL3C57rgjrBHTRgrTLC5SI7ZPvUCeGi4gk6Iiz+EtuM5
         D5wznUS9McOWGAE6DA+/NJJc/HIZO3Ro+yFaOiNe5bLeAiAmLvgJW4pqs4wiltafx5yt
         vZ84bBvHJtHqAnBIYvpPpFj1R1LZfCoI5I/R2LOUe0yeh/2U+Kdo0njY/LwntotDM0H0
         1DhBRxcMzrN6IcxMBE19giroKdXSVSmqtKaWLi2/wrvQaNSIjpiSEICuetSjF0Znkyv6
         urt3ZhQcNovgsbTsMEgpUCxKwu/hx6y9DlQ+ajZAWwe83LxNCFU/TdCohcWXb8NnDAJq
         vhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=McM7CnPbgdkmLZh6VG7qDEjT1SEephByc+qb6l6lSYc=;
        b=raDMUapnXO8xOHLv3t7+AB3QJMQ21n7p4rI+4sydafI+NaajOnR/mkkYR4kS/dQZtk
         L0MqnUtAKGyU7/PFNyLcF2BVxi0jNCWhGhIlU1FqzXZcYMqXsDiBbHtS9EUD9olmyJE+
         i9mRMcmm6SewP15IUuzkVGrma73Lqs+9o6G6dsKbdc48FX5w3AmqkRiLmAoLHexLZCpe
         r5+L9vPerQ+MFqnOXK+NhaOoACrBqadHkrAXuJBK28YVkv8ggnH8xI0y2mCx1RkJJWzu
         PF7KjMVnQ8POsJHAQNVIaKmH7U2WHE2j4XfKpdC7meLhM7yAqSPqsGcACCpthbLNi9tf
         pSgA==
X-Gm-Message-State: AGi0PubBGIWjBRB/A9p/bs/5/pDD5L0oGZzu42jrKLsO1VzTVAZumcKh
        SFy2a05snftwMZ6yBm0wWWwKlQ==
X-Google-Smtp-Source: APiQypIXdD2ZVoHpCn1D4oDNnOLYpOJ0dEiFs70BBHUeBTre6NVdTdrPPEJVCwMNSNfUsFjFH/eWjA==
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr27039605pfr.36.1588024583878;
        Mon, 27 Apr 2020 14:56:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b29sm13486760pfp.68.2020.04.27.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:56:23 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:56:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: drop time.h include
Message-ID: <20200427215619.GC77802@google.com>
References: <20200425003002.GC17217@google.com>
 <20200427204859.171084-1-emilyshaffer@google.com>
 <20200427210311.GB36078@google.com>
 <xmqqh7x47har.fsf@gitster.c.googlers.com>
 <xmqqd07s7gjr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd07s7gjr.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 02:41:12PM -0700, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >> Emily Shaffer wrote:
> >>
> >>> As pointed out in
> >>> https://lore.kernel.org/git/20200425003002.GC17217@google.com,
> >>
> >> This breadcrumb shouldn't be needed, since the rest of the commit
> >> message already speaks for itself.  We can save the future "git log"
> >> reader some time by leaing it out.
> >
> > True.
> 
> Well, removing these two lines made the rest non-sentence, so I had
> to rewrite the thing.  I am not sure if the educational value warrants
> the mention of compat/ exemption, but it people find it too noisy,
> it can certainly be dropped.

I've got a reroll to drop the "stdio.h" include too - do you want me to
send it? Your commit message is much nicer than what I came up with on
my end dropping the breadcrumb and generalizing to include stdio.h, so I
can adapt it if you're interested in the reroll.

> 
> Thanks.
> 
> -- >8 --
> 
> In the generic parts of the source files, system headers like
> <time.h> are supposed to be included indirectly by including
> "git-compat-util.h", which manages portability issues (platform
> specific compat/ sources are generally exempt from this rule).
> 
> Drop the inclusion.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  bugreport.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/bugreport.c b/bugreport.c
> index 089b939a87..e4a7ed3a23 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -2,7 +2,6 @@
>  #include "parse-options.h"
>  #include "stdio.h"
>  #include "strbuf.h"
> -#include "time.h"
>  #include "help.h"
>  #include "compat/compiler.h"
>  
> -- 
> 2.26.2-266-ge870325ee8
> 
