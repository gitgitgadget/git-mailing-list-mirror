Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF83C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiJKB22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJKB20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:28:26 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344A1402F
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:28:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 8so6483310ilj.4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs6ZcwpYar4Lwegtdmtf9+4/UiliCbGuvVdHwL9HOJY=;
        b=svh1QxhUXcqSMHgrXqm1yXvUoXNVHJ3IygX5mklwfzyAxj8DVYJqPPfG/bgJcGd1F6
         2QOIueKZqynWpyoJuIZVuRMHqX+dRAg8d9ltBB1kbO3J8g6/UTxti8QuDT30HdgBFnsu
         ntPUylvdx/dh3n75hsHJmw5Nkpt0sI1UabgRXMidTDg5H4IEKy6Pn0uwglgXWObtBX/p
         0hj8zv+j15tMBa0F69zjDC/iotsBnK3f9oBwWIKWZAv2XJNLSAdIMLrE4utEnwsOCcFY
         8ajfWjqja7S3fVa+l1M6tjrJn/D3U1UAB0rbPSmck1NW2YyOsJmRDK9NqoLj1pKSM0Bv
         vKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs6ZcwpYar4Lwegtdmtf9+4/UiliCbGuvVdHwL9HOJY=;
        b=qokULXIk1HrlIwNWHj895+AAposjY3Yz/1KBIEfs+AY9Vv3tleJAsB8XCKN1HQRuxf
         w6ZjrCLvM228Ayi6kWcSN9lZ2nSZTP0fDdp1fGuQhlHlvYub5EMw6FkjplXt5rl8K77j
         WKerGdO1YMSDccq4hGyzR+1VZP3ZOLKWNuapm+UYnryx/hykbbta+CzTvpuwxy0nBZlY
         Gi7Qf9C1QZ8rEghBHvR8RUyGIhDLrnoN4l9LwGTk4diwD4uB4b56xiRzcyeDvgbxwqPe
         8ogEgYvE4/L8aGRvTjPfLndaGljNbOYLiQuk7r0Mb8CUIJlSZUaIy/PuFVdsvgyHq7iz
         /Dkw==
X-Gm-Message-State: ACrzQf25yHKsV2ZwWmbdhICRfDh/jJtZhIHR0ECHA8DUN22hGkNIvTIX
        KP7jP4T6CrYqBqPr/WfuvcyWnA==
X-Google-Smtp-Source: AMsMyM4pgN6YrrnIyZgTqeVv6e0ayBHRRQT8Ic3Z96FnsdBYHvZO4XVWIwLhtlHZeUr3igNZJkthuQ==
X-Received: by 2002:a05:6e02:1447:b0:2fa:27f2:fb44 with SMTP id p7-20020a056e02144700b002fa27f2fb44mr10428264ilo.128.1665451705361;
        Mon, 10 Oct 2022 18:28:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g18-20020a056e02131200b002eb3b43cd63sm4449095ilr.18.2022.10.10.18.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:28:25 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:28:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y0TGuFDhoG1Nu6ND@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
 <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
 <Y0TF0M6UzLS9r6iM@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TF0M6UzLS9r6iM@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:24:32PM -0400, Taylor Blau wrote:
> > Makes sense. Two other tests that might be worth including:
> >
> >   - "shortlog --group=bogus" generates an error (we might already have
> >     such a test; I didn't check)
>
> We didn't have such a test before, so adding one is a good call, thanks!

Just writing back to say that this was a really good suggestion, since
it caught my mistake in writing:

    } else if (strchrnul(arg, '%')) {

since we'll always get back a non-NULL answer from calling `strchrnul`
instead of `strchr`.

Thanks ;-).

Thanks,
Taylor
