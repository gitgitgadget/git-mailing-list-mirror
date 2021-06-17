Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC12C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B68F613AA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhFQU5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFQU5f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 16:57:35 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A350FC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:55:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so904540ote.11
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nzEJfC1IIlTQLr1vJhG0H0CA4z8IvexmKVLh+AZIYko=;
        b=E5tP9wNe6k3XYVPzCPo30OSki3FvK71uIZ0a9IEaRsFpHGXXlefSSqGKE70nmyUL8C
         s+EPoiN62mHaIh61hya9JhdkhYyYm21269VBcrQYiMjqPsPxcNeQBfZfyTyFBU5/R5UR
         HuCuYOt6fVcxHnL1Kt4AbLfNvzhWgDGg0u03X++1t4A/Pgc9pGplb4WlXYVHU1VhT+yr
         ldxvVE0M8KqCkFFQz9l8M9cSKjADtijelDSF4Wblxp17LvPWCsehyD+Z4Qwk4uo/5Z9q
         A2cALOijZuMVUDJsc49ElhbgxrX6ADZYwYfrLv5Kmu8girHIzjCWV/0oTG7YlhKp3YIZ
         MtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nzEJfC1IIlTQLr1vJhG0H0CA4z8IvexmKVLh+AZIYko=;
        b=hTkemeg/19kXKXYyN7kNQAs6l1Yf5Bkz477p9yqiVOx6aMT1u4JFN+DGGlWo9BdoE0
         9ObJxgrmxitdZfMIySEMVqrVZw0pdUZ5UaeAQQINQi1VMj+P9r6yebwM/21UL+Gzx9Mn
         T1m9rYOcWqKWVtgA7T01N/N2+R+7HIKRZkAEEm/Jtgsr2Wh6HzcYEpNOw42vKgPutMtS
         camUjrUmdazLQg2q+egm/iC5siFOaHXuUvu4NxImoeYEsAgYuC9vIW5eSw4seVjEBjxF
         OShIxxO0GszaDvpSpreYBYjVdoAr66LZrQk5/Z1Fzs1nZBTR5w8p4HbPT+nIeTCvADQb
         VxmA==
X-Gm-Message-State: AOAM531C06ggtztS1pKarhtB3ieF/6+8bdlRvlVd8eyG7ttkb3lCBTBh
        ICjlbLS1Qw9339e1r0fJmSU=
X-Google-Smtp-Source: ABdhPJxJf6oS72ZhLPZ30jGHk2GVq0pcoTYQGlpwiS0CSMB0cdjbhIg1ALo6w85UGSGHcasFtmLpwQ==
X-Received: by 2002:a9d:4105:: with SMTP id o5mr6133553ote.20.1623963325944;
        Thu, 17 Jun 2021 13:55:25 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c11sm1375100oot.25.2021.06.17.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 13:55:25 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:55:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbb6bc37daf_9bf20865@natae.notmuch>
In-Reply-To: <patch-3.3-ddae86802e-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <patch-3.3-ddae86802e-20210617T095827Z-avarab@gmail.com>
Subject: RE: [PATCH 3/3] Makefile: remove an out-of-date comment
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This comment added in dfea575017 (Makefile: lazily compute header
> dependencies, 2010-01-26) has been out of date since
> 92b88eba9f (Makefile: use `git ls-files` to list header files, if
> possible, 2019-03-04), when we did exactly what it tells us not to do
> and added $(GENERATED_H) to $(OBJECTS) dependencies.

Very true.

> The rest of it was also somewhere between inaccurate and outdated,
> since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
> it's not followed by a list of header files, that got moved earlier in
> the file into LIB_H in b8ba629264 (Makefile: fold MISC_H into LIB_H,
> 2012-06-20).

I don't see the point in mentioning b8ba629264 twice, perhaps you meant:

60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H into LIB_H, 2012-07-06)

This commit also removed part of the comment:

  # XXX. Please check occasionally that these include all dependencies
  # gcc detects!

I have tried to understand what was the purpose of that comment in the
past, but I don't get it, it says:

  Dependencies on automatically generated headers such as command-list.h
  should _not_ be included here, since they are necessary even when
  building an object for the first time.

Why would it matter if we are building the object for the first time, or
rebuilding it? If we need command-list.h to build help.o once, we need
it always. What am I missing?

It seems to me this comment never made sense.

> --- a/Makefile
> +++ b/Makefile
> @@ -2503,12 +2503,6 @@ ifneq ($(dep_files_present),)
>  include $(dep_files_present)
>  endif
>  else
> -# Dependencies on header files, for platforms that do not support
> -# the gcc -MMD option.
> -#
> -# Dependencies on automatically generated headers such as command-list=
.h
> -# should _not_ be included here, since they are necessary even when
> -# building an object for the first time.
>  =


Can we remove that extra space once we are at it?

>  $(OBJECTS): $(LIB_H) $(GENERATED_H)
>  endif

The change itself looks good to me.

Cheers.

-- =

Felipe Contreras=
