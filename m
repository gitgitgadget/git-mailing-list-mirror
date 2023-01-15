Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B312C67871
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 06:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjAOG70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 01:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjAOG7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 01:59:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3528A76
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 22:59:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i1so3847960pfk.3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 22:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjDUIuWF/HO1WbeOYgNRlfcRXUEh/5TLCWqHxd5cXR0=;
        b=EHTVCE9ZW4CQZqZ6Q8xM3DSRdj0RxuMLyfQKoeGSXQgCCKe6qjQQtP2spd6+IZepLQ
         +jj00pAdkr9CXg376nzbJ6t0KCoVlsBGMhB/WlQrEy42/3HWZj62tnvzQJyN2tAhWpdi
         lCmEnbhnVMgMflN0SjJDa0ratG1nEHwX0j52+9uZeX9NvFp6IZorAOMH2cUNVnEKY4p3
         GGXv+oOi+BM2rwERpxd9sBYFjI5A5Yqq4Gehv/8eVxrM51sJHCHWGzGYKrxV9kQwdMqq
         25vh7LSZ7TBgwuJfAdiDDnHcV4vXzB+bMa+T3NwlwTGy5zWgojb9mZTeeCdEcX4zgzuC
         rZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TjDUIuWF/HO1WbeOYgNRlfcRXUEh/5TLCWqHxd5cXR0=;
        b=nZJfH6jXqJtVpD4ED0K6UK1jMUGpBh99WmS2FRCdhi6EoQptXd9mYFRfWRHVbkPqTF
         /lg9o7SPXi4Q7ih0cwmnwSw3p+dbn/jyvMU+oGyAkGRXpKSGmPzLcyuKo4B89D532QDV
         S0xqnfBGZmNobgymQnxXLz6Xlm/aI42ftx/ppQLUbemw9XIJHR0XUDLWyz92KuY5lxM0
         2lk/JteK6SYLI3epcO4L39kOBIjNVXRx43xLWPKWL7eBSzXF/GVOSqUxJdAchRZLgoDZ
         YKc0/6/n/ya7nfOwCJBXhhppUJVTYzufvpMd1q5UgKUgUnCzEljS5QYhKrFsZi2/a8i+
         gKcw==
X-Gm-Message-State: AFqh2krL1WBxSoD+xj9iw5tk8nYr3rV4PniQ3pFyuqOI9ui/NkDWaJht
        KZUiuYA5+Ix9YAbb5UT34AOyA4/1lSU=
X-Google-Smtp-Source: AMrXdXuI3S932cKHjD99KxgRwvlcld4IucWH+1Wfb5jSj2bAvpxEzmkcqLNQ8f4zMwjrOEG2AQ9lng==
X-Received: by 2002:a62:1ad6:0:b0:58b:b29c:50c2 with SMTP id a205-20020a621ad6000000b0058bb29c50c2mr10046912pfa.26.1673765959713;
        Sat, 14 Jan 2023 22:59:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m3-20020a62a203000000b005768b4f2d0dsm15992048pff.64.2023.01.14.22.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 22:59:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
        <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
        <xmqqv8l9ks86.fsf@gitster.g>
        <Y8LjTYhTycp/tTBn@coredump.intra.peff.net>
Date:   Sat, 14 Jan 2023 22:59:18 -0800
In-Reply-To: <Y8LjTYhTycp/tTBn@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 14 Jan 2023 12:15:57 -0500")
Message-ID: <xmqq4jssi8qh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On the other hand, I don't know how useful those deprecations are going
> to be, as it depends on the timeframe. If the deprecation is added for
> the same version of libcurl that implements the alternative (which is
> roughly the case here), then we'd always be stuck supporting the old and
> new forms (old for backwards compatibility, and new to silence the
> deprecation warning).

... or just keep the warning without promoting, with "-Wno-error=...".

> We care a lot more about the deprecation once the
> alternative has been around for a while, and/or the old way of doing
> things is about to be removed. And if we just wait until that removal,
> then we do not have to rely on deprecation warnings. The build will
> break just fine on its own. :)

Yes and no.  It is not always like "this symbol is now known under
this different name", which is trivial to adjust.  I briefly tried
to see how IOCTL -> SEEK change should look like until I realized
that the new way was invented too recently and stopped looking, but
it would involve changes to the function logic in the callback
functions, as the function signature---both parameters and its
return values---of the callback changes.  I do not want to see us
scrambling to make such adjustments to the code at the last minute,
so some sort of advance warning is a good thing to have.

Thanks.

