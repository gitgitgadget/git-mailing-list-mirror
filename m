Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CB6C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjHKS7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHKS7o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:59:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E930CF
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:59:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2986888a12.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691780382; x=1692385182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FEIB+8u+OivDKwcDUN6pQTuGMXTsPn0Cfx6YlI/GvWI=;
        b=HL9frelfLSIdRxfCXkkbk0GYMntR5nAhH0j8SzLrupJhbi+Xy1oS//ipJ6sEHBLWOs
         55koVBihEbYJTaYHIBDrvvqMFN3aEOGGHPJCC7hzsbWYSf/W3wifbiiGmKi8WME8wmSF
         U9DHLTR8pawT/XzjRvpcc9z6k6125ssqk/V2feV7WSb1ea/3z3KamGrx3AWGcEnfM46W
         3hcYFLJ5KGsAmgZ3YHo8n1BXEbGZsj8Sv0JPsXibUqz8SRJivBMfRH8VENPApzZftQ0n
         BtGPooPEPPey+KjrEl2MMtuWnm+0405ngQRsNknRo7u8KxHxrXmE5arFfrfK9WdTCEeo
         WpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780382; x=1692385182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEIB+8u+OivDKwcDUN6pQTuGMXTsPn0Cfx6YlI/GvWI=;
        b=k5eTMGYinemCKsrVPss4bbNHxsrvQGCodkEgvZVezYhAReqWfWZvDVAI7RCtz4ZjtN
         +4JhG6P1SWxgZyjpWiJydody1l91mC/EJntGqpYgnoCuDilFO7l/0/hpic4W7+6HB87v
         ZPG4VfvT1ZjYMoelX8Im14BbhVFruqPUDCuln+3xkTV/zNKSYFp3gfXaGWdzAPpxQmgF
         pw5zf8H929CxlTQTj0WqdWmwmgzIiqv1QRT99hZsI1D6yBElVKdttJW7lvSc90p8ase+
         KgBpj9QpPjYKrx+Xr1PHW8eGDPHk0FUPlc2w4IMUGwjDm8ski1Jfs++zMzT2lRvmc8NY
         t1BA==
X-Gm-Message-State: AOJu0Yzww3a1uhT50hEyPTO/XZABUFeY/VQM5dF20TtpslK3gRL1/sGP
        5SGmxaYCreCW4BulkoX0ZRLby3OPmZL8ZiNUdr2Ii8YaX7U=
X-Google-Smtp-Source: AGHT+IGE2UFtGjCTqpCn+g2XBQ3fe2mEnSJ6ji8y3wzSoJG0ATn9IlFfRSWMYx5iMi6f0DfnxJp0qS9sI0b+4kJi6tQ=
X-Received: by 2002:a05:6402:141:b0:522:b112:6254 with SMTP id
 s1-20020a056402014100b00522b1126254mr2212910edu.4.1691780382024; Fri, 11 Aug
 2023 11:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Andy Koppe <andy.koppe@gmail.com>
Date:   Fri, 11 Aug 2023 19:59:29 +0100
Message-ID: <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Jul 2023 at 19:16, Glen Choo  wrote:

> As a micro-nit: there's some useful context behind your chosen design in
> [1]. It would have been useful to link to it in the `---` context, or
> perhaps send this series as v3 and v4 to [1].
>
> [1] https://lore.kernel.org/git/20230712110732.8274-1-andy.koppe@gmail.com/

Point taken.

> > +             strbuf_expand(&sb, val, strbuf_expand_literal_cb, NULL);
>
> strbuf_expand() got removed in 'master' recently, so this should be
> rebased.

Done. I think I had started off main, wrongly assuming that it's the
same as master.

Thanks again,
Andy
