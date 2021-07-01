Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F70C11F66
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D946761443
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 00:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhGAAFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhGAAFX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 20:05:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF01C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 17:02:53 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso4657959otu.10
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=W0Yuukji0NuQVAeL2YTlPW5HC2vJBOete+iCwWYsK6I=;
        b=W/N+5Uetz3Kr0PLr28fsFYZLxduTs7Z6sI1F1J9xri95kUH1/tRPQ24kHnK+T+/Gdb
         XGNABhaQOH6eUfgQF4NZ134xAwsWn1xRw7fvsbEY/VXXLB9uak+mUnpbopyu1oNOJOlK
         QWqNAx0cdz0AyEG3Hkoqt4fs3RY/VZZzjr7FvdR95eMn1BcvVx3VXeHnA2YMGDJ7bCe/
         OBsX4YhqS91eFYgAKPIZNTLkTo8nGLOo0l3IWAhf/MLto0J2Ox3iF4YQHqQJ3dusXxL+
         ecwVa+pGd1Wxw6/T/mHyrbtX5NFQ089ZReYH0Fg1ENebn9AHhPAQYfw1zzYW8UNys+Dj
         Yh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=W0Yuukji0NuQVAeL2YTlPW5HC2vJBOete+iCwWYsK6I=;
        b=Y6dRkB+H1sbc4jotIhXZOvhka7lhNuUnNalS0BYz4VZRc2dfv2JoO5Nasrnwv0LUNI
         sLxbWER9Q/JGkVM4TFsHvc2BcwnIg8OU5OXoNBZaGyW7qqdD9neBeUngm81cZ1jylUqF
         dw+5hUhT//Am2oCAk4AdI+mS8sEJJlXLL3ukqH4OdzidggN7CQGLEbRAcEM9fWAsr8IY
         UrtT/+RFxFDKdgAWaJ2avgyoOfQSKTJ5MFl+2TXENCDWi9rxCwYGM9wZ/nbDILr4xoYo
         FDq1kdunWSh5TAV0JAWmG8maoD2rjOgy85sylNeorVLSXuQ5ThyrSBoCmVaBfh6tjtNY
         vUAQ==
X-Gm-Message-State: AOAM533cHNzaDt+nRcx6TtgZDBUzdfdebSZbk8u3DuyKQWV9QEGpsrpi
        Bl1FSgE9LL27rBt4ISzExNYxXvgfXgndWw==
X-Google-Smtp-Source: ABdhPJxNaUoSXY17Ezph6TxKFSbX2TcGEOdkgzLiDpH4q03I7T+qCgtUXRnhnF9CsZOoJQlO3xrnBw==
X-Received: by 2002:a05:6830:40b1:: with SMTP id x49mr11028035ott.64.1625097772210;
        Wed, 30 Jun 2021 17:02:52 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l11sm2748492oou.0.2021.06.30.17.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 17:02:51 -0700 (PDT)
Date:   Wed, 30 Jun 2021 19:02:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60dd062a779d7_1634c20840@natae.notmuch>
In-Reply-To: <xmqq4kdft122.fsf@gitster.g>
References: <xmqq4kdft122.fsf@gitster.g>
Subject: RE: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.

> --------------------------------------------------
> [New Topics]

This is a topic:

https://lore.kernel.org/git/20210623004815.1807-1-felipe.contreras@gmail.com/

So is this:

https://lore.kernel.org/git/20210615183157.104999-1-felipe.contreras@gmail.com/

And this:

https://lore.kernel.org/git/20210628031642.699156-1-felipe.contreras@gmail.com/

And this:

https://lore.kernel.org/git/20210607185043.893205-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
